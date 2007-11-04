From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/9] ide-disk: guarantee 400ns delay after writing command
 register
Date: Sun, 04 Nov 2007 15:56:30 +0300
Message-ID: <472DC17E.1010802@ru.mvista.com>
References: <200711022259.44214.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:10628 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754437AbXKDM4Y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 Nov 2007 07:56:24 -0500
In-Reply-To: <200711022259.44214.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: b/drivers/ide/ide-disk.c
> ===================================================================
> --- a/drivers/ide/ide-disk.c
> +++ b/drivers/ide/ide-disk.c
> @@ -274,6 +274,7 @@ static ide_startstop_t __ide_do_rw_disk(
>  		}
>  
>  		hwif->OUTBSYNC(drive, command, IDE_COMMAND_REG);
> +		ndelay(400);	/* FIXME */

    FIXME?

>  		return pre_task_out_intr(drive, rq);
>  	}

MBR, Sergei
