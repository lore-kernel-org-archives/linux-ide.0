From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH RFC 5/5] ahci_imx: add disable for spread-spectrum
Date: Wed, 16 Apr 2014 17:46:47 -0500
Message-ID: <CAL_JsqK_BbhXs0gcn=w=1KPKOD0HZzmYx5zAaS5_z=UvQDPNjw@mail.gmail.com>
References: <20140416084227.GD24070@n2100.arm.linux.org.uk>
	<E1WaLRa-0002yX-7L@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ve0-f173.google.com ([209.85.128.173]:53423 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755526AbaDPWqu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2014 18:46:50 -0400
In-Reply-To: <E1WaLRa-0002yX-7L@rmk-PC.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Shawn Guo <shawn.guo@freescale.com>, Sascha Hauer <kernel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Tejun Heo <tj@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-ide@vger.kernel.org

On Wed, Apr 16, 2014 at 3:43 AM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Spread-spectrum doesn't work with Cubox-i hardware, so we have to
> disable this feature.  Add a DT property so that platforms can
> indicate that this feature should not be enabled.

This is for spread-spectrum tx or rx? Transmit SS is optional to
support, but the receiver must support SS. Otherwise random drives
won't work which makes for a good user experience. Is this really a
board quirk rather than a Si issue?

Rob

>
> Having it as a negative property keeps existing DT files working.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/boot/dts/imx6q-cubox-i.dts |  1 +
>  drivers/ata/ahci_imx.c              | 14 +++++++++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx6q-cubox-i.dts b/arch/arm/boot/dts/imx6q-cubox-i.dts
> index 941365d7ee65..9efd8b0c8011 100644
> --- a/arch/arm/boot/dts/imx6q-cubox-i.dts
> +++ b/arch/arm/boot/dts/imx6q-cubox-i.dts
> @@ -16,4 +16,5 @@
>         fsl,transmit-level-mV = <1104>;
>         fsl,transmit-boost-mdB = <0>;
>         fsl,transmit-atten-16ths = <9>;
> +       fsl,no-spread-spectrum;
>  };
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index 1251d719cc73..f3221b8bfafa 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -208,6 +208,7 @@ struct reg_property {
>         const struct reg_value *values;
>         size_t num_values;
>         u32 def_value;
> +       u32 set_value;
>  };
>
>  static const struct reg_value gpr13_tx_level[] = {
> @@ -305,6 +306,10 @@ static const struct reg_property gpr13_props[] = {
>                 .values = gpr13_rx_eq,
>                 .num_values = ARRAY_SIZE(gpr13_rx_eq),
>                 .def_value = IMX6Q_GPR13_SATA_RX_EQ_VAL_3_0_DB,
> +       }, {
> +               .name = "fsl,no-spread-spectrum",
> +               .def_value = IMX6Q_GPR13_SATA_MPLL_SS_EN,
> +               .set_value = 0,
>         },
>  };
>
> @@ -318,6 +323,14 @@ static u32 imx_ahci_parse_props(struct device *dev,
>         for (i = 0; i < num; i++, prop++) {
>                 u32 of_val;
>
> +               if (prop->num_values == 0) {
> +                       if (of_property_read_bool(np, prop->name))
> +                               reg_value |= prop->set_value;
> +                       else
> +                               reg_value |= prop->def_value;
> +                       continue;
> +               }
> +
>                 if (of_property_read_u32(np, prop->name, &of_val)) {
>                         dev_info(dev, "%s not specified, using %08x\n",
>                                 prop->name, prop->def_value);
> @@ -392,7 +405,6 @@ static int imx_ahci_probe(struct platform_device *pdev)
>                                    IMX6Q_GPR13_SATA_RX_LOS_LVL_SATA2M |
>                                    IMX6Q_GPR13_SATA_RX_DPLL_MODE_2P_4F |
>                                    IMX6Q_GPR13_SATA_SPD_MODE_3P0G |
> -                                  IMX6Q_GPR13_SATA_MPLL_SS_EN |
>                                    reg_value;
>         }
>
> --
> 1.8.3.1
>
