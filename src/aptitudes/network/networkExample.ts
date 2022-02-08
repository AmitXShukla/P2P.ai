import { network } from '@oliveai/ldk';
import { oneLine } from 'common-tags';
import { add, format } from 'date-fns';

import { NetworkWhisper } from '../../whispers';

const run = async () => {
  const currentDate = new Date();
  const threeMonthsAgo = add(currentDate, { months: -3 });
  // const request: network.HTTPRequest = {
  //   method: 'GET',
  //   url: oneLine`
  //   https://api.fda.gov/food/enforcement.json?search=report_date:[
  //   ${format(threeMonthsAgo, 'yyyyMMdd')}
  //   +TO+
  //   ${format(currentDate, 'yyyyMMdd')}
  //   ]&limit=10
  //   `,
  // };
  const request: network.HTTPRequest = {
    method: 'GET',
    url: `https://raw.githubusercontent.com/AmitXShukla/SCM_Rx_Inventory_OLIVEai/main/assets/json/alerts.json`,
  };

  const response = await network.httpRequest(request);
  const decodedBody = await network.decode(response.body);
  const parsedObject = JSON.parse(decodedBody);
  console.log(parsedObject);
  const recalls = parsedObject.results;

  const whisper = new NetworkWhisper(recalls);
  whisper.show();
};

export default { run };
