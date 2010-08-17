From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH #upstream-fixes] pata_cmd64x: revert commit d62f5576
Date: Tue, 17 Aug 2010 18:39:14 +0200
Message-ID: <201008171839.14465.bzolnier@gmail.com>
References: <4C6A7CF6.5090706@kernel.org> <4C6AA436.2090003@kernel.org> <20100817163917.58ea1d06@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43951 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757123Ab0HQQj5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Aug 2010 12:39:57 -0400
Received: by fxm13 with SMTP id 13so3601342fxm.19
        for <linux-ide@vger.kernel.org>; Tue, 17 Aug 2010 09:39:55 -0700 (PDT)
In-Reply-To: <20100817163917.58ea1d06@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jeff@garzik.org>, "\"linux-ide@vger.kernel.org\" st" <linux-ide@vger.kernel.org>, stable <stable@kernel.org>, Milan Kocian <milan.kocian@wq.cz>

On Tuesday 17 August 2010 05:39:17 pm Alan Cox wrote:
> > The old problem is much less severe tho.  The introduced regression
> > causes oops while the old bug probably doesn't show itself too often.
> 
> If ever
> 
> > Does it really need to merge the DMA timings too?  If the device can't
> > do certain timing, it's PIO configuration should reflect that so
> > merging PIO part only should be enough for PIO configuration, no?
> 
> The timing code knows about DMA/PIO constraints itself. The whole mucking
> around passing both timings is just bogus.
> 
> Pass pair->dma_mode only and it'll work out the PIO for you. Not that it
> matters - no real hardware has a DMA mode with a slower address setup
> than its PIO mode.

There were some PIO3/MWDMA1 devices out in the wild (Iomega ZIP IIRC)..

Anyway the patch has never been submitted upstream:

*) I have absolutely no time to support it or related changes

*) it was not critical enough and/or important for other related work
   (it is more important in atang/ide2libata context)

> and for UT just stick in some value (eg 33000) so it works in PCI clocks

Exactly, ->udma is never used by the driver itself..

Thanks.
--
Bartlomiej Zolnierkiewicz
