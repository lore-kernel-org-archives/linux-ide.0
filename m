From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: Add tx4938ide driver
Date: Sun, 19 Oct 2008 20:32:13 +0400
Message-ID: <48FB610D.3020901@ru.mvista.com>
References: <20081017.231130.82350696.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:9394 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751359AbYJSQcb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Oct 2008 12:32:31 -0400
In-Reply-To: <20081017.231130.82350696.anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ralf@linux-mips.org

Hello.

Atsushi Nemoto wrote:

> This is the driver for the Toshiba TX4938 SoC EBUS controller ATA mode.
> It has custom set_pio_mode and some hacks for big endian.

> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

[...]

> diff --git a/drivers/ide/mips/tx4938ide.c b/drivers/ide/mips/tx4938ide.c
> new file mode 100644
> index 0000000..2e5778d
> --- /dev/null
> +++ b/drivers/ide/mips/tx4938ide.c
> @@ -0,0 +1,319 @@
[...]
> +static void tx4938ide_tune_ebusc(unsigned int ebus_ch,
> +				 unsigned int gbus_clock,
> +				 u8 pio)
> +{
> +	struct ide_timing *t = ide_timing_find_mode(XFER_PIO_0 + pio);
> +	u64 cr = __raw_readq(&tx4938_ebuscptr->cr[ebus_ch]);
> +	unsigned int sp = ((unsigned int)cr >> 4) & 3;
> +	unsigned int clock = gbus_clock / (4 - sp);
> +	unsigned int cycle = 1000000000 / clock;
> +	unsigned int wt, shwt;
> +
> +	/* IORDY setup time: 35ns */
> +	wt = (35 + cycle - 1) / cycle;

    It's not that simple I'm afraid: you can't just wait IORDY for 35 ns as 
that won't guarantee the minimum DIOx- actime time for the current PIO mode; 
so t->act8 (since it's >= t->act) should be part of the equation here, 
possibly with subtraction of couple cycles, if I'm interpreting the timing 
diagrams in the datasheet correctly...
    And please use DIV_ROUND_UP() -- like the other drivers do.

> +	/* actual wait-cycle is max(wt & ~1, 1) */

    I got an impression that WT[0] bit is used otherwise in the ready mode, 
and PWT[1:0]:WT[3:1] = 00000 would mean 0 cycles, not 1...

> +	if (wt > 2 && (wt & 1))
> +		wt++;
> +	wt &= ~1;
> +	/* Address valid to DIOR/DIOW setup */
> +	shwt = (t->setup + cycle - 1) / cycle;

    Use DIV_ROUND_UP() here too.

> +
> +	pr_debug("tx4938ide: ebus %d, bus cycle %dns, WT %d, SHWT %d\n",
> +		 ebus_ch, cycle, wt, shwt);
> +
> +	__raw_writeq((cr & ~(0x3f007ull)) | (wt << 12) | shwt,
> +		     &tx4938_ebuscptr->cr[ebus_ch]);
> +}

[...]

> +static const struct ide_port_info tx4938ide_port_info __initdata = {
> +	.port_ops = &tx4938ide_port_ops,
> +#ifdef __BIG_ENDIAN
> +	.tp_ops = &tx4938ide_tp_ops,
> +#endif
> +	.host_flags = IDE_HFLAG_MMIO | IDE_HFLAG_NO_DMA, /* no SFF-style DMA */

    DMA is not required to be SFF-style. It's just that TX4938 doesn't support 
any kind of IDE DMA, IIUC...

> +	.pio_mask = ATA_PIO5,
> +};
> +
> +static int __init tx4938ide_probe(struct platform_device *pdev)
> +{
> +	hw_regs_t hw;
> +	hw_regs_t *hws[] = { &hw, NULL, NULL, NULL };
> +	struct ide_host *host;
> +	unsigned long port[2], port_size[2];
> +	void __iomem *mmport[2];
> +	struct tx4938ide_platform_info *pdata = pdev->dev.platform_data;
> +	unsigned int ebus_ch;
> +	int irq;
> +	int ret;
> +	int i;

    Why not declare all 3 on the same line?

> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return -ENODEV;
> +
> +	ebus_ch = pdata->ebus_ch;
> +	port[0] = ((__raw_readq(&tx4938_ebuscptr->cr[ebus_ch]) >> 48) << 20)
> +		+ 0x10000;
> +	port[1] = port[0] + 0x10000;

    Why not pass these as platform device resources?

> +	port_size[0] = 8;
> +	port_size[1] = 1;
> +	port[1] += (6 << pdata->ioport_shift);
> +	for (i = 0; i < 2; i++)
> +		port_size[i] <<= pdata->ioport_shift;

    Why not do it right in the assignments above?

> +	for (i = 0; i < 2; i++) {
> +		if (!devm_request_mem_region(&pdev->dev,
> +					     port[i], port_size[i],
> +					     "tx4938ide"))
> +			return -EBUSY;

    From the datasheet I got an impression that whole 128 KB at offset 0x10000 
trigger IDE -CS0/1 signals, so why not request all 128 KB?

> +		mmport[i] = devm_ioremap(&pdev->dev, port[i], port_size[i]);
> +		if (!mmport[i])
> +			return -EBUSY;
> +	}
> +
> +	memset(&hw, 0, sizeof(hw));
> +	if (pdata->ioport_shift) {
> +		hw.io_ports_array[0] = (unsigned long)mmport[0];
> +#ifdef __BIG_ENDIAN
> +		mmport[0]++;
> +		mmport[1]++;
> +#endif
> +		for (i = 1; i <= 7; i++)
> +			hw.io_ports_array[i] = (unsigned long)mmport[0] +
> +				(i << pdata->ioport_shift);
> +		hw.io_ports.ctl_addr = (unsigned long)mmport[1];
> +	} else
> +		ide_std_init_ports(&hw, (unsigned long)mmport[0],
> +				   (unsigned long)mmport[1]);

    From the datasheet I got an impression that this case is not possible...

MBR, Sergei

