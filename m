From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Tue, 9 Sep 2008 17:44:59 +0100
Message-ID: <20080909174459.2aa9808a@lxorguk.ukuu.org.uk>
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ralf@linux-mips.org, sshtylyov@ru.mvista.com
List-Id: linux-ide@vger.kernel.org

> command/status registers, but the register layout is swapped on big
> endian.  There are some other endian issue and some special registers
> which requires many custom dma_ops/port_ops routines.

It would probably be a lot cleaner using the libata framework, and also
go obsolete less soon.

> +#define TX4939IDE_readl(base, reg) \
> +	__raw_readl((void __iomem *)((base) + TX4939IDE_REG32(reg)))
> +#define TX4939IDE_readw(base, reg) \
> +	__raw_readw((void __iomem *)((base) + TX4939IDE_REG16(reg)))
> +#define TX4939IDE_readb(base, reg) \
> +	__raw_readb((void __iomem *)((base) + TX4939IDE_REG8(reg)))
> +#define TX4939IDE_writel(val, base, reg) \
> +	__raw_writel(val, (void __iomem *)((base) + TX4939IDE_REG32(reg)))
> +#define TX4939IDE_writew(val, base, reg) \
> +	__raw_writew(val, (void __iomem *)((base) + TX4939IDE_REG16(reg)))
> +#define TX4939IDE_writeb(val, base, reg) \
> +	__raw_writeb(val, (void __iomem *)((base) + TX4939IDE_REG8(reg)))

It's generally frowned upon to hide all the detail in macros, it is much
easier to read and understand the code if you don't do this.

> +#define TX4939IDE_BASE(hwif)	((hwif)->io_ports.data_addr & ~0xfff)

Why do you have void __iomem casts all over the write methods not in the
_BASE() method - that would let sparse do its job properly

> +	for (i = 0; i < MAX_DRIVES; i++) {
> +		if (drive != &hwif->drives[i] &&

You don't actually need the first test. This also appears wrong. In your
tests MW_DMA_0 is 'faster' than PIO4 but in fact MW_DMA_0 PIO timings are
*slower* than PIO4 so the mode is not in fact slower.

> +	case XFER_MW_DMA_2:
> +	case XFER_MW_DMA_1:
> +	case XFER_MW_DMA_0:
> +	case XFER_PIO_4:
> +		value |= 0x0400;
> +		break;

This looks odd according to the speed tables. Can you clarify what is
going on ?

> +#ifdef __BIG_ENDIAN
> +	{
> +		unsigned int *table = hwif->dmatable_cpu;
> +		while (1) {
> +			cpu_to_le64s((u64 *)table);
> +			if (*table & 0x80000000)
> +				break;

You modify the table but you never ensure the data is not still in
temporary variables from the compiler or flushed from cache
