import { whisper } from '@oliveai/ldk';
import { network } from '@oliveai/ldk';
import NetworkSearchWhisper from '../whispers/NetworkSearchWhisper';

interface Props {
  clipboardText: string;
}
export default class ClipboardWhisper {
  whisper: whisper.Whisper;

  label: string;

  props: Props;

  async getData(str) {
    const request1: network.HTTPRequest = {
      method: 'GET',
      headers: { "Content-Type": ["application/json"] },
      url: "https://t7gfwerxpcslwfy-elishdb.adb.us-phoenix-1.oraclecloudapps.com/ords/admin/p2p/elasticsrch/" + str,
    };
    const req = network.httpRequest
    const request2: network.HTTPRequest = {
      method: 'GET',
      url: "https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/RestAPI/assets/fakeAPIResults_2.json",
    };
    try {
      // console.log("print res")
      const response = await network.httpRequest(request1);
      const decodedBody = await network.decode(response.body);
      // console.log("data from OCI:", decodedBody)
      const parsedObject = JSON.parse(decodedBody);
      const recalls = parsedObject.items;
      const whisper = new NetworkSearchWhisper(recalls);
      whisper.show();
    } catch (error) {
      console.log("error:", error)
      // console.log("calling backup REST API:")
      const response = await network.httpRequest(request2);
      const decodedBody = await network.decode(response.body);
      const parsedObject = JSON.parse(decodedBody);
      const recalls = parsedObject.results;
      const whisper = new NetworkSearchWhisper(recalls);
      whisper.show();
    }
  }

  constructor(clipboardText: string) {
    this.whisper = undefined;
    this.label = 'Clipboard text';
    this.props = {
      clipboardText,
    };
  }

  createComponents() {
    const message: whisper.Message = {
      type: whisper.WhisperComponentType.Message,
      body: this.props.clipboardText,
    };

    const searchButton: whisper.Button = {
      type: whisper.WhisperComponentType.Button,
      label: 'Search for this text',
      size: whisper.ButtonSize.Large,
      buttonStyle: whisper.ButtonStyle.Secondary,
      onClick: () => {
        this.getData(this.props.clipboardText);
        // const numClones = 1;
        // console.log('Resetting number of clones: ', numClones);
        // this.update({ numClones });
      },
    };

    return [message, searchButton];
  }

  show() {
    whisper
      .create({
        components: this.createComponents(),
        label: this.label,
        onClose: ClipboardWhisper.onClose,
      })
      .then((newWhisper) => {
        this.whisper = newWhisper;
      });
  }

  close() {
    this.whisper.close(ClipboardWhisper.onClose);
  }

  static onClose(err?: Error) {
    if (err) {
      console.error('There was an error closing Clipboard whisper', err);
    }
    // console.log('Clipboard whisper closed');
  }
}
