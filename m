From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] libata: increase LBA48 max sectors to 65535
Date: Wed, 15 Feb 2006 16:12:01 +0100
Message-ID: <20060215151200.GW4203@suse.de>
References: <1139754779159-git-send-email-htejun@gmail.com> <43EF8E61.5040409@pobox.com> <43EFD73D.4070207@gmail.com> <43F011DF.6020203@pobox.com> <20060215072449.GA31691@htj.dyndns.org> <20060215130725.GP4203@suse.de> <43F342E6.9060909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:33567 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1945971AbWBOPM6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Feb 2006 10:12:58 -0500
Content-Disposition: inline
In-Reply-To: <43F342E6.9060909@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

On Thu, Feb 16 2006, Tejun Heo wrote:
> Jens Axboe wrote:
> >On Wed, Feb 15 2006, Tejun Heo wrote:
> >
> >>max_hw_sectors/max_sectors separation patch made into the tree,
> >>increase max_sectors to its hardware limit.
> >>
> >>Signed-off-by: Tejun Heo <htejun@gmail.com>
> >>
> >>---
> >>
> >>Jeff, first of all, thanks for the pointer.  I have two more
> >>questions.
> >>
> >>* I make ATA_MAX_SECTORS_LBA48 65535 (the 0000h case is supposed to be
> >> broken, right?); however, the comment says 65534.  Should it be
> >> 65534?
> >
> >
> >Since we never noticed any breakage on !sectors on lba28, I think we can
> >safely assume that !sectors will work fine for lba48 as well. So why not
> >just make it full 64k, eg 65536? ->max_hw_sectors is an unsigned int
> >now, so 64k wont overflow it.
> >
> 
> Hello, Jens.
> 
> libata currently sets max_sectors to 200 (ATA_MAX_SECTORS) on lba28. 
> Are you talking about IDE driver?  IDE driver seems to set max_sectors 
> to 256 on probe and make it 2048 while setting up ide disk if lba48.

Yes I mean the IDE driver. The 200 sector value in libata has always
struck me as being extremely odd and a very bad choice. It's somewhere
in between reasonable defaults, which isn't very nice. I'd suggest just
making it 256 as well, unless Jeff has a reason why it's set to 200.

> Hmmm... Can we really trust all the firmwares?  I just feel that some 
> drive out there ought have screwed up about nsect == 00h/0000h case.

Apparently Windows uses it, so I'd say that should pretty much guarantee
that it will work for us. And as I mentioned, there has never been a
case where the IDE driver value of 256 triggered a drive bug (one time
one was suspected, it turned out to be something else though).

-- 
Jens Axboe

