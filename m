From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 06/10] ide-atapi: add a DEV_IS_IDECD macro
Date: Mon, 15 Sep 2008 20:19:01 +0200
Message-ID: <200809152019.02395.bzolnier@gmail.com>
References: <1221392158-3848-1-git-send-email-petkovbb@gmail.com> <1221392158-3848-7-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:10054 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490AbYIOScN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Sep 2008 14:32:13 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2270271rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 15 Sep 2008 11:32:12 -0700 (PDT)
In-Reply-To: <1221392158-3848-7-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Sunday 14 September 2008 13:35:54 Borislav Petkov wrote:
> This is a short-term-use one and will be removed later - it is added to solely
> improve readability.
> 
> There should be no functional change resulting from this patch.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> ---
>  drivers/ide/ide-atapi.c |   12 +++++++-----
>  1 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
> index 7045d34..e1fa52d 100644
> --- a/drivers/ide/ide-atapi.c
> +++ b/drivers/ide/ide-atapi.c
> @@ -477,6 +477,9 @@ static int ide_delayed_transfer_pc(ide_drive_t *drive)
>  	return WAIT_FLOPPY_CMD;
>  }
>  
> +#define DEV_IS_IDECD(drive)	\
> +		(drive->media == ide_cdrom || drive->media == ide_optical)
> +

This needs to check for drive->scsi or the subtle bugs will happen.

Also why not use dev_is_idecd() static inline function instead?
