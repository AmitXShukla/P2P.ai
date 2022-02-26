import { ui } from '@oliveai/ldk';
import {
  networkExample
} from '../../aptitudes';

import { IntroWhisper } from '../../whispers';
import { openHandler } from '..';

export const handler = async () => {
  new IntroWhisper().show();
  networkExample.run(); // SCM Rx IN AI Loop|
};

export default {
  start: () => ui.loopOpenHandler(handler),
};
