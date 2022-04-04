import { network } from '@oliveai/ldk';
import { oneLine } from 'common-tags';
import { NetworkWhisper } from '../../whispers';
import networkExample from './networkExample';

jest.mock('@oliveai/ldk');

const mockNetworkShow = jest.fn();
jest.mock('../../whispers', () => {
  return {
    NetworkWhisper: jest.fn().mockImplementation(() => {
      return { show: mockNetworkShow };
    }),
  };
});

describe('Network Example', () => {
  beforeAll(() => {
    jest.useFakeTimers('modern');
    jest.setSystemTime(new Date(2021, 0));
  });
  afterEach(() => {
    jest.clearAllMocks();
  });
  afterAll(() => {
    jest.useRealTimers();
  });

  it('should make a network request and display the result with a whisper', async () => {
    const responseStub: network.HTTPResponse = {
      statusCode: 200,
      body: new Uint8Array(),
      headers: {},
    };
    const responseBodyStub = { results: [] };
    network.httpRequest = jest.fn().mockResolvedValueOnce(responseStub);
    network.decode = jest.fn().mockResolvedValueOnce(JSON.stringify(responseBodyStub));

    await networkExample.run();

    expect(network.httpRequest).toBeCalledWith({
      method: 'GET',
      url: oneLine`
      https://api.fda.gov/food/enforcement.json?search=report_date:[
      20201001
      +TO+
      20210101
      ]&limit=10
      `,
    });
    expect(network.decode).toBeCalledWith(responseStub.body);
    expect(NetworkWhisper).toBeCalledWith(responseBodyStub.results);
    expect(mockNetworkShow).toBeCalled();
  });
});
