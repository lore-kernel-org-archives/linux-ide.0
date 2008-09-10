From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Thu, 11 Sep 2008 00:32:22 +0900 (JST)
Message-ID: <20080911.003222.51867360.anemo@mba.ocn.ne.jp>
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
	<48C6B768.4010200@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:64781 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752235AbYIJPcR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Sep 2008 11:32:17 -0400
In-Reply-To: <48C6B768.4010200@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

On Tue, 09 Sep 2008 21:50:32 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > +static void tx4939ide_set_mode(ide_drive_t *drive, const u8 speed)
> > +{
> > +	ide_hwif_t *hwif = HWIF(drive);
> > +	unsigned long base = TX4939IDE_BASE(hwif);
> > +	int is_slave = drive->dn & 1;
> > +	u16 value;
> > +	int safe_speed = speed;
> > +	int i;
> > +
> > +	for (i = 0; i < MAX_DRIVES; i++) {
> 
>     Use ide_get_paired_drive() ISO this loop.

Thanks.  That's what I needed.

> > +		if (drive != &hwif->drives[i] &&
> > +		    (hwif->drives[i].dev_flags & IDE_DFLAG_PRESENT))
> > +			safe_speed = min(safe_speed,
> > +					 (int)hwif->drives[i].current_speed);
> 
>     You shouldn't clamp the command PIO mode timings like this, and shouldn't 
> do it at all when DMA mode is set. Call ide_get_best_pio_mode(255, 4) to get 
> the mate drive's fastest PIO mode which should be a clamping value.
> 
> > +	/* Command Transfer Mode Select */
> > +	switch (safe_speed) {
> > +	case XFER_UDMA_5:
> > +	case XFER_UDMA_4:
> > +	case XFER_UDMA_3:
> > +	case XFER_UDMA_2:
> > +	case XFER_UDMA_1:
> > +	case XFER_UDMA_0:
> > +	case XFER_MW_DMA_2:
> 
>     You shouldn't change the command PIO mode when DMA mode is selected.

But the "Command Transfer Mode Select" bits affects access timings on
setting task registers for DMA command.  Hmm... do you mean I should
not do it _here_?

> > +	case XFER_MW_DMA_1:
> > +	case XFER_MW_DMA_0:
> > +	case XFER_PIO_4:
> 
>     MWDMA0/1 timings don't match PIO4, they are [much] slower.

Oh thanks.  I will fix it.

> > +		hwif->select_data =
> > +			(hwif->select_data & ~0xffff0000) | (value << 16);
> 
>     Why not just 0x0000ffff?
> 
> > +	else
> > +		hwif->select_data = (hwif->select_data & ~0x0000ffff) | value;
> 
>     Why not just 0xffff0000?

Indeed.

> > +static void tx4939ide_set_pio_mode(ide_drive_t *drive, const u8 pio)
> > +{
> > +	tx4939ide_set_mode(drive, XFER_PIO_0 + pio);
> > +}
> 
>     I suggest that you implement tx4939ide_set_{dma|pio}_mode() as seperate 
> functions, possibly using a common function to do a final part. These 2 
> methods are quite different functionally.
> 
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
> 
>     Unfortunately, programming the timings from the dma_setup() method isn't 
> enough since it won't be called for PIO transfers.  You'll have to use the 
> selectproc() method.

Thanks.  I should rework whole timing setup code.

---
Atsushi Nemoto
