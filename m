From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/3 v2] ide: add at91_ide driver
Date: Sun, 15 Feb 2009 20:29:13 +0300
Message-ID: <499850E9.80802@ru.mvista.com>
References: <200902061213.12216.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:34635 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752909AbZBOR2w (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Feb 2009 12:28:52 -0500
In-Reply-To: <200902061213.12216.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-ide@vger.kernel.org, Andrew Victor <avictor.za@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk

Stanislaw Gruszka wrote:
> This is IDE host driver for AT91 (SAM9, CAP9, AT572D940HF) Static Memory
> Controller with Compact Flash True IDE Mode logic.

> Driver have to switch 8/16 bit bus width when accessing Task Tile or Data
> Register. Moreover some extra things need to be done when setting PIO mode.
> Only PIO mode is used, hardware have no DMA support. If interrupt line is
> connected through GPIO extra quirk is needed to cope with fake interrupts.

> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>


> diff --git a/drivers/ide/at91_ide.c b/drivers/ide/at91_ide.c
> new file mode 100644
> index 0000000..ec28d36
> --- /dev/null
> +++ b/drivers/ide/at91_ide.c
> @@ -0,0 +1,489 @@

> +#define perr(fmt, args...) printk(KERN_ERR DRV_NAME ": " fmt, ##args)

    BTW, you can use pr_err() ISO printk() here...

> +
> +#ifdef DEBUG
> +#define pdbg(fmt, args...) printk(KERN_DEBUG "%s " fmt, __func__, ##args)

    ... and pr_debug() here.

> +#define REGS_SIZE	16

    Why? There are only 8 registers in each block.

> +#define enter_16bit(cs, mode) do {					\
> +	mode = at91_sys_read(AT91_SMC_MODE(cs));			\
> +	at91_sys_write(AT91_SMC_MODE(cs), mode | AT91_SMC_DBW_16);	\
> +} while (0)
> +
> +#define leave_16bit(cs, mode) at91_sys_write(AT91_SMC_MODE(cs), mode);

   Inline functions are preferrable.

> +static void apply_timings(const u8 chipselect, const u8 pio,
> +			  const struct ide_timing *timing, const u16 *ata_id)
> +{
> +	unsigned int t0, t1, t2, t6z, th;
> +	unsigned int cycle, setup, pulse, data_float;
> +	unsigned int mck_hz;
> +	struct clk *mck;
> +	int use_iordy;
> +
> +	/* see table 22 of Compact Flash standard 4.1 for the meaning,
> +	 * we do not stretch active (t2) time, so setup (t1) + hold time (th)
> +	 * assure at least minimal recovery (t2i) time */
> +	t0 = timing->cyc8b;
> +	t1 = timing->setup;
> +	t2 = timing->act8b;
> +
> +	/* ensure minimal "~IORD data hold time" (t6z) */
> +	t6z = (pio < 5) ? 30 : 20;
> +	th = t0 - t1 - t2;

    As I've already said, any math done on "non-quantized" timings will yield 
imprecise results. In this case, 'th' calculated will be higher than the 
actual one.

> +	if (t6z > th)
> +		t6z -= th;
> +	else
> +		t6z = 0; /* already covered in hold time */

    This seems neither correct nor necessary.  IIUC, TDF_CYCLES delay gets 
applied *concurrently* with the {NRD|NWE}_HOLD delay, so whichever is longer 
should automatically take precedence.

> +	use_iordy = 0;
> +	if (ata_id) {
> +		if ((pio > 2 || ata_id_has_iordy(ata_id)) &&
> +		    !(ata_id_is_cfa(ata_id) && pio > 4))
> +			use_iordy = 1;
> +	}

    It seems more consistent to just pass use_iordy into this function ISO ata_id.

> +
> +	set_smc_timings(chipselect, cycle, setup, pulse, data_float, use_iordy);
> +}
> +
> +static u8 ide_mm_inb(unsigned long port)
> +{
> +	return readb((void __iomem *) port);
> +}
> +
> +static void ide_mm_outb(u8 value, unsigned long port)
> +{
> +	writeb(value, (void __iomem *) port);
> +}
> +
> +void at91_ide_tf_load(ide_drive_t *drive, ide_task_t *task)
> +{
> +	ide_hwif_t *hwif = drive->hwif;
> +	struct ide_io_ports *io_ports = &hwif->io_ports;
> +	struct ide_taskfile *tf = &task->tf;
> +	u8 HIHI = (task->tf_flags & IDE_TFLAG_LBA48) ? 0xE0 : 0xEF;
> +
> +	if (task->tf_flags & IDE_TFLAG_FLAGGED)
> +		HIHI = 0xFF;
> +
> +	if (task->tf_flags & IDE_TFLAG_OUT_DATA) {
> +		u16 data = (tf->hob_data << 8) | tf->data;
> +		u8 chipselect = hwif->select_data;
> +		unsigned long mode;
> +
> +		enter_16bit(chipselect, mode);
> +		writew(data, (void __iomem *) io_ports->data_addr);
> +		leave_16bit(chipselect, mode);
> +	}

    I'd advise to implement this (never reached) fragment via a call to 
at91_ide_output_data() instead. That will result in a shorter code and will 
somewhat ease the pending task of rewriting tf_load/tf_read() methods for 
me... when I do this, there will be no need to reimplement these methods just 
because this fragment is different from the standard implementation. :-)

