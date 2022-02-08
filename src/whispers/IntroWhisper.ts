import { whisper } from '@oliveai/ldk';
import { stripIndent } from 'common-tags';
import { getOverlappingDaysInIntervals } from 'date-fns';
import { networkExample } from '../aptitudes';
import { network } from '@oliveai/ldk';
import NetworkSearchWhisper from '../whispers/NetworkSearchWhisper';

interface Props {
  newMessage: string;
  numClones: number;
  label: string;
}
export default class IntroWhisper {
  whisper: whisper.Whisper;
  label: string;
  props: Props;

  async getData(str) {
    const request: network.HTTPRequest = {
      method: 'GET',
      url: `https://raw.githubusercontent.com/AmitXShukla/SCM_Rx_Inventory_OLIVEai/main/assets/json/searchresults.json`,
    };
    const response = await network.httpRequest(request);
    const decodedBody = await network.decode(response.body);
    const parsedObject = JSON.parse(decodedBody);
    const recalls = parsedObject.results;
    console.log("Print results")
    console.log(JSON.stringify(recalls))
    const whisper = new NetworkSearchWhisper(recalls);
    whisper.show();
  }

  constructor() {
    this.whisper = undefined;
    this.label = 'Welcome to SCM_Rx_INV_AI Loop';
    this.props = {
      newMessage: '',
      numClones: 1,
      label: '',
    };
  }

