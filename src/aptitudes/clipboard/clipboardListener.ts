import { clipboard } from '@oliveai/ldk';

import { ClipboardWhisper } from '../../whispers';

const handler = (text: string) => {
  const whisper = new ClipboardWhisper(text);
  whisper.show();
};
const listen = () => {
  clipboard.listen(false, handler);
};

export { handler };
export default { listen };
