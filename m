From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Tue, 20 Jan 2009 14:07:17 +0300
Message-ID: <4975B065.6030705@ru.mvista.com>
References: <200901141345.42583.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:20055 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756779AbZATLHY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jan 2009 06:07:24 -0500
In-Reply-To: <200901141345.42583.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org

Hello.

Stanislaw Gruszka wrote:

> I'm writting IDE host driver for AT91 Static Memory Controller with Compact Flash
> True IDE logic. My company - Kelvatek wants to add driver into the mainline,
> we think it can be usesfull for others and including driver will be also beneficial
> for us obviously.  

   If everybody looked at it that way...

> Some issues with driver:
>
> * Why not platform driver  

   But it is a platform driver. :-)

> Generic pata/ide_platform driver will not work with AT91 as we need to 
>   

  Ah, why not generic...

> do special things before access Task File and Data Register (functions 
> set_8bit_mode() and set_16bit_mode()).

   That part really doesn't look well -- Atmel should have put more 
though into it and make the register stride 2 bytes, so that 16-bit 
access could alwys be used...

> * Tests
> We tested with our custom board which is slightly diffrent than
> Atmel Evaluation Kit. Pins settings in the patch are from Kelvatek's board,
> to run driver on sam9263ek board settings shall be changed.

  I then don't understand how are you submitting this as a part of 
SAM9623EK board code...

> We did not tests on Atmel sam9263ek board, because we have no proper connector
> for 1,8'' HDD.

   Not sure I've understood that. You have 1,8'' drive and the board has 
stndard IDE connector?

> * GPIO interrupt
> This is the most problem with the driver/hardware. Interrupt from device is
> delivered through GPIO. In AT91 GPIO interrupts are triggered on falling
> and raising edge of signal (this behaviour is not configured IIRC). Whereas
>   

   Ugh... what were they thinking?

> IDE device request interrupt on high level (raising edge in our case). This
>   

   The IDE interrupts historically trigger on rising edge.

> mean we have fake interrupts requests on cpu, which broke IDE layer. 
> Problem can be solved in hardware: when device INTRQ line is connected
> to CPU through AIC controlled IRQ0 or IRQ1 lines with proper level configured.
> We probably do such things in our board, but it's is rather impossible
> for Atmel Evaluation Kit. Also there is workaround in software: check interrupt
> pin value and exit instantly from ISR when line is on low level. Such thing
> is done in the patch (AT91_GPIO_IRQ_HACK in drivers/ide/ide-io.c), but
> this is dirty hack and should implemented differently (I hope someone
> could give my good idea how).
>   

   We need to teach IDE core that IRQ handler can be different from the 
default one.

> * Performance
> Driver works only in PIO mode, we have no hardware for DMA mode. 
> Probably  hardware support could be done using another Chip Select
> with Static Memory Controller and extra external logic. Maybe Atmel
> people could tell someting more about this issue?

   I wouldn't hope on that... :-)

> On PIO4 mode I achieve 4,5MB/s

   Seems a good result actually. How it was measured?

> Regards
> Stanislaw Gruszka
>
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
>
> ---
>  arch/arm/mach-at91/at91sam9263_devices.c |   96 +++++++
>  arch/arm/mach-at91/board-sam9263ek.c     |   11 +
>  arch/arm/mach-at91/include/mach/board.h  |    9 +
>   

   This should probably go thru the ARM tree... though the maintainer 
will decide.

> diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
> index 8b88408..976e228 100644
> --- a/arch/arm/mach-at91/at91sam9263_devices.c
> +++ b/arch/arm/mach-at91/at91sam9263_devices.c
> @@ -347,6 +347,102 @@ void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data)
>  void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data) {}
>  #endif
>  
> +/* --------------------------------------------------------------------
> + *  IDE
> + * -------------------------------------------------------------------- */
> +
> +#if defined(CONFIG_BLK_DEV_IDE_AT91) || defined(CONFIG_BLK_DEV_IDE_AT91_MODULE)
>   

   Welcome to the ARM #ifdef hell. :-)

