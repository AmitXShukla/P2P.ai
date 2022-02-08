import { whisper } from '@oliveai/ldk';
import { stripIndent } from 'common-tags';

interface Props {
  fileContents: string;
}
export default class FilesystemWhisper {
  whisper: whisper.Whisper;

  label: string;

  props: Props;

  constructor(fileContents: string) {
    this.whisper = undefined;
    this.label = 'Example Filesystem Aptitude Whisper';
    this.props = {
      fileContents,
    };
  }

  createComponents() {
    const markdown: whisper.Markdown = {
      type: whisper.WhisperComponentType.Markdown,
      body: stripIndent`
      # Example File Contents
      ${this.props.fileContents}
      `,
    };

    return [markdown];
  }

  show() {
    whisper
      .create({
        components: this.createComponents(),
        label: this.label,
        onClose: FilesystemWhisper.onClose,
      })
      .then((newWhisper) => {
        this.whisper = newWhisper;
      });
  }

  close() {
    this.whisper.close(FilesystemWhisper.onClose);
  }

  static onClose(err?: Error) {
    if (err) {
      console.error('There was an error closing Filesystem whisper', err);
    }
    console.log('Filesystem whisper closed');
  }
}
