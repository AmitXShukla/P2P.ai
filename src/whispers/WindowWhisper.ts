import { whisper, window } from '@oliveai/ldk';

interface Props {
  activeWindow: window.WindowInfo;
}
export default class WindowWhisper {
  whisper: whisper.Whisper;

  label: string;

  props: Props;

  constructor(activeWindow: window.WindowInfo) {
    this.whisper = undefined;
    this.label = 'Active Window Changed';
    this.props = {
      activeWindow,
    };
  }

  createComponents() {
    const name: whisper.ListPair = {
      type: whisper.WhisperComponentType.ListPair,
      copyable: true,
      label: 'Window Name',
      value: this.props.activeWindow.path,
      style: whisper.Urgency.None,
    };
    const pid: whisper.ListPair = {
      type: whisper.WhisperComponentType.ListPair,
      copyable: true,
      label: 'Process Id',
      value: this.props.activeWindow.pid.toString(),
      style: whisper.Urgency.None,
    };
    return [name, pid];
  }

  show() {
    whisper
      .create({
        components: this.createComponents(),
        label: this.label,
        onClose: WindowWhisper.onClose,
      })
      .then((newWhisper) => {
        this.whisper = newWhisper;
      });
  }

  close() {
    this.whisper.close(WindowWhisper.onClose);
  }

  static onClose(err?: Error) {
    if (err) {
      console.error('There was an error closing Window whisper', err);
    }
    console.log('Window whisper closed');
  }
}
