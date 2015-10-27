From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [v2 01/10] ata: ahci_brcmstb: add quick for broken ncq
Date: Tue, 27 Oct 2015 08:46:26 -0700
Message-ID: <562F9C52.8060609@gmail.com>
References: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com> <1445928491-7320-2-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35861 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932256AbbJ0PrH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Oct 2015 11:47:07 -0400
In-Reply-To: <1445928491-7320-2-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: Rob Herring <robh+dt@kernel.org>, Kevin Cernekee <cernekee@gmail.com>, Dragan Stancevic <dragan.stancevic@gmail.com>, linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>, devicetree@vger.kernel.org

On 26/10/15 23:48, Jaedon Shin wrote:
> Add quick for bronken ncq. The chipsets (eg. BCM7439A0, BCM7445A0 and
> BCM7445B0) need a workaround disabling NCQ. and it may need the
> MIPS-based set-top box platforms.

None of these chips are production chips, so at this point, disabling
NCQ should be done based on the compatible string we probed the driver
with, not using a specific property.

There are more comments below

> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---

[snip]

>  
> +static void brcm_sata_quick(struct platform_device *pdev,
> +			    struct brcm_ahci_priv *priv)
> +{
> +	void __iomem *ahci;
> +	struct resource *res;
> +	u32 reg;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ahci");
> +	ahci = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(ahci))
> +		return;
> +
> +	if (priv->quicks & BRCM_AHCI_QUICK_NONCQ) {
> +		reg  = readl(priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL);
> +		reg |= OVERRIDE_HWINIT;
> +		writel(reg, priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL);
> +
> +		/* Clear out the NCQ bit so the AHCI driver will not issue
> +		 * FPDMA/NCQ commands.
> +		 */
> +		reg = readl(ahci + HOST_CAP);
> +		reg &= ~HOST_CAP_NCQ;
> +		writel(reg, ahci + HOST_CAP);
> +
> +		reg = readl(priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL);
> +		reg &= ~OVERRIDE_HWINIT;
> +		writel(reg, priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL);
> +	}

In the original BSP, the NCQ disabling occurs prior to initializing the
SATA controller endianess. We would want to keep doing that in the same
order, and use brcm_sata_readreg() and brcm_sata_writereg() which take
care of doing these accesses in the native endianess of the system.

Reference is here:

https://github.com/Broadcom/stblinux-3.3/blob/master/linux/drivers/brcmstb/bchip.c#L254

> +
> +	devm_iounmap(&pdev->dev, ahci);
> +	devm_release_mem_region(&pdev->dev, res->start, resource_size(res));
> +}
> +
>  #ifdef CONFIG_PM_SLEEP
>  static int brcm_ahci_suspend(struct device *dev)
>  {
> @@ -256,7 +294,11 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->top_ctrl))
>  		return PTR_ERR(priv->top_ctrl);
>  
> +	if (of_property_read_bool(dev->of_node, "brcm,broken-ncq"))
> +		priv->quicks |= BRCM_AHCI_QUICK_NONCQ;
> +
>  	brcm_sata_init(priv);
> +	brcm_sata_quick(pdev, priv);
Florian
