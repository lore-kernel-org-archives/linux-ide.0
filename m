From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/11] ide: remove ide_use_fast_pio()
Date: Mon, 06 Aug 2007 20:13:07 +0400
Message-ID: <46B74893.2030202@ru.mvista.com>
References: <200708042209.10987.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:10244 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753257AbXHFQLG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Aug 2007 12:11:06 -0400
In-Reply-To: <200708042209.10987.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Remove ide_use_fast_pio() and just re-tune PIO unconditionally if DMA tuning
> has failed in ->ide_dma_check.  All host drivers using ide_use_fast_pio() set
> drive->autotune so PIO is always tuned anyway and in some cases we _really_
> need to re-tune PIO because PIO and DMA timings are shared.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: b/drivers/ide/ide-lib.c
> ===================================================================
> --- a/drivers/ide/ide-lib.c
> +++ b/drivers/ide/ide-lib.c
> @@ -96,21 +96,6 @@ static u8 ide_rate_filter(ide_drive_t *d
>  	return min(speed, mode);
>  }
>  
> -int ide_use_fast_pio(ide_drive_t *drive)
> -{
> -	struct hd_driveid *id = drive->id;
> -
> -	if ((id->capability & 1) && drive->autodma)
> -		return 1;
> -
> -	if ((id->capability & 8) || (id->field_valid & 2))
> -		return 1;

    This reminds me to some time actually fix handling of pre-EIDE drives in 
ide_config_drive_speed()... :-)

MBR, Sergei
