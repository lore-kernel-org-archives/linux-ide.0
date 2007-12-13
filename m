From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 14/20] ide: convert "empty" REQ_TYPE_ATA_CMD requests
 to use REQ_TYPE_ATA_TASKFILE
Date: Thu, 13 Dec 2007 15:55:10 +0300
Message-ID: <47612BAE.5030109@ru.mvista.com>
References: <200712092217.32139.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:28987 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751952AbXLMMyw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Dec 2007 07:54:52 -0500
In-Reply-To: <200712092217.32139.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

Bartlomiej Zolnierkiewicz wrote:

> Based on the previous work by Tejun Heo.

> There should be no functionality changes caused by this patch.

    I didn't get the point. Why do you consider them "empty"?

> Cc: Tejun Heo <htejun@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> Index: b/drivers/ide/ide-disk.c
> ===================================================================
> --- a/drivers/ide/ide-disk.c
> +++ b/drivers/ide/ide-disk.c
> @@ -620,8 +620,10 @@ static int set_multcount(ide_drive_t *dr
>  
>  	if (drive->special.b.set_multmode)
>  		return -EBUSY;
> +
>  	ide_init_drive_cmd (&rq);
> -	rq.cmd_type = REQ_TYPE_ATA_CMD;
> +	rq.cmd_type = REQ_TYPE_ATA_TASKFILE;
> +
>  	drive->mult_req = arg;
>  	drive->special.b.set_multmode = 1;
>  	(void) ide_do_drive_cmd (drive, &rq, ide_wait);
> Index: b/drivers/ide/ide-taskfile.c
> ===================================================================
> --- a/drivers/ide/ide-taskfile.c
> +++ b/drivers/ide/ide-taskfile.c
> @@ -782,7 +782,7 @@ int ide_cmd_ioctl (ide_drive_t *drive, u
>  		struct request rq;
>  
>  		ide_init_drive_cmd(&rq);
> -		rq.cmd_type = REQ_TYPE_ATA_CMD;
> +		rq.cmd_type = REQ_TYPE_ATA_TASKFILE;
>  
>  		return ide_do_drive_cmd(drive, &rq, ide_wait);
>  	}
> Index: b/drivers/ide/ide.c
> ===================================================================
> --- a/drivers/ide/ide.c
> +++ b/drivers/ide/ide.c
> @@ -876,7 +876,7 @@ int set_pio_mode(ide_drive_t *drive, int
>  		return -EBUSY;
>  
>  	ide_init_drive_cmd(&rq);
> -	rq.cmd_type = REQ_TYPE_ATA_CMD;
> +	rq.cmd_type = REQ_TYPE_ATA_TASKFILE;
>  
>  	drive->tune_req = (u8) arg;
>  	drive->special.b.set_tune = 1;

MBR, Sergei