> +/* Proper CS address space will be added */
> +#define AT91_IDE_TASK_FILE	0x00c00000
> +#define AT91_IDE_CTRL_REG	0x00e00000
>   

   Er, are you sure? Address lines should be 110 to address the device 
control and alternate status registers, do they get asserted properly?

> +static struct resource ide_resources[] = {
> +	[0] = {
> +		.start	= AT91_IDE_TASK_FILE,
> +		.end	= AT91_IDE_TASK_FILE + 8 - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= AT91_IDE_CTRL_REG,
> +		.end	= AT91_IDE_CTRL_REG, /* 1 byte */
> +		.flags	= IORESOURCE_MEM,
> +	},
>   

   Er, why no IRQ resource?

> diff --git a/drivers/ide/at91_ide.c b/drivers/ide/at91_ide.c
> new file mode 100644
> index 0000000..f82ecb9
> --- /dev/null
> +++ b/drivers/ide/at91_ide.c
> @@ -0,0 +1,459 @@
> +/*
> + * IDE host driver for AT91 Static Memory Controler
>   

  I'm afraid you're being too generic here: e.g. AT91RM9200 has 
incompatible SMC.

> +#define DEBUG 1
> +#define DRV_NAME "at91_ide"
> +
> +#define perr(fmt, args...) printk(KERN_ERR DRV_NAME ": " fmt, ##args)
> +
> +#ifdef DEBUG
> +#define pdbg(fmt, args...) printk(KERN_DEBUG "%s " fmt, __func__, ##args)
> +#else
> +#define pdbg(fmt, args...)
> +#endif
>   

   Consider using dev_err() and dev_dbg() instead...

> +/* 
> + * AT91 Static Memory Controller maps Task File and Data Register
> + * at the same address. To distinguish access between these two
> + * different bus data width is used: 8Bit for Task File, 16Bit for Data I/O
> + */
> +
> +static void init_smc_mode(const u8 chipselect)
> +{
> +	at91_sys_write(AT91_SMC_MODE(chipselect), AT91_SMC_READMODE |
> +						  AT91_SMC_WRITEMODE |
> +						  AT91_SMC_BAT_SELECT |
> +						  AT91_SMC_TDF_(2)); 

   I'm not sure why you're fixing the data float timing to 2 cycles -- 
it correponds to the t6z timing which is 30 ns for ATA modes and 20 ns 
for CF specific ones...
   Why are you not using optimized data float mode?

> +static unsigned int calc_mck_cycles(unsigned int ns, unsigned int mck_hz)
> +{
> +	u64 tmp = ns;  

   No empty line after declaration.

> +	tmp *= mck_hz;
> +	tmp += 1000*1000*1000 + 1; /* round up */

    You probably mean -1 if you intend to just round up (so tmp += 
999999999).

> +static void set_ebi_timings(const u8 chipselect, const u8 pio)
> +{
> +	/* Compact Flash True IDE mode timings, all values in nano seconds,
> +	 * see table 22 of standard 4.1 */
> +	const struct { unsigned int t0, t1, t2, t2i, t9; } timings[7] = {
> +		{ .t0 = 600, .t1 = 70, .t2 = 290, .t2i =  0, .t9 = 20 }, /* PIO 0 */
> +		{ .t0 = 383, .t1 = 50, .t2 = 290, .t2i =  0, .t9 = 15 }, /* PIO 1 */
> +		{ .t0 = 240, .t1 = 30, .t2 = 290, .t2i =  0, .t9 = 10 }, /* PIO 2 */
> +		{ .t0 = 180, .t1 = 30, .t2 =  80, .t2i = 70, .t9 = 10 }, /* PIO 3 */
> +		{ .t0 = 120, .t1 = 25, .t2 =  70, .t2i = 25, .t9 = 10 }, /* PIO 4 */
> +		{ .t0 = 100, .t1 = 15, .t2 =  65, .t2i = 25, .t9 = 10 }, /* PIO 5 */
> +		{ .t0 =  80, .t1 = 10, .t2 =  55, .t2i = 20, .t9 = 10 }, /* PIO 6 */
> +	};

   Well, you've already received comments on this one...
   I've already started the patch adding support of the CFA modes.

> +	unsigned int t0, t1, t2, t2i, t9;
> +	unsigned int mck_hz;
> +	struct clk *mck;
> +	unsigned long mode;
> +
> +	BUG_ON(pio > 6);
> +
> +	t0 = timings[pio].t0;
> +	t1 = timings[pio].t1;
> +	t2 = timings[pio].t2;
> +	t2i = timings[pio].t2i;
> +	t9 = timings[pio].t9;
> +
> +	if (t2i > 0) {
> +		/* t1 is the part of t2i, let's t9 be the rest of t2i */
> +		WARN_ON(t2i < t1); 

   Doesn't happen.

> +		if (t9 < t2i - t1)
> +			t9 = t2i - t1;
>   

   It  more sense to calculate such things *after* quantizing the 
timings with calc_mck_cycles()...

> +	mck = clk_get(NULL, "mck");
> +	BUG_ON(IS_ERR(mck));
> +	mck_hz = clk_get_rate(mck);
>   

   Why not call clk_get[_rate]() only once, at startup? It can change 
dynamically?

> +	t0 = calc_mck_cycles(t0, mck_hz);
> +	t1 = calc_mck_cycles(t1, mck_hz);
> +	t2 = calc_mck_cycles(t2, mck_hz);
> +	t2i = calc_mck_cycles(t2i, mck_hz);
>   

   If you're not using t2i, why quantize it?

> +	t9 = calc_mck_cycles(t9, mck_hz);
> +	pdbg("t0=%u t1=%u t2=%u t2i=%u t9=%u\n", t0, t1, t2, t2i, t9);
>   

   Besides, we have ide_timing_compute() doing the same thing.

> +	/* values are rounded up so we need to assure cycle is larger than pulse */
> +	if (t0 < t1 + t2 + t9)
> +		t0 = t1 + t2 + t9;
> +
> +	/* setup calculated timings */
> +	at91_sys_write(AT91_SMC_SETUP(chipselect), AT91_SMC_NWESETUP_(t1) |
> +						   AT91_SMC_NCS_WRSETUP_(0) |
> +						   AT91_SMC_NRDSETUP_(t1) |
> +						   AT91_SMC_NCS_RDSETUP_(0));
> +	at91_sys_write(AT91_SMC_PULSE(chipselect), AT91_SMC_NWEPULSE_(t2) |
> +						   AT91_SMC_NCS_WRPULSE_(t1 + t2 + t9) |
>   

  With zero address to CS setup time it's the same as t0.

> +						   AT91_SMC_NRDPULSE_(t2) |
> +						   AT91_SMC_NCS_RDPULSE_(t1 + t2 + t9));
>   

   Same here.

> +	/* disable or enable waiting for IORDY signal */
> +	mode = at91_sys_read(AT91_SMC_MODE(chipselect));
> +	mode &= ~AT91_SMC_EXNWMODE;
> +	if (pio <= 4)
>   

   The IORDY loigic is not as simple -- you'd better use 
ata_id_has_iordy() for PIO modes < 5.

> +		mode |= AT91_SMC_EXNWMODE_FROZEN;
>   

   No, it should be READY mode.

> +	else 
> +		mode |= AT91_SMC_EXNWMODE_DISABLE;
>   

   This constant is 0, so else branch can be skipped.

> +static void at91_ide_set_pio_mode(ide_drive_t *drive, const u8 pio)
> +{
> +	u8 chipselect = drive->hwif->extra_base;
> +
> +	pdbg("pio %u\n", pio);
> +
> +	if (pio > 6) {
>   

   Can't happen.

> +static const struct ide_port_info at91_ide_port_info __initdata = {
> +	.port_ops = &at91_ide_port_ops,
> +	.tp_ops = &at91_ide_tp_ops,
> +	.host_flags = IDE_HFLAG_MMIO | IDE_HFLAG_NO_DMA | IDE_HFLAG_SINGLE,
> +	.pio_mask = ATA_PIO6,
>   

   No support for mode 6 yet, working on it.

> +static int __init at91_ide_probe(struct platform_device *pdev)
> +{
> +	int ret = -ENOMEM;
> +	hw_regs_t hw;
> +	hw_regs_t *hws[] = { &hw, NULL, NULL, NULL };
> +	struct resource *tf_res, *ctl_res;
> +	unsigned long tf_base = 0, ctl_base = 0;
> +	struct at91_ide_data *board = pdev->dev.platform_data;
> +	struct ide_host *host;
> +
> +	tf_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	ctl_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!ctl_res || !tf_res) {
> +		perr("can't get memory resources\n");
> +		goto err;
>   

   -ENODEV fits here better than -ENOMEM.
   You also need to call request_mem_region()

> +#if 0
>   

   This is ghenerall frowned on...

> +	/* In 12-0275-01 version of the PCB address
> +	 * lines CF_A0 and CF_A2 are swapped */
>   

   You should try to communicate such info to the driver via the 
platfrom data...

> +#else
> +	/* Proper lines addresses */
> +	hw.io_ports.data_addr = tf_base + 0;
> +	hw.io_ports.error_addr = tf_base + 1;
> +	hw.io_ports.nsect_addr = tf_base + 2;
> +	hw.io_ports.lbal_addr = tf_base + 3;
> +	hw.io_ports.lbam_addr = tf_base + 4;
> +	hw.io_ports.lbah_addr =	tf_base + 5;
> +	hw.io_ports.device_addr = tf_base + 6;
> +	hw.io_ports.command_addr = tf_base + 7;

   I suggest using hw.io_ports_array instead.

> +	hw.irq = board->irq_pin;
>   

   Why not pass it normally, via the platform device's resource?

> diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
> index cc35d6d..6dba1fc 100644
> --- a/drivers/ide/ide-io.c
> +++ b/drivers/ide/ide-io.c
> @@ -1354,7 +1354,12 @@ static void unexpected_intr (int irq, ide_hwgroup_t *hwgroup)
>   *	request completed. At this point we issue the next request
>   *	on the hwgroup and the process begins again.
>   */
> - 
> +#define AT91_GPIO_IRQ_HACK
> +
> +#ifdef AT91_GPIO_IRQ_HACK
> +#include <mach/gpio.h>
> +#endif 
> +
>  irqreturn_t ide_intr (int irq, void *dev_id)
>  {
>  	unsigned long flags;
> @@ -1364,6 +1369,21 @@ irqreturn_t ide_intr (int irq, void *dev_id)
>  	ide_handler_t *handler;
>  	ide_startstop_t startstop;
>  
> +#ifdef AT91_GPIO_IRQ_HACK
> +#define NR_TRIES 10
> +	int ntries = 0;
> +	int pin_val1, pin_val2;	
> +	do {
> +		pin_val1 = at91_get_gpio_value(AT91_PIN_PB20);
> +		pin_val2 = at91_get_gpio_value(AT91_PIN_PB20);
> +	} while (pin_val1 != pin_val2 && ntries++ < NR_TRIES);
>   

   You need manual pin debouncing even after calling 
at91_set_deglitch()? :-O

> +	udelay(20); // XXX: this need to be here otherwise IDE layer losts interrups, don't know why !!!
>   

   Ugh...

MBR, Sergei


