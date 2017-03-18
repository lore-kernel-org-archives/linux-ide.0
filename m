From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 1/3] ata: add Palmchip BK3710 PATA controller driver
Date: Sat, 18 Mar 2017 16:52:18 +0300
Message-ID: <bc9a2d9b-1f16-4b59-0033-235686c76dcb@cogentembedded.com>
References: <1489509414-11491-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20170314163742epcas5p32a49df6b4ae6c21ee159c79320df5781@epcas5p3.samsung.com>
 <1489509414-11491-2-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1489509414-11491-2-git-send-email-b.zolnierkie@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Hello!

On 3/14/2017 7:36 PM, Bartlomiej Zolnierkiewicz wrote:

> Add Palmchip BK3710 PATA controller driver.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
[...]
> diff --git a/drivers/ata/pata_bk3710.c b/drivers/ata/pata_bk3710.c
> new file mode 100644
> index 0000000..6d77217
> --- /dev/null
> +++ b/drivers/ata/pata_bk3710.c
> @@ -0,0 +1,386 @@
[...]
> +static void pata_bk3710_chipinit(void __iomem *base)
> +{
[...]
> +	/*
> +	 * IORDYTMP IORDY Timer for Primary Register
> +	 * (ATA_IORDYTMP_IORDYTMP     , 0xffff  )
> +	 */
> +	iowrite32(0xFFFF, base + BK3710_IORDYTMP);

    As I've already said, this is useless as we don't handle the IORDY timeout 
interrupt anyway; writing 0 would be fine.

> +
> +	/*
> +	 * Configure BMISP Register
> +	 * (ATA_BMISP_DMAEN1	, DISABLE )	|
> +	 * (ATA_BMISP_DMAEN0	, DISABLE )	|
> +	 * (ATA_BMISP_IORDYINT	, CLEAR)	|
> +	 * (ATA_BMISP_INTRSTAT	, CLEAR)	|
> +	 * (ATA_BMISP_DMAERROR	, CLEAR)
> +	 */
> +	iowrite16(0, base + BK3710_BMISP);

    Bits 0-3 cane only be cleared by writing 1, so this write can't clear 
them, contrary to what the comment says. Might be a material for a follow-up 
patch tho...

[...]
> +static int __init pata_bk3710_probe(struct platform_device *pdev)
> +{
> +	struct clk *clk;
> +	struct resource *mem;
> +	struct ata_host *host;
> +	struct ata_port *ap;
> +	void __iomem *base;
> +	unsigned long rate;
> +	int irq;
> +
> +	clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(clk))
> +		return -ENODEV;
> +
> +	clk_enable(clk);
> +	rate = clk_get_rate(clk);
> +	if (!rate)
> +		return -EINVAL;
> +
> +	/* NOTE:  round *down* to meet minimum timings; we count in clocks */
> +	ideclk_period = 1000000000UL / rate;
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (mem == NULL) {
> +		pr_err(DRV_NAME ": failed to get memory region resource\n");
> +		return -ENODEV;
> +	}

    NULL check not needed here, devm_ioremap_resource() checks this anyway.

> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		pr_err(DRV_NAME ": failed to get IRQ resource\n");
> +		return irq;
> +	}
> +
> +	base = devm_ioremap_resource(&pdev->dev, mem);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
[...]
> +/* work with hotplug and coldplug */
> +MODULE_ALIAS("platform:palm_bk3710");
> +
> +static struct platform_driver pata_bk3710_driver = {
> +	.driver = {
> +		.name = "palm_bk3710",

    Not DRV_NAME?

[...]

MBR, Sergei
