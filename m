From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash interface.
Date: Fri, 21 Nov 2008 09:29:18 -0800
Message-ID: <4926EFEE.2010701@caviumnetworks.com>
References: <49261BE5.2010406@caviumnetworks.com> <4926E467.9020305@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8562 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbYKURg2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Nov 2008 12:36:28 -0500
In-Reply-To: <4926E467.9020305@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-mips <linux-mips@linux-mips.org>

Thanks for the feedback...

Sergei Shtylyov wrote:
> Hello.
> 
> David Daney wrote:
> 
>> As part of our efforts to get the Cavium OCTEON processor support
>> merged (see: http://marc.info/?l=linux-mips&m=122704699515601), we
>> have this CF driver for your consideration.
> 
>> Most OCTEON variants have *no* DMA or interrupt support
> 
>    That latter excludes the variant of porting to the IDE core...

That's right.

> 
>> The register definitions are part of the chip support patch set
>> mentioned above, and are not included here.
> 
>> At this point I would like to get feedback on the patch and would
>> expect that it would merge via the linux-mips tree along with the rest
>> of the chip support.
> 
>    Why a libata driver should be merged via the linus-mips tree?
> 

I don't have a strong preference.  The driver depends on the processor 
support *and* it is only relevant to OCTEON based boards.  If the 
linux-ide maintainers would prefer to merge it via their tree that is 
fine with me.

>> Thanks,
> 
>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> 
>> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
>> new file mode 100644
>> index 0000000..e8712c0
>> --- /dev/null
>> +++ b/drivers/ata/pata_octeon_cf.c
>> @@ -0,0 +1,942 @@
> [...]
>> +#define DRV_NAME    "pata_octeon_cf"
>> +#define DRV_VERSION    "2.1"
> 
>    First version and already 2.1? :-)

No, versions 1.0, 1.1, and 2.0 exist, but are living a decadent 
out-of-tree life.

[...]
>> +static unsigned int div_roundup(unsigned int n, unsigned int d)
>> +{
>> +    return (n + d - 1) / d;
>> +}
> 
>    Why reinvent the wheel? There's DIV_ROUND_UP macro in 
> <linux/kernel.h>...
> 

OK.

