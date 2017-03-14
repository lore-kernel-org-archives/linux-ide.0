From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/3] ata: add Palmchip BK3710 PATA controller driver
Date: Tue, 14 Mar 2017 17:36:05 +0100
Message-ID: <7111156.vsgJrabAQa@amdc3058>
References: <1489064496-6270-1-git-send-email-b.zolnierkie@samsung.com>
 <1489064496-6270-2-git-send-email-b.zolnierkie@samsung.com>
 <c30eeadf-c4f3-3d35-9b2f-abc9eed3e4e8@cogentembedded.com>
 <CGME20170314163607epcas1p42caadae15d32c0179f43df08d8a5224a@epcas1p4.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:35056 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbdCNQgM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 14 Mar 2017 12:36:12 -0400
In-reply-to: <c30eeadf-c4f3-3d35-9b2f-abc9eed3e4e8@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Tejun Heo <tj@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


Hi,

On Sunday, March 12, 2017 08:28:43 PM Sergei Shtylyov wrote:
> Hello!
> 
> On 03/09/2017 04:01 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> > Add Palmchip BK3710 PATA controller driver.
> >
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> [...]
> > diff --git a/drivers/ata/pata_bk3710.c b/drivers/ata/pata_bk3710.c
> > new file mode 100644
> > index 0000000..65ee737
> > --- /dev/null
> > +++ b/drivers/ata/pata_bk3710.c
> > @@ -0,0 +1,395 @@
> > +/*
> > + * Palmchip BK3710 PATA controller driver
> > + *
> > + * Copyright (c) 2017 Samsung Electronics Co., Ltd.
> > + *		http://www.samsung.com
> > + *
> > + * Based on palm_bk3710.c:
> > + *
> > + * Copyright (C) 2006 Texas Instruments.
> > + * Copyright (C) 2007 MontaVista Software, Inc., <source@mvista.com>
> > + *
> > + * This file is subject to the terms and conditions of the GNU General Public
> > + * License.  See the file "COPYING" in the main directory of this archive
> > + * for more details.
> > + */
> > +
> > +#include <linux/types.h>
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/ioport.h>
> > +#include <linux/ata.h>
> > +#include <linux/libata.h>
> > +#include <linux/delay.h>
> > +#include <linux/init.h>
> > +#include <linux/clk.h>
> > +#include <linux/platform_device.h>
> 
>     Probably a good idea to sort the #include's alphabetically...

Done.

> > +
> > +#define DRV_NAME "pata_bk3710"
> > +#define DRV_VERSION "0.1.0"
> 
>     This macro isn't used anywhere, do we really need it?

Removed.

> > +
> > +#define BK3710_REG_OFFSET	0x1F0
> 
>     I'd call it BK3710_TF_OFFSET or something of that sort...
> The DM644x manual calls these register command block (which seems to comply 
> with ATA wording)...

Renamed.

> > +#define BK3710_CTL_OFFSET	0x3F6
> > +
> > +#define BK3710_BMISP		0x02
> 
>     Nothing other than the BMIDE status register, dunno why they made it 16-bit...
> 
> > +#define BK3710_IDETIMP		0x40
> > +#define BK3710_UDMACTL		0x48
> > +#define BK3710_MISCCTL		0x50
> > +#define BK3710_REGSTB		0x54
> > +#define BK3710_REGRCVR		0x58
> > +#define BK3710_DATSTB		0x5C
> > +#define BK3710_DATRCVR		0x60
> > +#define BK3710_DMASTB		0x64
> > +#define BK3710_DMARCVR		0x68
> > +#define BK3710_UDMASTB		0x6C
> > +#define BK3710_UDMATRP		0x70
> > +#define BK3710_UDMAENV		0x74
> > +#define BK3710_IORDYTMP		0x78
> 
>     I'd keep all registers declared as in the IDE driver, for the purposes of 
> documentation...

Don't see much point in it as the real documentation is available.

