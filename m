From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] libata: increase LBA48 max sectors to 65535
Date: Thu, 16 Feb 2006 08:42:58 +0100
Message-ID: <20060216074258.GF4203@suse.de>
References: <1139754779159-git-send-email-htejun@gmail.com> <43EF8E61.5040409@pobox.com> <43EFD73D.4070207@gmail.com> <43F011DF.6020203@pobox.com> <20060215072449.GA31691@htj.dyndns.org> <20060215130725.GP4203@suse.de> <43F342E6.9060909@gmail.com> <20060215151200.GW4203@suse.de> <43F38D49.4080601@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:29231 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932504AbWBPHnf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Feb 2006 02:43:35 -0500
Content-Disposition: inline
In-Reply-To: <43F38D49.4080601@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, albertcc@tw.ibm.com, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>

On Wed, Feb 15 2006, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Thu, Feb 16 2006, Tejun Heo wrote:
> >
> >>Jens Axboe wrote:
> >>
> >>>On Wed, Feb 15 2006, Tejun Heo wrote:
> >>>
> >>>
> >>>>max_hw_sectors/max_sectors separation patch made into the tree,
> >>>>increase max_sectors to its hardware limit.
> >>>>
> >>>>Signed-off-by: Tejun Heo <htejun@gmail.com>
> >>>>
> >>>>---
> >>>>
> >>>>Jeff, first of all, thanks for the pointer.  I have two more
> >>>>questions.
> >>>>
> >>>>* I make ATA_MAX_SECTORS_LBA48 65535 (the 0000h case is supposed to be
> >>>>broken, right?); however, the comment says 65534.  Should it be
> >>>>65534?
> >>>
> >>>
> >>>Since we never noticed any breakage on !sectors on lba28, I think we can
> >>>safely assume that !sectors will work fine for lba48 as well. So why not
> >>>just make it full 64k, eg 65536? ->max_hw_sectors is an unsigned int
> >>>now, so 64k wont overflow it.
> >>>
> >>
> >>Hello, Jens.
> >>
> >>libata currently sets max_sectors to 200 (ATA_MAX_SECTORS) on lba28. 
> >>Are you talking about IDE driver?  IDE driver seems to set max_sectors 
> >>to 256 on probe and make it 2048 while setting up ide disk if lba48.
> >
> >
> >Yes I mean the IDE driver. The 200 sector value in libata has always
> >struck me as being extremely odd and a very bad choice. It's somewhere
> >in between reasonable defaults, which isn't very nice. I'd suggest just
> >making it 256 as well, unless Jeff has a reason why it's set to 200.
> 
> Its set to 200 for a libata-related reason that I now forget :(

Tsk tsk :-)

> It had nothing to do with controllers or devices, hence the FIXME.

How about making it 256 at the start of a kernel cycle and see if
anything falls apart? If IDE works, then surely SATA should as well.

> As an aside, I wonder if the PRD limit is unnecessarily low.  I don't 
> remember seeing anything that claimed we were limited to 256 s/g entries 
> in the old IDE docs?

As Mark mentions it doesn't matter for lba28, for lba48 it'll typically
gives us at least 256*4k == 1meg of transfer, which is above/at the soft
limit we'll use anyways.

-- 
Jens Axboe

