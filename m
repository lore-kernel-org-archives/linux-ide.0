From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 1/5] ahci: imx: Pull out the clock enable/disable calls
Date: Wed, 20 Nov 2013 10:55:53 +0100
Message-ID: <201311201055.53953.marex@denx.de>
References: <1384651251-5548-1-git-send-email-marex@denx.de> <201311182123.00169.marex@denx.de> <528A90A6.3030009@boundarydevices.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:58443 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727Ab3KTJ4A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Nov 2013 04:56:00 -0500
In-Reply-To: <528A90A6.3030009@boundarydevices.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eric Nelson <eric.nelson@boundarydevices.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Richard Zhu <r65037@freescale.com>, Tejun Heo <tj@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Linux-IDE <linux-ide@vger.kernel.org>

Dear Eric Nelson,

> Hi Marek,
> 
> On 11/18/2013 01:23 PM, Marek Vasut wrote:
> > Hi Eric,
> > 
> >> Hi Marek,
> >> 
> >> On 11/16/2013 06:20 PM, Marek Vasut wrote:
> >>> The same code for enabling and disabling SATA clock was found in
> >>> multiple places in the driver. Implement functions that enable/disable
> >>> the SATA clock and use them in such places instead of duplicating the
> >>> code.
> >>> 
> >>> Signed-off-by: Marek Vasut <marex@denx.de>
> >>> Cc: Shawn Guo <shawn.guo@linaro.org>
> >>> Cc: Richard Zhu <r65037@freescale.com>
> >>> Cc: Tejun Heo <tj@kernel.org>
> >>> Cc: Linux-IDE <linux-ide@vger.kernel.org>
> >>> ---
> >>> 
> >>>    drivers/ata/ahci_imx.c | 133
> >>>    ++++++++++++++++++++++++++++--------------------- 1 file changed, 75
> >>>    insertions(+), 58 deletions(-)
> >>> 
> >>> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> >>> index ae2d73f..c7ee505 100644
> >>> --- a/drivers/ata/ahci_imx.c
> >>> +++ b/drivers/ata/ahci_imx.c
> >>> @@ -47,6 +47,73 @@ static int ahci_imx_hotplug;
> >>> 
> >>>    module_param_named(hotplug, ahci_imx_hotplug, int, 0644);
> >>>    MODULE_PARM_DESC(hotplug, "AHCI IMX hot-plug support (0=Don't
> >>>    support, 1=support)");
> >>> 
> >>> <snip>
> >> 
> >> I haven't traced through all of this, but if you're copying from
> >> the Freescale 3.0.35 kernel, note that there's a bug in it, and
> >> the 0x7FFFFFFD really wanted to be an 0x7FFFFFFF.
> > 
> > I'm not taking this from FSL 3.0.35, no, but thanks for pointing this
> > out!
> > 
> >> The way I read this comment, the writes need to happen in two
> >> 
> >> steps:
> >> 	- write everything with the PHY disabled
> >> 	- enable the PHY
> >> 
> >> We had reports of stalls waiting for SATA drives to be enumerated
> >> that were solved with this commit...
> >> 
> >> 	https://github.com/boundarydevices/linux-
> > 
> > imx6/commit/0186ea224ce6bd1cb4757
> > 
> >> a0f83b0090e26a021f4
> > 
> > [...]
> > 
> >>> +	regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
> >>> +			IMX6Q_GPR13_SATA_MPLL_CLK_EN,
> >>> +			IMX6Q_GPR13_SATA_MPLL_CLK_EN);
> > 
> > Isn't this snippet doing exactly what your patch does ?
> 
> This part is doing the "set the bit" part:
> 	https://github.com/boundarydevices/linux-imx6/blob/boundary-
imx_3.0.35_4.1
> .0/arch/arm/mach-mx6/board-mx6_nitrogen6x.c#L728
> 
> The previous block isn't clearing the enable bit though:
> 
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
> 
> The explicit clearing of bit 1 is what was necessary (and I think
> it's what the original author was after).
> 
> This was a hard one to find, because it seems that it only shows
> up on some boards, and most of the time on those boards.
> 
> Here are some references:
> 	http://boundarydevices.com/freescale-ubuntu-image-with-4-0-0-
kernel/#comme
> nt-60464
> http://boundarydevices.com/debian-installer-on-i-mx6-boards/#comment-76203
> 
> The symptom is (was) that U-Boot worked 100% of the time, but
> the kernel failed to find the drive.
> 
> Using 'mm' in U-Boot to clear the bit before kernel launch also
> allowed things to function.

Ah, now I see it. I will cook a patch, thanks!
