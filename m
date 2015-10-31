From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [v2 06/10] phy: phy_brcmstb_sata: add data for phy version
Date: Sat, 31 Oct 2015 16:20:24 +0100
Message-ID: <7143236.HOM9hXl6B3@wuerfel>
References: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com> <1445928491-7320-7-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:56928 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390AbbJaPUj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Oct 2015 11:20:39 -0400
In-Reply-To: <1445928491-7320-7-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>
Cc: Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>, Kevin Cernekee <cernekee@gmail.com>, Dragan Stancevic <dragan.stancevic@gmail.com>, linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>, devicetree@vger.kernel.org

On Tuesday 27 October 2015 15:48:07 Jaedon Shin wrote:
> 
>  static const struct of_device_id brcm_sata_phy_of_match[] = {
> -       { .compatible   = "brcm,bcm7445-sata-phy" },
> +       { .compatible   = "brcm,bcm7445-sata-phy",
> +         .data = (void *)BRCM_SATA_PHY_28NM },
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, brcm_sata_phy_of_match);
> @@ -135,6 +145,7 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         struct device_node *dn = dev->of_node, *child;
> +       const struct of_device_id *of_id;
>         struct brcm_sata_phy *priv;
>         struct resource *res;
>         struct phy_provider *provider;
> @@ -154,6 +165,12 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
>         if (IS_ERR(priv->phy_base))
>                 return PTR_ERR(priv->phy_base);
>  
> +       of_id = of_match_node(brcm_sata_phy_of_match, dn);
> +       if (of_id)
> +               priv->version = (enum brcm_sata_phy_version)of_id->data;
> +       else
> +               priv->version = BRCM_SATA_PHY_28NM;
> +
> 

As you don't actually use that variable except to set the 'offset' for
phy_base, it would be nicer to use a structure that you can point to:

struct brcm_sata_phy_data {
	unsigned long offset;
};

const struct brcm_sata_phy_data brcm_sata_phy_28nm = {
	.offset = SATA_MDIO_REG_28NM_SPACE_SIZE,
};

static const struct of_device_id brcm_sata_phy_of_match[] = {
	{ .compatible   = "brcm,bcm7445-sata-phy", .data = &brcm_sata_phy_28nm },
	{},
};

	Arnd
