From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Fri, 12 Sep 2008 23:37:17 +0900 (JST)
Message-ID: <20080912.233717.27957136.anemo@mba.ocn.ne.jp>
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
	<48C99CA8.5030602@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:52341 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752840AbYILOhL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Sep 2008 10:37:11 -0400
In-Reply-To: <48C99CA8.5030602@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

On Fri, 12 Sep 2008 02:33:12 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > +static void tx4939ide_dma_host_set(ide_drive_t *drive, int on)
> > +{
> > +	ide_hwif_t *hwif	= HWIF(drive);
> > +	u8 unit			= drive->dn & 1;
> > +	unsigned long base = TX4939IDE_BASE(hwif);
> > +	u8 dma_stat = TX4939IDE_readb(base, DMA_stat);
> > +
> > +	if (on)
> > +		dma_stat |= (1 << (5 + unit));
> > +	else
> > +		dma_stat &= ~(1 << (5 + unit));
> > +
> > +	TX4939IDE_writeb(dma_stat, base, DMA_stat);
> > +}
> >   
> 
>    BTW, you could save on using ide_dma_host_set() in LE mode if you'd 
> set hwif->dma_base properly...

Yes.  I like endian-free approach in general, but there is already
some ifdefs in this driver.  I have no strong opinion here.

> > +static int __tx4939ide_dma_setup(ide_drive_t *drive)
> > +{
> > +	ide_hwif_t *hwif = drive->hwif;
> > +	struct request *rq = HWGROUP(drive)->rq;
> > +	unsigned int reading;
> > +	u8 dma_stat;
> > +	unsigned long base = TX4939IDE_BASE(hwif);
> > +
> [...]
> > +
> > +	/* read DMA status for INTR & ERROR flags */
> > +	dma_stat = TX4939IDE_readb(base, DMA_stat);
> > +
> > +	/* clear INTR & ERROR flags */
> > +	TX4939IDE_writeb(dma_stat | 6, base, DMA_stat);
> > +	/* recover intmask cleared by writing to bit2 of DMA_stat */
> > +	TX4939IDE_writew(TX4939IDE_IGNORE_INTS << 8, base, int_ctl);
> >   
> 
>    I think it might be worth factoring the BMDMA status clearing code 
> into a separate function...

OK.  Good idea.

> > +static int tx4939ide_dma_setup(ide_drive_t *drive)
> > +{
> > +	ide_hwif_t *hwif = HWIF(drive);
> > +	unsigned long base = TX4939IDE_BASE(hwif);
> > +	int is_slave = drive->dn & 1;
> > +	unsigned int nframes;
> > +	int rc, i;
> > +	unsigned int sect_size = queue_hardsect_size(drive->queue);
> > +	u16 select_data;
> > +
> > +	select_data = (hwif->select_data >> (is_slave ? 16 : 0)) & 0xffff;
> > +	TX4939IDE_writew(select_data, base, Sys_Ctl);
> > +	if (is_slave)
> > +		TX4939IDE_writew(sect_size / 2, base, Xfer_Cnt_2);
> > +	else
> > +		TX4939IDE_writew(sect_size / 2, base, Xfer_Cnt_1);
> > +
> > +	rc = __tx4939ide_dma_setup(drive);
> 
>    Hm, I think you need to call this earlier and do an early exit if it 
> returns 1.
> 
> > +	if (rc == 0) {
> >   
> 
>    Better check for !=0, return early and avoid unnecessary 
> indentatiuon, isn't it?

It mighet be better.  I'll try it.

> > +static void tx4939ide_dma_start(ide_drive_t *drive)
> > +{
> > +	ide_hwif_t *hwif = drive->hwif;
> > +	unsigned long base = TX4939IDE_BASE(hwif);
> > +	u8 dma_cmd;
> > +
> > +	/* Note that this is done *after* the cmd has
> > +	 * been issued to the drive, as per the BM-IDE spec.
> > +	 */
> > +	dma_cmd = TX4939IDE_readb(base, DMA_Cmd);
> > +	/* start DMA */
> > +	TX4939IDE_writeb(dma_cmd | 1, base, DMA_Cmd);
> > +
> > +	wmb();
> > +}
> >   
> 
>    You could save by using ide_dma_start() in LE mode too...

Ditto.

> > +#ifdef __BIG_ENDIAN
> > +/* custom iops (independent from SWAP_IO_SPACE) */
> > +static u8 mm_inb(unsigned long port)
> > +{
> > +	return (u8)readb((void __iomem *)port);
> > +}
> > +static void mm_outb(u8 value, unsigned long port)
> > +{
> > +	writeb(value, (void __iomem *)port);
> > +}
> >   
> 
>    I'm not sure readb()/writeb() are good substitute for 
> __raw_readb()/__raw_writeb() as __swizzle_addr_b() might be actually 
> changing the address...

__swizzle_addr_b() used for both readb() and __raw_readb().  ioswabb()
is used for readb() and __raw_ioswabb() is used for __raw_readb().
Hm, __raw_readb() might be better for consistency, though I cannot
imagine any custom ioswabb() ;-)

---
Atsushi Nemoto