>> + * Called after libata determines the needed PIO mode. This
>> + * function programs the Octeon bootbus regions to support the
>> + * timing requirements of the PIO mode.
>> + *
>> + * @ap:     ATA port information
>> + * @dev:    ATA device
>> + */
>> +static void octeon_cf_set_piomode(struct ata_port *ap, struct 
>> ata_device *dev)
>> +{
>> +    struct octeon_cf_data *ocd = ap->dev->platform_data;
>> +    cvmx_mio_boot_reg_timx_t mio_boot_reg_tim;
>> +    unsigned int cs = ocd->base_region;
>> +
>> +    int use_iordy;        /* Non zero to monitor the IORDY signal */
>> +    int clocks_us;        /* Number of clock cycles per microsec */
>> +    /* These names are timing parameters from the ATA spec */
>> +    int t1;
>> +    int t2;
>> +    int t2i;
>> +    int t4;
>> +    int t6;
>> +    int t6z;
>> +    /*
>> +     * PIO modes 0-4 all allow the device to deassert IORDY to slow down
>> +     * the host.
> 
>    That's not so simple.  Drive may support PIO mode up to 2 but not 
> support IORDY -- typical for low-end CF.  There's ata_pio_need_iordy() 
> for checking if the current PIO mode needs IORDY.
> 

OK.

>> +     */
>> +    use_iordy = 1;
> 
>    Empty line needed after the declaration block.
> 
>> +    /* Use the PIO mode to determine out timing parameters */
>> +    switch (dev->pio_mode) {
>> +    case XFER_PIO_0:
>> +        t1 = 70;
>> +        t2 = 165;
> 
>    These 2 parameters (along with t2i) are returned by 
> ata_timing_find_mode().
> 

OK.

[...]
>> +    t4 = (t4 * clocks_us) / 1000 / 2;
>> +    if (t4)
>> +        t4--;
>> +    t6 = (t6 * clocks_us) / 1000 / 2;
>> +    if (t6)
>> +        t6--;
>> +    t6z = (t6z * clocks_us) / 1000 / 2;
>> +    if (t6z)
>> +        t6z--;
> 
>    I think the above repetitive calculation needs to be factored out 
> into a function.
> 

Yep.

>> +static void octeon_cf_set_dmamode(struct ata_port *ap, struct 
>> ata_device *dev)
>> +{
> [...]
>> +    switch (dev->dma_mode) {
>> +    case XFER_MW_DMA_0:
>> +        dma_ackh = 20;    /* Tj */
>> +        To = 480;
>> +        Td = 215;
>> +        Tkr = 50;
> 
>    It's safer to use Tkw instead as it's 215 ns minimum in this mode (in 
> other modes Tkr and Tkw minimums are the same).
>    Again, To, Td, and Tkw are returned by ata_timing_find_mode().
> 
>> +    /* Td (Seem to need more margin here.... */
>> +    oe_a = Td + 20;
> 
>    Well, you shouldn't...
> 

Hmm...

>> +/**
>> + * Handle an I/O request.
>> + *
>> + * @cf:         Device to access
>> + * @lba_sector: Starting sector
>> + * @num_sectors:
>> + *                   Number of sectors to transfer
>> + * @buffer:     Data buffer
>> + * @write:      Is the a write. Default to a read
>> + */
>> +static unsigned int octeon_cf_data_xfer(struct ata_device *dev,
>> +                    unsigned char *buffer,
>> +                    unsigned int buflen,
>> +                    int rw)
>> +{
>> +    struct ata_port *ap        = dev->link->ap;
>> +    struct octeon_cf_data *ocd    = ap->dev->platform_data;
>> +    void __iomem *data_addr        = ap->ioaddr.data_addr;
>> +    unsigned int words;
>> +    unsigned int count;
>> +
>> +    /*
>> +     * Odd lengths are not supported. We should always be a
>> +     * multiple of 512.
>> +     */
>> +    BUG_ON(buflen & 1);
>> +    if (ocd->is16bit) {
>> +        words = buflen / 2;
>> +        if (rw) {
>> +            count = 16;
>> +            while (words--) {
>> +                iowrite16(*(uint16_t *)buffer, data_addr);
> 
>    Not seeing the reason to use iowrite16() and not writew() as 
> registers are always memory mapped...

I will consider that.

> 
>> +                buffer += sizeof(uint16_t);
>> +                /*
>> +                 * Every 16 writes do a read so the
>> +                 * bootbus FIFO doesn't fill up.
>> +                 */
>> +                if (--count == 0) {
>> +                    ioread8(ap->ioaddr.altstatus_addr);
>> +                    count = 16;
>> +                }
> 
>    This is a strange/slow way of doing anything every 16 data writes.

Oh, how would you do something every 16 writes?

> Why not use iowrite16_rep()?

Two reasons.  It is broken, and we need to do something every 16 writes.

We need to be careful not to be anti-social by filling the FIFO.  Once 
the FIFO is filled other cores will be starved of I/O resources.

[...]
>> +static void octeon_cf_tf_read16(struct ata_port *ap, struct 
>> ata_taskfile *tf)
>> +{
>> +    u16 blob;
>> +    /* The base of the registers is at ioaddr.data_addr. */
>> +    void __iomem *base = ap->ioaddr.data_addr;
>> +
>> +    blob = __raw_readw(base + 0xc);
>> +    tf->feature = blob >> 8;
> 
>    How come the error register gets mapped at offset 0xC?
>    (Well, that would explain alike part in another CF driver.)
> 

In 16 bit mode it overlaps the data register, so it must be accessed via 
the 0xc address.

[...]
>> +/**
>> + * Check if any queued commands have more DMAs, if so start the next
>> + * transfer, else do standard handling.
>> + */
>> +irqreturn_t octeon_cf_interrupt(int irq, void *dev_instance)
> 
>    Is that a normal IDE interrupt, or some Octeon specific interrupt?
> 

No, It is OCTEON specific.  It fires when a DMA operation is complete. 
As I mentioned earlier, the normal IDE interrupt is not connected to 
anything on most boards.

>> +{
>> +    struct ata_host *host = dev_instance;
>> +    struct octeon_cf_port *cf_port;
>> +    int i;
>> +    unsigned int handled = 0;
>> +    unsigned long flags;
>> +
>> +    spin_lock_irqsave(&host->lock, flags);
>> +
>> +    DPRINTK("ENTER\n");
>> +    for (i = 0; i < host->n_ports; i++) {
> 
>    Oh, you can have several ports?

In theory it could happen...

> 
>> +        struct ata_port *ap;
>> +        struct ata_queued_cmd *qc;
>> +
>> +        ap = host->ports[i];
>> +        if (!ap || (ap->flags & ATA_FLAG_DISABLED))
>> +            continue;
>> +
>> +        qc = ata_qc_from_tag(ap, ap->link.active_tag);
>> +        if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)) &&
>> +            (qc->flags & ATA_QCFLAG_ACTIVE)) {
>> +            u8 status = octeon_cf_bmdma_status(ap);
>> +            if ((status & ATA_DMA_INTR)
>> +                && !(status & ATA_DMA_ACTIVE)
>> +                && !sg_is_last(qc->cursg)) {
>> +                qc->cursg = sg_next(qc->cursg);
>> +                handled = 1;
>> +                octeon_cf_bmdma_start(qc);
>> +            } else {
>> +                status = ioread8(ap->ioaddr.altstatus_addr);
>> +                if (status & ATA_BUSY) {
> 
>    If it's normal IDE interrupt,

Which it is not.  So...

> BSY bit will always be 0 

...this doesn't hold, thus all this code.

> (unless the 
> interrupt is shared with some other device)...
> 
>> +                    /*
>> +                     * We are busy, try to handle
>> +                     * it later.  This is the DMA
>> +                     * finished interrupt, and it
>> +                     * could take a little while
>> +                     * for the card to be ready
>> +                     * for more commands.
>> +                     */
>> +                    cf_port = (struct octeon_cf_port *)ap->private_data;
>> +                    tasklet_schedule(&cf_port->delayed_irq_tasklet);
> 
>    ... in which case the tasklet would seem pointless.

See above.

> 
>> +static int __devinit octeon_cf_probe(struct platform_device *pdev)
>> +{
>> +    struct resource *res_cs0, *res_cs1;
>> +
>> +    void __iomem *cs0;
>> +    void __iomem *cs1;
> [...]
>> +
>> +    res_cs0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +    res_cs1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> 
> [...]
> 
>> +    base = cs0 + ocd->base_region_bias;
>> +    if (!ocd->is16bit) {
> [...]
>> +        ap->ioaddr.altstatus_addr = base + 0xe;
>> +        ap->ioaddr.ctl_addr    = base + 0xe;
> 
>    Wait, why have 2 MMIO resources then?

The boards that are 'TrueIDE' use two resources, others only one.

> 
>> +    } else if (is_true_ide) {
> [...]
>> +        if (use_cf_dma) {
>> +            ap->mwdma_mask    = 0x1f;    /* Support Multiword DMA 0-4 */
>> +            irq = platform_get_irq(pdev, 0);
>> +            irq_handler = octeon_cf_interrupt;
> 
>    So, what kind of interrupt this is?
> 

DMA completion, see above.

[...]

Thanks,
David Daney

