From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/7] it821x: use ide_get_pair_dev() helper
Date: Mon, 22 Dec 2008 13:11:38 +0300
Message-ID: <494F67DA.2090903@ru.mvista.com>
References: <20081221210007.23795.27999.sendpatchset@localhost.localdomain> <20081221210029.23795.66085.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:45154 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750785AbYLVKLo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Dec 2008 05:11:44 -0500
In-Reply-To: <20081221210029.23795.66085.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Because presence of the peer device was not checked in
> it821x_set_pio_mode() PIO0 mode was used for taskfile PIO
> in single device configurations.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>   

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: b/drivers/ide/it821x.c
> ===================================================================
> --- a/drivers/ide/it821x.c
> +++ b/drivers/ide/it821x.c
> @@ -167,12 +167,10 @@ static void it821x_clock_strategy(ide_dr
>  	ide_hwif_t *hwif = drive->hwif;
>  	struct pci_dev *dev = to_pci_dev(hwif->dev);
>  	struct it821x_dev *itdev = ide_get_hwifdata(hwif);
> -	ide_drive_t *pair;
> +	ide_drive_t *pair = ide_get_pair_dev(drive);
>  	int clock, altclock, sel = 0;
>  	u8 unit = drive->dn & 1, v;
>  
> -	pair = &hwif->drives[1 - unit];
> -
>  	if(itdev->want[0][0] > itdev->want[1][0]) {
>  		clock = itdev->want[0][1];
>  		altclock = itdev->want[1][1];
> @@ -239,15 +237,13 @@ static void it821x_set_pio_mode(ide_driv
>  {
>  	ide_hwif_t *hwif = drive->hwif;
>  	struct it821x_dev *itdev = ide_get_hwifdata(hwif);
> -	ide_drive_t *pair;
> +	ide_drive_t *pair = ide_get_pair_dev(drive);
>  	u8 unit = drive->dn & 1, set_pio = pio;
>  
>  	/* Spec says 89 ref driver uses 88 */
>  	static u16 pio_timings[]= { 0xAA88, 0xA382, 0xA181, 0x3332, 0x3121 };
>  	static u8 pio_want[]    = { ATA_66, ATA_66, ATA_66, ATA_66, ATA_ANY };
>  
> -	pair = &hwif->drives[1 - unit];
> -
>  	/*
>  	 * Compute the best PIO mode we can for a given device. We must
>  	 * pick a speed that does not cause problems with the other device

  I wonder why this driver was testing 'pair', there was absolutely no 
chance for it being NULL. :-)

MBR, Sergei


