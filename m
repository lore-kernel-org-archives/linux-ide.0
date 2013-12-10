From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH V6 3/3] ahci: imx: Add i.MX53 support
Date: Tue, 10 Dec 2013 12:47:38 +0100
Message-ID: <20131210114738.GA4097@pengutronix.de>
References: <1385369222-5288-1-git-send-email-marex@denx.de>
 <1385369222-5288-3-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51238 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542Ab3LJLrs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Dec 2013 06:47:48 -0500
Content-Disposition: inline
In-Reply-To: <1385369222-5288-3-git-send-email-marex@denx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, Richard Zhu <r65037@freescale.com>, Tejun Heo <tj@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Linux-IDE <linux-ide@vger.kernel.org>

Marek,

On Mon, Nov 25, 2013 at 09:47:02AM +0100, Marek Vasut wrote:
> Add minor adjustments to support i.MX53 SATA port as well as i.MX6Q one.
> The difference here is mostly the clock which need to be enabled and also
> the lack of need of programming IOMUXC registers on i.MX53. All of which
> is well handles in the clock enable/disable functions. Note that this patch
> also cleans up the names of the common functions, so they don't read imx6q_*
> but imx_* instead.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Richard Zhu <r65037@freescale.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Linux-IDE <linux-ide@vger.kernel.org>
> ---
>  drivers/ata/ahci_imx.c | 180 +++++++++++++++++++++++++++++++++----------------
>  1 file changed, 122 insertions(+), 58 deletions(-)
> 
> V2: Rebase this patch to be coherent with formating change in 1/5 .
> V3: Rebase this patch to be coherent with change in 1/5 .
> V4: Use sata_ref_clk for both MX53 and MX6 instead of separate sata_phy_clk
>     for MX53.
> V5: Rebase on top of changes in 1/6 and 2/6 . Note that I am keeping the small
>     delay after enabling clock on MX53 as well.
> V6: Rebase on top of changes in 1/3 and 2/3 . Also, this is important, add
>     softreset hook for the i.MX53 implemented by the ahci_imx_softreset()
>     function. For MX6, This function invokes the regular AHCI softreset
>     function, but for MX53 a function which retries the softreset is invoked.
>     The reset hook is needed, otherwise I observe some drives are not detected
>     at all.
> 
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index 6214411..8cb8965 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -34,10 +34,21 @@ enum {
>  	HOST_TIMER1MS = 0xe0,			/* Timer 1-ms */
>  };
>  
> +enum ahci_imx_type {
> +	AHCI_IMX53,
> +	AHCI_IMX6Q,
> +};

Please next time introduce a SoC specific struct to encode the
differences between SoCs. This way you can abstract away the differences
in flags and function callbacks and don't end up with functions which
do completely different things for different SoCs like currently in
imx_sata_clock_enable(). The if (type == SOC_XY) style doesn't scale in
many drivers anymore.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
