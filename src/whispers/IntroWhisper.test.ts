import { whisper } from '@oliveai/ldk';
import { IntroWhisper } from '.';

jest.mock('@oliveai/ldk');

const mockWhisperClose = jest.fn();
const mockWhisperUpdate = jest.fn();

describe('Intro Whisper', () => {
  beforeEach(() => {
    whisper.create = jest
      .fn()
      .mockResolvedValueOnce({ close: mockWhisperClose, update: mockWhisperUpdate });
  });
  afterEach(() => {
    jest.resetAllMocks();
  });

  it('creates components as expected', () => {
    const newWhisper = new IntroWhisper();
    const actual = newWhisper.createComponents();

    // Check that we're getting expected component types in the expected order
    const expected = [
      expect.objectContaining({
        type: whisper.WhisperComponentType.Message,
      }),
      expect.objectContaining({
        type: whisper.WhisperComponentType.Divider,
      }),
      expect.objectContaining({
        type: whisper.WhisperComponentType.CollapseBox,
        children: [expect.objectContaining({ type: whisper.WhisperComponentType.Markdown })],
      }),
      expect.objectContaining({
        type: whisper.WhisperComponentType.Divider,
      }),
      expect.objectContaining({
        type: whisper.WhisperComponentType.Markdown,
      }),
      expect.objectContaining({
        type: whisper.WhisperComponentType.Box,
        children: [
          expect.objectContaining({
            type: whisper.WhisperComponentType.Button,
          }),
          expect.objectContaining({
            type: whisper.WhisperComponentType.Button,
          }),
        ],
      }),
      expect.objectContaining({
        type: whisper.WhisperComponentType.Divider,
      }),
      expect.objectContaining({
        type: whisper.WhisperComponentType.Markdown,
      }),
      expect.objectContaining({
        type: whisper.WhisperComponentType.TextInput,
      }),
      expect.objectContaining({
        type: whisper.WhisperComponentType.Email,
      }),
      expect.objectContaining({
        type: whisper.WhisperComponentType.Password,
      }),
      expect.objectContaining({
        type: whisper.WhisperComponentType.Telephone,
      }),
      expect.objectContaining({
        type: whisper.WhisperComponentType.Button,
      }),
      expect.objectContaining({
        type: whisper.WhisperComponentType.Link,
      }),
      expect.objectContaining({
        type: whisper.WhisperComponentType.Checkbox,
      }),
      expect.objectContaining({
        type: whisper.WhisperComponentType.ListPair,
      }),
      expect.objectContaining({
        type: whisper.WhisperComponentType.Number,
      }),
      expect.objectContaining({
        type: whisper.WhisperComponentType.Select,
      }),
      expect.objectContaining({
        type: whisper.WhisperComponentType.RadioGroup,
      }),
      expect.objectContaining({
        type: whisper.WhisperComponentType.Divider,
      }),
      expect.objectContaining({
        type: whisper.WhisperComponentType.Markdown,
      }),
      expect.objectContaining({
        type: whisper.WhisperComponentType.Message,
      }),
      expect.objectContaining({
        type: whisper.WhisperComponentType.TextInput,
      }),
      expect.objectContaining({
        type: whisper.WhisperComponentType.TextInput,
      }),
      expect.objectContaining({
        type: whisper.WhisperComponentType.Button,
      }),
      expect.objectContaining({
        type: whisper.WhisperComponentType.Button,
      }),
    ];

    expect(actual).toEqual(expected);
  });

  it('creates components with functional handlers', async () => {
    const newWhisper = new IntroWhisper();
    newWhisper.show();
    await Promise.resolve();
    const components = newWhisper.createComponents();

    // // Check box's first and second button onClicks
    // const box = components[5] as whisper.Box;
    // const boxFirstButton = box.children[0] as whisper.Button;
    // const boxSecondButton = box.children[1] as whisper.Button;
    // boxFirstButton.onClick(null, null);
    // expect(console.log).toBeCalledWith('Button 1 clicked.');
    // boxSecondButton.onClick(null, null);
    // expect(console.log).toBeCalledWith('Button 2 clicked.');

    // // Check textInput's onChange
    // const textInput = components[8] as whisper.TextInput;
    // textInput.onChange(null, 'test', null);
    // expect(console.log).toBeCalledWith('Text changed: ', 'test');

    // // Check email's onChange
    // const email = components[9] as whisper.Email;
    // email.onChange(null, 'test', null);
    // expect(console.log).toBeCalledWith('Email changed: ', 'test');

    // // Check password's onChange
    // const password = components[10] as whisper.Password;
    // password.onChange(null, 'test', null);
    // expect(console.log).toBeCalledWith('Password changed: ', 'test');

    // // Check telephone's onChange
    // const telephone = components[11] as whisper.Telephone;
    // telephone.onChange(null, 'test', null);
    // expect(console.log).toBeCalledWith('Telephone number changed: ', 'test');

    // // Check button's onClick
    // const button = components[12] as whisper.Button;
    // button.onClick(null, null);
    // expect(console.log).toBeCalledWith('Button clicked.');

    // // Check link's onClick
    // const link = components[13] as whisper.Link;
    // link.onClick(null, null);
    // expect(console.log).toBeCalledWith('Link clicked.');

    // // Check checkbox's onChange
    // const checkbox = components[14] as whisper.Checkbox;
    // checkbox.onChange(null, true, null);
    // expect(console.log).toBeCalledWith('Checkbox clicked: ', true);

    // // Check numberInput's onChange
    // const numberInput = components[16] as whisper.NumberInput;
    // numberInput.onChange(null, 0, null);
    // expect(console.log).toBeCalledWith('Number changed: ', 0);

    // // Check select's onSelect
    // const select = components[17] as whisper.Select;
    // select.onSelect(null, 0, null);
    // expect(console.log).toBeCalledWith('Selected: ', 0);

    // // Check radioBtn's onSelect
    // const radioBtn = components[18] as whisper.RadioGroup;
    // radioBtn.onSelect(null, 0, null);
    // expect(console.log).toBeCalledWith('Radio button option selected: ', 0);

    // // Check updatableMessageInput's onSelect
    // const updatableMessageInput = components[22] as whisper.TextInput;
    // updatableMessageInput.onChange(null, 'test message', null);
    // expect(console.log).toBeCalledWith('Updating message text: ', 'test message');
    // expect(mockWhisperUpdate).toBeCalled();
    // expect(newWhisper.props.newMessage).toEqual('test message');

    // // Check updatableLabelInput's onSelect
    // const updatableLabelInput = components[23] as whisper.TextInput;
    // updatableLabelInput.onChange(null, 'test label', null);
    // expect(console.log).toBeCalledWith('Updating whisper label: ', 'test label');
    // expect(mockWhisperUpdate).toBeCalled();
    // expect(newWhisper.props.label).toEqual('test label');

    // // Check clicking on a clone button twice
    // const cloneButton = components[25] as whisper.Button;
    // cloneButton.onClick(null, null);
    // expect(console.log).toBeCalledWith('Adding another clone: ', 2);
    // expect(mockWhisperUpdate).toBeCalled();
    // expect(newWhisper.props.numClones).toEqual(2);
    // cloneButton.onClick(null, null);
    // expect(console.log).toBeCalledWith('Adding another clone: ', 3);
    // expect(mockWhisperUpdate).toBeCalled();
    // expect(newWhisper.props.numClones).toEqual(3);

    // // Check clicking on reset clones button
    // const resetClonesButton = components[24] as whisper.Button;
    // resetClonesButton.onClick(null, null);
    // expect(console.log).toBeCalledWith('Resetting number of clones: ', 1);
    // expect(mockWhisperUpdate).toBeCalled();
    // expect(newWhisper.props.numClones).toEqual(1);
  });

  it('uses default values for updatable components', async () => {
    const newWhisper = new IntroWhisper();
    newWhisper.show();
    await Promise.resolve();
    newWhisper.update({});

    expect(mockWhisperUpdate).toBeCalledWith({
      label: 'Intro Whisper',
      components: expect.arrayContaining([
        expect.objectContaining({
          type: whisper.WhisperComponentType.Message,
          body: 'Type in the field below to update this line of text',
        }),
        expect.objectContaining({
          type: whisper.WhisperComponentType.Button,
          label: 'Clone Me',
        }),
      ]),
    });
  });

  it('updates as expected for passed in params', async () => {
    const newWhisper = new IntroWhisper();
    newWhisper.show();
    await Promise.resolve();
    newWhisper.update({ newMessage: 'test message', numClones: 3, label: 'test label' });

    expect(mockWhisperUpdate).toBeCalledWith({
      label: 'test label',
      components: expect.arrayContaining([
        expect.objectContaining({
          type: whisper.WhisperComponentType.Message,
          body: 'test message',
        }),
        expect.objectContaining({
          type: whisper.WhisperComponentType.Button,
          label: 'Clone Me',
        }),
        expect.objectContaining({
          type: whisper.WhisperComponentType.Button,
          label: 'Clone Me',
        }),
        expect.objectContaining({
          type: whisper.WhisperComponentType.Button,
          label: 'Clone Me',
        }),
      ]),
    });
  });

  it('creates a whisper and closes it gracefully', async () => {
    const newWhisper = new IntroWhisper();
    newWhisper.show();
    await Promise.resolve();
    newWhisper.close();

    expect(whisper.create).toBeCalledWith(
      expect.objectContaining({
        label: 'Intro Whisper',
        onClose: IntroWhisper.onClose,
      })
    );
    expect(mockWhisperClose).toBeCalled();
  });

  it.each`
    scenario              | error
    ${'without an error'} | ${undefined}
    ${'with an error'}    | ${new Error('error')}
  `('should close properly $scenario', ({ error }) => {
    IntroWhisper.onClose(error);

    if (error) {
      expect(console.error).toBeCalledWith('There was an error closing Intro whisper', error);
    }
    expect(console.log).toBeCalledWith('Intro whisper closed');
  });
});
