From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2 1/3] ata: add Palmchip BK3710 PATA controller driver
Date: Wed, 22 Mar 2017 18:59:10 +0100
Message-ID: <4365895.k4zyj0CytI@amdc3058>
References: <1489509414-11491-1-git-send-email-b.zolnierkie@samsung.com>
 <1489509414-11491-2-git-send-email-b.zolnierkie@samsung.com>
 <bc9a2d9b-1f16-4b59-0033-235686c76dcb@cogentembedded.com>
 <CGME20170322175912epcas5p2dc82f4879de4c440523e7d31c9bf385b@epcas5p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:32882 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965203AbdCVR7R (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 22 Mar 2017 13:59:17 -0400
In-reply-to: <bc9a2d9b-1f16-4b59-0033-235686c76dcb@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Tejun Heo <tj@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


Hi,

On Saturday, March 18, 2017 04:52:18 PM Sergei Shtylyov wrote:
> Hello!
> 
> On 3/14/2017 7:36 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> > Add Palmchip BK3710 PATA controller driver.
> >
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> [...]
> > diff --git a/drivers/ata/pata_bk3710.c b/drivers/ata/pata_bk3710.c
> > new file mode 100644
> > index 0000000..6d77217
> > --- /dev/null
> > +++ b/drivers/ata/pata_bk3710.c
> > @@ -0,0 +1,386 @@
> [...]
> > +static void pata_bk3710_chipinit(void __iomem *base)
> > +{
> [...]
> > +	/*
> > +	 * IORDYTMP IORDY Timer for Primary Register
> > +	 * (ATA_IORDYTMP_IORDYTMP     , 0xffff  )
> > +	 */
> > +	iowrite32(0xFFFF, base + BK3710_IORDYTMP);
> 
>     As I've already said, this is useless as we don't handle the IORDY timeout 
> interrupt anyway; writing 0 would be fine.

Will fix in v3, in the incremental patch (so it is easier to revert
if it turns out to cause problems later or port to palm_bk3710).

> > +
> > +	/*
> > +	 * Configure BMISP Register
> > +	 * (ATA_BMISP_DMAEN1	, DISABLE )	|
> > +	 * (ATA_BMISP_DMAEN0	, DISABLE )	|
> > +	 * (ATA_BMISP_IORDYINT	, CLEAR)	|
> > +	 * (ATA_BMISP_INTRSTAT	, CLEAR)	|
> > +	 * (ATA_BMISP_DMAERROR	, CLEAR)
> > +	 */
> > +	iowrite16(0, base + BK3710_BMISP);
> 
>     Bits 0-3 cane only be cleared by writing 1, so this write can't clear 

The documentation does say this about bits 1-3, bit 0 is handled in
a different way.

> them, contrary to what the comment says. Might be a material for a follow-up 
> patch tho...

Will fix in the incremental patch in v3.

> [...]
> > +static int __init pata_bk3710_probe(struct platform_device *pdev)
> > +{
> > +	struct clk *clk;
> > +	struct resource *mem;
> > +	struct ata_host *host;
> > +	struct ata_port *ap;
> > +	void __iomem *base;
> > +	unsigned long rate;
> > +	int irq;
> > +
> > +	clk = devm_clk_get(&pdev->dev, NULL);
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
> 
>     NULL check not needed here, devm_ioremap_resource() checks this anyway.

Will be fixed in v3.

> > +
> > +	irq = platform_get_irq(pdev, 0);
> > +	if (irq < 0) {
> > +		pr_err(DRV_NAME ": failed to get IRQ resource\n");
> > +		return irq;
> > +	}
> > +
> > +	base = devm_ioremap_resource(&pdev->dev, mem);
> > +	if (IS_ERR(base))
> > +		return PTR_ERR(base);
> > +
> [...]
> > +/* work with hotplug and coldplug */
> > +MODULE_ALIAS("platform:palm_bk3710");
> > +
> > +static struct platform_driver pata_bk3710_driver = {
> > +	.driver = {
> > +		.name = "palm_bk3710",
> 
>     Not DRV_NAME?

DRV_NAME is "pata_bk3710" and the platform driver name needs to
match the old driver name for compatibility reasons (supporting
both drivers by the arch specific code).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

