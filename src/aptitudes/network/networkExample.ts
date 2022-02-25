import { network } from '@oliveai/ldk';
import { oneLine } from 'common-tags';
import { add, format } from 'date-fns';

import { NetworkWhisper } from '../../whispers';

const run = async () => {
  // const currentDate = new Date();
  // const threeMonthsAgo = add(currentDate, { months: -3 });
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
  // url: `https://raw.githubusercontent.com/AmitXShukla/SCM_Rx_Inventory_OLIVEai/main/assets/json/alerts.json`,

  const request1: network.HTTPRequest = {
    method: 'GET',
    headers: { "Content-Type": ["application/json"] },
    url: "https://t7gfwerxpcslwfy-elishdb.adb.us-phoenix-1.oraclecloudapps.com/ords/admin/p2p/sysalerts/A",
  };
  const req = network.httpRequest
  const request2: network.HTTPRequest = {
    method: 'GET',
    url: "https://raw.githubusercontent.com/AmitXShukla/SCM_Rx_Inventory_OLIVEai/main/assets/json/alerts.json",
  };
  try {
    console.log("print res")
    const response = await network.httpRequest(request1);
    const decodedBody = await network.decode(response.body);
    console.log("data from OCI:", decodedBody)
    const parsedObject = JSON.parse(decodedBody);
    const recalls = parsedObject.items;
    const whisper = new NetworkWhisper(recalls);
    whisper.show();
  } catch (error) {
    console.log("error:", error)
    // console.log("calling backup REST API:")
    const response = await network.httpRequest(request2);
    const decodedBody = await network.decode(response.body);
    const parsedObject = JSON.parse(decodedBody);
    const recalls = parsedObject.results;
    const whisper = new NetworkWhisper(recalls);
    whisper.show();
  }
};

export default { run };
