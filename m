From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 4/6] ide: add ide_busy_sleep() helper
Date: Tue, 04 Dec 2007 15:32:49 +0300
Message-ID: <475548F1.6040308@ru.mvista.com>
References: <200712032252.53249.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:49566 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752710AbXLDMcb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2007 07:32:31 -0500
In-Reply-To: <200712032252.53249.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Add ide_busy_sleep() helper and use it in do_probe(),
> enable_nest() and probe_hwif().

> As a nice side-effect this fixes a minor bug in enable_nest()
> (the code was reading status register without any delay).

    Huh?

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: b/drivers/ide/ide-probe.c
> ===================================================================
> --- a/drivers/ide/ide-probe.c
> +++ b/drivers/ide/ide-probe.c
[...]
> @@ -489,20 +499,16 @@ static int do_probe (ide_drive_t *drive,
>  static void enable_nest (ide_drive_t *drive)
>  {
>  	ide_hwif_t *hwif = HWIF(drive);
> -	unsigned long timeout;
>  
>  	printk("%s: enabling %s -- ", hwif->name, drive->id->model);
>  	SELECT_DRIVE(drive);
>  	msleep(50);
>  	hwif->OUTB(EXABYTE_ENABLE_NEST, IDE_COMMAND_REG);
> -	timeout = jiffies + WAIT_WORSTCASE;
> -	do {
> -		if (time_after(jiffies, timeout)) {
> -			printk("failed (timeout)\n");
> -			return;
> -		}
> -		msleep(50);

    Here's a delay, isn't it?

> -	} while ((hwif->INB(IDE_STATUS_REG)) & BUSY_STAT);
> +
> +	if (ide_busy_sleep(hwif)) {
> +		printk(KERN_CONT "failed (timeout)\n");
> +		return;
> +	}
>  
>  	msleep(50);

MBR, Sergei
