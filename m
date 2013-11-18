From: Eric Nelson <eric.nelson@boundarydevices.com>
Subject: Re: [PATCH 1/5] ahci: imx: Pull out the clock enable/disable calls
Date: Mon, 18 Nov 2013 11:47:23 -0700
Message-ID: <528A60BB.4010802@boundarydevices.com>
References: <1384651251-5548-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:41884 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296Ab3KRSr2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Nov 2013 13:47:28 -0500
Received: by mail-pd0-f173.google.com with SMTP id x10so6881401pdj.4
        for <linux-ide@vger.kernel.org>; Mon, 18 Nov 2013 10:47:27 -0800 (PST)
In-Reply-To: <1384651251-5548-1-git-send-email-marex@denx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marex@denx.de>, linux-arm-kernel@lists.infradead.org
Cc: Richard Zhu <r65037@freescale.com>, Tejun Heo <tj@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Linux-IDE <linux-ide@vger.kernel.org>

Hi Marek,

On 11/16/2013 06:20 PM, Marek Vasut wrote:
> The same code for enabling and disabling SATA clock was found in multiple
> places in the driver. Implement functions that enable/disable the SATA clock
> and use them in such places instead of duplicating the code.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Richard Zhu <r65037@freescale.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Linux-IDE <linux-ide@vger.kernel.org>
> ---
>   drivers/ata/ahci_imx.c | 133 ++++++++++++++++++++++++++++---------------------
>   1 file changed, 75 insertions(+), 58 deletions(-)
>
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index ae2d73f..c7ee505 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -47,6 +47,73 @@ static int ahci_imx_hotplug;
>   module_param_named(hotplug, ahci_imx_hotplug, int, 0644);
>   MODULE_PARM_DESC(hotplug, "AHCI IMX hot-plug support (0=Don't support, 1=support)");
>
> <snip>
 >

I haven't traced through all of this, but if you're copying from
the Freescale 3.0.35 kernel, note that there's a bug in it, and
the 0x7FFFFFFD really wanted to be an 0x7FFFFFFF.

The way I read this comment, the writes need to happen in two
steps:
	- write everything with the PHY disabled
	- enable the PHY

We had reports of stalls waiting for SATA drives to be enumerated
that were solved with this commit...

	https://github.com/boundarydevices/linux-imx6/commit/0186ea224ce6bd1cb4757a0f83b0090e26a021f4

> +	/*
> +	 * set PHY Paremeters, two steps to configure the GPR13,
> +	 * one write for rest of parameters, mask of first write
> +	 * is 0x07fffffd, and the other one write for setting
> +	 * the mpll_clk_en.
> +	 */
> +	if (config) {
> +		regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
> +				IMX6Q_GPR13_SATA_RX_EQ_VAL_MASK
> +				| IMX6Q_GPR13_SATA_RX_LOS_LVL_MASK
> +				| IMX6Q_GPR13_SATA_RX_DPLL_MODE_MASK
> +				| IMX6Q_GPR13_SATA_SPD_MODE_MASK
> +				| IMX6Q_GPR13_SATA_MPLL_SS_EN
> +				| IMX6Q_GPR13_SATA_TX_ATTEN_MASK
> +				| IMX6Q_GPR13_SATA_TX_BOOST_MASK
> +				| IMX6Q_GPR13_SATA_TX_LVL_MASK
> +				| IMX6Q_GPR13_SATA_TX_EDGE_RATE
> +				, IMX6Q_GPR13_SATA_RX_EQ_VAL_3_0_DB
> +				| IMX6Q_GPR13_SATA_RX_LOS_LVL_SATA2M
> +				| IMX6Q_GPR13_SATA_RX_DPLL_MODE_2P_4F
> +				| IMX6Q_GPR13_SATA_SPD_MODE_3P0G
> +				| IMX6Q_GPR13_SATA_MPLL_SS_EN
> +				| IMX6Q_GPR13_SATA_TX_ATTEN_9_16
> +				| IMX6Q_GPR13_SATA_TX_BOOST_3_33_DB
> +				| IMX6Q_GPR13_SATA_TX_LVL_1_025_V);
> +	}
> +	regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
> +			IMX6Q_GPR13_SATA_MPLL_CLK_EN,
> +			IMX6Q_GPR13_SATA_MPLL_CLK_EN);
> +

Regards,


Eric

