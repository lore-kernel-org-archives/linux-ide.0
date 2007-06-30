From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: add ide_set{_max}_pio() (take 2)
Date: Sun, 1 Jul 2007 01:05:33 +0200
Message-ID: <200707010105.33488.bzolnier@gmail.com>
References: <200707010046.15532.bzolnier@gmail.com> <4686DBE4.2060702@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:42586 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbXF3WtV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jun 2007 18:49:21 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1035544ugf
        for <linux-ide@vger.kernel.org>; Sat, 30 Jun 2007 15:49:20 -0700 (PDT)
In-Reply-To: <4686DBE4.2060702@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Sunday 01 July 2007, Jeff Garzik wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > * Add IDE_HFLAG_ABUSE_{PREFETCH,FAST_DEVSEL,DMA_MODES} flags
> >   and set them in ht6560, cmd640, cmd64x and sc1200 host drivers.
> > 
> > * Add set_pio_mode_abuse() for checking if host driver has a non-standard
> >   ->tuneproc() implementation and use it in do_special().
> > 
> > * Add ide_set_pio() for setting PIO mode (it uses hwif->pio_mask to find
> >   the maximum PIO mode supported by the host), also add ide_set_max_pio()
> >   wrapper for ide_set_pio() to use for auto-tuning.  Convert users of
> >   ->tuneproc to use ide_set{_max}_pio() where possible.  This leaves only
> >   do_special(), set_using_pio(), ide_hwif_restore() and ide_set_pio() as
> >   a direct users of ->tuneproc.
> > 
> > * Remove no longer needed ide_get_best_pio_mode() calls and printk-s
> >   reporting PIO mode selected from ->tuneproc implementations.
> > 
> > * Rename ->tuneproc hook to ->set_pio_mode and make 'pio' argument const.
> > 
> > * Remove stale comment from ide_config_drive_speed().
> > 
> > v2:
> > * Fix "ata_" prefix (Noticed by Jeff).
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Cc: Jeff Garzik <jeff@garzik.org>
> 
> Thanks Bart!

np, thanks for bringing my attention to the issue

I just completely forgot about shared namespace / backtraces
and was happily intending to add more "ata_" prefixes to tag
code areas dealt with... :)

I will just blame too much IDE hacking to have caused some
kind of tunnel vision.

Bart