> [...]
> > +static void pata_bk3710_setudmamode(void __iomem *base, unsigned int dev,
> > +				    unsigned int mode)
> > +{
> > +	u32 val32;
> > +	u16 val16;
> > +	u8 tenv, trp, t0;
> 
>     I think DaveM prefers reverse Christmas tree order with the declarations 
> but maybe that's only for the networking tree... :-)
> 
> > +
> > +	/* DMA Data Setup */
> > +	t0 = DIV_ROUND_UP(pata_bk3710_udmatimings[mode].cycletime,
> > +			  ideclk_period) - 1;
> > +	tenv = DIV_ROUND_UP(20, ideclk_period) - 1;
> > +	trp = DIV_ROUND_UP(pata_bk3710_udmatimings[mode].rptime,
> > +			   ideclk_period) - 1;
> > +
> > +	/* udmastb Ultra DMA Access Strobe Width */
> > +	val32 = ioread32(base + BK3710_UDMASTB) & (0xFF << (dev ? 0 : 8));
> 
>     I'd separate ioread32() and & to the different lines but as this is copied 
> from the IDE driver verbatim, you can ignore me. :-)

Ignored. ;-)

> > +	val32 |= (t0 << (dev ? 8 : 0));
> 
>     Outer parens not really needed.

Fixed.

> > +	iowrite32(val32, base + BK3710_UDMASTB);
> > +
> > +	/* udmatrp Ultra DMA Ready to Pause Time */
> > +	val32 = ioread32(base + BK3710_UDMATRP) & (0xFF << (dev ? 0 : 8));
> > +	val32 |= (trp << (dev ? 8 : 0));
> 
>     Here as well..

ditto

> > +	iowrite32(val32, base + BK3710_UDMATRP);
> > +
> > +	/* udmaenv Ultra DMA envelop Time */
> > +	val32 = ioread32(base + BK3710_UDMAENV) & (0xFF << (dev ? 0 : 8));
> > +	val32 |= (tenv << (dev ? 8 : 0));
> 
>     And here...

ditto

