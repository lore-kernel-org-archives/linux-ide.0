From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Sun, 14 Sep 2008 22:05:12 +0900 (JST)
Message-ID: <20080914.220512.126760706.anemo@mba.ocn.ne.jp>
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
	<48CC3516.9080404@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:51226 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753008AbYINNFB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 14 Sep 2008 09:05:01 -0400
In-Reply-To: <48CC3516.9080404@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

On Sun, 14 Sep 2008 01:48:06 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > +#ifdef __BIG_ENDIAN
> > +	/* This setting does not affect PRD fetch */
> > +	/* ByteSwap=1, Endian=00 */
> > +	TX4939IDE_writew(0xc911, base, Add_Ctl);
> > +#else
> > +	TX4939IDE_writew(0xc901, base, Add_Ctl);
> > +#endif
> >   
> 
>    Aren't these the default register values? Is there a sense in writing 
> them?

Indeed.  It seems redundant.

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
> > +static void mm_tf_load(ide_drive_t *drive, ide_task_t *task)
> > +{
> > +	ide_hwif_t *hwif = drive->hwif;
> > +	struct ide_io_ports *io_ports = &hwif->io_ports;
> > +	struct ide_taskfile *tf = &task->tf;
> > +	u8 HIHI = (task->tf_flags & IDE_TFLAG_LBA48) ? 0xE0 : 0xEF;
> > +
> > +	if (task->tf_flags & IDE_TFLAG_FLAGGED)
> > +		HIHI = 0xFF;
> > +
> > +	if (task->tf_flags & IDE_TFLAG_OUT_DATA) {
> > +		u16 data = (tf->hob_data << 8) | tf->data;
> > +
> > +		__raw_writew(data, (void __iomem *)io_ports->data_addr);
> >   
> 
>    This doesn't look consistent (aside from the TX4939IDE_REG8/16 issue) 
> -- mm_outsw_swap() calls cpu_to_le16() before writing 16-bit data but 
> this code doesn't. So, either one of those should be wrong...

Thanks, this code should be wrong.  IDE_TFLAG_OUT_DATA is totally
untested...

> > +static void mm_insw_swap(unsigned long port, void *addr, u32 count)
> > +{
> > +	unsigned short *ptr = addr;
> > +	unsigned long size = count * 2;
> > +	port &= ~1;
> > +	while (count--)
> > +		*ptr++ = le16_to_cpu(__raw_readw((void __iomem *)port));
> > +	__ide_flush_dcache_range((unsigned long)addr, size);
> > +}
> > +static void mm_outsw_swap(unsigned long port, void *addr, u32 count)
> > +{
> > +	unsigned short *ptr = addr;
> > +	unsigned long size = count * 2;
> > +	port &= ~1;
> > +	while (count--) {
> > +		__raw_writew(cpu_to_le16(*ptr), (void __iomem *)port);
> > +		ptr++;
> > +	}
> > +	__ide_flush_dcache_range((unsigned long)addr, size);
> > +}
> >   
> 
>     Hum... but is it really correct to convert from/to LE order above? 
> I'm prett sure that data is expected in LE order -- look ar 
> ide_fix_driveid() for example...

Well, do you mean I should use cpu_to_le16 in mm_insw_swap and
le16_to_cpu in mm_outsw_swap?  Or can I avoid these swapping entirely
in some way?

---
Atsushi Nemoto
