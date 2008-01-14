From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 10/12] ide-floppy: remove atomic test_*bit macros
Date: Mon, 14 Jan 2008 22:50:58 +0100
Message-ID: <200801142250.58201.bzolnier@gmail.com>
References: <1200255505-31418-1-git-send-email-bbpetkov@yahoo.de> <1200255505-31418-10-git-send-email-bbpetkov@yahoo.de> <1200255505-31418-11-git-send-email-bbpetkov@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:1601 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbYANVoM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Jan 2008 16:44:12 -0500
Received: by ug-out-1314.google.com with SMTP id z38so900346ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 14 Jan 2008 13:44:10 -0800 (PST)
In-Reply-To: <1200255505-31418-11-git-send-email-bbpetkov@yahoo.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sunday 13 January 2008, Borislav Petkov wrote:
> ..and replace them with flag enums.
> 
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
> ---
>  drivers/ide/ide-floppy.c |  132 +++++++++++++++++++++++++--------------------
>  1 files changed, 73 insertions(+), 59 deletions(-)

[...]

> @@ -506,14 +516,14 @@ static ide_startstop_t idefloppy_pc_intr(ide_drive_t *drive)
>  
>  	debug_log("Reached %s interrupt handler\n", __FUNCTION__);
>  
> -	if (test_bit(PC_DMA_IN_PROGRESS, &pc->flags)) {
> +	if (PC_FLAG_DMA_IN_PROGRESS & pc->flags) {

the usual kernel convention is to put flag last, i.e.

pc->flags & PC_FLAG_DMA_IN_PROGRESS

[...]

> @@ -570,7 +581,7 @@ static ide_startstop_t idefloppy_pc_intr(ide_drive_t *drive)
>  		printk(KERN_ERR "ide-floppy: CoD != 0 in %s\n", __FUNCTION__);
>  		return ide_do_reset(drive);
>  	}
> -	if (((ireason & IO) == IO) == test_bit(PC_WRITING, &pc->flags)) {
> +	if (((ireason & IO) == IO) == (PC_FLAG_WRITING  & pc->flags)) {

- test_bit() returns 1 or 0 (=> boolean)
- (pc->flags & PC_FLAG_WRITING) is 0x10 or 0

so the above comparison will fail

> @@ -607,7 +618,7 @@ static ide_startstop_t idefloppy_pc_intr(ide_drive_t *drive)
>  		xferfunc(drive, pc->current_position, bcount);
>  	else
>  		ide_floppy_io_buffers(drive, pc, bcount,
> -				test_bit(PC_WRITING, &pc->flags));
> +				(PC_FLAG_WRITING & pc->flags));

ditto, this may actually work but '(pc->flags & PC_FLAG_WRITING) ? 1 : 0'
would be much safer from maintainability POV

[...]

> @@ -1720,13 +1731,16 @@ static int idefloppy_media_changed(struct gendisk *disk)
>  {
>  	struct ide_floppy_obj *floppy = ide_floppy_g(disk);
>  	ide_drive_t *drive = floppy->drive;
> +	int ret;
>  
>  	/* do not scan partitions twice if this is a removable device */
>  	if (drive->attach) {
>  		drive->attach = 0;
>  		return 0;
>  	}
> -	return test_and_clear_bit(IDEFLOPPY_MEDIA_CHANGED, &floppy->flags);
> +	ret = IDEFLOPPY_FLAG_MEDIA_CHANGED & floppy->flags;
> +	floppy->flags &= ~IDEFLOPPY_FLAG_MEDIA_CHANGED;
> +	return ret;
>  }

same issue

otherwise looks good, please fix/resubmit
(together with patch #12)
