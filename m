From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 10/12] ide-floppy: remove atomic test_*bit macros
Date: Wed, 16 Jan 2008 23:25:31 +0100
Message-ID: <200801162325.31598.bzolnier@gmail.com>
References: <1200255505-31418-1-git-send-email-bbpetkov@yahoo.de> <200801142250.58201.bzolnier@gmail.com> <20080115201032.GB5699@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:31909 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbYAPWjO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jan 2008 17:39:14 -0500
Received: by ug-out-1314.google.com with SMTP id z38so272679ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 16 Jan 2008 14:39:13 -0800 (PST)
In-Reply-To: <20080115201032.GB5699@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bbpetkov@yahoo.de
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tuesday 15 January 2008, Borislav Petkov wrote:

[...]

> .. this is the second one...
> 
> 
> From: Borislav Petkov <bbpetkov@yahoo.de>
> Date: Tue, 15 Jan 2008 20:49:18 +0100
> Subject: [PATCH 16/18] ide-floppy: remove atomic test_*bit macros
> 
> ..and replace them with flag enums.
> 
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>

applied

[...]

> @@ -1713,13 +1723,16 @@ static int idefloppy_media_changed(struct gendisk *disk)
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
> +	ret = floppy->flags & IDEFLOPPY_FLAG_MEDIA_CHANGED;
> +	floppy->flags &= ~IDEFLOPPY_FLAG_MEDIA_CHANGED;
> +	return ret;
>  }

this chunk (idefloppy_media_changed() return value is now 2 instead of 1
if IDEFLOPPY_FLAG_MEDIA_CHANGED flag is set) seems to have slipped through

[ I fixed it while merging the patch ]
