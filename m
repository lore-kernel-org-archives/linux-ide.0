From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 02/10] ata: ahch_brcmstb: add data for port offset
Date: Thu, 22 Oct 2015 21:54:18 -0700
Message-ID: <CAGVrzcbdMkTVVby9V2HnZpvYB9sdo_ti_=5AvoxFO=OBvwb42Q@mail.gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com> <1445564663-66824-3-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:37226 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbbJWEy6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Oct 2015 00:54:58 -0400
In-Reply-To: <1445564663-66824-3-git-send-email-jaedon.shin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>, Brian Norris <computersforpeace@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

2015-10-22 18:44 GMT-07:00 Jaedon Shin <jaedon.shin@gmail.com>:
> Add data of device node for port offset.

Looks good to me, some minor nits below.

>
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---
>  drivers/ata/ahci_brcmstb.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
> index 14b7305d2ba0..8cf6f7d4798f 100644
> --- a/drivers/ata/ahci_brcmstb.c
> +++ b/drivers/ata/ahci_brcmstb.c
> @@ -72,6 +72,7 @@
>  struct brcm_ahci_priv {
>         struct device *dev;
>         void __iomem *top_ctrl;
> +       u32 port_offset;
>         u32 port_mask;
>  };
>
> @@ -110,7 +111,7 @@ static inline void brcm_sata_writereg(u32 val, void __iomem *addr)
>  static void brcm_sata_phy_enable(struct brcm_ahci_priv *priv, int port)
>  {
>         void __iomem *phyctrl = priv->top_ctrl + SATA_TOP_CTRL_PHY_CTRL +
> -                               (port * SATA_TOP_CTRL_PHY_OFFS);
> +                               (port * priv->port_offset);
>         void __iomem *p;
>         u32 reg;
>
> @@ -139,7 +140,7 @@ static void brcm_sata_phy_enable(struct brcm_ahci_priv *priv, int port)
>  static void brcm_sata_phy_disable(struct brcm_ahci_priv *priv, int port)
>  {
>         void __iomem *phyctrl = priv->top_ctrl + SATA_TOP_CTRL_PHY_CTRL +
> -                               (port * SATA_TOP_CTRL_PHY_OFFS);
> +                               (port * priv->port_offset);
>         void __iomem *p;
>         u32 reg;
>
> @@ -234,6 +235,13 @@ static int brcm_ahci_resume(struct device *dev)
>  }
>  #endif
>
> +static const struct of_device_id ahci_of_match[] = {
> +       {.compatible = "brcm,bcm7445-ahci",
> +                       .data = (void *)SATA_TOP_CTRL_PHY_OFFS},

We could omit having to specify explicitly the offset here.

> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, ahci_of_match);
> +
>  static struct scsi_host_template ahci_platform_sht = {
>         AHCI_SHT(DRV_NAME),
>  };
> @@ -241,6 +249,7 @@ static struct scsi_host_template ahci_platform_sht = {
>  static int brcm_ahci_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> +       const struct of_device_id *of_id = NULL;
>         struct brcm_ahci_priv *priv;
>         struct ahci_host_priv *hpriv;
>         struct resource *res;
> @@ -256,6 +265,12 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>         if (IS_ERR(priv->top_ctrl))
>                 return PTR_ERR(priv->top_ctrl);
>
> +       of_id = of_match_node(ahci_of_match, dev->of_node);
> +       if (!of_id)
> +               return -EINVAL;
> +
> +       priv->port_offset = (u32)of_id->data;

And if of_id->data is NULL here, just default to
SATA_TOP_CTRL_PHY_OFFS. But I have no strong preference.
