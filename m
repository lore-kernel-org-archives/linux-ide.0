From: Sander <sander@humilis.net>
Subject: Re: FUA and 311x (was Re: LibPATA code issues / 2.6.15.4)
Date: Thu, 2 Mar 2006 09:57:47 +0100
Message-ID: <20060302085747.GB8570@favonius>
References: <1141254762.11543.10.camel@rousalka.dyndns.org> <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com> <440650BC.5090501@pobox.com> <4406512A.9080708@pobox.com> <311601c90603011820u4fc89b04te1be39b9ed2ef35b@mail.gmail.com> <44065C7C.6090509@pobox.com> <311601c90603011900q7fe21fbx1020e4ba4062dc24@mail.gmail.com> <44066132.4010205@pobox.com> <44066378.1080408@rtr.ca> <44066400.6070503@pobox.com>
Reply-To: sander@humilis.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ookhoi.xs4all.nl ([213.84.114.66]:26531 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1751973AbWCBI5d (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Mar 2006 03:57:33 -0500
Content-Disposition: inline
In-Reply-To: <44066400.6070503@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <lkml@rtr.ca>, "Eric D. Mudama" <edmudama@gmail.com>, Jens Axboe <axboe@suse.de>, Tejun Heo <htejun@gmail.com>, Nicolas Mailhot <nicolas.mailhot@gmail.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Carlos Pardo <Carlos.Pardo@siliconimage.com>

Jeff Garzik wrote (ao):
> Mark Lord wrote:
> >Jeff Garzik wrote:
> >..
> >
> >>Sounds like un-blacklisting the drive, and adding ATA_FLAG_NO_FUA is 
> >>the way to go...
> >
> >
> >Might as well add sata_mv to that blacklist as well.
> 
> Have you confirmed that it doesn't work with FUA?
> 
> We recently patched sata_mv to add ATA_CMD_WRITE_FUA_EXT, in response to 
> a nasty bug report, and ISTR the complainer went away.

That is correct. I was that complainer and reported that the patch works
for me: http://lkml.org/lkml/2006/2/15/175

Also, the patch went into the next -rc kernel that time.

	Sander

PS, can I get you guys interested in the sata_mv driver? I would really
love to use Marvell controller:
http://www.ussg.iu.edu/hypermail/linux/kernel/0602.2/0914.html

I'd be very happy to test any patches and will report how they do.

-- 
Humilis IT Services and Solutions
http://www.humilis.net
