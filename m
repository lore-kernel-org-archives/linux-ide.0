From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 11/21] ide-floppy: fix comments formatting
Date: Sat, 12 Jan 2008 21:16:23 +0100
Message-ID: <200801122116.23951.bzolnier@gmail.com>
References: <1200052699-28420-1-git-send-email-bbpetkov@yahoo.de> <1200052699-28420-11-git-send-email-bbpetkov@yahoo.de> <1200052699-28420-12-git-send-email-bbpetkov@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:20602 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758095AbYALUUC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Jan 2008 15:20:02 -0500
Received: by ug-out-1314.google.com with SMTP id z38so640512ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 12 Jan 2008 12:20:02 -0800 (PST)
In-Reply-To: <1200052699-28420-12-git-send-email-bbpetkov@yahoo.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Friday 11 January 2008, Borislav Petkov wrote:
> That is,
> - remove unnecessary comments
> - shorten comments
> - shorten lines longer 80 columns
> - cleanup whitespace
> - add a missing loglevel KERN_ to a printk-call
> - fix misc checkpatch warnings

Majority of this patch consists of checkpatch.pl fixes so it should be merged
with patch #20.  Also a lot of code beautified here is _heavily_ modified in
later patches so some of fixups below could be moved there (which would also
decrease the size of this patch significantly).

> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
> ---
>  drivers/ide/ide-floppy.c |  402 +++++++++++++++++++++-------------------------
>  1 files changed, 181 insertions(+), 221 deletions(-)

[...]

> +#define	PC_ABORT		0	/* Set when an error is considered\
> +					   normal - We won't retry */

'\' shouldn't be there and

/* ... */
#define		PC_ABORT		0

would be probably more readable

> +#define PC_DMA_RECOMMENDED	2	/* DMA use preferred, if possible */

please make it match the other flags while at it (space -> tab)

[...]

> -#define IDEFLOPPY_USE_READ12		2	/* Use READ12/WRITE12 or READ10/WRITE10 */
> +#define IDEFLOPPY_USE_READ12		2	/* READ(10|12)/WRITE(10|12) */

The original comment was way more informative.

Moreover this particular flag is never set so it could be just removed
(together with some dead code for handling it) in a separate (pre-)patch.

>  #define	IDEFLOPPY_FORMAT_IN_PROGRESS	3	/* Format in progress */

please make it match the other flags while at it (tab -> space)

> -#define IDEFLOPPY_CLIK_DRIVE	        4       /* Avoid commands not supported in Clik drive */
> -#define IDEFLOPPY_ZIP_DRIVE		5	/* Requires BH algorithm for packets */
> +#define IDEFLOPPY_CLIK_DRIVE	        4       /* Avoid commands not supported\
> +						   in Clik drive */
> +#define IDEFLOPPY_ZIP_DRIVE		5	/* Requires BH algorithm for\
> +						   packets */

no need for '\' characters

[...]

> -static void idefloppy_queue_pc_head (ide_drive_t *drive,idefloppy_pc_t *pc,struct request *rq)
> +static void idefloppy_queue_pc_head(ide_drive_t *drive, idefloppy_pc_t *pc,
> +		struct request *rq)

minor CodingStyle nitpick:

static void idefloppy_queue_pc_head(ide_drive_t *drive, idefloppy_pc_t *pc,
				    struct request *rq)

would be more readable IMO but it is a matter of personal taste

[ same applies for other similar modifications done by this patch series ]
