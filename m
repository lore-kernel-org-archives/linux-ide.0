From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 10/11] ide-pmac: remove nIEN clearing from
	pmac_ide_do_setfeature()
Date: Mon, 23 Jul 2007 08:03:44 +1000
Message-ID: <1185141825.5439.73.camel@localhost.localdomain>
References: <200707222033.55198.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:60432 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760519AbXGVWDt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Jul 2007 18:03:49 -0400
In-Reply-To: <200707222033.55198.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sun, 2007-07-22 at 20:33 +0200, Bartlomiej Zolnierkiewicz wrote:
> Upper layers are responsible for controlling nIEN so don't clear nIEN after
> command execution in pmac_ide_do_setfeature().

Same comment as before regarding the weirdo drive in the wallstreet. I
need to do some tests.

Ben.

> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ide/ppc/pmac.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> Index: b/drivers/ide/ppc/pmac.c
> ===================================================================
> --- a/drivers/ide/ppc/pmac.c
> +++ b/drivers/ide/ppc/pmac.c
> @@ -555,7 +555,6 @@ pmac_ide_do_setfeature(ide_drive_t *driv
>  	result = __ide_wait_stat(drive, drive->ready_stat,
>  				 BUSY_STAT|DRQ_STAT|ERR_STAT,
>  				 WAIT_CMD, &stat);
> -	hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
>  	if (result)
>  		printk(KERN_ERR "%s: pmac_ide_do_setfeature disk not ready "
>  			"after SET_FEATURE !\n", drive->name);

