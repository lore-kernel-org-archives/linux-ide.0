From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RESEND PATCH 08/10] ide-floppy: mv idefloppy_{should_,}report_error
Date: Sat, 5 Jan 2008 16:54:23 +0100
Message-ID: <200801051654.23662.bzolnier@gmail.com>
References: <1199366409-26016-1-git-send-email-bbpetkov@yahoo.de> <1199366409-26016-8-git-send-email-bbpetkov@yahoo.de> <1199366409-26016-9-git-send-email-bbpetkov@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:53133 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753740AbYAEPm6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Jan 2008 10:42:58 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2919142ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 05 Jan 2008 07:42:57 -0800 (PST)
In-Reply-To: <1199366409-26016-9-git-send-email-bbpetkov@yahoo.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 03 January 2008, Borislav Petkov wrote:
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
> ---
>  drivers/ide/ide-floppy.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
> index 2c139e7..fd5fe7b 100644
> --- a/drivers/ide/ide-floppy.c
> +++ b/drivers/ide/ide-floppy.c
> @@ -544,7 +544,7 @@ static ide_startstop_t idefloppy_transfer_pc1(ide_drive_t *drive)
>  }
>  
>  /* Supresses error messages resulting from Medium not present */
> -static inline int idefloppy_should_report_error(idefloppy_t *floppy)
> +static inline int idefloppy_report_error(idefloppy_t *floppy)

wait, this function does indeed check if it _should_ report the error
(it doesn't report it itself)... however...

>  {
>  	if (floppy->sense_key == 0x02 &&
>  	    floppy->asc       == 0x3a &&
> @@ -587,7 +587,7 @@ static ide_startstop_t idefloppy_issue_pc(ide_drive_t *drive, idefloppy_pc_t *pc
>  		 */
>  		if (!test_bit(PC_ABORT, &pc->flags)) {
>  			if (!test_bit(PC_SUPPRESS_ERROR, &pc->flags)) {
> -				if (idefloppy_should_report_error(floppy))
> +				if (idefloppy_report_error(floppy))
>  					printk(KERN_ERR "ide-floppy: %s: I/O error, "
>  					       "pc = %2x, key = %2x, "
>  					       "asc = %2x, ascq = %2x\n",
> @@ -809,7 +809,7 @@ static ide_startstop_t idefloppy_do_request(ide_drive_t *drive,
>  
>  	if (rq->errors >= ERROR_MAX) {
>  		if (floppy->failed_pc != NULL) {
> -			if (idefloppy_should_report_error(floppy))
> +			if (idefloppy_report_error(floppy))
>  				printk(KERN_ERR "ide-floppy: %s: I/O error,"
>  					" pc = %2x, key = %2x, asc = %2x,"
>  					" ascq = %2x\n",

if you move the printk() into the function the new name would suddenly
make sense! :)

it may be also worth to remove 'inline' from idefloppy_report_error()
while at it (this function is not performance critical and this should
cut some bytes from the driver binary)
