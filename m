From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/3] ide: IORDY handling fixes
Date: Sun, 14 Jun 2009 00:47:25 +0400
Message-ID: <4A34105D.70507@ru.mvista.com>
References: <200906131822.22343.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:57389 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751941AbZFMUrb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 Jun 2009 16:47:31 -0400
In-Reply-To: <200906131822.22343.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> Add ide_pio_need_iordy() helper and convert host drivers to use it.
>
> This fixes it8172, it8213, pdc202xx_old, piix, slc90e66 and siimage
> host drivers to handle IORDY correctly.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>   

[...]

> Index: b/drivers/ide/ide-xfer-mode.c
> ===================================================================
> --- a/drivers/ide/ide-xfer-mode.c
> +++ b/drivers/ide/ide-xfer-mode.c
> @@ -107,6 +107,12 @@ u8 ide_get_best_pio_mode(ide_drive_t *dr
>  }
>  EXPORT_SYMBOL_GPL(ide_get_best_pio_mode);
>  
> +int ide_pio_need_iordy(ide_drive_t *drive, const u8 pio)
> +{
> +	return ata_id_pio_need_iordy(drive->id, pio);
> +}
> +EXPORT_SYMBOL_GPL(ide_pio_need_iordy);
>   

   Hm, why there was a need for such a wrapper? Why not just call it 
directly?

> Index: b/drivers/ide/it8213.c
> ===================================================================
> --- a/drivers/ide/it8213.c
> +++ b/drivers/ide/it8213.c
> @@ -50,7 +50,7 @@ static void it8213_set_pio_mode(ide_driv
>  		control |= 1;	/* Programmable timing on */
>  	if (drive->media != ide_disk)
>  		control |= 4;	/* ATAPI */
> -	if (pio > 2)
> +	if (ide_pio_need_iordy(drive, pio))
>  		control |= 2;	/* IORDY */
>  	if (is_slave) {
>  		master_data |=  0x4000;
> Index: b/drivers/ide/pdc202xx_old.c
> ===================================================================
> --- a/drivers/ide/pdc202xx_old.c
> +++ b/drivers/ide/pdc202xx_old.c
> @@ -73,7 +73,7 @@ static void pdc202xx_set_mode(ide_drive_
>  		 * Prefetch_EN / IORDY_EN / PA[3:0] bits of register A
>  		 */
>  		AP &= ~0x3f;
> -		if (ata_id_iordy_disable(drive->id))
>   

   Hm, now that was surely wrong...

> +		if (ide_pio_need_iordy(drive, speed - XFER_PIO_0))
>  			AP |= 0x20;	/* set IORDY_EN bit */
>  		if (drive->media == ide_disk)
>  			AP |= 0x10;	/* set Prefetch_EN bit */
>   

[...]

MBR, Sergei


