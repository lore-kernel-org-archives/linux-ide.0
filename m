From: Bruce Stenning <b.stenning@indigovision.com>
Subject: RE: sata_mv port lockup on hotplug (kernel 2.6.38.2)
Date: Fri, 2 Sep 2011 17:22:38 +0100
Message-ID: <C1438B59050E1B4C9482FF3266AD6BA32D8D9854F7@gretna.indigovision.com>
References: <20110430140109.GJ29280@htj.dyndns.org>
 <C1438B59050E1B4C9482FF3266AD6BA32C777089B2@gretna.indigovision.com>
 <20110525094127.GF10146@htj.dyndns.org> <4DF20E03.9030502@teksavvy.com>
 <20110610140155.GJ15235@htj.dyndns.org> <4DF25526.9010800@teksavvy.com>
 <20110611121957.GA7980@mtj.dyndns.org> <4DF4F30B.70702@teksavvy.com>
 <20110613104856.GC16021@htj.dyndns.org>
 <C1438B59050E1B4C9482FF3266AD6BA32D8D984D03@gretna.indigovision.com>
 <20110902011305.GE2752@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gretna.indigovision.com ([62.7.85.227]:1182 "EHLO
	gretna.indigovision.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753259Ab1IBQWl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Sep 2011 12:22:41 -0400
In-Reply-To: <20110902011305.GE2752@htj.dyndns.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <kernel@teksavvy.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

> That's weird.  Another EH is scheduled after one completes but EH
> doesn't kick in.  Hmmm... can't see how that can happen.  How easily
> can you reproduce the problem?
>
> Thanks.

Hi Tejun,

I hope you are well :-)

I have been trying to determine if the problem is that it is failing to
schedule the EH, or whether it is correctly scheduling it but for some
reason it is getting blocked or lost.

Unfortunately it has so far been quite difficult to reproduce when specifically
attempting to.  In normal use cases I reproduced it twice by unplugging a drive
from a RAID array with redundancy intact.  This was out of around a dozen
cycles of waiting until redundancy was restored while the unit was under load,
popping the disk, reinserting, and triggering a RAID rebuild.

I have only twice managed to trigger a lockup deliberately.  In both cases the
tracing showed a scheduled EH which was subsequently not enacted.

How long could it take for the EH to be enacted?  In the lockups that I
have reproduced it did not seem to have recovered minutes later, but perhaps
if I had waited longer...?  I have noticed that error recovery sometimes backs
off for 8s and even 33s, but it always warns when that sort of delay is coming
up.

I shall continue to try to track down why the scheduled EH does not happen.

Kind Regards,

Bruce.


Latest News at: http://www.indigovision.com/index.php/en/news.html
