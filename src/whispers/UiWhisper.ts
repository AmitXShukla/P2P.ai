import { whisper } from '@oliveai/ldk';

interface Props {
  searchText: string;
}
export default class UiWhisper {
  whisper: whisper.Whisper;

  label: string;

  props: Props;

  constructor(searchText: string) {
    this.whisper = undefined;
    this.label = 'UI Search Aptitude Fired';
    this.props = {
      searchText,
    };
  }

  createComponents() {
    const message: whisper.Message = {
      type: whisper.WhisperComponentType.Message,
      body: this.props.searchText,
    };

    return [message];
  }

  show() {
    whisper
      .create({
        components: this.createComponents(),
        label: this.label,
        onClose: UiWhisper.onClose,
      })
      .then((newWhisper) => {
        this.whisper = newWhisper;
      });
  }

  close() {
    this.whisper.close(UiWhisper.onClose);
  }

  static onClose(err?: Error) {
    if (err) {
      console.error('There was an error closing Ui whisper', err);
    }
    console.log('Ui whisper closed');
  }
}
