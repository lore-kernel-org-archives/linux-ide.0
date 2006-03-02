From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: FUA and 311x (was Re: LibPATA code issues / 2.6.15.4)
Date: Wed, 1 Mar 2006 23:23:37 -0700
Message-ID: <311601c90603012223j10aef3e0s3158567594bb9791@mail.gmail.com>
References: <1141239617.23202.5.camel@rousalka.dyndns.org>
	 <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com>
	 <440650BC.5090501@pobox.com> <4406512A.9080708@pobox.com>
	 <311601c90603011820u4fc89b04te1be39b9ed2ef35b@mail.gmail.com>
	 <44065C7C.6090509@pobox.com>
	 <311601c90603011900q7fe21fbx1020e4ba4062dc24@mail.gmail.com>
	 <44066132.4010205@pobox.com> <44066378.1080408@rtr.ca>
	 <44066400.6070503@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.197]:50132 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751397AbWCBGXj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Mar 2006 01:23:39 -0500
Received: by wproxy.gmail.com with SMTP id i27so334517wra
        for <linux-ide@vger.kernel.org>; Wed, 01 Mar 2006 22:23:38 -0800 (PST)
In-Reply-To: <44066400.6070503@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <lkml@rtr.ca>, Jens Axboe <axboe@suse.de>, Tejun Heo <htejun@gmail.com>, Nicolas Mailhot <nicolas.mailhot@gmail.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Carlos Pardo <Carlos.Pardo@siliconimage.com>

On 3/1/06, Jeff Garzik <jgarzik@pobox.com> wrote:
> Mark Lord wrote:
> > Jeff Garzik wrote:
> > ..
> >
> >> Sounds like un-blacklisting the drive, and adding ATA_FLAG_NO_FUA is
> >> the way to go...
> >
> >
> > Might as well add sata_mv to that blacklist as well.
>
> Have you confirmed that it doesn't work with FUA?

I'll see if I can find one of these around the lab tomorrow and test
the raw command support.  If that's fine at a basic level, it might be
a bug in the driver?
