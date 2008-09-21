From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver (v2)
Date: Mon, 22 Sep 2008 01:32:56 +0900 (JST)
Message-ID: <20080922.013256.128618380.anemo@mba.ocn.ne.jp>
References: <20080918.001342.52129176.anemo@mba.ocn.ne.jp>
	<48D57245.8060606@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:64071 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554AbYIUQci (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 21 Sep 2008 12:32:38 -0400
In-Reply-To: <48D57245.8060606@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: bzolnier@gmail.com, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, ralf@linux-mips.org

On Sun, 21 Sep 2008 01:59:33 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > +	if (pair)
> > +		safe = min(safe, ide_get_best_pio_mode(pair, 255, 4));
> > +	/*
> > +	 * Update Command Transfer Mode for master/slave and Data
> > +	 * Transfer Mode for this drive.
> > +	 */
> > +	mask = is_slave ? 0x07f00700 : 0x070007f0;
> > +	val = (safe << 24) | (safe << 8) | (pio << (is_slave ? 20 : 4));
> >   
> 
>    You are not obliged to set the same command rimings for both drives...

I thought I should use "safe" command timings for command transfer
mode since taskfile registers should be considered as "shared" for
both drives.  At least device selection sequence should be done in
safe speed, isn't it?

> > +		/* wait 12GBUSCLK (typ. 60ns @ GBUS200MHz) */
> > +		ndelay(400);
> >   
> 
>    But why wait 400 ns?

Well, I should recalculate safe value for possible slowest gbus clock.

> > +	if (stat & (TX4939IDE_INT_ADDRERR | TX4939IDE_INT_REACHMUL |
> > +		    TX4939IDE_INT_DEVTIMING | TX4939IDE_INT_BUSERR))
> > +		pr_err("%s: Error interrupt %#x (%s%s%s%s )\n",
> > +		       hwif->name, stat,
> > +		       (stat & TX4939IDE_INT_ADDRERR) ?
> > +		       " Address-Error" : "",
> > +		       (stat & TX4939IDE_INT_REACHMUL) ?
> > +		       " Reach-Multiple" : "",
> >   
> 
>    This is not an error condition and should only happen in so called 
> VDMA mode iff you suspend the transfer, IIUC.

So just masking Reach-Multiple interrupt is better?

> > +	case TX4939IDE_INT_HOST | TX4939IDE_INT_XFEREND:
> > +		dma_stat = tx4939ide_readb(base, TX4939IDE_DMA_stat);
> > +		if (!(dma_stat & 4))
> > +			pr_debug("%s: weird interrupt status. "
> >   
> 
>    This one is worth pr_warning() or even pr_err()...
> 
> > +				 "DMA_stat %#02x int_ctl %#04x\n",
> > +				 hwif->name, dma_stat, ctl);
> >   
> 
>    However,  it's already done in the dma_end() method;.do we need 
> really to print 2 messages?

Yes, we don't need this usually.  So I used pr_debug() instead of
pr_warning().  But I have no strong opinition here.  I'll drop it.

> > +static void tx4939ide_init_iops(ide_hwif_t *hwif)
> > +{
> > +	/* use extra_base for base address of the all registers */
> > +	hwif->extra_base = hwif->io_ports.data_addr & ~0xfff;
> > +}
> 
>    Ugh... didn't realize that using hwif->extra_base necessiates the 
> init_iops() method. But why is it necessary? We're not using 
> hwif->extra_base to access the taskfile.

The extra_base is used by TX4939IDE_BASE() everywhere...
And I cannot find other good place to initialize extra_base.

We can initialize extra_base in tx4939ide_probe by using
ide_host_alloc()/ide_host_register() instead of ide_host_add().  Is
this preferred?

> > +static void tx4939ide_tf_load(ide_drive_t *drive, ide_task_t *task)
> > +{
> > +	mm_tf_load(drive, task);
> > +	if (task->tf_flags & IDE_TFLAG_OUT_DEVICE) {
> > +		ide_hwif_t *hwif = drive->hwif;
> > +		void __iomem *base = TX4939IDE_BASE(hwif);
> > +		/* Fix ATA100 CORE System Control Register */
> > +		tx4939ide_writew(tx4939ide_readw(base, TX4939IDE_Sys_Ctl) &
> > +				 0x07f0,
> > +				 base, TX4939IDE_Sys_Ctl);
> 
>    Why? Doesn't page 17-4 of the datasheet say that these bits get 
> auto-cleared ona  write to the device/head register? Or is this to 
> address <CAUSION> on page 17-9?

Yes, that "CAUSION".  I will put it in the comment.

>    Phew, that was long review...

I will address all other issues.

Thank you for great review again!

---
Atsushi Nemoto
