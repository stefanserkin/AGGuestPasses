import { LightningElement, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getBarcodeScanner } from 'lightning/mobileCapabilities';
import checkInGuestPass from '@salesforce/apex/GuestPassController.checkInGuestPass';
import getLocations from '@salesforce/apex/GuestPassController.getScannerLocations';

export default class GuestPassMobileScanner extends LightningElement {
    isLoading = false;
    error;

    scanner;
    scannedBarcode = '';
    resultMessage = '';

    wiredLocations = [];
    locationOptions = [];
    selectedLocationId;
    selectedLocationName;
 
    // When component is initialized, detect whether to enable Scan button
    connectedCallback() {
        this.scanner = getBarcodeScanner();
    }

    @wire(getLocations)
    wiredResult(result) {
        this.isLoading = true;
        this.wiredLocations = result;
        if (result.data) {
            result.data.forEach(row => {
                this.locationOptions = [...this.locationOptions, {value: row.Id, label: row.Name}];
            });
            this.error = undefined;
        } else if (result.error) {
            this.locations = undefined;
            this.error = result.error;
            console.error(this.error);
        }
    }

    get appHeader() {
        return this.selectedLocationId == null
            ? `Select a Location`
            : `Scan Guest Passes for ${this.selectedLocationName}`;
    }

    get scannerUnavailable() {
        return (this.scanner == null || !this.scanner.isAvailable());
    }

    get hasSelectedLocation() {
        return this.selectedLocationId != null && this.selectedLocationId.length > 0;
    }

    get scanButtonDisabled() {
        return (this.scannerUnavailable || !this.hasSelectedLocation);
    }

    handleLocationChange(event) {
        this.selectedLocationId = event.detail.value;
        this.selectedLocationName = event.target.options.find(opt => opt.value === this.selectedLocationId).label;
    }

    handleRemoveLocation() {
        this.selectedLocationId = null;
        this.selectedLocationName = null;
    }
 
    // When Scan Barcode button is clicked, scan the barcode and read the value
    handleScanBarcode(event) {
        event.preventDefault();

        // Reset scannedBarcode to empty string before starting new scan
        this.scannedBarcode = '';

        const scanningOptions = {
            barcodeTypes: [
                this.scanner.barcodeTypes.QR,
                this.scanner.barcodeTypes.EAN_8
            ],
            instructionText: 'Scan a QR Code',
            successText: 'Scanning complete.'
        };

        this.scanner.beginCapture(scanningOptions)
            .then((result) => {
                this.scannedBarcode = result.value;
                checkInGuestPass({ 
                    guestPassName: this.scannedBarcode, 
                    scanningLocationId: this.selectedLocationId 
                })
                    .then((scanResult) => {
                        this.resultMessage = scanResult.isSuccess ? 'Checked In' : scanResult.errorMessage;
                        if (scanResult.isSuccess) {
                            this.dispatchEvent(
                                new ShowToastEvent({
                                    title: 'Success',
                                    message: `Guest Pass ${scanResult.name} was successfully checked in`,
                                    variant: 'success'
                                })
                            );
                        } else {
                            this.dispatchEvent(
                                new ShowToastEvent({
                                    title: 'Scan Failed',
                                    message: `Failed to check in Guest Pass ${scanResult.name}. Error: ${scanResult.errorMessage}`,
                                    variant: 'error'
                                })
                            );
                        }
                        
                    })
                    .catch((error) => {
                        console.error(error);
                    });

            })
            .catch((error) => {
                // Handle cancellation and unexpected errors here
                if (error.code == 'USER_DISMISSED') {
                    // User clicked Cancel
                    this.dispatchToastEvent(
                        'Scanning Cancelled',
                        'You cancelled the scanning session.',
                        'info',
                        'dismissible'
                    );
                } else { 
                    // Inform the user we ran into something unexpected
                    this.dispatchToastEvent(
                        'Scan Error',
                        'There was a problem scanning the barcode: ' + error.message,
                        'error',
                        'sticky'
                    );
                }
            })
            .finally(() => {
                // Clean up by ending capture,
                // whether we completed successfully or had an error
                this.scanner.endCapture();
            });
    }
 
    dispatchToastEvent(title, errorMessage, variant, mode) {
        const toastEvent = new ShowToastEvent({
            title: title,
            message: errorMessage,
            variant: variant,
            mode: mode
        })
        this.dispatchEvent(toastEvent);
    }

}