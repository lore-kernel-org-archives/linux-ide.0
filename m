From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/4] sis5513: clear prefetch and postwrite for ATAPI devices
Date: Mon, 03 Sep 2007 18:04:28 +0400
Message-ID: <46DC146C.8050307@ru.mvista.com>
References: <200708092214.18015.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.mvista.com ([63.81.120.155]:61262 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750890AbXICOBj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Sep 2007 10:01:39 -0400
In-Reply-To: <200708092214.18015.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Clear prefetch and postwrite for ATAPI devices instead of depending on BIOS.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: b/drivers/ide/pci/sis5513.c
> ===================================================================
> --- a/drivers/ide/pci/sis5513.c
> +++ b/drivers/ide/pci/sis5513.c
> @@ -1,5 +1,5 @@
>  /*
> - * linux/drivers/ide/pci/sis5513.c	Version 0.29	Aug 1, 2007
> + * linux/drivers/ide/pci/sis5513.c	Version 0.30	Aug 9, 2007

    Oh, the driver turned 0.30! Insn't a time for party? ;-)

> @@ -522,20 +522,19 @@ static void sis_program_timings(ide_driv
>  		sis_ata133_program_timings(drive, mode);
>  }
>  
> -/* Enables per-drive prefetch and postwrite */
>  static void config_drive_art_rwp (ide_drive_t *drive)
>  {
>  	ide_hwif_t *hwif	= HWIF(drive);
>  	struct pci_dev *dev	= hwif->pci_dev;
> -
>  	u8 reg4bh		= 0;
> -	u8 rw_prefetch		= (0x11 << drive->dn);
> +	u8 rw_prefetch		= 0;
>  
> -	if (drive->media != ide_disk)
> -		return;
>  	pci_read_config_byte(dev, 0x4b, &reg4bh);
>  
> -	if ((reg4bh & rw_prefetch) != rw_prefetch)
> +	if (drive->media == ide_disk)
> +		rw_prefetch = 0x11 << drive->dn;
> +
> +	if ((reg4bh & (0x11 << drive->dn)) != rw_prefetch)
>  		pci_write_config_byte(dev, 0x4b, reg4bh|rw_prefetch);

    ... except of | operator's style. ;-)
