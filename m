From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: FUA and 311x (was Re: LibPATA code issues / 2.6.15.4)
Date: Wed, 01 Mar 2006 22:18:24 -0500
Message-ID: <44066400.6070503@pobox.com>
References: <1141239617.23202.5.camel@rousalka.dyndns.org>	 <4405F471.8000602@rtr.ca>	 <1141254762.11543.10.camel@rousalka.dyndns.org>	 <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com>	 <440650BC.5090501@pobox.com> <4406512A.9080708@pobox.com>	 <311601c90603011820u4fc89b04te1be39b9ed2ef35b@mail.gmail.com>	 <44065C7C.6090509@pobox.com> <311601c90603011900q7fe21fbx1020e4ba4062dc24@mail.gmail.com> <44066132.4010205@pobox.com> <44066378.1080408@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:24215 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751945AbWCBDS3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Mar 2006 22:18:29 -0500
In-Reply-To: <44066378.1080408@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: "Eric D. Mudama" <edmudama@gmail.com>, Jens Axboe <axboe@suse.de>, Tejun Heo <htejun@gmail.com>, Nicolas Mailhot <nicolas.mailhot@gmail.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Carlos Pardo <Carlos.Pardo@siliconimage.com>

Mark Lord wrote:
> Jeff Garzik wrote:
> ..
> 
>> Sounds like un-blacklisting the drive, and adding ATA_FLAG_NO_FUA is 
>> the way to go...
> 
> 
> Might as well add sata_mv to that blacklist as well.

Have you confirmed that it doesn't work with FUA?

We recently patched sata_mv to add ATA_CMD_WRITE_FUA_EXT, in response to 
a nasty bug report, and ISTR the complainer went away.


> And while I'm at it, the pdc_adma and sata_qstor controllers/drivers are 
> fine with FUA.

Verified or just guessing?

	Jeff


