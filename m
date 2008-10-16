From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: Add tx4939ide driver (v3)
Date: Thu, 16 Oct 2008 16:52:45 +0400
Message-ID: <48F7391D.8050109@ru.mvista.com>
References: <20081003.000838.27954527.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:60113 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750926AbYJPMwv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Oct 2008 08:52:51 -0400
In-Reply-To: <20081003.000838.27954527.anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ralf@linux-mips.org

Hello.

Atsushi Nemoto wrote:

> This is the driver for the Toshiba TX4939 SoC ATA controller.
>
> This controller has standard ATA taskfile registers and DMA
> command/status registers, but the register layout is swapped on big
> endian.  There are some other endian issue and some special registers
> which requires many custom dma_ops/tp_ops routines and build_dmatable.
>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

   Mostly ACK but there's still a few minor nits...

> diff --git a/drivers/ide/mips/Makefile b/drivers/ide/mips/Makefile
> index 677c7b2..1e0ad98 100644
> --- a/drivers/ide/mips/Makefile
> +++ b/drivers/ide/mips/Makefile
> @@ -1,4 +1,5 @@
>  obj-$(CONFIG_BLK_DEV_IDE_SWARM)		+= swarm.o
>   

  The context have changed here but I guess Bart handled that...

> diff --git a/drivers/ide/mips/tx4939ide.c b/drivers/ide/mips/tx4939ide.c
> new file mode 100644
> index 0000000..6671d64
> --- /dev/null
> +++ b/drivers/ide/mips/tx4939ide.c
> @@ -0,0 +1,775 @@
>   
[...]
> +/* ATA Shadow Registers (8-bit except for DATA which is 16-bit) */
> +#define TX4939IDE_DATA			0x000
>   

   Not sure whether the data register deserves more respect than the 
others. :-)

> +/* H/W DMA Registers  */
> +#define TX4939IDE_DMA_Cmd	0x800	/* 8-bit */
> +#define TX4939IDE_DMA_stat	0x802	/* 8-bit */
>   

   Symbol case still inconsistent...

