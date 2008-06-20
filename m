From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 12/18] ide: use ->tf_load in actual_try_to_identify()
Date: Sat, 21 Jun 2008 03:14:30 +0400
Message-ID: <485C39D6.6020801@ru.mvista.com>
References: <20080620213323.13202.71450.sendpatchset@localhost.localdomain> <20080620213445.13202.61145.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:59092 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755727AbYFTXOh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Jun 2008 19:14:37 -0400
In-Reply-To: <20080620213445.13202.61145.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:
> Convert actual_try_to_identify() to use ->tf_load instead of ->OUTB.
>
> There should be no functional changes caused by this patch.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>   
[...]
> Index: b/drivers/ide/ide-probe.c
> ===================================================================
> --- a/drivers/ide/ide-probe.c
> +++ b/drivers/ide/ide-probe.c
> @@ -290,9 +290,15 @@ static int actual_try_to_identify (ide_d
>  	/* set features register for atapi
>  	 * identify command to be sure of reply
>  	 */
> -	if ((cmd == WIN_PIDENTIFY))
> -		/* disable dma & overlap */
> -		hwif->OUTB(0, io_ports->feature_addr);
> +	if (cmd == WIN_PIDENTIFY) {
> +		ide_task_t task;
> +
> +		memset(&task, 0, sizeof(task));
> +		/* disable DMA & overlap */
> +		task.tf_flags = IDE_TFLAG_OUT_FEATURE;
> +
> +		drive->hwif->tf_load(drive, &task);
> +	}
>   

   Eww, this is bulky but should be a part of your plan to switch to 
tf_load() method...

WBR, Sergei


