import { ui } from '@oliveai/ldk';

import { IntroWhisper } from '../../whispers';

export const handler = async () => {
  new IntroWhisper().show();
};

export default {
  start: () => ui.loopOpenHandler(handler),
};
