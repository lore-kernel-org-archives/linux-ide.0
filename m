From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/3] ide-cd: cdrom_decode_status: simplify do_end_request logic
Date: Sat, 4 Apr 2009 14:20:03 +0200
Message-ID: <200904041420.03842.bzolnier@gmail.com>
References: <1238745519-19389-3-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:53386 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbZDDMRM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Apr 2009 08:17:12 -0400
In-Reply-To: <1238745519-19389-3-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


On Friday 03 April 2009, Borislav Petkov wrote:
> Set do_end_request per default which results in several lines removed
> and simplifying code flow. Also, add defines for cdrom_decode_status's
> return codes instead of naked numbers.
> 
> There should be no functional change resulting from this patch.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> ---
>  drivers/ide/ide-cd.c |   35 ++++++++++++-----------------------
>  drivers/ide/ide-cd.h |    9 ++++++---
>  2 files changed, 18 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> index bc37027..59a8bc2 100644
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -301,17 +301,11 @@ static int ide_cd_breathe(ide_drive_t *drive, struct request *rq)
>  	}
>  }
>  
> -/**
> - * Returns:
> - * 0: if the request should be continued.
> - * 1: if the request will be going through error recovery.
> - * 2: if the request should be ended.
> - */
>  static int cdrom_decode_status(ide_drive_t *drive, u8 stat)
>  {
>  	ide_hwif_t *hwif = drive->hwif;
>  	struct request *rq = hwif->rq;
> -	int err, sense_key, do_end_request;
> +	int err, sense_key, do_end_request = 1;

I think that do_end_request inversion makes code harder to follow
and adds risk of subtle behavior changes.  It is not worth it IMHO,
especialy since we may later remove this variable by doing a bit
of code re-organization.

[...]

> @@ -18,15 +18,18 @@
>  
>  #define ATAPI_WAIT_WRITE_BUSY	(10 * HZ)
>  
> -/************************************************************************/
> -
> -#define SECTOR_BITS 		9
> +#define SECTOR_BITS		9
>  #ifndef SECTOR_SIZE
>  #define SECTOR_SIZE		(1 << SECTOR_BITS)
>  #endif

you may remove this extra SECTOR_SIZE definition while at it

>  #define SECTORS_PER_FRAME	(CD_FRAMESIZE >> SECTOR_BITS)
>  #define SECTOR_BUFFER_SIZE	(CD_FRAMESIZE * 32)
>  
> +/* internal decode_status codes */
> +#define REQ_CONT               0
> +#define REQ_RECOVER            1
> +#define REQ_FAIL               2

REQ_* prefix is too generic, IDE_RQ_*?  also please use enum for it
