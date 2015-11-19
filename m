From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [v5 2/7] ata: ahci_brcmstb: add quirk for broken ncq
Date: Thu, 19 Nov 2015 10:44:54 -0800
Message-ID: <20151119184454.GD64635@google.com>
References: <1447900879-1549-1-git-send-email-jaedon.shin@gmail.com>
 <1447900879-1549-3-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35462 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934528AbbKSSo5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Nov 2015 13:44:57 -0500
Received: by pacej9 with SMTP id ej9so88934641pac.2
        for <linux-ide@vger.kernel.org>; Thu, 19 Nov 2015 10:44:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1447900879-1549-3-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, linux-ide@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Dragan Stancevic <dragan.stancevic@gmail.com>

On Thu, Nov 19, 2015 at 11:41:14AM +0900, Jaedon Shin wrote:
> Add quirk for broken ncq. Some chipsets (eg. BCM7349A0, BCM7445A0,
> BCM7445B0, and all 40nm chipsets including BCM7425) need a workaround
> disabling NCQ.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> Acked-by: Brian Norris <computersforpeace@gmail.com>
> ---
>  drivers/ata/ahci_brcmstb.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
> index 73e3b0b2a3c2..3bf1cf6259d7 100644
> --- a/drivers/ata/ahci_brcmstb.c
> +++ b/drivers/ata/ahci_brcmstb.c
> @@ -69,10 +69,15 @@
>  	(DATA_ENDIAN << DMADESC_ENDIAN_SHIFT) |		\
>  	(MMIO_ENDIAN << MMIO_ENDIAN_SHIFT))
>  
> +enum brcm_ahci_quirks {
> +	BRCM_AHCI_QUIRK_NONCQ		= BIT(0),
> +};
> +
>  struct brcm_ahci_priv {
>  	struct device *dev;
>  	void __iomem *top_ctrl;
>  	u32 port_mask;
> +	u32 quirks;
>  };
>  
>  static const struct ata_port_info ahci_brcm_port_info = {
> @@ -202,6 +207,42 @@ static u32 brcm_ahci_get_portmask(struct platform_device *pdev,
>  	return impl;
>  }
>  
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
> +		reg = brcm_sata_readreg(ahci + HOST_CAP);
> +		reg &= ~HOST_CAP_NCQ;
> +		brcm_sata_writereg(reg, ahci + HOST_CAP);
> +
> +		reg = brcm_sata_readreg(ctrl);
> +		reg &= ~OVERRIDE_HWINIT;
> +		brcm_sata_writereg(reg, ctrl);
> +
> +		devm_iounmap(&pdev->dev, ahci);
> +		devm_release_mem_region(&pdev->dev, res->start,
> +					resource_size(res));

You missed Tejun's suggestion:

http://article.gmane.org/gmane.linux.ide/60602

This can all be killed and replaced with 

	hpriv->flags |= AHCI_HFLAG_NO_NCQ;

And you need to move brcm_sata_quirks() after
ahci_platform_get_resources(). (It makes sense there anyway, despite
whatever the original Broadcom BSP did.)

Brian

> +	}
> +}
> +
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
> +
>  	brcm_sata_init(priv);
>  
>  	priv->port_mask = brcm_ahci_get_portmask(pdev, priv);
> -- 
> 2.6.3
> 
