From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/3] ide: add at91_ide driver
Date: Wed, 04 Feb 2009 15:19:50 +0300
Message-ID: <498987E6.7040909@ru.mvista.com>
References: <200902031147.22827.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:15955 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750892AbZBDMT4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Feb 2009 07:19:56 -0500
In-Reply-To: <200902031147.22827.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.arm.linux.org.uk

Hello.

Stanislaw Gruszka wrote:

> This is IDE host driver for AT91SAM9 Static Memory Controller with Compact
> Flash True IDE Mode logic.
>
> Driver have to switch 8/16 bit bus width when accessing Task Tile or Data
> Register. Moreover some extra things need to be done when setting PIO mode.
> Only PIO mode is used, hardware have no DMA support. If interrupt line is
> connected through GPIO extra quirk is needed to cope with fake interrupts.
>
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
>   
[...]
> diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
> index fb51f0e..6674b9b 100644
> --- a/arch/arm/mach-at91/include/mach/board.h
> +++ b/arch/arm/mach-at91/include/mach/board.h
> @@ -59,6 +59,18 @@ struct at91_cf_data {
>  };
>  extern void __init at91_add_device_cf(struct at91_cf_data *data);
>  
> + /* Compact Flash True IDE mode */
> +struct at91_ide_data {
> +	u8	irq_pin;		/* the same meaning as for CF */
>   

  I again have to express my dislike about not passing IRQ the usual 
way. Also, see my comments to the platform code.

> +	u8	det_pin;
> +	u8	rst_pin;
> +	u8	chipselect;
> +	u8	flags;
> +#define AT91_IDE_SWAP_A0_A2 0x01
> +};
> +
> +extern void __init at91_add_device_ide(struct at91_ide_data *data);
> +
>   /* MMC / SD */
>  struct at91_mmc_data {
>  	u8		det_pin;	/* card detect IRQ */
> diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
> index 3dad229..b11da5b 100644
> --- a/drivers/ide/Kconfig
> +++ b/drivers/ide/Kconfig
> @@ -721,6 +721,11 @@ config BLK_DEV_IDE_TX4939
>  	depends on SOC_TX4939
>  	select BLK_DEV_IDEDMA_SFF
>  
> +config BLK_DEV_IDE_AT91
> +	tristate "Atmel AT91 IDE support"
>   

   Please be more specific -- you can't drive AT91RM9200 SMC.

> +	depends on ARM && ARCH_AT91
>   

   Please add "&& !ARCH_AT91RM9200". And maybe "&& !ARCH_AT91X40" too...

> diff --git a/drivers/ide/at91_ide.c b/drivers/ide/at91_ide.c
> new file mode 100644
> index 0000000..3a1f7e0
> --- /dev/null
> +++ b/drivers/ide/at91_ide.c
> @@ -0,0 +1,496 @@
> +/*
> + * IDE host driver for AT91SAM9 Static Memory Controller
>   

   Why not call the driver 'at91sam9_ide'?

> +/*
> + * AT91 Static Memory Controller

  AT91SAM9.

> maps Task File and Data Register
>   
> + * at the same address. To distinguish access between these two

   It would have been strange if it did it otherwise...

> + * different bus data width is used: 8Bit for Task File, 16Bit for Data I/O
> + *
> + * After initialization we do 8/16 bit flipping (changes in SMC MODE register)
> + * only inside IDE callback routines which are serialized by IDE layer,
> + * so no additional locking needed.
> + */
> +
> +static void init_smc_mode(const u8 chipselect)
> +{
> +	at91_sys_write(AT91_SMC_MODE(chipselect), AT91_SMC_READMODE |
> +						  AT91_SMC_WRITEMODE |
> +						  AT91_SMC_BAT_SELECT |
> +						  AT91_SMC_TDF_(0));
>   

   I'm not sure why are you fixing the dataflow timing again, this time 
to 0...

> +}
> +
> +static inline void set_8bit_mode(const u8 chipselect)
> +{
> +	unsigned long mode = at91_sys_read(AT91_SMC_MODE(chipselect));
> +	mode &= ~AT91_SMC_DBW;
> +	mode |= AT91_SMC_DBW_8;
> +	at91_sys_write(AT91_SMC_MODE(chipselect), mode);
> +	pdbg("%u %08lx\n", chipselect, mode);
> +}
> +
> +static inline void set_16bit_mode(const u8 chipselect)
> +{
> +	unsigned long mode = at91_sys_read(AT91_SMC_MODE(chipselect));
> +	mode &= ~AT91_SMC_DBW;
> +	mode |= AT91_SMC_DBW_16;
> +	at91_sys_write(AT91_SMC_MODE(chipselect), mode);
> +	pdbg("%u %08lx\n", chipselect, mode);
> +}
>   

  I'd advice to make this single function because it looks like a code 
duplication too much.

> +static void set_smc_timings(const u8 chipselect, const u16 cycle,
> +			    const u16 setup, const u16 pulse,
> +			    const u16 data_float, int use_iordy)
>   

   Have you considered using already present sam9_smc_configure() 
instead to avoid the code duplication (it needs to be exported though)?

> +{
> +	unsigned long mode;
> +
> +	/* setup timings in SMC */
> +	at91_sys_write(AT91_SMC_SETUP(chipselect), AT91_SMC_NWESETUP_(setup) |
> +						   AT91_SMC_NCS_WRSETUP_(0) |
> +						   AT91_SMC_NRDSETUP_(setup) |
> +						   AT91_SMC_NCS_RDSETUP_(0));
> +	at91_sys_write(AT91_SMC_PULSE(chipselect), AT91_SMC_NWEPULSE_(pulse) |
> +						   AT91_SMC_NCS_WRPULSE_(cycle) |
> +						   AT91_SMC_NRDPULSE_(pulse) |
> +						   AT91_SMC_NCS_RDPULSE_(cycle));
> +	at91_sys_write(AT91_SMC_CYCLE(chipselect), AT91_SMC_NWECYCLE_(cycle) |
> +						   AT91_SMC_NRDCYCLE_(cycle));
> +
> +	mode = at91_sys_read(AT91_SMC_MODE(chipselect));
>   

   Frankly speaking, I don't see why you're reading this register back 
if you already know what needs to be set there -- as you've done it in 
init_smc_mode().

> +static unsigned int calc_mck_cycles(unsigned int ns, unsigned int mck_hz)
> +{
> +	u64 tmp = ns;
> +
> +	tmp *= mck_hz;
> +	tmp += 1000*1000*1000 - 1; /* round up */
> +	do_div(tmp, 1000*1000*1000);
> +	return (unsigned int) tmp;
> +}
> +
> +static void apply_timings(const u8 chipselect, const u8 pio,
> +			  const struct ide_timing *timing, const u16 *ata_id)
> +{
> +	unsigned int t0, t1, t2, t6z, th;
> +	unsigned int cycle, setup, pulse, data_float;
> +	unsigned int mck_hz;
> +	struct clk *mck;
> +	int use_iordy;
>   
[...]
> +
> +	use_iordy = 0;
>   

   Can be done in initializer...

> +	if (ata_id) {
> +		if (ata_id_is_cfa(ata_id)) {
> +			if (pio == 3 || pio == 4)
> +				use_iordy = 1;
>   
> +		} else if (pio >= 3 || ata_id_has_iordy(ata_id))
> +			use_iordy = 1;
>   


   No, you should check for IORDY regardless of CFA and using IORDY 
shouldn't be limeited to modes 3 and 4:

        if (ata_id_has_iordy(ata_id) && !(ata_id_is_cfa(ata_id) && pio > 4))
           use_iodry = 1;

> +static u8 ide_mm_inb(unsigned long port)
> +{
> +	return (u8) readb((void __iomem *) port);
>   

  Explict cast not needed here.

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
>   

   Sigh. Bart, couldn't we drop that stupid flag? I bet nobody ever used it.

> +void at91_ide_tf_read(ide_drive_t *drive, ide_task_t *task)
> +{
> +	ide_hwif_t *hwif = drive->hwif;
> +	struct ide_io_ports *io_ports = &hwif->io_ports;
> +	struct ide_taskfile *tf = &task->tf;
> +
> +	if (task->tf_flags & IDE_TFLAG_IN_DATA) {
>   

   ... and this one too?

> +/*
> + * If interrupt is delivered through GPIO, IRQ are triggered on falling
> + * and raising edge of signal. Whereas IDE device request interrupt on high
> + * level (raising edge in our case). This mean we have fake interrupts, so
> + * we need to check interrupt pin and exit instantly from ISR when line
> + * is on low level.
> + */
> +
> +irqreturn_t at91_irq_handler(int irq, void *dev_id)
> +{
> +	int ntries = 8;
> +	int pin_val1, pin_val2;
> +
> +	/* additional deglitch, line can be noisy in badly designed PCB */
> +	do {
> +		pin_val1 = at91_get_gpio_value(irq);
> +		pin_val2 = at91_get_gpio_value(irq);
> +	} while (pin_val1 != pin_val2 && --ntries > 0);
>   

  I suggest a shorter code:

	do {
		pin_val = at91_get_gpio_value(irq);
	} while (pin_val != at91_get_gpio_value(irq) && --ntries > 0);


> +static int __init at91_ide_probe(struct platform_device *pdev)
> +{
>   
[...]
> +	host->ports[0]->extra_base = board->chipselect;
>   

   BTW, we have 2 fields in the struct hwif_s that fit this case better: 
config_data and select_data. It's a bit stange that you've selected 
extra_base...

MBR, Sergei


