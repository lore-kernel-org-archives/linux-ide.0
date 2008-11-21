From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash interface.
Date: Fri, 21 Nov 2008 21:14:47 +0300
Message-ID: <4926FA97.201@ru.mvista.com>
References: <49261BE5.2010406@caviumnetworks.com> <4926E467.9020305@ru.mvista.com> <4926EFEE.2010701@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:5233 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752999AbYKUSOq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 Nov 2008 13:14:46 -0500
In-Reply-To: <4926EFEE.2010701@caviumnetworks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: linux-ide@vger.kernel.org, linux-mips <linux-mips@linux-mips.org>

Hello.

David Daney wrote:

>>> The register definitions are part of the chip support patch set
>>> mentioned above, and are not included here.

>>> At this point I would like to get feedback on the patch and would
>>> expect that it would merge via the linux-mips tree along with the rest
>>> of the chip support.

>>    Why a libata driver should be merged via the linus-mips tree?

> I don't have a strong preference.  The driver depends on the processor 
> support *and* it is only relevant to OCTEON based boards.  If the 

    Most SoC IDE drivers are like that.

> linux-ide maintainers would prefer to merge it via their tree that is 
> fine with me.

>>> Thanks,

>>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

>>> +static void octeon_cf_set_dmamode(struct ata_port *ap, struct 
>>> ata_device *dev)
>>> +{

>> [...]

>>> +    switch (dev->dma_mode) {
>>> +    case XFER_MW_DMA_0:
>>> +        dma_ackh = 20;    /* Tj */
>>> +        To = 480;
>>> +        Td = 215;
>>> +        Tkr = 50;

>>    It's safer to use Tkw instead as it's 215 ns minimum in this mode 
>> (in other modes Tkr and Tkw minimums are the same).
>>    Again, To, Td, and Tkw are returned by ata_timing_find_mode().

>>> +    /* Td (Seem to need more margin here.... */
>>> +    oe_a = Td + 20;

>>    Well, you shouldn't...

> Hmm...

     Shouldn't need more margin -- that why those a minimum timings.

>>> +/**
>>> + * Handle an I/O request.
>>> + *
>>> + * @cf:         Device to access
>>> + * @lba_sector: Starting sector
>>> + * @num_sectors:
>>> + *                   Number of sectors to transfer
>>> + * @buffer:     Data buffer
>>> + * @write:      Is the a write. Default to a read
>>> + */
>>> +static unsigned int octeon_cf_data_xfer(struct ata_device *dev,
>>> +                    unsigned char *buffer,
>>> +                    unsigned int buflen,
>>> +                    int rw)
>>> +{
>>> +    struct ata_port *ap        = dev->link->ap;
>>> +    struct octeon_cf_data *ocd    = ap->dev->platform_data;
>>> +    void __iomem *data_addr        = ap->ioaddr.data_addr;
>>> +    unsigned int words;
>>> +    unsigned int count;
>>> +
>>> +    /*
>>> +     * Odd lengths are not supported. We should always be a
>>> +     * multiple of 512.
>>> +     */
>>> +    BUG_ON(buflen & 1);
>>> +    if (ocd->is16bit) {
>>> +        words = buflen / 2;
>>> +        if (rw) {
>>> +            count = 16;
>>> +            while (words--) {
>>> +                iowrite16(*(uint16_t *)buffer, data_addr);
>>
>>
>>    Not seeing the reason to use iowrite16() and not writew() as 
>> registers are always memory mapped...

> I will consider that.

    Now that I think again, neither of those is correct. We must treat the 
data as a stream of bytes.

>>> +                buffer += sizeof(uint16_t);
>>> +                /*
>>> +                 * Every 16 writes do a read so the
>>> +                 * bootbus FIFO doesn't fill up.
>>> +                 */
>>> +                if (--count == 0) {
>>> +                    ioread8(ap->ioaddr.altstatus_addr);
>>> +                    count = 16;
>>> +                }

>>    This is a strange/slow way of doing anything every 16 data writes.

> Oh, how would you do something every 16 writes?

	count = words > 16 ? 16 : words;
	words -= count;
	iowrite16_rep(ptr, data_addr, count);
	ioread(ap->ioaddr.altstatus_addr);

>> Why not use iowrite16_rep()?

> Two reasons.  It is broken, and we need to do something every 16 writes.

    It's not broken -- using iowrite16() is wrong.

> We need to be careful not to be anti-social by filling the FIFO.  Once 
> the FIFO is filled other cores will be starved of I/O resources.

    It's not the first time I'm seeing this driver, so I'm familiar with the 
trick. Altho I didn't realize that this abuses the shared write buffer.

> [...]

>>> +static void octeon_cf_tf_read16(struct ata_port *ap, struct 
>>> ata_taskfile *tf)
>>> +{
>>> +    u16 blob;
>>> +    /* The base of the registers is at ioaddr.data_addr. */
>>> +    void __iomem *base = ap->ioaddr.data_addr;
>>> +
>>> +    blob = __raw_readw(base + 0xc);
>>> +    tf->feature = blob >> 8;

>>    How come the error register gets mapped at offset 0xC?
>>    (Well, that would explain alike part in another CF driver.)

> In 16 bit mode it overlaps the data register, so it must be accessed via 
 > the 0xc address.

    Actually, these register *always* overlap. That's the way that IDE thing 
works. :-)
    But I'm getting it now -- no way to differ the data read/write from the 
error/feature register read/write in 16-bit mode.

>>> +/**
>>> + * Check if any queued commands have more DMAs, if so start the next
>>> + * transfer, else do standard handling.
>>> + */
>>> +irqreturn_t octeon_cf_interrupt(int irq, void *dev_instance)

>>    Is that a normal IDE interrupt, or some Octeon specific interrupt?

> No, It is OCTEON specific.  It fires when a DMA operation is complete. 

> As I mentioned earlier, the normal IDE interrupt is not connected to 
> anything on most boards.

    That's not exactly a good design desicion...

>>> +{
>>> +    struct ata_host *host = dev_instance;
>>> +    struct octeon_cf_port *cf_port;
>>> +    int i;
>>> +    unsigned int handled = 0;
>>> +    unsigned long flags;
>>> +
>>> +    spin_lock_irqsave(&host->lock, flags);
>>> +
>>> +    DPRINTK("ENTER\n");

    "ENTER" needs "EXIT", no?

>>> +    for (i = 0; i < host->n_ports; i++) {
>>> +        struct ata_port *ap;
>>> +        struct ata_queued_cmd *qc;
>>> +
>>> +        ap = host->ports[i];
>>> +        if (!ap || (ap->flags & ATA_FLAG_DISABLED))
>>> +            continue;
>>> +
>>> +        qc = ata_qc_from_tag(ap, ap->link.active_tag);
>>> +        if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)) &&
>>> +            (qc->flags & ATA_QCFLAG_ACTIVE)) {
>>> +            u8 status = octeon_cf_bmdma_status(ap);
>>> +            if ((status & ATA_DMA_INTR)
>>> +                && !(status & ATA_DMA_ACTIVE)
>>> +                && !sg_is_last(qc->cursg)) {
>>> +                qc->cursg = sg_next(qc->cursg);
>>> +                handled = 1;
>>> +                octeon_cf_bmdma_start(qc);
>>> +            } else {
>>> +                status = ioread8(ap->ioaddr.altstatus_addr);
>>> +                if (status & ATA_BUSY) {

>>    If it's normal IDE interrupt,

> Which it is not.  So...

>> BSY bit will always be 0 

> ...this doesn't hold, thus all this code.

    Not necessarily. Depends on when the DMA interrupt occurs. Although it 
probably predates the IDE interrupt...

>>> +static int __devinit octeon_cf_probe(struct platform_device *pdev)
>>> +{
>>> +    struct resource *res_cs0, *res_cs1;
>>> +
>>> +    void __iomem *cs0;
>>> +    void __iomem *cs1;

>> [...]

>>> +
>>> +    res_cs0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +    res_cs1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);

>> [...]

>>> +    base = cs0 + ocd->base_region_bias;
>>> +    if (!ocd->is16bit) {

>> [...]

>>> +        ap->ioaddr.altstatus_addr = base + 0xe;
>>> +        ap->ioaddr.ctl_addr    = base + 0xe;

>>    Wait, why have 2 MMIO resources then?

> The boards that are 'TrueIDE' use two resources, others only one.

    But your probe will abort seeing only one resource. I think this needs to 
be changed.

MBR, Sergei
