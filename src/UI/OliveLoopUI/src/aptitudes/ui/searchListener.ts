import { ui } from '@oliveai/ldk';

import { UiWhisper } from '../../whispers';

const handler = (text: string) => {
  const whisper = new UiWhisper(text);
  whisper.show();
};
const listen = () => {
  ui.listenGlobalSearch(handler);
  ui.listenSearchbar(handler);
};

export { handler };
export default { listen };
