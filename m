From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 14/21] ide-floppy: mv idefloppy_{should_,}report_error
Date: Sat, 12 Jan 2008 21:16:31 +0100
Message-ID: <200801122116.31722.bzolnier@gmail.com>
References: <1200052699-28420-1-git-send-email-bbpetkov@yahoo.de> <1200052699-28420-14-git-send-email-bbpetkov@yahoo.de> <1200052699-28420-15-git-send-email-bbpetkov@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:20602 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759698AbYALUUK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Jan 2008 15:20:10 -0500
Received: by ug-out-1314.google.com with SMTP id z38so640512ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 12 Jan 2008 12:20:09 -0800 (PST)
In-Reply-To: <1200052699-28420-15-git-send-email-bbpetkov@yahoo.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Friday 11 January 2008, Borislav Petkov wrote:
> In addition to shortening the function name, move the printk-call into the
> function thereby saving some code lines. Also, make the function out_of_line
> since it is not on a performance critical path.
> 
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
> ---
>  drivers/ide/ide-floppy.c |   37 ++++++++++++++-----------------------
>  1 files changed, 14 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
> index 49d83a1..b718615 100644
> --- a/drivers/ide/ide-floppy.c
> +++ b/drivers/ide/ide-floppy.c
> @@ -707,16 +707,18 @@ static ide_startstop_t idefloppy_transfer_pc1(ide_drive_t *drive)
>  	return ide_started;
>  }
>  
> -/*
> - * Suppresses error messages resulting from Medium not present.
> - */
> -static inline int idefloppy_should_report_error(idefloppy_floppy_t *floppy)
> +static void idefloppy_report_error(idefloppy_floppy_t *floppy,
> +		idefloppy_pc_t *pc)
>  {

-> Would make a sense to move the comment here instead of removing it
(it is useful unless you remeber all ->{sense_key,asc,ascq} value).

>  	if (floppy->sense_key == 0x02 &&
>  	    floppy->asc       == 0x3a &&
>  	    floppy->ascq      == 0x00)
> -		return 0;
> -	return 1;
> +		return;

Otherwise the patch is fine.
