From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 05/10] ide-atapi: accomodate transfer length to ide-cd
Date: Mon, 15 Sep 2008 20:15:11 +0200
Message-ID: <200809152015.12602.bzolnier@gmail.com>
References: <1221392158-3848-1-git-send-email-petkovbb@gmail.com> <1221392158-3848-6-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:5749 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315AbYIOScI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Sep 2008 14:32:08 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2270292rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 15 Sep 2008 11:32:08 -0700 (PDT)
In-Reply-To: <1221392158-3848-6-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Sunday 14 September 2008 13:35:53 Borislav Petkov wrote:
> There should be no functional change resulting from this patch.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> ---
>  drivers/ide/ide-atapi.c  |    4 +++-
>  drivers/ide/ide-floppy.c |    2 +-
>  drivers/ide/ide-tape.c   |    2 +-
>  drivers/scsi/ide-scsi.c  |    3 ++-
>  include/linux/ide.h      |    2 +-
>  5 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
> index df17401..7045d34 100644
> --- a/drivers/ide/ide-atapi.c
> +++ b/drivers/ide/ide-atapi.c
> @@ -546,7 +546,7 @@ static ide_startstop_t ide_transfer_pc(ide_drive_t *drive)
>  }
>  
>  ide_startstop_t ide_issue_pc(ide_drive_t *drive, unsigned int timeout,
> -			     ide_expiry_t *expiry)
> +			     ide_expiry_t *expiry, int xferlen)
>  {
>  	struct ide_atapi_pc *pc = drive->pc;
>  	ide_hwif_t *hwif = drive->hwif;
> @@ -561,6 +561,8 @@ ide_startstop_t ide_issue_pc(ide_drive_t *drive, unsigned int timeout,
>  	/* Request to transfer the entire buffer at once */
>  	if (drive->media == ide_tape && scsi == 0)
>  		bcount = pc->req_xfer;
> +	else if (drive->media == ide_cdrom || drive->media == ide_optical)
> +		bcount = xferlen;
>  	else
>  		bcount = min(pc->req_xfer, 63 * 1024);

If you move info->last_block to ide_drive_t it is possible to factor out
xferlen setup from ide_cd_do_request() to a separate handler and move
it here.  Then xferlen argument to ide_issue_pc() won't be necessary.

How's about it?
