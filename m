From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 12/12] ide: use do_rw_taskfile() in flagged_taskfile()
Date: Thu, 25 Oct 2007 00:03:57 +0400
Message-ID: <471FA52D.3080506@ru.mvista.com>
References: <200710082320.31069.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:34852 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755139AbXJXUDs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Oct 2007 16:03:48 -0400
In-Reply-To: <200710082320.31069.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

Bartlomiej Zolnierkiewicz wrote:

> Based on the earlier work by Tejun Heo.

> * Move setting IDE_TFLAG_LBA48 taskfile flag from do_rw_taskfile()
>   function to the callers.

> * Add IDE_TFLAG_FLAGGED taskfile flag for flagged taskfiles coming
>   from ide_taskfile_ioctl().  Check it instead of ->tf_out_flags.all.

> * Add IDE_TFLAG_OUT_DATA taskfile flag to indicate the need to load
>   IDE data register in ide_tf_load().

> * Add IDE_TFLAG_OUT_* taskfile flags to indicate the need to load
>   particular IDE taskfile registers in ide_tf_load().

   These two last paragraphs seem like being kind of duplication. Doesn't the 
latter include the former one?

> * Update do_rw_taskfile() and ide_tf_load() users to set respective
>   IDE_TFLAG_OUT_* taksfile flags.

> * Add task_dma_ok() helper.

> * Use IDE_TFLAG_FLAGGED taskfile flag to select HIHI mask in ide_tf_load().

> * Use do_rw_taskfile() in flagged_taskfile().

> * Remove no longer needed 'tf_out_flags' field from ide_task_t.

> There should be no functionality changes caused by this patch.

[...]

> Index: b/drivers/ide/ide-taskfile.c
> ===================================================================
> --- a/drivers/ide/ide-taskfile.c
> +++ b/drivers/ide/ide-taskfile.c
> @@ -68,25 +68,39 @@ void ide_tf_load(ide_drive_t *drive, ide
>  	struct ide_taskfile *tf = &task->tf;
>  	u8 HIHI = (task->tf_flags & IDE_TFLAG_LBA48) ? 0xE0 : 0xEF;
>  
> +	if (task->tf_flags & IDE_TFLAG_FLAGGED)
> +		HIHI = 0xFF;

    Hm, what that's for?

>  	if (IDE_CONTROL_REG)
>  		hwif->OUTB(drive->ctl, IDE_CONTROL_REG); /* clear nIEN */

    Does this set the HOB bit?

>  
>  	if ((task->tf_flags & IDE_TFLAG_NO_SELECT_MASK) == 0)
>  		SELECT_MASK(drive, 0);
>  
> -	if (task->tf_flags & IDE_TFLAG_LBA48) {
> +	if (task->tf_flags & IDE_TFLAG_OUT_DATA)
> +		hwif->OUTW((tf->hob_data << 8) | tf->data, IDE_DATA_REG);

    I wonder which commands could require a single data register write...

> +	if (task->tf_flags & IDE_TFLAG_OUT_HOB_FEATURE)
>  		hwif->OUTB(tf->hob_feature, IDE_FEATURE_REG);
> +	if (task->tf_flags & IDE_TFLAG_OUT_HOB_NSECT)
>  		hwif->OUTB(tf->hob_nsect, IDE_NSECTOR_REG);
> +	if (task->tf_flags & IDE_TFLAG_OUT_HOB_LBAL)
>  		hwif->OUTB(tf->hob_lbal, IDE_SECTOR_REG);
> +	if (task->tf_flags & IDE_TFLAG_OUT_HOB_LBAM)
>  		hwif->OUTB(tf->hob_lbam, IDE_LCYL_REG);
> +	if (task->tf_flags & IDE_TFLAG_OUT_HOB_LBAH)
>  		hwif->OUTB(tf->hob_lbah, IDE_HCYL_REG);
> -	}

    I'm not sure we're in HOB mode now... :-|

MBR, Sergei
