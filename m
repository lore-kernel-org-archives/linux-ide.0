From: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 07/10] phy: phy_brcmstb_sata: add support 40nm platforms
Date: Thu, 22 Oct 2015 22:06:03 -0700
Message-ID: <CAGVrzcaYPv3zyV8n6Wag-b5S34C30YU=dDnHpPr7eKuut7JEvg@mail.gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com> <1445564663-66824-8-git-send-email-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445564663-66824-8-git-send-email-jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-MIPS <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

2015-10-22 18:44 GMT-07:00 Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Add offsets for 40nm BMIPS based set-top box platforms.
>
> Signed-off-by: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/phy/phy-brcmstb-sata.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/phy/phy-brcmstb-sata.c b/drivers/phy/phy-brcmstb-sata.c
> index 41c7535d706b..1cc80743b1b6 100644
> --- a/drivers/phy/phy-brcmstb-sata.c
> +++ b/drivers/phy/phy-brcmstb-sata.c
> @@ -30,7 +30,8 @@
>  #define MAX_PORTS                                      2
>
>  /* Register offset between PHYs in PCB space */
> -#define SATA_MDIO_REG_SPACE_SIZE                       0x1000
> +#define SATA_MDIO_REG_28NM_SPACE_SIZE                  0x1000
> +#define SATA_MDIO_REG_40NM_SPACE_SIZE                  0x10
>
>  struct brcm_sata_port {
>         int portnum;
> @@ -47,7 +48,7 @@ struct brcm_sata_phy {
>         struct brcm_sata_port phys[MAX_PORTS];
>  };
>
> -enum sata_mdio_phy_regs_28nm {
> +enum sata_mdio_phy_regs {
>         PLL_REG_BANK_0                          = 0x50,
>         PLL_REG_BANK_0_PLLCONTROL_0             = 0x81,
>
> @@ -85,7 +86,7 @@ static void brcm_sata_mdio_wr(void __iomem *addr, u32 bank, u32 ofs,
>  #define FMAX_VAL_DEFAULT       0x3df
>  #define FMAX_VAL_SSC           0x83
>
> -static void brcm_sata_cfg_ssc_28nm(struct brcm_sata_port *port)
> +static void brcm_sata_cfg_ssc(struct brcm_sata_port *port)
>  {
>         void __iomem *base = brcm_sata_phy_base(port);
>         struct brcm_sata_phy *priv = port->phy_priv;
> @@ -116,19 +117,25 @@ static int brcm_sata_phy_init(struct phy *phy)
>  {
>         struct brcm_sata_port *port = phy_get_drvdata(phy);
>
> -       brcm_sata_cfg_ssc_28nm(port);
> +       brcm_sata_cfg_ssc(port);
>
>         return 0;
>  }
>
> -static const struct phy_ops phy_ops_28nm = {
> +static const struct phy_ops phy_ops = {
>         .init           = brcm_sata_phy_init,
>         .owner          = THIS_MODULE,
>  };
>
>  static const struct of_device_id brcm_sata_phy_of_match[] = {
>         { .compatible   = "brcm,bcm7445-sata-phy",
> -                       .data = (void *)SATA_MDIO_REG_SPACE_SIZE },
> +                       .data = (void *)SATA_MDIO_REG_28NM_SPACE_SIZE },
> +       { .compatible   = "brcm,bcm7346-sata-phy",
> +                       .data = (void *)SATA_MDIO_REG_40NM_SPACE_SIZE },
> +       { .compatible   = "brcm,bcm7360-sata-phy",
> +                       .data = (void *)SATA_MDIO_REG_40NM_SPACE_SIZE },
> +       { .compatible   = "brcm,bcm7362-sata-phy",
> +                       .data = (void *)SATA_MDIO_REG_40NM_SPACE_SIZE },

Same comment as the AHCI portion, we need to update the Device Tree
binding document to make these new compatible strings documented
there.

Thank you!

>         {},
>  };
>  MODULE_DEVICE_TABLE(of, brcm_sata_phy_of_match);
> @@ -185,7 +192,7 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
>                 port = &priv->phys[id];
>                 port->portnum = id;
>                 port->phy_priv = priv;
> -               port->phy = devm_phy_create(dev, child, &phy_ops_28nm);
> +               port->phy = devm_phy_create(dev, child, &phy_ops);
>                 port->ssc_en = of_property_read_bool(child, "brcm,enable-ssc");
>                 if (IS_ERR(port->phy)) {
>                         dev_err(dev, "failed to create PHY\n");
> --
> 2.6.2
>



-- 
Florian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
