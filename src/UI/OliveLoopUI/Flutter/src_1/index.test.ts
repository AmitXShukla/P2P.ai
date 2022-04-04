import {
  clipboardListener,
  filesystemExample,
  keyboardListener,
  networkExample,
  searchListener,
  activeWindowListener,
openHandler,
} from './aptitudes';
jest.mock('./aptitudes');

const mockIntroWhisperShow = jest.fn();

jest.mock('./whispers', () => ({
  IntroWhisper: jest.fn(() => ({
    show: mockIntroWhisperShow,
  })),
}));

describe('Project Startup', () => {
  afterEach(() => {
    jest.clearAllMocks();
  });

  it('should start the aptitudes and open handler on startup', async () => {
    // eslint-disable-next-line global-require
    await require('.');
    expect(console.log).toBeCalledWith('Example Loop Started');
    expect(openHandler.start).toBeCalled();
    expect(mockIntroWhisperShow).toBeCalled();
    expect(clipboardListener.listen).toBeCalled();
    expect(filesystemExample.run).toBeCalled();
    expect(keyboardListener.listen).toBeCalled();
    expect(networkExample.run).toBeCalled();
    expect(searchListener.listen).toBeCalled();
    expect(activeWindowListener.listen).toBeCalled();
  });
});

