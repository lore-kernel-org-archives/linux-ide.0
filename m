From: Jens Axboe <axboe@suse.de>
Subject: Re: Marvell MV88SX6041 SATA Driver PIO4 Mode Not DMA
Date: Tue, 15 Nov 2005 08:57:25 +0100
Message-ID: <20051115075724.GT3699@suse.de>
References: <1131648518.26701.247242836@webmail.messagingengine.com> <437471D0.3090404@pobox.com> <20051111121447.GQ3699@suse.de> <4374A4AC.8010007@pobox.com> <20051111142905.GV3699@suse.de> <20051111143850.GX3699@suse.de> <43790315.7000804@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:1828 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932325AbVKOH4U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Nov 2005 02:56:20 -0500
Content-Disposition: inline
In-Reply-To: <43790315.7000804@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Spencer Tuttle <rodeojones@fastmail.fm>, linux-ide@vger.kernel.org

On Mon, Nov 14 2005, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Fri, Nov 11 2005, Jens Axboe wrote:
> >
> >>On Fri, Nov 11 2005, Jeff Garzik wrote:
> >>
> >>>Jens Axboe wrote:
> >>>
> >>>>On Fri, Nov 11 2005, Jeff Garzik wrote:
> >>>>
> >>>>
> >>>>>Spencer Tuttle wrote:
> >>>>>
> >>>>>
> >>>>>>I have just compiled the new 2.6.14 kernel from the gentoo-sources 
> >>>>>>tree.
> >>>>>>
> >>>>>>I can access the drives just fine, but it seems really slow.  Here is
> >>>>>>the dmesg output when I load the kernel module
> >>>>>
> >>>>>That's expected, since the driver in 2.6.14 only does PIO mode.
> >>>>>
> >>>>>Try 2.6.14-gitN which supports EDMA.
> >>>>
> >>>>
> >>>>Did you see these as well:
> >>>>
> >>>>blk_queue_max_hw_segments: set to minimum 1
> >>>>
> >>>>Could it be forgetting to set ->sg_tablesize as well?
> >>>
> >>>[jgarzik@sata linux-2.6]$ grep MV_MAX_SG_CT drivers/scsi/sata_mv.c
> >>>       MV_MAX_SG_CT            = 176,
> >>>       MV_SG_TBL_SZ            = (16 * MV_MAX_SG_CT),
> >>>       .sg_tablesize           = MV_MAX_SG_CT,
> >>
> >>It was just a guess, clearly someone is calling scsi_alloc_queue() with
> >>an sdev->host->sg_tablesize of 0. While that wont make PIO a whole lot
> >>faster, it's clearly a bug and would certainly hurt DMA performance.
> >
> >
> >Before commit 31961943e3110c5a1c36b1e0069c29f7c4380e51, sata_mv had
> >->sg_tablesize set to MV_UNDEF which was defined to 0. Just checking,
> >2.6.14 ships with that.
> 
> OK, that version has no DMA support, so that makes sense.

sg_tablesize isn't necessarily tied to dma support, but the performance
difference should be marginal so...

> I guess the gist of the thread is, sg_tablesize should never be less 
> than one, even if "it would hurt DMA performance"?

Precisely, a request with zero segments doesn't make sense for any
request carrying data.

-- 
Jens Axboe

