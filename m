From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] ide: turn selectproc() method into dev_select() method
Date: Thu, 19 Mar 2009 18:45:14 +0300
Message-ID: <49C2688A.3070808@ru.mvista.com>
References: <200903191831.43621.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:1184 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753430AbZCSPoc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Mar 2009 11:44:32 -0400
In-Reply-To: <200903191831.43621.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, benh@kernel.crashing.org

Hello, I wrote:

> Turn selectproc() method into dev_select() method by teaching it to write to the
> device register and moving it from 'struct ide_port_ops' to 'struct ide_tp_ops'.

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

[...]

> Index: linux-2.6/drivers/ide/trm290.c
> ===================================================================
> --- linux-2.6.orig/drivers/ide/trm290.c
> +++ linux-2.6/drivers/ide/trm290.c
> @@ -171,10 +171,11 @@ static void trm290_prepare_drive (ide_dr
>  	local_irq_restore(flags);
>  }
>  
> -static void trm290_selectproc (ide_drive_t *drive)
> +static void trm290_dev_select(ide_drive_t *drive)
>  {
>  	trm290_prepare_drive(drive, !!(drive->dev_flags & IDE_DFLAG_USING_DMA));
> -}
> +
> +	outb(drive->select | ATA_DEVICE_OBS, drive->hwif->io_ports.device_addr);}

    Oops, I keep forgetting about running checkpatch.pl first. :-<
    Bart, do I need to repost, or you can fix it while applying?

MBR, Sergei
