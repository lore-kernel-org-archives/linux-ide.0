From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH V2 1/6] ahci: imx: Explicitly clear IMX6Q_GPR13_SATA_MPLL_CLK_EN
Date: Fri, 22 Nov 2013 12:26:45 -0700
Message-ID: <528FAFF5.9040404@boundarydevices.com>
References: <1385118304-27435-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:55745 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755588Ab3KVT0r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Nov 2013 14:26:47 -0500
Received: by mail-pa0-f49.google.com with SMTP id kx10so1719814pab.22
        for <linux-ide@vger.kernel.org>; Fri, 22 Nov 2013 11:26:46 -0800 (PST)
In-Reply-To: <1385118304-27435-1-git-send-email-marex@denx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marex@denx.de>, linux-arm-kernel@lists.infradead.org
Cc: Richard Zhu <r65037@freescale.com>, Tejun Heo <tj@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Linux-IDE <linux-ide@vger.kernel.org>

On 11/22/2013 4:04 AM, Marek Vasut wrote:
> We must clear this IMX6Q_GPR13_SATA_MPLL_CLK_EN bit on i.MX6Q, otherwise
> Linux will fail to find the attached drive on some boards.
>
> This entire fix was:
> Reported-by: Eric Nelson <eric.nelson@boundarydevices.com>
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Richard Zhu <r65037@freescale.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Linux-IDE <linux-ide@vger.kernel.org>
> ---
>   drivers/ata/ahci_imx.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> V2: Update the value in the comment from 0x7ffffffd to 0x7ffffffe
>
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index ae2d73f..14227d1 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -113,7 +113,7 @@ static int imx6q_sata_init(struct device *dev, void __iomem *mmio)
>   	/*
>   	 * set PHY Paremeters, two steps to configure the GPR13,
>   	 * one write for rest of parameters, mask of first write
> -	 * is 0x07fffffd, and the other one write for setting
> +	 * is 0x07fffffe, and the other one write for setting

0x07ffffff, d+2 = f,
bit 1 is IMX6Q_GPR13_SATA_MPLL_CLK_EN, which you just added
bit 0 is IMX6Q_GPR13_SATA_TX_EDGE_RATE, which is also in your expression

>   	 * the mpll_clk_en.
>   	 */
>   	regmap_update_bits(imxpriv->gpr, 0x34, IMX6Q_GPR13_SATA_RX_EQ_VAL_MASK
> @@ -125,6 +125,7 @@ static int imx6q_sata_init(struct device *dev, void __iomem *mmio)
>   			| IMX6Q_GPR13_SATA_TX_BOOST_MASK
>   			| IMX6Q_GPR13_SATA_TX_LVL_MASK
>   			| IMX6Q_GPR13_SATA_TX_EDGE_RATE
> +			| IMX6Q_GPR13_SATA_MPLL_CLK_EN
>   			, IMX6Q_GPR13_SATA_RX_EQ_VAL_3_0_DB
>   			| IMX6Q_GPR13_SATA_RX_LOS_LVL_SATA2M
>   			| IMX6Q_GPR13_SATA_RX_DPLL_MODE_2P_4F

