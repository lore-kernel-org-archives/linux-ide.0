From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Fri, 12 Sep 2008 19:34:06 +0400
Message-ID: <48CA8BEE.1090305@ru.mvista.com>
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>	<48C851ED.4090607@ru.mvista.com> <20080912.005243.48535230.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:2788 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753762AbYILPdY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Sep 2008 11:33:24 -0400
In-Reply-To: <20080912.005243.48535230.anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

Atsushi Nemoto wrote:

>>>+static void tx4939ide_check_error_ints(ide_hwif_t *hwif, u16 stat)
>>>+{
>>>+	if (stat & TX4939IDE_INT_BUSERR) {
>>>+		unsigned long base = TX4939IDE_BASE(hwif);
>>>+		/* reset FIFO */
>>>+		TX4939IDE_writew(TX4939IDE_readw(base, Sys_Ctl) |
>>>+				 0x4000,
>>>+				 base, Sys_Ctl);

>>   Are you sure bit 14 is self-clearing? The datashhet doesn't seem to 
>>say that...

> Well, I cannot remember...  I thought I checked that bit cleard by
> reading it, but actually the bit is write-only.  Maybe clearing
> explicitly would be a safe bet.

    It's also write-only on TC86C001, and the original driver (as well as 
mine) cleared it explicitly.

>>>+	rc = __tx4939ide_dma_setup(drive);
>>>+	if (rc == 0) {
>>>+		/* Number of sectors to transfer. */
>>>+		nframes = 0;
>>>+		for (i = 0; i < hwif->sg_nents; i++)
>>>+			nframes += sg_dma_len(&hwif->sg_table[i]);
>>>+		BUG_ON(nframes % sect_size != 0);
>>>+		nframes /= sect_size;
>>>+		BUG_ON(nframes == 0);
>>>+		TX4939IDE_writew(nframes, base, Sec_Cnt);

>>   Ugh, it looks much easier in my TC86C001 driver... doesn't 
>>hwgroup->rq->nr_sectors give you a number of 512 sectors?
>>Why bother with other (multiple of 512) sizes when you can always 
>>program transfer in 512-byte sectors? Or was I wrong there?

    Anyway, the TX3939 datasheet says that sector size must be a multiple of 
256 words when transferring more than 1 sector.

> Hmm.  Good idea.  I will try it.

    At least it worked with a CD-ROM for me. :-)

>>>+static int tx4939ide_dma_end(ide_drive_t *drive)
>>>+{
>>>+	if ((dma_stat & 7) == 0 &&
>>>+	    (ctl & (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST)) ==
>>>+	    (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST))
>>>+		/* INT_IDE lost... bug? */
>>>+		return 0;

>>   You shouldn't fake the BMDMA interrupt. If it's not there, it's not 
>>there. Or does this actually happen?

> IIRC, Yes.

    Hum, let me think... worth printing a message if this happens.

>>>+		/*
>>>+		 * If only one of XFERINT and HOST was asserted, mask
>>>+		 * this interrupt and wait for an another one.  Note

>>   This comment somewhat contradicts the code which returns 1 if only 
>>HOST interupt is asserted if ERR is set.

    Which is not its business to test. I think you should remove that above 
check -- if there's INTRQ asserted, then it's asserted. I wonder if BMIDE 
interrupt bit gets set in that case (suspecting it's not)...

> Indeed.  I will make the comment more precise.

>>>+	case TX4939IDE_INT_HOST | TX4939IDE_INT_XFEREND:
>>>+		dma_stat = TX4939IDE_readb(base, DMA_stat);
>>>+		if (!(dma_stat & 4))
>>>+			pr_debug("%s: weired interrupt status. "
>>>  

>>   Weird.

> Sure.  But it can happen IIRC...

    I meant the typo. :-)

>>>#ifdef __BIG_ENDIAN
>>>+/* custom iops (independent from SWAP_IO_SPACE) */
>>>  
>>>+static u8 mm_inb(unsigned long port)
>>>+{
>>>+	return (u8)readb((void __iomem *)port);
>>>+}
>>>+static void mm_outb(u8 value, unsigned long port)
>>>+{
>>>+	writeb(value, (void __iomem *)port);
>>>+}
>>>+static void mm_tf_load(ide_drive_t *drive, ide_task_t *task)
>>>+{
>>>  

>>[...]

>>>+	if (task->tf_flags & IDE_TFLAG_OUT_DEVICE) {
>>>+		unsigned long base = TX4939IDE_BASE(hwif);
>>>+		mm_outb((tf->device & HIHI) | drive->select,
>>>+			 io_ports->device_addr);

>>   I'm seeing no sense in re-defining so far...

>>>+		/* Fix ATA100 CORE System Control Register */
>>>+		TX4939IDE_writew(TX4939IDE_readw(base, Sys_Ctl) & 0x07f0,
>>>+				 base, Sys_Ctl);

>>   Ah... you're doing it here (but not in LE mode?). I think to avoid 
>>duplicating ide_tf_load() you need ot use selectproc().

> Oh, my fault.  LE mode also needs this fix.  I still need ide_tf_load
> on BE mode to support IDE_TFLAG_OUT_DATA.

   Yeah, that totally useless flag...

>>>+static void mm_insw_swap(unsigned long port, void *addr, u32 count)
>>>+{
>>>+	unsigned short *ptr = addr;
>>>+	unsigned long size = count * 2;
>>>+	port &= ~1;
>>>+	while (count--)
>>>+		*ptr++ = le16_to_cpu(__raw_readw((void __iomem *)port));
>>>+	__ide_flush_dcache_range((unsigned long)addr, size);

>>   Why is this needed BTW?

> Do you mean __ide_flush_dcache_range?  This is needed to avoid cache
> inconsistency on PIO drive.  PIO transfer only writes to cache but
> upper layers expects the data is in main memory.

    Hum, then I wonder why it's MIPS specific...

>>>+static const struct ide_tp_ops tx4939ide_tp_ops = {
>>>+	.exec_command		= ide_exec_command,
>>>+	.read_status		= ide_read_status,
>>>+	.read_altstatus		= ide_read_altstatus,
>>>+	.read_sff_dma_status	= tx4939ide_read_sff_dma_status,

>>   Hum, it should be re-defined in both LE and BE mode (but actually not 
>>called anyway).

> What do you mean?  Please elaborate?

    I mean that in LE mode you're using ide_read_sff_dma_status() but not 
setting hwif->dma_base, so it won't work. But since it shouldn't be called in 
this driver's case, this doesn't hurt.

MBR, Sergei
