From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Fri, 12 Sep 2008 02:33:12 +0400
Message-ID: <48C99CA8.5030602@ru.mvista.com>
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:49820 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751810AbYIKWdS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Sep 2008 18:33:18 -0400
In-Reply-To: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
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
> which requires many custom dma_ops/port_ops routines.
>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>   
[...]
> diff --git a/drivers/ide/mips/tx4939ide.c b/drivers/ide/mips/tx4939ide.c
> new file mode 100644
> index 0000000..ba9776d
> --- /dev/null
> +++ b/drivers/ide/mips/tx4939ide.c
> @@ -0,0 +1,762 @@
>   
[...]
> +static void tx4939ide_dma_host_set(ide_drive_t *drive, int on)
> +{
> +	ide_hwif_t *hwif	= HWIF(drive);
> +	u8 unit			= drive->dn & 1;
> +	unsigned long base = TX4939IDE_BASE(hwif);
> +	u8 dma_stat = TX4939IDE_readb(base, DMA_stat);
> +
> +	if (on)
> +		dma_stat |= (1 << (5 + unit));
> +	else
> +		dma_stat &= ~(1 << (5 + unit));
> +
> +	TX4939IDE_writeb(dma_stat, base, DMA_stat);
> +}
>   

   BTW, you could save on using ide_dma_host_set() in LE mode if you'd 
set hwif->dma_base properly...

> +static int __tx4939ide_dma_setup(ide_drive_t *drive)
> +{
> +	ide_hwif_t *hwif = drive->hwif;
> +	struct request *rq = HWGROUP(drive)->rq;
> +	unsigned int reading;
> +	u8 dma_stat;
> +	unsigned long base = TX4939IDE_BASE(hwif);
> +
[...]
> +
> +	/* read DMA status for INTR & ERROR flags */
> +	dma_stat = TX4939IDE_readb(base, DMA_stat);
> +
> +	/* clear INTR & ERROR flags */
> +	TX4939IDE_writeb(dma_stat | 6, base, DMA_stat);
> +	/* recover intmask cleared by writing to bit2 of DMA_stat */
> +	TX4939IDE_writew(TX4939IDE_IGNORE_INTS << 8, base, int_ctl);
>   

   I think it might be worth factoring the BMDMA status clearing code 
into a separate function...

> +
> +	drive->waiting_for_dma = 1;
> +	return 0;
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
> +	if (is_slave)
> +		TX4939IDE_writew(sect_size / 2, base, Xfer_Cnt_2);
> +	else
> +		TX4939IDE_writew(sect_size / 2, base, Xfer_Cnt_1);
> +
> +	rc = __tx4939ide_dma_setup(drive);
>   

   Hm, I think you need to call this earlier and do an early exit if it 
returns 1.

> +	if (rc == 0) {
>   

   Better check for !=0, return early and avoid unnecessary 
indentatiuon, isn't it?

> +		/* Number of sectors to transfer. */
> +		nframes = 0;
> +		for (i = 0; i < hwif->sg_nents; i++)
> +			nframes += sg_dma_len(&hwif->sg_table[i]);
> +		BUG_ON(nframes % sect_size != 0);
> +		nframes /= sect_size;
> +		BUG_ON(nframes == 0);
> +		TX4939IDE_writew(nframes, base, Sec_Cnt);
> +	}
> +	return rc;
> +}
> +
> +static void tx4939ide_dma_start(ide_drive_t *drive)
> +{
> +	ide_hwif_t *hwif = drive->hwif;
> +	unsigned long base = TX4939IDE_BASE(hwif);
> +	u8 dma_cmd;
> +
> +	/* Note that this is done *after* the cmd has
> +	 * been issued to the drive, as per the BM-IDE spec.
> +	 */
> +	dma_cmd = TX4939IDE_readb(base, DMA_Cmd);
> +	/* start DMA */
> +	TX4939IDE_writeb(dma_cmd | 1, base, DMA_Cmd);
> +
> +	wmb();
> +}
>   

   You could save by using ide_dma_start() in LE mode too...

> +#ifdef __BIG_ENDIAN
> +/* custom iops (independent from SWAP_IO_SPACE) */
> +static u8 mm_inb(unsigned long port)
> +{
> +	return (u8)readb((void __iomem *)port);
> +}
> +static void mm_outb(u8 value, unsigned long port)
> +{
> +	writeb(value, (void __iomem *)port);
> +}
>   

   I'm not sure readb()/writeb() are good substitute for 
__raw_readb()/__raw_writeb() as __swizzle_addr_b() might be actually 
changing the address...

MBR, Sergei


