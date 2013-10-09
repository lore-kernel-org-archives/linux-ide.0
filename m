From: Tejun Heo <tj@kernel.org>
Subject: Re: [v2] ahci: imx: setup power saving methods
Date: Wed, 9 Oct 2013 16:35:40 -0400
Message-ID: <20131009203540.GE5592@mtj.dyndns.org>
References: <1381224562-2378-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1381224562-2378-2-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:51409 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965Ab3JIUfp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Oct 2013 16:35:45 -0400
Received: by mail-qc0-f175.google.com with SMTP id v2so1003125qcr.6
        for <linux-ide@vger.kernel.org>; Wed, 09 Oct 2013 13:35:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1381224562-2378-2-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhuhongxing@gmail.com>
Cc: shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

Hello,

On Tue, Oct 08, 2013 at 05:29:22PM +0800, Richard Zhu wrote:
> @@ -1,6 +1,6 @@
>  /*
> + * copyright (c) 2013 Freescale Semiconductor, Inc.
>   * Freescale IMX AHCI SATA platform driver
> - * Copyright 2013 Freescale Semiconductor, Inc.

I don't really mind making small changes along with other changes but
would appreciate if you can at least mention the change in the
changelog.  As it currently stands, I'm not even sure whether the
above is an intended change or just something slipped.

> +module_param_named(hp, ahci_imx_hp, int, 0644);

Can you please spellout "hp" to "hotplug" especially for the name
visible outside?  It isn't a common abbreviation and it's not like we
despearately lose the extra three chars there.

> @@ -105,6 +114,39 @@ static int imx6q_sata_init(struct device *dev, void __iomem *mmio)
>  	reg_val = clk_get_rate(imxpriv->ahb_clk) / 1000;
>  	writel(reg_val, mmio + HOST_TIMER1MS);
>  
> +	if (ahci_imx_hp == 0) {
> +		/*
> +		 * hot-plug is not supported.
> +		 * In order to save power consumption, enter PDDQ mode
> +		 * when there is no device detected on the port.
> +		 * NOTE: hot-plug wouldn't supported when PDDQ mode is
> +		 * ever entered.
> +		 */
> +		do {
> +			sstatus = readl(mmio + 0x100 + PORT_SCR_STAT);
> +			if ((sstatus & 0xF) == 0)
> +				usleep_range(1000, 2000);
> +			else
> +				break;
> +
> +			if (iterations == 0) {
> +				pr_info("No sata disk.\n");
> +				reg_val = readl(mmio + PORT_PHY_CTL);
> +				writel(reg_val | PORT_PHY_CTL_PDDQ_LOC,
> +						mmio + PORT_PHY_CTL);
> +				regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
> +						IMX6Q_GPR13_SATA_MPLL_CLK_EN,
> +						!IMX6Q_GPR13_SATA_MPLL_CLK_EN);
> +				clk_disable_unprepare(imxpriv->sata_ref_clk);
> +				imxpriv->no_device = 1;
> +
> +				return 0;
> +			}
> +		} while (iterations-- > 0);

Hmm... I'm not a big fan of this approach as it essentially is an
incomplete implementation of SATA device detection.  Wouldn't it be
better to override error_handler?  ie. implement
ahci_imx_error_handler() which wraps ahci_error_handler() and do
something like the following,

	static bool first_time = true;

	ahci_error_handler(ap);

	if (!first_time || ahci_imx_hotplug)
		return;

	first_time = false;

	ata_for_each_dev(dev, link, ENABLED)
		return;

	DISABLE LINK;

Thanks.

-- 
tejun
