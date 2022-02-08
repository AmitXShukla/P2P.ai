import { ui } from '@oliveai/ldk';

import { handler } from './openHandler';

jest.mock('@oliveai/ldk');

const mockIntroWhisperShow = jest.fn();
jest.mock('../../whispers', () => ({
  IntroWhisper: jest.fn(() => ({
    show: mockIntroWhisperShow,
  })),
}));

describe('Open Handler', () => {
  afterEach(() => {
    jest.clearAllMocks();
  });

  it('should show the Intro Whisper', async () => {
    await handler();

    expect(mockIntroWhisperShow).toBeCalled();
  });
});
