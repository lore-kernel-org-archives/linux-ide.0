From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] ide-cd: reverse NOT_READY sense key logic
Date: Mon, 6 Apr 2009 22:59:15 +0200
Message-ID: <200904062259.15556.bzolnier@gmail.com>
References: <1238922962-19727-1-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:28755 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758286AbZDFVLk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Apr 2009 17:11:40 -0400
In-Reply-To: <1238922962-19727-1-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sunday 05 April 2009, Borislav Petkov wrote:
> Make the case of flushing the drive's cache explicit.
> 
> There should be no functional change resulting from this patch.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> ---
>  drivers/ide/ide-cd.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> index 2989aa8..2aa13d8 100644
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -341,15 +341,15 @@ static int cdrom_decode_status(ide_drive_t *drive, u8 stat)
>  
>  	switch (sense_key) {
>  	case NOT_READY:
> -		if (blk_fs_request(rq) == 0 || rq_data_dir(rq) == READ) {
> +		if (blk_fs_request(rq) && rq_data_dir(rq) == WRITE) {
> +			if (ide_cd_breathe(drive, rq))
> +				return 1;
> +		} else {
>  			cdrom_saw_media_change(drive);
>  
>  			if (blk_fs_request(rq) && !quiet)

Didn't we want to remove this blk_fs_request() while at it?
