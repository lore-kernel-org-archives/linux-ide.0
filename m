From: Brad Campbell <brad@wasp.net.au>
Subject: Re: Still having problems with sata_promise on all late kernels
Date: Tue, 14 Aug 2007 14:42:37 +0400
Message-ID: <46C1871D.2030006@wasp.net.au>
References: <46C11BBE.6010802@wasp.net.au> <46C181FD.8040708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:39939 "EHLO wasp.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754423AbXHNKmr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Aug 2007 06:42:47 -0400
In-Reply-To: <46C181FD.8040708@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Brad Campbell wrote:
>> G'day all,
>>
>> This has been happening on a lightly loaded box for a while now. I have
>> posted about it before.
>> The issue is now I've upgraded 3 drives from 250GB Maxtors to 750GB
>> WD's, it's just getting worse, particularly when the drives are loaded.
>> I've jumpered the WD's to 1.5GB PHY speed (I had to do that or the
>> on-board via sata controller would not recognise one of the drives.
>> The box is a bit of a mish-mash of controllers. I have 3 Promise
>> SATA150TX4, one SIL3112 (all on PCI cards) and the on-board 2 port VIA
>> driver.
>>
>> I'm at a bit of a loss as to what to do really, short of replacing the
>> Promise cards with something else.
> 
> ATA bus error is a strong indicator for hardware problem.  Please get a
> separate power supply (doesn't have to be an expensive one), power it up
> [1], and connect some of the drives to the power supply and see whether
> errors persist on those drives.
> 

Hrm, I did try that a while back. I'll give that a bash again tonight.

This is only happening on the Promise cards. The drives on the SIL and VIA controllers will work as 
hard as I care to work them and never fault.

I'll try and do a GIT bisection this evening, If I go back to 2.6.16 I get no errors and the system 
works perfectly well. Same can be said for the failure to shut down actually. 2.6.16 worked flawlessly.

Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
