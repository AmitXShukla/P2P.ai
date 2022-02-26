import { IntroWhisper } from './whispers';
import {
  clipboardListener,
  // filesystemExample,
  keyboardListener,
  networkExample,
  searchListener,
  // activeWindowListener,
  openHandler,
} from './aptitudes';

(async function main(): Promise<void> {
  console.log('P2P.ai Started');
  // TODO: activeWindowListener.listen(); // start here, Loop only listen to ERP App window, chrome://localhost in this case
  clipboardListener.listen(); // loop is listening to ITEM/PO/DocCART key values
  // filesystemExample.run(); // not using for now, plan to use to address vendor/Item receiving files functionalities only
  // keyboardListener.listen(); // loop is listening to ITEM/PO/DocCART key values
  // searchListener.listen(); // loop is listening to ITEM/PO/DocCART key values
  openHandler.start(); // use this to display startup messages, // perhaps also show ERP system Alerts
  // new IntroWhisper().show();
  // networkExample.run(); // SCM Rx IN AI Loop| This is included in open handler already
})();