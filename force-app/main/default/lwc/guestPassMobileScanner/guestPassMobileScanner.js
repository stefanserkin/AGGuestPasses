import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getBarcodeScanner } from 'lightning/mobileCapabilities';
import checkInGuestPass from '@salesforce/apex/GuestPassScannerController.checkInGuestPass';

export default class GuestPassMobileScanner extends LightningElement {
    scanner;
    scanButtonDisabled = false;
    scannedBarcode = '';
    result = '';
 
    // When component is initialized, detect whether to enable Scan button
    connectedCallback() {
        this.scanner = getBarcodeScanner();
        if (this.scanner == null || !this.scanner.isAvailable()) {
            this.scanButtonDisabled = true;
        }
    }
 
    //When Scan Barcode button is clicked, scan the barcode and read the value
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
                checkInGuestPass({ guestPassName: this.scannedBarcode })
                    .then((checkInResult) => {
                        this.result = checkInResult;
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Successful Scan',
                                message: 'Barcode scanned successfully.',
                                variant: 'success'
                            })
                        );
                    })
                    .catch((error) => {
                        console.error(error);
                    });

            })
            .catch((error) => {
                // Handle cancellation and unexpected errors here
                console.error('Scan Error: ' + JSON.stringify(error));
                if (error.code == 'userDismissedScanner') {
                    // User clicked Cancel
                    this.dispatchToastEvent('Scanning Cancelled',
                        'You cancelled the scanning session.',
                        'error',
                        'sticky'
                    );
                } else { 
                    // Inform the user we ran into something unexpected
                    this.dispatchToastEvent('Barcode Scanner Error',
                        'There was a problem scanning the barcode: ' + error.message,
                        'error',
                        'sticky'
                    );
                }
            })
            .finally(() => {
                console.log('#finally');
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