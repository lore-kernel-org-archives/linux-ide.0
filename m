From: Tejun Heo <tj@kernel.org>
Subject: Re: [v4 02/10] ata: ahci_brcmstb: add quirk for broken ncq
Date: Tue, 17 Nov 2015 15:01:23 -0500
Message-ID: <20151117200123.GD22864@mtj.duckdns.org>
References: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com>
 <1446213684-2625-3-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:36070 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbbKQUB1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Nov 2015 15:01:27 -0500
Content-Disposition: inline
In-Reply-To: <1446213684-2625-3-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>
Cc: Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>, Kevin Cernekee <cernekee@gmail.com>, Dragan Stancevic <dragan.stancevic@gmail.com>, linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>, devicetree@vger.kernel.org

Hello,

On Fri, Oct 30, 2015 at 11:01:16PM +0900, Jaedon Shin wrote:
> +static void brcm_sata_quirks(struct platform_device *pdev,
> +			     struct brcm_ahci_priv *priv)
> +{
> +	if (priv->quirks & BRCM_AHCI_QUIRK_NONCQ) {
> +		void __iomem *ctrl = priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL;
> +		void __iomem *ahci;
> +		struct resource *res;
> +		u32 reg;
> +
> +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +						   "ahci");
> +		ahci = devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(ahci))
> +			return;
> +
> +		reg = brcm_sata_readreg(ctrl);
> +		reg |= OVERRIDE_HWINIT;
> +		brcm_sata_writereg(reg, ctrl);
> +
> +		/* Clear out the NCQ bit so the AHCI driver will not issue
> +		 * FPDMA/NCQ commands.
> +		 */
> +		reg = readl(ahci + HOST_CAP);
> +		reg &= ~HOST_CAP_NCQ;
> +		writel(reg, ahci + HOST_CAP);
> +
> +		reg = brcm_sata_readreg(ctrl);
> +		reg &= ~OVERRIDE_HWINIT;
> +		brcm_sata_writereg(reg, ctrl);
> +
> +		devm_iounmap(&pdev->dev, ahci);
> +		devm_release_mem_region(&pdev->dev, res->start,
> +					resource_size(res));
> +	}
> +}

Does the controller actually need HOST_CAP_NCQ bit turned off to work
correctly?  If the only thing necessary is the host not issuing NCQ
commands, setting AHCI_HFLAG_NO_NCQ should do.

>  static void brcm_sata_init(struct brcm_ahci_priv *priv)
>  {
>  	/* Configure endianness */
> @@ -256,6 +297,11 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->top_ctrl))
>  		return PTR_ERR(priv->top_ctrl);
>  
> +	if (of_device_is_compatible(dev->of_node, "brcm,bcm7425-ahci"))
> +		priv->quirks |= BRCM_AHCI_QUIRK_NONCQ;
> +
> +	brcm_sata_quirks(pdev, priv);

What's the point of "branch - set a bit - test the bit" sequence?
Just do

	if (of_device_is_compatiable(...))
		brcm_ahci_disable_ncq(...);

Thanks.

-- 
tejun
