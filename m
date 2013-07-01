From: Zhu Richard-R65037 <r65037@freescale.com>
Subject: RE: [v2 2/4] imx: ahci: enable ahci sata on imx6q platforms
Date: Mon, 1 Jul 2013 14:48:03 +0000
Message-ID: <0E83723C55F66F43A6041464FE31119D30C2E5@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1372672975-2997-1-git-send-email-r65037@freescale.com>
 <1372672975-2997-3-git-send-email-r65037@freescale.com>,<20130701125508.GX516@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:52453
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751665Ab3GAOsH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Jul 2013 10:48:07 -0400
In-Reply-To: <20130701125508.GX516@pengutronix.de>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>, Richard Zhu <richard.zhuhongxing@gmail.com>
Cc: "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi Sascha;
Thanks for your comments.

Best Regards
Richard Zhu
________________________________________
From: Sascha Hauer [s.hauer@pengutronix.de]
Sent: Monday, July 01, 2013 8:55 PM
To: Richard Zhu
Cc: shawn.guo@linaro.org; linux-arm-kernel@lists.infradead.org; jgarzik@pobox.com; avorontsov@ru.mvista.com; rob.herring@calxeda.com; linux-ide@vger.kernel.org; Zhu Richard-R65037
Subject: Re: [v2 2/4] imx: ahci: enable ahci sata on imx6q platforms

On Mon, Jul 01, 2013 at 06:02:53PM +0800, Richard Zhu wrote:
> Only the imx6q contains the ahci sata controller,
> other imx6 SoCs don't have it.
>
> Enable the ahci sata only on imx6q platforms
>
> Signed-off-by: Richard Zhu <r65037@freescale.com>
> ---
>  arch/arm/mach-imx/mach-imx6q.c |   85 +++++++++++++++++++++++++++++++++++++++-
> +/* imx6q ahci module initialization. */
> +static int imx6q_sata_phy_clk(struct device *dev, int enable)
> +{
> +     int ret = 0;
> +     struct clk *sata_ref_clk;
> +
> +     sata_ref_clk = devm_clk_get(dev, "sata_ref_100m");
> +     if (IS_ERR(sata_ref_clk)) {
> +             dev_err(dev, "can't get sata_ref clock.\n");
> +             return PTR_ERR(sata_ref_clk);
> +     }

devm_clk_get takes a reference to the clock. That's not something you
want to do each time you enable/disable a clock.
[Richard] Accepted.

> +     if (enable) {
> +             /* Enable PHY clock */
> +             ret = clk_prepare_enable(sata_ref_clk);
> +             if (ret < 0) {
> +                     dev_err(dev, "can't prepare-enable sata_ref clock\n");
> +                     clk_put(sata_ref_clk);
> +                     ret = PTR_ERR(sata_ref_clk);

What are you intending by converting a valid pointer to an error code?
[Richard] Typo-mistake, would be corrected.

> +             }
> +     } else {
> +             /* Disable PHY clock */
> +             clk_disable_unprepare(sata_ref_clk);
> +     }
> +
> +     return ret;
> +}
> +
> +static int imx6q_sata_init(struct device *dev, void __iomem *addr)
> +{
> +     int ret = 0;
> +     struct regmap *gpr;
> +
> +     ret = imx6q_sata_phy_clk(dev, true);
> +     if (ret < 0)
> +             return ret;
> +
> +     gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
> +     if (IS_ERR(gpr)) {
> +             pr_err("failed to find fsl,imx6q-iomux-gpr regmap\n");
> +             return PTR_ERR(gpr);
> +     }
> +
> +     /*
> +      * set PHY Paremeters, two steps to configure the GPR13,
> +      * one write for rest of parameters, mask of first write
> +      * is 0x07fffffd, and the other one write for setting
> +      * the mpll_clk_en.
> +      */
> +     regmap_update_bits(gpr, 0x34, 0x07fffffd, 0x0593e4c4);

You are adding the register defines in the next patch. Wouldn't it make
sense to use them?
[Richard] Ok, would be replaced by the register's definitions.

Sascha

--
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


