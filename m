From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 4/5] sata_mv new mv_sata_hardreset handler
Date: Thu, 03 Apr 2008 10:21:23 -0400
Message-ID: <47F4E7E3.2030108@rtr.ca>
References: <47F1736F.8020104@rtr.ca> <47F1755F.9000303@rtr.ca> <47F2F002.9070401@gmail.com> <47F3E3A8.10309@rtr.ca> <47F429B0.7020204@gmail.com> <47F44572.5010100@rtr.ca> <47F44BCB.7030005@gmail.com> <47F4E341.9080609@rtr.ca> <47F4E3E4.5080706@rtr.ca> <47F4E530.5040901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2352 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756998AbYDCOVY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Apr 2008 10:21:24 -0400
In-Reply-To: <47F4E530.5040901@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Tejun Heo wrote:
> Mark Lord wrote:
>> Though, mind you.. as soon as your rework *does* hit upstream,
>> I'll happily submit further sata_mv patches to take full advantage.
>>
>> The less custom code in sata_mv in the end, the happier I'll be.
>> That's why there's a comment there right now reminding me of it.
> 
> Yeap, I fully agree.  Also, the said change will probably go into 2.6.26 
> too.  It's unfortunate that your sata_mv work overlaps too much with 
> recent API overhauls.  I don't know how Jeff will merge stuff but 
> merging sata_mv changes first is fine by me.  I'll update API changes 
> accordingly and run it by you.
..

Mmm.. I still need a way to handle access to the port-multiplier registers.
We never did resolve that one fully on the earlier pass.

It would be great if Jeff could just merge the API stuff now,
so LLD changes for 2.6.26 could then build on top of the updated API.

Doing it all at the final-minute merge window just doesn't leave
me enough real-time to go through the Marvell review processes.

Cheers