> +void at91_ide_tf_read(ide_drive_t *drive, ide_task_t *task)
> +{
> +	ide_hwif_t *hwif = drive->hwif;
> +	struct ide_io_ports *io_ports = &hwif->io_ports;
> +	struct ide_taskfile *tf = &task->tf;
> +
> +	if (task->tf_flags & IDE_TFLAG_IN_DATA) {
> +		u8 chipselect = hwif->select_data;
> +		u16 data;
> +		unsigned long mode;
> +
> +		enter_16bit(chipselect, mode);
> +		data = readw((void __iomem *) io_ports->data_addr);
> +		leave_16bit(chipselect, mode);
> +
> +		tf->data = data & 0xff;
> +		tf->hob_data = (data >> 8) & 0xff;
 > +	}

    I'd advise to implement this (never reached) fragment via a call to 
at91_ide_input_data().

> +static const struct ide_port_info at91_ide_port_info __initdata = {
> +	.port_ops	= &at91_ide_port_ops,
> +	.tp_ops		= &at91_ide_tp_ops,
> +	.host_flags 	= IDE_HFLAG_MMIO | IDE_HFLAG_NO_DMA | IDE_HFLAG_SINGLE |
> +			  IDE_HFLAG_NO_IO_32BIT | IDE_HFLAG_UNMASK_IRQS,
> +	.pio_mask 	= ATA_PIO5,

    You *can* use ATA_PIO6 here.  It just won't be actually selected by the 
IDE core -- until CF specific mode support patch gets merged (I'm expecting 
this to happen in the 2.6.30-rc1 merge window).

> +};
> +
> +/*
> + * If interrupt is delivered through GPIO, IRQ are triggered on falling
> + * and raising edge of signal. Whereas IDE device request interrupt on high
> + * level (raising edge in our case). This mean we have fake interrupts, so

    I think you meant "rising"...

> +static int __init at91_ide_probe(struct platform_device *pdev)
> +{
[...]
> +	/* setup Static Memory Controller - PIO 0 as default */
> +	pio0_timing = ide_timing_find_mode(XFER_PIO_0);
> +	apply_timings(board->chipselect, 0, pio0_timing, NULL);

    Why not pass ide_timing_find_mode(XFER_PIO_0) directly?

> +static struct platform_driver at91_ide_driver = {
> +	.driver	= {
> +		.name = DRV_NAME,
> +		.owner = THIS_MODULE,
> +	},
> +	.probe	= at91_ide_probe,
> +	.remove	= __exit_p(at91_ide_remove),
> +};
> +
> +static int __init at91_ide_init(void)
> +{
> +	return platform_driver_register(&at91_ide_driver);
> +}

    If the probe() method is marked __init, it's typcailly called via 
platfrom_device_probe() ISO platform_driver_register() and the .probe field 
initializer gets omitted in the 'struct platform_driver' initializer.

MBR, Sergei
