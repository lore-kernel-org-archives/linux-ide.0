From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 12/20] ide: use wait_drive_not_busy() in drive_cmd_intr()
Date: Mon, 10 Dec 2007 16:02:00 +0300
Message-ID: <475D38C8.3020908@ru.mvista.com>
References: <200712092215.45956.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:48097 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752670AbXLJNBj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Dec 2007 08:01:39 -0500
In-Reply-To: <200712092215.45956.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: b/drivers/ide/ide-taskfile.c
> ===================================================================
> --- a/drivers/ide/ide-taskfile.c
> +++ b/drivers/ide/ide-taskfile.c
> @@ -260,7 +260,7 @@ static ide_startstop_t task_no_data_intr
>  	return ide_stopped;
>  }
>  
> -static u8 wait_drive_not_busy(ide_drive_t *drive)
> +u8 wait_drive_not_busy(ide_drive_t *drive)
>  {
>  	ide_hwif_t *hwif = HWIF(drive);
>  	int retries;

   I think you should remove the comment line below:

	* (drive_cmd_intr waits that long).

MBR, Sergei

