import { whisper, window } from '@oliveai/ldk';
import { WindowWhisper } from '.';

jest.mock('@oliveai/ldk');

const mockWhisperClose = jest.fn();

const TEST_PARAM = { path: 'test', pid: 0 } as window.WindowInfo;

describe('Window Whisper', () => {
  beforeEach(() => {
    whisper.create = jest.fn().mockResolvedValueOnce({ close: mockWhisperClose });
  });
  afterEach(() => {
    jest.resetAllMocks();
  });

  it('creates components as expected', () => {
    const newWhisper = new WindowWhisper(TEST_PARAM);
    const actual = newWhisper.createComponents();

    const expected = [
      expect.objectContaining({
        type: whisper.WhisperComponentType.ListPair,
        label: 'Window Name',
        value: TEST_PARAM.path,
      }),
      expect.objectContaining({
        type: whisper.WhisperComponentType.ListPair,
        label: 'Process Id',
        value: TEST_PARAM.pid.toString(),
      }),
    ];

    expect(actual).toEqual(expected);
  });

  it('creates a whisper and closes it gracefully', async () => {
    const newWhisper = new WindowWhisper(TEST_PARAM);
    newWhisper.show();
    await Promise.resolve();
    newWhisper.close();

    expect(whisper.create).toBeCalledWith(
      expect.objectContaining({
        components: newWhisper.createComponents(),
        label: 'Active Window Changed',
        onClose: WindowWhisper.onClose,
      })
    );
    expect(mockWhisperClose).toBeCalled();
  });

  it.each`
    scenario              | error
    ${'without an error'} | ${undefined}
    ${'with an error'}    | ${new Error('error')}
  `('should close properly $scenario', ({ error }) => {
    WindowWhisper.onClose(error);

    if (error) {
      expect(console.error).toBeCalledWith('There was an error closing Window whisper', error);
    }
    expect(console.log).toBeCalledWith('Window whisper closed');
  });
});
