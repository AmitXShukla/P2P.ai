import { whisper } from '@oliveai/ldk';

interface Props {
  keyboardText: string;
}
export default class KeyboardWhisper {
  whisper: whisper.Whisper;

  label: string;

  props: Props;

  constructor(keyboardText: string) {
    this.whisper = undefined;
    this.label = 'Keyboard Aptitude Fired';
    this.props = {
      keyboardText,
    };
  }

  createComponents() {
    const message: whisper.Message = {
      type: whisper.WhisperComponentType.Message,
      body: this.props.keyboardText,
    };

    return [message];
  }

  show() {
    whisper
      .create({
        components: this.createComponents(),
        label: this.label,
        onClose: KeyboardWhisper.onClose,
      })
      .then((newWhisper) => {
        this.whisper = newWhisper;
      });
  }

  close() {
    this.whisper.close(KeyboardWhisper.onClose);
  }

  static onClose(err?: Error) {
    if (err) {
      console.error('There was an error closing Keyboard whisper', err);
    }
    console.log('Keyboard whisper closed');
  }
}
