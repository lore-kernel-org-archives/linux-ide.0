From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 18/21] ide-floppy: fix error handling in idefloppy_probe()
Date: Sat, 12 Jan 2008 21:18:01 +0100
Message-ID: <200801122118.01949.bzolnier@gmail.com>
References: <1200052699-28420-1-git-send-email-bbpetkov@yahoo.de> <1200052699-28420-18-git-send-email-bbpetkov@yahoo.de> <1200052699-28420-19-git-send-email-bbpetkov@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:21337 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758823AbYALUUF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Jan 2008 15:20:05 -0500
Received: by ug-out-1314.google.com with SMTP id z38so640516ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 12 Jan 2008 12:20:04 -0800 (PST)
In-Reply-To: <1200052699-28420-19-git-send-email-bbpetkov@yahoo.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Friday 11 January 2008, Borislav Petkov wrote:
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
> ---
>  drivers/ide/ide-floppy.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
> index 89b26ea..0729df5 100644
> --- a/drivers/ide/ide-floppy.c
> +++ b/drivers/ide/ide-floppy.c
> @@ -1737,7 +1737,8 @@ static int ide_floppy_probe(ide_drive_t *drive)
>  				" emulation.\n", drive->name);
>  		goto failed;
>  	}
> -	if ((floppy = kzalloc(sizeof (idefloppy_floppy_t), GFP_KERNEL)) == NULL) {
> +	floppy = kzalloc(sizeof(idefloppy_floppy_t), GFP_KERNEL);
> +	if (!floppy) {
>  		printk(KERN_ERR "ide-floppy: %s: Can't allocate a floppy"
>  				" structure\n", drive->name);
>  		goto failed;

I'm unable to see any problem with error handling here?

This change should be combined with the rest of checkpatch.pl fixes.
