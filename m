From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: add cable detection for early UDMA66 devices (take
 2)
Date: Mon, 06 Aug 2007 20:27:06 +0400
Message-ID: <46B74BDA.8010201@ru.mvista.com>
References: <200707291949.46232.bzolnier@gmail.com> <46ADF515.10302@ru.mvista.com> <200708030017.27362.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:10400 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754524AbXHFQZF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Aug 2007 12:25:05 -0400
In-Reply-To: <200708030017.27362.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Craig Block <chblock3@yahoo.com>

Bartlomiej Zolnierkiewicz wrote:

>>> 	if (hwif->cbl == ATA_CBL_PATA40_SHORT)
>>> 		return 1;

>>    Wait, shouldn't this check come ahead of all the other code since we're 
>>basically overriding every other check with it?

> Fixed.

    Hm, not completely but well...

> [PATCH] ide: add cable detection for early UDMA66 devices (take 3)

> * Move ide_in_drive_list() from ide-dma.c to ide-iops.c.

> * Add ivb_list[] table for listening early UDMA66 devices which don't conform
>   to ATA4 standard wrt cable detection (bit14 is zero, only bit13 is valid)
>   and use only device side cable detection for them since host side cable
>   detection may be unreliable.

> * Add model "QUANTUM FIREBALLlct10 05" with firwmare "A03.0900" to the list
>   (from Craig's bugreport).

> v2:
> * Improve kernel message basing on suggestion from Sergei.

> v3:
> * Don't print kernel message when no device side cable detection is done,
>   plus some minor fixes.  (Noticed by Sergei)

> Thanks to Craig for testing this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: b/drivers/ide/ide-dma.c
> ===================================================================
> --- a/drivers/ide/ide-dma.c
> +++ b/drivers/ide/ide-dma.c
> @@ -135,25 +135,6 @@ static const struct drive_list_entry dri
>  };
>  
>  /**
> - *	ide_in_drive_list	-	look for drive in black/white list
> - *	@id: drive identifier
> - *	@drive_table: list to inspect
> - *
> - *	Look for a drive in the blacklist and the whitelist tables
> - *	Returns 1 if the drive is found in the table.
> - */
> -
> -int ide_in_drive_list(struct hd_driveid *id, const struct drive_list_entry *drive_table)
> -{
> -	for ( ; drive_table->id_model ; drive_table++)
> -		if ((!strcmp(drive_table->id_model, id->model)) &&
> -		    (!drive_table->id_firmware ||
> -		     strstr(id->fw_rev, drive_table->id_firmware)))
> -			return 1;
> -	return 0;
> -}
> -
> -/**
>   *	ide_dma_intr	-	IDE DMA interrupt handler
>   *	@drive: the drive the interrupt is for
>   *
> Index: b/drivers/ide/ide-iops.c
> ===================================================================
> --- a/drivers/ide/ide-iops.c
> +++ b/drivers/ide/ide-iops.c
[...]
> @@ -573,11 +601,16 @@ u8 eighty_ninty_three (ide_drive_t *driv
>  {
>  	ide_hwif_t *hwif = drive->hwif;
>  	struct hd_driveid *id = drive->id;
> +	int ivb = ide_in_drive_list(id, ivb_list);

    Why do a loockup if we may override it anyway?

>  	if (hwif->cbl == ATA_CBL_PATA40_SHORT)
>  		return 1;

MBR, Sergei
