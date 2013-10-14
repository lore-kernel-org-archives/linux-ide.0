From: Zhu Richard-R65037 <r65037@freescale.com>
Subject: RE: [v3] ahci: imx: setup power saving methods
Date: Mon, 14 Oct 2013 02:39:01 +0000
Message-ID: <0E83723C55F66F43A6041464FE31119D40E14F@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1381487831-30090-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1381487831-30090-2-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20131013201634.GF18075@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131013201634.GF18075@htj.dyndns.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tejun Heo <tj@kernel.org>, Richard Zhu <richard.zhuhongxing@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-ide@vger.kernel.org

Hi Tejun:
Thanks for your review comments.

Best Regards
Richard Zhu


-----Original Message-----
From: Tejun Heo [mailto:htejun@gmail.com] On Behalf Of Tejun Heo
Sent: Monday, October 14, 2013 4:17 AM
To: Richard Zhu
Cc: shawn.guo@linaro.org; linux-arm-kernel@lists.infradead.org; jgarzik@pobox.com; linux-ide@vger.kernel.org; Zhu Richard-R65037
Subject: Re: [v3] ahci: imx: setup power saving methods

Hello,

On Fri, Oct 11, 2013 at 06:37:11PM +0800, Richard Zhu wrote:
> @@ -1,6 +1,6 @@
>  /*
> + * copyright (c) 2013 Freescale Semiconductor, Inc.
>   * Freescale IMX AHCI SATA platform driver
> - * Copyright 2013 Freescale Semiconductor, Inc.

Forgot to mention the above in the commit message?
[Richard] Ok, I would add change-note in the commit message.

> +static void ahci_imx_error_handler(struct ata_port *ap); static void 
> +ahci_host_stop(struct ata_host *host);

Please put the ops definition below the function defs so that the above aren't necessary.
[Richard] Accept.

> +static void ahci_imx_error_handler(struct ata_port *ap) {
> +	u32 reg_val;
> +	struct ata_device *dev;
> +	struct ata_host *host = dev_get_drvdata(ap->dev);
> +	struct ahci_host_priv *hpriv = host->private_data;
> +	void __iomem *mmio = hpriv->mmio;
> +	struct imx_ahci_priv *imxpriv = dev_get_drvdata(ap->dev->parent);
> +
> +	/* wrapper of the ahci_error_handler */
> +	if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
> +		/* restart engine */
> +		ahci_stop_engine(ap);
> +		ahci_start_engine(ap);
> +	}

Please export ahci_error_handler() and use that instead of duplicating this part.
[Richard] Ok, accept.

> +
> +	sata_pmp_error_handler(ap);
> +
> +	if (!ata_dev_enabled(ap->link.device))
> +		ahci_stop_engine(ap);
> +	/* end of wrapper */
> +
> +	if (!(imxpriv->first_time) || ahci_imx_hotplug)
> +		return;
> +
> +	imxpriv->first_time = false;
> +
> +	ata_for_each_dev(dev, &ap->link, ENABLED)
> +		return;
> +	/* DISABLE LINK to save power consumption */

A bit more explanation would be nice.  ie. briefly explain why it can't be part of usual LPM.
[Richard] no problem, I would add the explanation later. Thanks.

> +	reg_val = readl(mmio + PORT_PHY_CTL);
> +	writel(reg_val | PORT_PHY_CTL_PDDQ_LOC, mmio + PORT_PHY_CTL);
> +	regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
> +			IMX6Q_GPR13_SATA_MPLL_CLK_EN,
> +			!IMX6Q_GPR13_SATA_MPLL_CLK_EN);
> +	clk_disable_unprepare(imxpriv->sata_ref_clk);
> +	imxpriv->no_device = true;
> +}
> +
> +static void ahci_host_stop(struct ata_host *host) {
> +	struct device *dev = host->dev;
> +	struct ahci_platform_data *pdata = dev_get_platdata(dev);
> +	struct ahci_host_priv *hpriv = host->private_data;
> +
> +	if (pdata && pdata->exit)
> +		pdata->exit(dev);
> +
> +	if (!IS_ERR(hpriv->clk)) {
> +		clk_disable_unprepare(hpriv->clk);
> +		clk_put(hpriv->clk);
> +	}
> +}

Please do not duplicate functions like this.  Why not export and inherit from ahci_platform_ops?
[Richard] Ok, I would export and inherit from ahci_platform_ops.

>  static int imx6q_sata_init(struct device *dev, void __iomem *mmio)  {
>  	int ret = 0;
> -	unsigned int reg_val;
> +	u32 reg_val;

Hah?  Why is this chunk in this patch?
[Richard] Would be removed later. Thanks.

> +static int imx_ahci_suspend(struct device *dev) {
> +	struct imx_ahci_priv *imxpriv =  dev_get_drvdata(dev->parent);
> +
> +	if (!(imxpriv->no_device)) {

Please lose the unnecessary parantheses.
[Richard] Would be removed later. Thanks.

> +		regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
> +				IMX6Q_GPR13_SATA_MPLL_CLK_EN,
> +				!IMX6Q_GPR13_SATA_MPLL_CLK_EN);
> +		clk_disable_unprepare(imxpriv->sata_ref_clk);
> +	}

Some comment of what's going on would be nice.

Other than the above, looks good to me.
[Richard] Ok, no problem, comments would be added in next version.
Thanks again. :).

Thanks.

--
tejun
