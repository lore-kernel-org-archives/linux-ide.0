From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 15/20] ide: don't enable local IRQs for PIO-in in driver_cmd_intr()
Date: Mon, 10 Dec 2007 16:39:38 +0300
Message-ID: <475D419A.1050506@ru.mvista.com>
References: <200712092218.30672.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:48344 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751153AbXLJNjS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Dec 2007 08:39:18 -0500
In-Reply-To: <200712092218.30672.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Don't enable local IRQs for PIO-in protocol in driver_cmd_intr().

> While at it:

> * Remove redundant rq->cmd_type check.

> * Read status register after enabling local IRQs for no-data protocol.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> Index: b/drivers/ide/ide-io.c
> ===================================================================
> --- a/drivers/ide/ide-io.c
> +++ b/drivers/ide/ide-io.c
> @@ -638,17 +638,18 @@ static ide_startstop_t drive_cmd_intr (i
>  {
>  	struct request *rq = HWGROUP(drive)->rq;
>  	ide_hwif_t *hwif = HWIF(drive);
> -	u8 *args = (u8 *) rq->buffer;
> -	u8 stat = hwif->INB(IDE_STATUS_REG);
> +	u8 *args = (u8 *)rq->buffer, pio_in = (args && args[3]) ? 1 : 0, stat;
>  
> -	local_irq_enable_in_hardirq();
> -	if (rq->cmd_type == REQ_TYPE_ATA_CMD &&
> -	    (stat & DRQ_STAT) && args && args[3]) {
> +	if (pio_in) {
>  		u8 io_32bit = drive->io_32bit;
> +		stat = hwif->INB(IDE_STATUS_REG);

    You've lost DRQ=1 check (which is returned in the next patch however)...

MBR, Sergei