> [...]
> > +static void pata_bk3710_setdmamode(void __iomem *base, unsigned int dev,
> 
>     Maybe setmwdmamode()?

Renamed.

> > +				   unsigned short min_cycle,
> > +				   unsigned int mode)
> > +{
> > +	const struct ata_timing *t;
> > +	int cycletime;
> > +	u32 val32;
> > +	u16 val16;
> > +	u8 td, tkw, t0;
> > +
> > +	t = ata_timing_find_mode(mode);
> > +	cycletime = max_t(int, t->cycle, min_cycle);
> > +
> > +	/* DMA Data Setup */
> > +	t0 = DIV_ROUND_UP(cycletime, ideclk_period);
> > +	td = DIV_ROUND_UP(t->active, ideclk_period);
> > +	tkw = t0 - td - 1;
> > +	td -= 1;
> 
> 	td--;

Fixed.

> > +
> > +	val32 = ioread32(base + BK3710_DMASTB) & (0xFF << (dev ? 0 : 8));
> > +	val32 |= (td << (dev ? 8 : 0));
> 
>     And here...

ditto

> > +	iowrite32(val32, base + BK3710_DMASTB);
> > +
> > +	val32 = ioread32(base + BK3710_DMARCVR) & (0xFF << (dev ? 0 : 8));
> > +	val32 |= (tkw << (dev ? 8 : 0));
> 
>     And here...

ditto

> [...]
> > +static void pata_bk3710_setpiomode(void __iomem *base, struct ata_device *pair,
> > +				   unsigned int dev, unsigned int cycletime,
> > +				   unsigned int mode)
> > +{
> > +	const struct ata_timing *t;
> > +	u32 val32;
> > +	u8 t2, t2i, t0;
> > +
> > +	t = ata_timing_find_mode(XFER_PIO_0 + mode);
> > +
> > +	/* PIO Data Setup */
> > +	t0 = DIV_ROUND_UP(cycletime, ideclk_period);
> > +	t2 = DIV_ROUND_UP(t->active, ideclk_period);
> > +
> > +	t2i = t0 - t2 - 1;
> > +	t2 -= 1;
> 
> 	t2--;

ditto

> > +
> > +	val32 = ioread32(base + BK3710_DATSTB) & (0xFF << (dev ? 0 : 8));
> > +	val32 |= (t2 << (dev ? 8 : 0));
> 
>     Outer parens not needed.

ditto

> > +	iowrite32(val32, base + BK3710_DATSTB);
> > +
> > +	val32 = ioread32(base + BK3710_DATRCVR) & (0xFF << (dev ? 0 : 8));
> > +	val32 |= (t2i << (dev ? 8 : 0));
> 
>     Here too..

ditto

> > +	iowrite32(val32, base + BK3710_DATRCVR);
> > +
> > +	/* FIXME: this is broken also in the old driver */
> 
>    What's wrong with this logic BTW?

Two things:
- it happens too late, after "mode" variable has been read
- we should probably just merge timings instead of downgrading PIO mode

> > +	if (pair) {
> > +		u8 mode2 = pair->pio_mode - XFER_PIO_0;
> > +
> > +		if (mode2 < mode)
> > +			mode = mode2;
> > +	}
> > +
> > +	/* TASKFILE Setup */
> > +	t0 = DIV_ROUND_UP(t->cyc8b, ideclk_period);
> > +	t2 = DIV_ROUND_UP(t->act8b, ideclk_period);
> > +
> > +	t2i = t0 - t2 - 1;
> > +	t2 -= 1;
> 
> 	t2--;

Fixed.

> > +
> > +	val32 = ioread32(base + BK3710_REGSTB) & (0xFF << (dev ? 0 : 8));
> > +	val32 |= (t2 << (dev ? 8 : 0));
> 
>     Outer parens again...

ditto

> > +	iowrite32(val32, base + BK3710_REGSTB);
> > +
> > +	val32 = ioread32(base + BK3710_REGRCVR) & (0xFF << (dev ? 0 : 8));
> > +	val32 |= (t2i << (dev ? 8 : 0));
> 
>     And again...

ditto

> > +	iowrite32(val32, base + BK3710_REGRCVR);
> > +}
> > +
> > +static void pata_bk3710_set_piomode(struct ata_port *ap,
> > +				    struct ata_device *adev)
> > +{
> > +	void __iomem *base = (void __iomem *)ap->ioaddr.bmdma_addr;
> > +	struct ata_device *pair = ata_dev_pair(adev);
> > +	const struct ata_timing *t = ata_timing_find_mode(adev->pio_mode);
> > +	const u16 *id = adev->id;
> > +	unsigned int cycle_time;
> > +	int is_slave = adev->devno;
> > +	const u8 pio = adev->pio_mode - XFER_PIO_0;
> > +
> > +	if (id[ATA_ID_FIELD_VALID] & 2) {
> > +		if (ata_id_has_iordy(id))
> > +			cycle_time = id[ATA_ID_EIDE_PIO_IORDY];
> > +		else
> > +			cycle_time = id[ATA_ID_EIDE_PIO];
> > +
> > +		/* conservative "downgrade" for all pre-ATA2 drives */
> > +		if (pio < 3 && cycle_time < t->cycle)
> > +			cycle_time = 0; /* use standard timing */
> > +	}
> > +
> > +	if (!cycle_time)
> > +		cycle_time = t->cycle;
> 
>     This seems like a helper needed by libata in general but OK...

I need to think about this a bit more..

[...]

> > +static int __init pata_bk3710_probe(struct platform_device *pdev)
> > +{
> > +	struct clk *clk;
> > +	struct resource *mem, *irq;
> > +	struct ata_host *host;
> > +	struct ata_port *ap;
> > +	void __iomem *base;
> > +	unsigned long rate, mem_size;
> > +
> > +	clk = clk_get(&pdev->dev, NULL);
> 
>     devm_clk_get()?

Fixed.

> > +	if (IS_ERR(clk))
> > +		return -ENODEV;
> > +
> > +	clk_enable(clk);
> > +	rate = clk_get_rate(clk);
> > +	if (!rate)
> > +		return -EINVAL;
> > +
> > +	/* NOTE:  round *down* to meet minimum timings; we count in clocks */
> > +	ideclk_period = 1000000000UL / rate;
> > +
> > +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (mem == NULL) {
> > +		pr_err(DRV_NAME ": failed to get memory region resource\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> 
>     How about platform_get_irq()? I've fixed it... :-)

Converted.

> > +	if (irq == NULL) {
> > +		pr_err(DRV_NAME ": failed to get IRQ resource\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	mem_size = resource_size(mem);
> > +	if (!devm_request_mem_region(&pdev->dev, mem->start, mem_size,
> > +				     DRV_NAME)) {
> > +		pr_err(DRV_NAME ": failed to request memory region\n");
> > +		return -EBUSY;
> > +	}
> > +
> > +	base = ioremap(mem->start, mem_size);
> 
>     How about devm_ioremap_resource() instead of the above?

ditto

> > +	if (!base) {
> > +		pr_err(DRV_NAME ": failed to map IO memory\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	/* Configure the Palm Chip controller */
> 
>     It's Palmchip. :-)

Fixed.

[...]

Thanks for review!

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

