From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: FUA and 311x (was Re: LibPATA code issues / 2.6.15.4)
Date: Thu, 02 Mar 2006 06:52:55 -0500
Message-ID: <4406DC97.3030606@pobox.com>
References: <1141239617.23202.5.camel@rousalka.dyndns.org>	 <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com>	 <440650BC.5090501@pobox.com> <4406512A.9080708@pobox.com>	 <311601c90603011820u4fc89b04te1be39b9ed2ef35b@mail.gmail.com>	 <44065C7C.6090509@pobox.com>	 <311601c90603011900q7fe21fbx1020e4ba4062dc24@mail.gmail.com>	 <44066132.4010205@pobox.com> <44066378.1080408@rtr.ca>	 <44066400.6070503@pobox.com> <311601c90603012223j10aef3e0s3158567594bb9791@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:65461 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750709AbWCBLxB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Mar 2006 06:53:01 -0500
In-Reply-To: <311601c90603012223j10aef3e0s3158567594bb9791@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: Mark Lord <lkml@rtr.ca>, Jens Axboe <axboe@suse.de>, Tejun Heo <htejun@gmail.com>, Nicolas Mailhot <nicolas.mailhot@gmail.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Carlos Pardo <Carlos.Pardo@siliconimage.com>

Eric D. Mudama wrote:
> On 3/1/06, Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>Mark Lord wrote:
>>
>>>Jeff Garzik wrote:
>>>..
>>>
>>>
>>>>Sounds like un-blacklisting the drive, and adding ATA_FLAG_NO_FUA is
>>>>the way to go...
>>>
>>>
>>>Might as well add sata_mv to that blacklist as well.
>>
>>Have you confirmed that it doesn't work with FUA?
> 
> 
> I'll see if I can find one of these around the lab tomorrow and test
> the raw command support.  If that's fine at a basic level, it might be
> a bug in the driver?

Quite possibly.  Anything goes with sata_mv at the moment...  I've done 
my best to cover most of the errata and get it working, but there are 
still some key errata workarounds missing.  It's still marked "HIGHLY 
EXPERIMENTAL" in the Kconfig ;-)

	Jeff



