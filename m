From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11-rc2 26/29] ide: map ide_cmd_ioctl() to ide_taskfile_ioctl()
Date: Fri, 4 Feb 2005 03:22:09 +0100
Message-ID: <58cb370e05020318227d6ebdeb@mail.gmail.com>
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202031037.GK1187@htj.dyndns.org>
	 <58cb370e050203095417fed306@mail.gmail.com>
	 <4202D9ED.5020203@home-tj.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.192]:6901 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263129AbVBDCWQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Feb 2005 21:22:16 -0500
Received: by wproxy.gmail.com with SMTP id 67so401160wri
        for <linux-ide@vger.kernel.org>; Thu, 03 Feb 2005 18:22:10 -0800 (PST)
In-Reply-To: <4202D9ED.5020203@home-tj.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@home-tj.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Fri, 04 Feb 2005 11:11:57 +0900, Tejun Heo <tj@home-tj.org> wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On Wed, 2 Feb 2005 12:10:37 +0900, Tejun Heo <tj@home-tj.org> wrote:
> >
> >>>26_ide_taskfile_cmd_ioctl.patch
> >>>
> >>>      ide_cmd_ioctl() converted to use ide_taskfile_ioctl().  This
> >>>      is the last user of REQ_DRIVE_CMD.
> >
> >
> > ide_cmd_ioctl() needs to map to taskfile transport not ide_taskfile_ioctl()
> >
> >
> >>Index: linux-ide-export/drivers/ide/ide-iops.c
> >>===================================================================
> >>--- linux-ide-export.orig/drivers/ide/ide-iops.c        2005-02-02 10:28:04.466320918 +0900
> >>+++ linux-ide-export/drivers/ide/ide-iops.c     2005-02-02 10:28:07.406843817 +0900
> >>@@ -648,11 +648,11 @@ u8 eighty_ninty_three (ide_drive_t *driv
> >>
> >> EXPORT_SYMBOL(eighty_ninty_three);
> >>
> >>-int ide_ata66_check (ide_drive_t *drive, ide_task_t *args)
> >>+int ide_ata66_check (ide_drive_t *drive, task_ioreg_t *regs)
> >
> >
> > nitpick: int ide_ata66_check()
> >
> 
> meaning...?

silly minor nitpick - please drop extra space while at it:
int ide_ata66_check(ide_drive_t *drive, task_ioreg_t *regs)

> >
> >> {
> >>-       if ((args->tfRegister[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
> >>-           (args->tfRegister[IDE_SECTOR_OFFSET] > XFER_UDMA_2) &&
> >>-           (args->tfRegister[IDE_FEATURE_OFFSET] == SETFEATURES_XFER)) {
> >>+       if ((regs[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
> >>+           (regs[IDE_SECTOR_OFFSET] > XFER_UDMA_2) &&
> >>+           (regs[IDE_FEATURE_OFFSET] == SETFEATURES_XFER)) {
> >
> >
> > nitpick: please drop brackets
> >
> 
> Parenthese?

doh, yes

> >
> >> #ifndef CONFIG_IDEDMA_IVB
> >>                if ((drive->id->hw_config & 0x6000) == 0) {
> >> #else /* !CONFIG_IDEDMA_IVB */
> >>@@ -678,11 +678,11 @@ int ide_ata66_check (ide_drive_t *drive,
> >>  * 1 : Safe to update drive->id DMA registers.
> >>  * 0 : OOPs not allowed.
> >>  */
> >>-int set_transfer (ide_drive_t *drive, ide_task_t *args)
> >>+int set_transfer (ide_drive_t *drive, task_ioreg_t *regs)
> >
> >
> > nitpick: int set_transfer()
> >
> 
> ??

extra space

> >
> >> {
> >>-       if ((args->tfRegister[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
> >>-           (args->tfRegister[IDE_SECTOR_OFFSET] >= XFER_SW_DMA_0) &&
> >>-           (args->tfRegister[IDE_FEATURE_OFFSET] == SETFEATURES_XFER) &&
> >>+       if ((regs[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
> >>+           (regs[IDE_SECTOR_OFFSET] >= XFER_SW_DMA_0) &&
> >>+           (regs[IDE_FEATURE_OFFSET] == SETFEATURES_XFER) &&
> >
> >
> > nitpick: brackets
> >
> 
> Parentheses?

yep
