From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/2] ide-cd: cdrom_decode_status: use return codes instead of naked numbers
Date: Mon, 6 Apr 2009 23:00:15 +0200
Message-ID: <200904062300.16108.bzolnier@gmail.com>
References: <1238922962-19727-2-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:55424 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757938AbZDFVLm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Apr 2009 17:11:42 -0400
In-Reply-To: <1238922962-19727-2-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sunday 05 April 2009, Borislav Petkov wrote:
> Remove unused SECTOR_SIZE while at it.
> 
> There should be no functional change resulting from this patch.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

[...]

> @@ -431,7 +425,7 @@ static int cdrom_decode_status(ide_drive_t *drive, u8 stat)
>  	/* if we got a CHECK_CONDITION status, queue a request sense command */
>  	if (stat & ATA_ERR)
>  		cdrom_queue_request_sense(drive, NULL, NULL);
> -	return 1;
> +	return REQ_RECOVER;
>  
>  end_request:
>  	if (stat & ATA_ERR) {
> @@ -445,9 +439,9 @@ end_request:
>  		hwif->rq = NULL;
>  
>  		cdrom_queue_request_sense(drive, rq->sense, rq);
> -		return 1;
> -	} else
> -		return 2;
> +		return REQ_RECOVER;
> +	}
> +	return REQ_FAIL;
>  }

Could it be that cdrom_newpc_intr() chunk got lost somewhere along the way,
IIRC it was there?

[...]
  
> +/* internal decode_status codes */
> +#define REQ_CONT               0
> +#define REQ_RECOVER            1
> +#define REQ_FAIL               2

Did you notice my comments about REQ_* in previous mail?
