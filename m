From: Zhu Richard-R65037 <r65037@freescale.com>
Subject: RE: [v2] ahci: imx: setup power saving methods
Date: Thu, 10 Oct 2013 10:31:15 +0000
Message-ID: <0E83723C55F66F43A6041464FE31119D408C24@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1381224562-2378-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1381224562-2378-2-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20131009203540.GE5592@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-db9lp0253.outbound.messaging.microsoft.com ([213.199.154.253]:14224
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751269Ab3JJKbW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Oct 2013 06:31:22 -0400
In-Reply-To: <20131009203540.GE5592@mtj.dyndns.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi Tejun:
Thanks for your review.

Best Regards
Richard Zhu


-----Original Message-----
From: Tejun Heo [mailto:htejun@gmail.com] On Behalf Of Tejun Heo
Sent: Thursday, October 10, 2013 4:36 AM
To: Richard Zhu
Cc: shawn.guo@linaro.org; linux-arm-kernel@lists.infradead.org; jgarzik@pobox.com; linux-ide@vger.kernel.org; Zhu Richard-R65037
Subject: Re: [v2] ahci: imx: setup power saving methods

Hello,

On Tue, Oct 08, 2013 at 05:29:22PM +0800, Richard Zhu wrote:
> @@ -1,6 +1,6 @@
>  /*
> + * copyright (c) 2013 Freescale Semiconductor, Inc.
>   * Freescale IMX AHCI SATA platform driver
> - * Copyright 2013 Freescale Semiconductor, Inc.

I don't really mind making small changes along with other changes but would appreciate if you can at least mention the change in the changelog.  As it currently stands, I'm not even sure whether the above is an intended change or just something slipped.
[Richard] thanks, No problem, I would add the change-notice in the change-log in next version.

> +module_param_named(hp, ahci_imx_hp, int, 0644);

Can you please spellout "hp" to "hotplug" especially for the name visible outside?  It isn't a common abbreviation and it's not like we despearately lose the extra three chars there.
[Richard] Accepted. "hp" would be replaced by "hotplug".

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

Hmm... I'm not a big fan of this approach as it essentially is an incomplete implementation of SATA device detection.  Wouldn't it be better to override error_handler?  ie. implement
ahci_imx_error_handler() which wraps ahci_error_handler() and do something like the following,

	static bool first_time = true;

	ahci_error_handler(ap);

	if (!first_time || ahci_imx_hotplug)
		return;

	first_time = false;

	ata_for_each_dev(dev, link, ENABLED)
		return;

	DISABLE LINK;
[Richard] Do you means to override the .error_handler of ata_port_operations defined in libahci.c or ahci_platform.c driver?
Ok, let me make a try on it. Thanks again for your review comments.

Thanks.

--
tejun


