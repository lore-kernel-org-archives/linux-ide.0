From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/3] ide-cd: use ide_drive_t's rq in cdrom_queue_request_sense
Date: Tue, 27 Jan 2009 16:07:08 +0100
Message-ID: <200901271607.10869.bzolnier@gmail.com>
References: <1233002440-4325-1-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f21.google.com ([209.85.219.21]:39919 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbZA0PZQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Jan 2009 10:25:16 -0500
In-Reply-To: <1233002440-4325-1-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Monday 26 January 2009, Borislav Petkov wrote:
> There should be no functionality change resulting from this patch.
> 
> Suggested-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> ---
>  drivers/ide/ide-cd.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> index d3d5fb6..3907466 100644
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -207,7 +207,7 @@ static void cdrom_queue_request_sense(ide_drive_t *drive, void *sense,
>  				      struct request *failed_command)
>  {
>  	struct cdrom_info *info		= drive->driver_data;
> -	struct request *rq		= &info->request_sense_request;
> +	struct request *rq		= &drive->request_sense_rq;

Don't we want to also remove now unused ->request_sense_request?
