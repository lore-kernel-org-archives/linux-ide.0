From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11-rc2 08/09] ide: map ide_cmd_ioctl() to ide_taskfile_ioctl()
Date: Sun, 6 Feb 2005 19:46:49 +0100
Message-ID: <58cb370e050206104674386588@mail.gmail.com>
References: <20050205021502.GA17767@htj.dyndns.org>
	 <20050205021557.6A692132705@htj.dyndns.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.193]:12395 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261289AbVBFSqx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Feb 2005 13:46:53 -0500
Received: by wproxy.gmail.com with SMTP id 67so746006wri
        for <linux-ide@vger.kernel.org>; Sun, 06 Feb 2005 10:46:49 -0800 (PST)
In-Reply-To: <20050205021557.6A692132705@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@home-tj.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

I have not fully reviewed it yet but I've noticed two things...

> @@ -648,11 +648,11 @@ u8 eighty_ninty_three (ide_drive_t *driv
> 
>  EXPORT_SYMBOL(eighty_ninty_three);
> 
> -int ide_ata66_check (ide_drive_t *drive, ide_task_t *args)
> +int ide_ata66_check(ide_drive_t *drive, task_ioreg_t *regs)
>  {
> -       if ((args->tfRegister[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
> -           (args->tfRegister[IDE_SECTOR_OFFSET] > XFER_UDMA_2) &&
> -           (args->tfRegister[IDE_FEATURE_OFFSET] == SETFEATURES_XFER)) {
> +       if (regs[IDE_COMMAND_OFFSET] == WIN_SETFEATURES &&
> +           regs[IDE_SECTOR_OFFSET] > XFER_UDMA_2 &&
> +           regs[IDE_FEATURE_OFFSET] == SETFEATURES_XFER) {
>  #ifndef CONFIG_IDEDMA_IVB
>                 if ((drive->id->hw_config & 0x6000) == 0) {
>  #else /* !CONFIG_IDEDMA_IVB */

What is the rationale for this change?
ide_task_t is available in ide_cmd_ioctl().

> @@ -678,11 +678,11 @@ int ide_ata66_check (ide_drive_t *drive,
>   * 1 : Safe to update drive->id DMA registers.
>   * 0 : OOPs not allowed.
>   */
> -int set_transfer (ide_drive_t *drive, ide_task_t *args)
> +int set_transfer(ide_drive_t *drive, task_ioreg_t *regs)
>  {
> -       if ((args->tfRegister[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
> -           (args->tfRegister[IDE_SECTOR_OFFSET] >= XFER_SW_DMA_0) &&
> -           (args->tfRegister[IDE_FEATURE_OFFSET] == SETFEATURES_XFER) &&
> +       if (regs[IDE_COMMAND_OFFSET] == WIN_SETFEATURES &&
> +           regs[IDE_SECTOR_OFFSET] >= XFER_SW_DMA_0 &&
> +           regs[IDE_FEATURE_OFFSET] == SETFEATURES_XFER &&
>             (drive->id->dma_ultra ||
>              drive->id->dma_mword ||
>              drive->id->dma_1word))

ditto

> +       io_32bit = drive->io_32bit;
> +       drive->io_32bit = 0;    /* racy */
> +       ret = ide_diag_taskfile(drive, &task, in_size, buf);
> +       drive->io_32bit = io_32bit;

It wasn't racy before this patch.  I know that it is like that
in ide_taskfile_ioctl() but it is not an excuse for propagating
the bug.  It can be easily fixed if you use drive_cmd_intr()
instead of task_in_intr() as task->handler.

Thanks,
Bartlomiej
