import { whisper } from '@oliveai/ldk';
import { stripIndent } from 'common-tags';

type Recall = {
  [key: string]: string;
};
interface Props {
  recalls: Recall[];
}
export default class NetworkSearchWhisper {
  whisper: whisper.Whisper;
  label: string;
  props: Props;

  constructor(recalls: Recall[]) {
    this.whisper = undefined;
    this.label = 'SCM_Rx_INV Search Results';
    this.props = {
      recalls,
    };
  }
  createComponents() {
    const components = [];
    this.props.recalls.forEach((recall) => {
      components.push({
        type: whisper.WhisperComponentType.Link,
        text: `ENTITY: ${recall.entity}- ${recall.transactionType} (${recall.itemID})`,
        onClick: () => {
          const markdown = stripIndent`
          ## Item Details
          transactionType: ${recall.transactionType}

          UNSPSC: ${recall.UNSPSC}

          entity: ${recall.entity}

          category: ${recall.category}

          resultType: ${recall.resultType}

          preferredItem: ${recall.preferredItem}

          preferredVendor: ${recall.preferredVendor}

          onContract: ${recall.onContract}

          description: ${recall.description}

          message: ${recall.message}

          # AI ALERTS
          ## Anomaly Detection
          price: ${recall.alert["anomalyDetection"].price}

          receivingTime: ${recall.alert["anomalyDetection"].receivingTime}

          qtyOrdered: ${recall.alert["anomalyDetection"].qtyOrdered}

          qtyOnHand: ${recall.alert["anomalyDetection"].qtyOnHand}

          matchExceptionRaised: ${recall.alert["anomalyDetection"].matchExceptionRaised}

          ## Purchase Recommendation
          ${recall.alert["purchaseRecommendation"]}
          `;

          whisper.create({
            label: `Details for ${recall.itemID}`,
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
        onClose: NetworkSearchWhisper.onClose,
      })
      .then((newWhisper) => {
        this.whisper = newWhisper;
      });
  }

  close() {
    this.whisper.close(NetworkSearchWhisper.onClose);
  }

  static onClose(err?: Error) {
    if (err) {
      console.error('There was an error closing Network whisper', err);
    }
    console.log('Network whisper closed');
  }
}
