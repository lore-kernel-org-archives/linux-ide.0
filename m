From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ide: add ide_set{_max}_pio() (take 2)
Date: Sat, 30 Jun 2007 18:40:36 -0400
Message-ID: <4686DBE4.2060702@garzik.org>
References: <200707010046.15532.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38793 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752815AbXF3Wkj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Jun 2007 18:40:39 -0400
In-Reply-To: <200707010046.15532.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> * Add IDE_HFLAG_ABUSE_{PREFETCH,FAST_DEVSEL,DMA_MODES} flags
>   and set them in ht6560, cmd640, cmd64x and sc1200 host drivers.
> 
> * Add set_pio_mode_abuse() for checking if host driver has a non-standard
>   ->tuneproc() implementation and use it in do_special().
> 
> * Add ide_set_pio() for setting PIO mode (it uses hwif->pio_mask to find
>   the maximum PIO mode supported by the host), also add ide_set_max_pio()
>   wrapper for ide_set_pio() to use for auto-tuning.  Convert users of
>   ->tuneproc to use ide_set{_max}_pio() where possible.  This leaves only
>   do_special(), set_using_pio(), ide_hwif_restore() and ide_set_pio() as
>   a direct users of ->tuneproc.
> 
> * Remove no longer needed ide_get_best_pio_mode() calls and printk-s
>   reporting PIO mode selected from ->tuneproc implementations.
> 
> * Rename ->tuneproc hook to ->set_pio_mode and make 'pio' argument const.
> 
> * Remove stale comment from ide_config_drive_speed().
> 
> v2:
> * Fix "ata_" prefix (Noticed by Jeff).
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Cc: Jeff Garzik <jeff@garzik.org>

Thanks Bart!

	Jeff