  createComponents() {
    const divider: whisper.Divider = {
      type: whisper.WhisperComponentType.Divider,
    };

    // Intro message.
    const introMessage: whisper.Message = {
      type: whisper.WhisperComponentType.Message,
      body: 'REST API is using a demo database. Please do not use it for any live reporting purpose. refer to https://github.com/AmitXShukla/SCM_Rx_Inventory_OLIVEai for documentation.',
      style: whisper.Urgency.Success,
    };

    // Collapse box.
    const collapsibleContent: whisper.Markdown = {
      type: whisper.WhisperComponentType.Markdown,
      body: stripIndent`
      # Startup instructions
      Step 0: Review ALERTs section above for latest system messages.

      Step 1: login to Healthcare OLTP / ERP Application, Olive_SCM_Rx_AI is expecting you to use a your ERP app.

      Step 2: enter some data in app | search text in Olive Help | select & copy text to your clipboard
        for example, PO12345 | MSR12345 | ITEM12345 | RECV12345 (use these strings for **demo)

      Step 3: AI API is smart to parse your text as PO | ITEM | others, perform an elastic search in database and render active matching results.

      Step 4: Review two sections in search results, Section 1: About/Details about searched items | Section 2: AI Alerts based on pre-trained ML Models.
      `,
    };
    const collapseBox: whisper.CollapseBox = {
      type: whisper.WhisperComponentType.CollapseBox,
      children: [collapsibleContent],
      open: true,
    };

    // const alertMessage: whisper.Message = {
    //   type: whisper.WhisperComponentType.Message,
    //   body: 'ALERT: DocCART Surgical items at par location Oakland are low in inventory, Auto Replenishment POs must dispatch to avoid deficit.',
    //   style: whisper.Urgency.Error,
    // };
    // // Box example.
    // const boxHeader: whisper.Markdown = {
    //   type: whisper.WhisperComponentType.Markdown,
    //   body: '# Box with Child Components',
    // };
    // const firstButton: whisper.Button = {
    //   type: whisper.WhisperComponentType.Button,
    //   label: 'Button 1',
    //   onClick: () => {
    //     console.log('Button 1 clicked.');
    //   },
    // };
    // const secondButton: whisper.Button = {
    //   type: whisper.WhisperComponentType.Button,
    //   label: 'Button 2',
    //   onClick: () => {
    //     console.log('Button 2 clicked.');
    //   },
    // };
    // const box: whisper.Box = {
    //   type: whisper.WhisperComponentType.Box,
    //   children: [firstButton, secondButton],
    //   direction: whisper.Direction.Horizontal,
    //   justifyContent: whisper.JustifyContent.SpaceEvenly,
    // };

    // // Various example components.
    // const exampleComponentsHeading: whisper.Markdown = {
    //   type: whisper.WhisperComponentType.Markdown,
    //   body: '# Example Components',
    // };
    // const textInput: whisper.TextInput = {
    //   type: whisper.WhisperComponentType.TextInput,
    //   label: 'Text Input',
    //   onChange: (_error: Error | undefined, val: string) => {
    //     console.log('Text changed: ', val);
    //   },
    // };
    // const email: whisper.Email = {
    //   type: whisper.WhisperComponentType.Email,
    //   label: 'Email',
    //   onChange: (_error: Error | undefined, val: string) => {
    //     console.log('Email changed: ', val);
    //   },
    // };
    // const password: whisper.Password = {
    //   type: whisper.WhisperComponentType.Password,
    //   label: 'Password',
    //   onChange: (_error: Error | undefined, val: string) => {
    //     console.log('Password changed: ', val);
    //   },
    // };
    // const telephone: whisper.Telephone = {
    //   type: whisper.WhisperComponentType.Telephone,
    //   label: 'Telephone Number',
    //   onChange: (_error: Error | undefined, val: string) => {
    //     console.log('Telephone number changed: ', val);
    //   },
    // };
    // const button: whisper.Button = {
    //   type: whisper.WhisperComponentType.Button,
    //   label: 'Button',
    //   onClick: () => {
    //     console.log('Button clicked.');
    //   },
    // };
    // const link: whisper.Link = {
    //   type: whisper.WhisperComponentType.Link,
    //   text: 'Example of a link',
    //   onClick: () => {
    //     console.log('Link clicked.');
    //   },
    // };
    // const checkbox: whisper.Checkbox = {
    //   type: whisper.WhisperComponentType.Checkbox,
    //   label: 'Checkbox',
    //   tooltip: "Here's a tooltip.",
    //   value: false,
    //   onChange: (_error: Error | undefined, val: boolean) => {
    //     console.log('Checkbox clicked: ', val);
    //   },
    // };
    // const pair: whisper.ListPair = {
    //   type: whisper.WhisperComponentType.ListPair,
    //   copyable: true,
    //   label: 'List pair example:',
    //   value: 'This value is copyable.',
    //   style: whisper.Urgency.None,
    // };
    // const numberInput: whisper.NumberInput = {
    //   type: whisper.WhisperComponentType.Number,
    //   value: 6,
    //   max: 10,
    //   min: 1,
    //   step: 2,
    //   tooltip: 'Number Input',
    //   label: 'Number Input',
    //   onChange: (_error: Error | undefined, val: number) => {
    //     console.log('Number changed: ', val);
    //   },
    // };
    // const select: whisper.Select = {
    //   type: whisper.WhisperComponentType.Select,
    //   label: 'Select Box',
    //   options: ['One', 'Two', 'Three'],
    //   selected: 0,
    //   onSelect: (_error: Error | undefined, val: number) => {
    //     console.log('Selected: ', val);
    //   },
    // };
    // const radioBtn: whisper.RadioGroup = {
    //   type: whisper.WhisperComponentType.RadioGroup,
    //   options: ['Option 1', 'Option 2', 'Option 3'],
    //   onSelect: (_error: Error | undefined, val: number) => {
    //     console.log('Radio button option selected: ', val);
    //   },
    // };

    // Showing how to use whisper.update
    // const updatableComponentsHeading: whisper.Markdown = {
    //   type: whisper.WhisperComponentType.Markdown,
    //   body: 'search here',
    // };
    const updatableMessage: whisper.Message = {
      type: whisper.WhisperComponentType.Message,
      header: 'find ....',
      body: this.props.newMessage || 'Type in the field below to search for input',
      style: whisper.Urgency.Warning,
    };
    const updatableMessageInput: whisper.TextInput = {
      type: whisper.WhisperComponentType.TextInput,
      label: 'New Search Input',
      onChange: (_error: Error | undefined, val: string) => {
        console.log('Updating message text: ', val);
        this.update({ newMessage: val });
      },
    };
    // const updatableLabelInput: whisper.TextInput = {
    //   type: whisper.WhisperComponentType.TextInput,
    //   label: 'Change Whisper Label',
    //   onChange: (_error: Error | undefined, val: string) => {
    //     console.log('Updating whisper label: ', val);
    //     this.update({ label: val });
    //   },
    // };
    // const resetButton: whisper.Button = {
    //   type: whisper.WhisperComponentType.Button,
    //   label: 'Reset Clones',
    //   size: whisper.ButtonSize.Large,
    //   buttonStyle: whisper.ButtonStyle.Secondary,
    //   onClick: () => {
    //     const numClones = 1;
    //     console.log('Resetting number of clones: ', numClones);
    //     this.update({ numClones });
    //   },
    // };
    const searchButton: whisper.Button = {
      type: whisper.WhisperComponentType.Button,
      label: 'Search',
      size: whisper.ButtonSize.Large,
      buttonStyle: whisper.ButtonStyle.Secondary,
      onClick: () => {
        this.getData(this.props.newMessage);
        // const numClones = 1;
        // console.log('Resetting number of clones: ', numClones);
        // this.update({ numClones });
      },
    };
    // const clonedComponents: whisper.ChildComponents[] = [];
    // for (let i = this.props.numClones; i > 0; i -= 1) {
    //   const clone: whisper.Button = {
    //     type: whisper.WhisperComponentType.Button,
    //     label: 'Clone Me',
    //     onClick: () => {
    //       const numClones = this.props.numClones + 1;
    //       console.log('Adding another clone: ', numClones);
    //       this.update({ numClones });
    //     },
    //   };
    //   clonedComponents.push(clone);
    // }

    return [
      introMessage,
      divider,
      collapseBox,
      // divider,
      // alertMessage,
      // boxHeader,
      // box,
      // divider,
      // exampleComponentsHeading,
      // textInput,
      // email,
      // password,
      // telephone,
      // button,
      // link,
      // checkbox,
      // pair,
      // numberInput,
      // select,
      // radioBtn,
      divider,
      // updatableComponentsHeading,
      updatableMessage,
      updatableMessageInput,
      // updatableLabelInput,
      // resetButton,
      searchButton
      // ...clonedComponents,
    ];
  }

  show() {
    whisper
      .create({
        components: this.createComponents(),
        label: this.label,
        onClose: IntroWhisper.onClose,
      })
      .then((newWhisper) => {
        this.whisper = newWhisper;
      });
  }

  update(props: Partial<Props>) {
    this.props = { ...this.props, ...props };
    this.whisper.update({
      label: this.props.label || this.label,
      components: this.createComponents(),
    });
  }

  close() {
    this.whisper.close(IntroWhisper.onClose);
  }

  static onClose(err?: Error) {
    if (err) {
      console.error('There was an error closing Intro whisper', err);
    }
    console.log('Intro whisper closed');
  }
}
