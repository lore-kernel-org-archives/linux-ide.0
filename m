From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: 40-wire/80-wire detection
Date: Tue, 24 Jul 2007 18:47:16 +0400
Message-ID: <46A610F4.9030306@ru.mvista.com>
References: <305029.41682.qm@web58107.mail.re3.yahoo.com> <200707190032.35039.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:13077 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750933AbXGXOpQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Jul 2007 10:45:16 -0400
In-Reply-To: <200707190032.35039.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Craig Block <chblock3@yahoo.com>, Stephen.Clark@seclark.us, Jeff Garzik <jeff@garzik.org>, Matt Sealey <matt@genesi-usa.com>, linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> [PATCH] ide: add cable detection for early UDMA66 devices

> * Move ide_in_drive_list() from ide-dma.c to ide-iops.c.

> * Add ivb_list[] table for listening early UDMA66 devices which don't conform
>   to ATA4 standard wrt cable detection (bit14 is zero, only bit13 is valid)
>   and use only device side cable detection for them since host side cable
>   detection may be unreliable.

> * Add model "QUANTUM FIREBALLlct10 05" with firwmare "A03.0900" to the list
>   (from Craig's bugreport).

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> Index: b/drivers/ide/ide-iops.c
> ===================================================================
> --- a/drivers/ide/ide-iops.c
> +++ b/drivers/ide/ide-iops.c
> @@ -565,6 +565,34 @@ int ide_wait_stat (ide_startstop_t *star
>  
>  EXPORT_SYMBOL(ide_wait_stat);
>  
> +/**
> + *	ide_in_drive_list	-	look for drive in black/white list
> + *	@id: drive identifier
> + *	@drive_table: list to inspect
> + *
> + *	Look for a drive in the blacklist and the whitelist tables
> + *	Returns 1 if the drive is found in the table.
> + */
> +
> +int ide_in_drive_list(struct hd_driveid *id, const struct drive_list_entry *drive_table)
> +{
> +	for ( ; drive_table->id_model ; drive_table++)
> +		if ((!strcmp(drive_table->id_model, id->model)) &&
> +		    (!drive_table->id_firmware ||
> +		     strstr(id->fw_rev, drive_table->id_firmware)))
> +			return 1;
> +	return 0;
> +}
> +
> +/*
> + * Early UDMA66 devices don't set bit14 to 1, only bit13 is valid.
> + * We list them here and depend on the device side cable detection for them.
> + */
> +static const struct drive_list_entry ivb_list[] = {
> +	{ "QUANTUM FIREBALLlct10 05"	, "A03.0900"	},
> +	{ NULL				, NULL		}
> +};
> +
>  /*
>   *  All hosts that use the 80c ribbon must use!
>   *  The name is derived from upper byte of word 93 and the 80c ribbon.
> @@ -573,11 +601,16 @@ u8 eighty_ninty_three (ide_drive_t *driv
>  {
>  	ide_hwif_t *hwif = drive->hwif;
>  	struct hd_driveid *id = drive->id;
> +	int ivb = ide_in_drive_list(id, ivb_list);
> +
> +	if (ivb)
> +		printk(KERN_DEBUG "%s: enabling IVB cable detection quirk\n",
> +				  drive->name);

    Wound't more explicit message, something like "ignoring word 93 validity 
check" be better?

>  
>  	if (hwif->cbl == ATA_CBL_PATA40_SHORT)
>  		return 1;
>  
> -	if (hwif->cbl != ATA_CBL_PATA80)
> +	if (hwif->cbl != ATA_CBL_PATA80 && !ivb)
>  		goto no_80w;
>  
>  	/* Check for SATA but only if we are ATA5 or higher */
> @@ -587,11 +620,11 @@ u8 eighty_ninty_three (ide_drive_t *driv
>  	/*
>  	 * FIXME:
>  	 * - change master/slave IDENTIFY order
> -	 * - force bit13 (80c cable present) check
> +	 * - force bit13 (80c cable present) check also for !ivb devices
>  	 *   (unless the slave device is pre-ATA3)
>  	 */
>  #ifndef CONFIG_IDEDMA_IVB
> -	if (id->hw_config & 0x4000)
> +	if ((id->hw_config & 0x4000) || (ivb && (id->hw_config & 0x2000)))

    I take it that change renders CONFIG_IDEDMA_IVB basically unneeded -- 
unless for the user which wants to see if his drive needs to be added to the 
list.  Bbut then, the host side cable check may fail, so this doesn't seem a 
reliable test anyway -- so, this code either needs to be changed to behave as 
if the drive was foundin the list or removed completely, shouldn't it?

>  #else
>  	if (id->hw_config & 0x6000)
>  #endif

    BTW, shouldn't ide_ata66_check() also be changed?

MBR, Sergei
