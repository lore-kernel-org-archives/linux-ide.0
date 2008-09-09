From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Tue, 09 Sep 2008 21:50:32 +0400
Message-ID: <48C6B768.4010200@ru.mvista.com>
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:57679 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751847AbYIIRtx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Sep 2008 13:49:53 -0400
In-Reply-To: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ralf@linux-mips.org

Atsushi Nemoto wrote:
> This is the driver for the Toshiba TX4939 SoC ATA controller.

> This controller has standard ATA taskfile registers and DMA
> command/status registers, but the register layout is swapped on big
> endian.  There are some other endian issue and some special registers
> which requires many custom dma_ops/port_ops routines.

> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> This patch is against linux-next 20080905.

>  drivers/ide/Kconfig          |    6 +
>  drivers/ide/mips/Makefile    |    1 +
>  drivers/ide/mips/tx4939ide.c |  762 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 769 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/ide/mips/tx4939ide.c

> diff --git a/drivers/ide/mips/tx4939ide.c b/drivers/ide/mips/tx4939ide.c
> new file mode 100644
> index 0000000..ba9776d
> --- /dev/null
> +++ b/drivers/ide/mips/tx4939ide.c
> @@ -0,0 +1,762 @@

[...]

> +static void tx4939ide_set_mode(ide_drive_t *drive, const u8 speed)
> +{
> +	ide_hwif_t *hwif = HWIF(drive);
> +	unsigned long base = TX4939IDE_BASE(hwif);
> +	int is_slave = drive->dn & 1;
> +	u16 value;
> +	int safe_speed = speed;
> +	int i;
> +
> +	for (i = 0; i < MAX_DRIVES; i++) {

    Use ide_get_paired_drive() ISO this loop.

> +		if (drive != &hwif->drives[i] &&
> +		    (hwif->drives[i].dev_flags & IDE_DFLAG_PRESENT))
> +			safe_speed = min(safe_speed,
> +					 (int)hwif->drives[i].current_speed);

    You shouldn't clamp the command PIO mode timings like this, and shouldn't 
do it at all when DMA mode is set. Call ide_get_best_pio_mode(255, 4) to get 
the mate drive's fastest PIO mode which should be a clamping value.

> +	/* Command Transfer Mode Select */
> +	switch (safe_speed) {
> +	case XFER_UDMA_5:
> +	case XFER_UDMA_4:
> +	case XFER_UDMA_3:
> +	case XFER_UDMA_2:
> +	case XFER_UDMA_1:
> +	case XFER_UDMA_0:
> +	case XFER_MW_DMA_2:

    You shouldn't change the command PIO mode when DMA mode is selected.

> +	case XFER_MW_DMA_1:
> +	case XFER_MW_DMA_0:
> +	case XFER_PIO_4:

    MWDMA0/1 timings don't match PIO4, they are [much] slower.

> +		value |= 0x0400;
> +		break;
> +	case XFER_PIO_3:
> +		value |= 0x0300;
> +		break;
> +	case XFER_PIO_2:
> +		value |= 0x0200;
> +		break;
> +	case XFER_PIO_1:
> +		value |= 0x0100;
> +		break;
> +	default:
> +	case XFER_PIO_0:
> +		value |= 0x0000;
> +		break;
> +	}
 > +
> +	if (is_slave)
> +		hwif->select_data =
> +			(hwif->select_data & ~0xffff0000) | (value << 16);

    Why not just 0x0000ffff?

> +	else
> +		hwif->select_data = (hwif->select_data & ~0x0000ffff) | value;

    Why not just 0xffff0000?

> +	TX4939IDE_writew(value, base, Sys_Ctl);
> +}
> +
> +static void tx4939ide_set_pio_mode(ide_drive_t *drive, const u8 pio)
> +{
> +	tx4939ide_set_mode(drive, XFER_PIO_0 + pio);
> +}

    I suggest that you implement tx4939ide_set_{dma|pio}_mode() as seperate 
functions, possibly using a common function to do a final part. These 2 
methods are quite different functionally.

> +
> +static void tx4939ide_check_error_ints(ide_hwif_t *hwif, u16 stat)
> +{
> +	if (stat & TX4939IDE_INT_BUSERR) {
> +		unsigned long base = TX4939IDE_BASE(hwif);
> +		/* reset FIFO */
> +		TX4939IDE_writew(TX4939IDE_readw(base, Sys_Ctl) |
> +				 0x4000,
> +				 base, Sys_Ctl);
> +	}
> +	if (stat & (TX4939IDE_INT_ADDRERR | TX4939IDE_INT_REACHMUL |
> +		    TX4939IDE_INT_DEVTIMING | TX4939IDE_INT_BUSERR))
> +		pr_err("%s: Error interrupt %#x (%s%s%s%s )\n",
> +		       hwif->name, stat,
> +		       (stat & TX4939IDE_INT_ADDRERR) ?
> +		       " Address-Error" : "",
> +		       (stat & TX4939IDE_INT_REACHMUL) ?
> +		       " Reach-Multiple" : "",
> +		       (stat & TX4939IDE_INT_DEVTIMING) ?
> +		       " DEV-Timing" : "",
> +		       (stat & TX4939IDE_INT_BUSERR) ?
> +		       " Bus-Error" : "");
> +}
> +
> +static void tx4939ide_clear_irq(ide_drive_t *drive)
> +{
> +	ide_hwif_t *hwif;
> +	unsigned long base;
> +	u16 ctl;
> +
> +	/*
> +	 * tx4939ide_dma_test_irq() and tx4939ide_dma_end() do all
> +	 * jobs for DMA case.
> +	 */
> +	if (drive->waiting_for_dma)
> +		return;
> +	hwif = HWIF(drive);
> +	base = TX4939IDE_BASE(hwif);
> +	ctl = TX4939IDE_readw(base, int_ctl);
> +
> +	tx4939ide_check_error_ints(hwif, ctl);
> +	TX4939IDE_writew(ctl, base, int_ctl);
> +}
> +
> +static int tx4939ide_dma_setup(ide_drive_t *drive)
> +{
> +	ide_hwif_t *hwif = HWIF(drive);
> +	unsigned long base = TX4939IDE_BASE(hwif);
> +	int is_slave = drive->dn & 1;
> +	unsigned int nframes;
> +	int rc, i;
> +	unsigned int sect_size = queue_hardsect_size(drive->queue);
> +	u16 select_data;
> +
> +	select_data = (hwif->select_data >> (is_slave ? 16 : 0)) & 0xffff;
> +	TX4939IDE_writew(select_data, base, Sys_Ctl);

    Unfortunately, programming the timings from the dma_setup() method isn't 
enough since it won't be called for PIO transfers.  You'll have to use the 
selectproc() method.

MBR, Sergei
