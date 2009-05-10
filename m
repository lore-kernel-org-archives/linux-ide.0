From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 14/14] ide: unify interrupt reason checking
Date: Sun, 10 May 2009 23:39:37 +0200
Message-ID: <200905102339.38126.bzolnier@gmail.com>
References: <1241855134-4984-1-git-send-email-petkovbb@gmail.com> <1241855134-4984-15-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:4536 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166AbZEJVgG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 May 2009 17:36:06 -0400
In-Reply-To: <1241855134-4984-15-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 09 May 2009 09:45:34 Borislav Petkov wrote:
> Add ide_check_ireason() function that handles all ATAPI devices. Move
> the ATAPI_COD check later in the if-else chain since the case for
> ATAPI_COD to be set is rather unlikely in a normal operation. Also, add
> a branch predictor hint for it. Generally, move all unlikely cases in
> ireason checking further down in the code path.
> 
> In addition, add PFX for printks originating from ide-atapi. Finally,
> remove ide_cd_check_ireason.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> ---
>  drivers/ide/ide-atapi.c |   94 ++++++++++++++++++++++++++++++++++-------------
>  drivers/ide/ide-cd.c    |   48 +-----------------------
>  include/linux/ide.h     |    2 +
>  3 files changed, 71 insertions(+), 73 deletions(-)

[...]

> @@ -324,6 +327,56 @@ void ide_read_bcount_and_ireason(ide_drive_t *drive, u16 *bcount, u8 *ireason)
>  EXPORT_SYMBOL_GPL(ide_read_bcount_and_ireason);
>  
>  /*
> + * Check the contents of the interrupt reason register and attempt to recover if
> + * there are problems.
> + *
> + * Returns:
> + * - 0 if everything's ok
> + * - 1 if the request has to be terminated.
> + */
> +int ide_check_ireason(ide_drive_t *drive, struct request *rq, int len,
> +		      int ireason, int rw)
> +{
> +	ide_hwif_t *hwif = drive->hwif;
> +
> +	debug_log("ireason: 0x%x, rw: 0x%x\n", ireason, rw);
> +
> +	if (ireason == (!rw << 1))
> +		return 0;
> +	else if (ireason == (rw << 1)) {
> +		printk(KERN_ERR PFX "%s: %s: wrong transfer direction!\n",
> +				drive->name, __func__);
> +
> +		if (dev_is_idecd(drive))
> +			ide_pad_transfer(drive, rw, len);
> +	}
> +	else if (!rw && ireason == ATAPI_COD) {

ERROR: else should follow close brace '}'
#90: FILE: drivers/ide/ide-atapi.c:353:
+       }
+       else if (!rw && ireason == ATAPI_COD) {

> +		if (dev_is_idecd(drive)) {
> +			/*
> +			 * some drives (ASUS) seem to tell us that status info

s/some/Some/

> +			 * is available.  Just get it and ignore.
> +			 */
> +			(void)hwif->tp_ops->read_status(hwif);
> +			return 0;
> +		}
> +	} else {
> +		if (unlikely(ireason & ATAPI_COD))
> +			printk(KERN_ERR PFX "%s: CoD != 0 in %s\n", drive->name,
> +					__func__);

This is redundant given printk() below and using unlikely() in error-only
code-paths is overdoing it a bit (putting it very mildly)...

> +		/* drive wants a command packet, or invalid ireason... */
> +		printk(KERN_ERR PFX "%s: %s: bad interrupt reason 0x%02x\n",
> +				drive->name, __func__, ireason);

> @@ -501,13 +543,13 @@ static u8 ide_wait_ireason(ide_drive_t *drive, u8 ireason)
>  
>  	while (retries-- && ((ireason & ATAPI_COD) == 0 ||
>  		(ireason & ATAPI_IO))) {
> -		printk(KERN_ERR "%s: (IO,CoD != (0,1) while issuing "
> +		printk(KERN_ERR PFX "%s: (IO,CoD != (0,1) while issuing "

WARNING: line over 80 characters
#203: FILE: drivers/ide/ide-atapi.c:625:
+                       printk(KERN_ERR PFX "%s: (IO,CoD) != (0,1) while issuing "

[ Please remember about checkpatch.pl. ]

> @@ -652,9 +608,7 @@ static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
>  		goto out_end;
>  	}
>  
> -	/* check which way to transfer data */
> -	rc = ide_cd_check_ireason(drive, rq, len, ireason, write);
> -	if (rc)
> +	if (ide_check_ireason(drive, rq, len, ireason, write))
>  		goto out_end;

This introduces a real bug -- we check rc's value in "out_end" path.
