From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 13/15] ide: add ata_set{_max}_pio()
Date: Sat, 30 Jun 2007 22:31:09 +0200
Message-ID: <200706302231.10032.bzolnier@gmail.com>
References: <200706302111.29322.bzolnier@gmail.com> <4686B70F.9080606@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:8308 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbXF3UOs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jun 2007 16:14:48 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1777304mue
        for <linux-ide@vger.kernel.org>; Sat, 30 Jun 2007 13:14:46 -0700 (PDT)
In-Reply-To: <4686B70F.9080606@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org


Hi,

On Saturday 30 June 2007, Jeff Garzik wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > * Add IDE_HFLAG_ABUSE_{PREFETCH,FAST_DEVSEL,DMA_MODES} flags
> >   and set them in ht6560, cmd640, cmd64x and sc1200 host drivers.
> > 
> > * Add set_pio_mode_abuse() for checking if host driver has a non-standard
> >   ->tuneproc() implementation and use it in do_special().
> > 
> > * Add ata_set_pio() for setting PIO mode (it uses hwif->pio_mask to find
> >   the maximum PIO mode supported by the host), also add ata_set_max_pio()
> >   wrapper for ata_set_pio() to use for auto-tuning.  Convert users of
> >   ->tuneproc to use ata_set{_max}_pio() where possible.  This leaves only
> >   do_special(), set_using_pio(), ide_hwif_restore() and ata_set_pio() as
> >   a direct users of ->tuneproc.
> > 
> > * Remove no longer needed ide_get_best_pio_mode() calls and printk-s
> >   reporting PIO mode selected from ->tuneproc implementations.
> > 
> > * Rename ->tuneproc hook to ->set_pio_mode and make 'pio' argument const.
> > 
> > * Remove stale comment from ide_config_drive_speed().
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> It seems highly inconsistent for drivers/ide to use the "ide_" prefix 
> the vast majority of the time, but then "ata_" prefix in this one case, 

This has been changing recently since "ide_" prefix seems to have
negative emotional connotations. :-)

New patches for drivers/ide should use exclusively the "ata_" prefix.

> particularly when libata uses the "ata_" prefix almost exclusively.

I don't see *any* problem with this since libata exists in the separate
directory and the amount of code shared between libata and drivers/ide
equals *zero* (not counting <linux/ata.h> containing defines etc).

Thanks,
Bart