> +static void tx4939ide_set_dma_mode(ide_drive_t *drive, const u8 mode)
> +{
> +	ide_hwif_t *hwif = drive->hwif;
> +	u32 mask, val;
> +
> +	/* Update Data Transfer Mode for this drive. */
> +	if (mode >= XFER_UDMA_0)
> +		val = mode - XFER_UDMA_0 + 8;
> +	else if (mode >= XFER_MW_DMA_0)
> +		val = mode - XFER_MW_DMA_0 + 5;
> +	else
> +		val = mode - XFER_PIO_0;
>   

   I must've missed that in the previous review but you don't need to 
handle PIO modes in this method.

> +static u16 tx4939ide_check_error_ints(ide_hwif_t *hwif)
> +{
> +	void __iomem *base = TX4939IDE_BASE(hwif);
> +	u16 ctl = tx4939ide_readw(base, TX4939IDE_Int_Ctl);
> +
> +	if (ctl & TX4939IDE_INT_BUSERR) {
> +		/* reset FIFO */
> +		u16 sysctl = tx4939ide_readw(base, TX4939IDE_Sys_Ctl);
> +		tx4939ide_writew(sysctl | 0x4000, base, TX4939IDE_Sys_Ctl);
> +		mmiowb();
> +		/* wait 12GBUSCLK (typ. 60ns @ GBUS200MHz, max 270ns) */
> +		ndelay(270);
> +		tx4939ide_writew(sysctl, base, TX4939IDE_Sys_Ctl);
> +	}
> +	if (ctl & (TX4939IDE_INT_ADDRERR |
> +		    TX4939IDE_INT_DEVTIMING | TX4939IDE_INT_BUSERR))
>   

   Hm, why not line up TX4939IDE_INT_DEVTIMING with TX4939IDE_INT_ADDRERR?

> +static void tx4939ide_clear_irq(ide_drive_t *drive)
> +{
> +	ide_hwif_t *hwif;
> +	void __iomem *base;
> +	u16 ctl;
> +
> +	/*
> +	 * tx4939ide_dma_test_irq() and tx4939ide_dma_end() do all
> +	 * jobs for DMA case.
>   

   Shouldn't it be "job", singular?

> +#ifdef __BIG_ENDIAN
> +static void tx4939ide_dma_host_set(ide_drive_t *drive, int on)
> +{
> +	ide_hwif_t *hwif	= drive->hwif;
> +	u8 unit			= drive->dn & 1;
> +	void __iomem *base = TX4939IDE_BASE(hwif);
> +	u8 dma_stat = tx4939ide_readb(base, TX4939IDE_DMA_stat);
>   

   Hm, why not line up all the initializers? Either do line up all or do 
not line up any...

> +static u8 tx4939ide_read_and_clear_dma_status(void __iomem *base)
>   

   Hum, that's a long name... :-)

> +#ifdef __BIG_ENDIAN
> +/* custom ide_build_dmatable to handle swapped layout */
> +static int tx4939ide_build_dmatable(ide_drive_t *drive, struct request *rq)
> +{
>   
[...]
> +			xcount = bcount & 0xffff;
> +			if (xcount == 0x0000) {
>   

   Hm, I'm not sure this is necessary here... although I didn't see an 
explicit mention that zero count means 64 KB in the datasheet -- which 
it must mean if the BMIDE spec. was followed).
In ide-dma.c this check was added because of CS5530's brain damage...

> +static int tx4939ide_dma_end(ide_drive_t *drive)
> +{
>   
[...]
> +	if ((dma_stat & 7) == 0 &&
> +	    (ctl & (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST)) ==
> +	    (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST))
>   

   Parens around & and | are hardly needed...

> +/* returns 1 if dma irq issued, 0 otherwise */
> +static int tx4939ide_dma_test_irq(ide_drive_t *drive)
> +{
> +	ide_hwif_t *hwif = drive->hwif;
> +	void __iomem *base = TX4939IDE_BASE(hwif);
> +	u16 ctl;
> +	u8 dma_stat, stat;
> +	u16 ide_int;
> +	int found = 0;
> +
> +	ctl = tx4939ide_check_error_ints(hwif);
> +	ide_int = ctl & (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST);
> +	switch (ide_int) {
> +	case TX4939IDE_INT_HOST:
> +		/* On error, XFEREND might not be asserted. */
> +		stat = tx4939ide_readb(base, TX4939IDE_AltStat_DevCtl);
> +		if ((stat & (ATA_BUSY|ATA_DRQ|ATA_ERR)) == ATA_ERR)
> +			found = 1;
> +		else {
> +			/* Wait for XFERINT (Mask HOST and unmask XFERINT) */
>   

   s/XFERINT/XFEREND/

> +			ctl &= ~TX4939IDE_INT_XFEREND << 8;
> +			ctl |= TX4939IDE_INT_HOST << 8;
>   

  The last statement seems superfluous given that the same is achieved 
by the following statement.

> +		}
> +		ctl |= ide_int << 8;
> +		break;
> +	case TX4939IDE_INT_HOST | TX4939IDE_INT_XFEREND:
> +		dma_stat = tx4939ide_readb(base, TX4939IDE_DMA_stat);
> +		if (!(dma_stat & 4))
> +			pr_warning("%s: weird interrupt status. "
> +				   "DMA_stat %#02x int_ctl %#04x\n",
> +				   hwif->name, dma_stat, ctl);
> +		found = 1;
> +		break;
> +	}
> +	/*
> +	 * Do not clear XFERINT, HOST now.  They will be cleared by
>   

   s/XFERINT/XFEREND/

> +static u8 tx4939ide_read_sff_dma_status(ide_hwif_t *hwif)
> +{
> +	void __iomem *base = TX4939IDE_BASE(hwif);
> +	return tx4939ide_readb(base, TX4939IDE_DMA_stat);
> +}
> +
>   

   Can't ide_read_sff_dma_status() be used in LE mode now that you set 
hwif->dma_base?

> +static void tx4939ide_insw_swap(unsigned long port, void *addr, u32 count)
>   
[...]
> +static void tx4939ide_outsw_swap(unsigned long port, void *addr, u32 count)
>   

   Shouldn't these be inline (if you really need them)?

> +static int __init tx4939ide_probe(struct platform_device *pdev)
> +{
>   
[...]
> +	pr_info("TX4939 IDE interface (%lx,%d)\n", mapbase, irq);
>   

   Hm, the bare numbers in the log won't be informative, could you add 
"base" and "IRQ"?

MBR, Sergei


