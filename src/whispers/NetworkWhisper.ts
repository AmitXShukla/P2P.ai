import { whisper } from '@oliveai/ldk';
import { stripIndent } from 'common-tags';

type Recall = {
  [key: string]: string;
};
interface Props {
  recalls: Recall[];
}
export default class NetworkWhisper {
  whisper: whisper.Whisper;

  label: string;

  props: Props;

  constructor(recalls: Recall[]) {
    this.whisper = undefined;
    this.label = 'Review System Alerts';
    this.props = {
      recalls,
    };
  }
  createComponents() {
    const components = [];
    this.props.recalls.forEach((recall) => {
      components.push({
        type: whisper.WhisperComponentType.Link,
        text: `${recall.city} (${recall.status})`,
        onClick: () => {
          const markdown = stripIndent`
          # ALERT
          ${recall.message}
          `;

          whisper.create({
            label: `Alert for ${recall.city}`,
            components: [
              {
                type: whisper.WhisperComponentType.Markdown,
                body: markdown,
              },
            ],
          });
        },
      });
    });

    return components;
  }
  // createComponents() {
  //   const components = [];
  //   this.props.recalls.forEach((recall) => {
  //     components.push({
  //       type: whisper.WhisperComponentType.Link,
  //       text: `${recall.recalling_firm} (${recall.recall_initiation_date})`,
  //       onClick: () => {
  //         const markdown = stripIndent`
  //         # Recalling Firm
  //         ${recall.recalling_firm}
  //         # Recall Number
  //         ${recall.recall_number}
  //         # Product Description
  //         ${recall.product_description}
  //         # Reason for Recall
  //         ${recall.reason_for_recall}
  //         `;

  //         whisper.create({
  //           label: `Recall for ${recall.recalling_firm}`,
  //           components: [
  //             {
  //               type: whisper.WhisperComponentType.Markdown,
  //               body: markdown,
  //             },
  //           ],
  //         });
  //       },
  //     });
  //   });

  //   return components;
  // }

  show() {
    whisper
      .create({
        components: this.createComponents(),
        label: this.label,
        onClose: NetworkWhisper.onClose,
      })
      .then((newWhisper) => {
        this.whisper = newWhisper;
      });
  }

  close() {
    this.whisper.close(NetworkWhisper.onClose);
  }

  static onClose(err?: Error) {
    if (err) {
      console.error('There was an error closing Network whisper', err);
    }
    console.log('Network whisper closed');
  }
}
