From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 06/10] phy: phy_brcmstb_sata: add data for phy offset
Date: Thu, 22 Oct 2015 22:04:11 -0700
Message-ID: <CAGVrzcZR8iUSG97FpfPCPRRqvTTZuiMaiFTqZDHqt1o8m=NczQ@mail.gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com> <1445564663-66824-7-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35292 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbbJWFEu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Oct 2015 01:04:50 -0400
In-Reply-To: <1445564663-66824-7-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Kevin Cernekee <cernekee@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

2015-10-22 18:44 GMT-07:00 Jaedon Shin <jaedon.shin@gmail.com>:
> Add data of device node for phy offset.

Similar comment to the AHCI portion, we could just omit specifying the
offset in the of_device_id.data member, and just assume the current
offset if not defined.

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

>
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---
>  drivers/phy/phy-brcmstb-sata.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/phy/phy-brcmstb-sata.c b/drivers/phy/phy-brcmstb-sata.c
> index 0be55dafe9ea..41c7535d706b 100644
> --- a/drivers/phy/phy-brcmstb-sata.c
> +++ b/drivers/phy/phy-brcmstb-sata.c
> @@ -42,6 +42,7 @@ struct brcm_sata_port {
>  struct brcm_sata_phy {
>         struct device *dev;
>         void __iomem *phy_base;
> +       u32 phy_offset;
>
>         struct brcm_sata_port phys[MAX_PORTS];
>  };
> @@ -65,7 +66,7 @@ static inline void __iomem *brcm_sata_phy_base(struct brcm_sata_port *port)
>  {
>         struct brcm_sata_phy *priv = port->phy_priv;
>
> -       return priv->phy_base + (port->portnum * SATA_MDIO_REG_SPACE_SIZE);
> +       return priv->phy_base + (port->portnum * priv->phy_offset);
>  }
>
>  static void brcm_sata_mdio_wr(void __iomem *addr, u32 bank, u32 ofs,
> @@ -126,7 +127,8 @@ static const struct phy_ops phy_ops_28nm = {
>  };
>
>  static const struct of_device_id brcm_sata_phy_of_match[] = {
> -       { .compatible   = "brcm,bcm7445-sata-phy" },
> +       { .compatible   = "brcm,bcm7445-sata-phy",
> +                       .data = (void *)SATA_MDIO_REG_SPACE_SIZE },
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, brcm_sata_phy_of_match);
> @@ -135,6 +137,7 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         struct device_node *dn = dev->of_node, *child;
> +       const struct of_device_id *of_id = NULL;
>         struct brcm_sata_phy *priv;
>         struct resource *res;
>         struct phy_provider *provider;
> @@ -154,6 +157,12 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
>         if (IS_ERR(priv->phy_base))
>                 return PTR_ERR(priv->phy_base);
>
> +       of_id = of_match_node(brcm_sata_phy_of_match, dn);
> +       if (!of_id)
> +               return -EINVAL;
> +
> +       priv->phy_offset = (u32)of_id->data;
> +
>         for_each_available_child_of_node(dn, child) {
>                 unsigned int id;
>                 struct brcm_sata_port *port;
> --
> 2.6.2
>



-- 
Florian
