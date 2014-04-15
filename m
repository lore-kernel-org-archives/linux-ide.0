From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] ahci: imx: software workaround for phy reset issue
 in resume
Date: Tue, 15 Apr 2014 12:10:18 -0400
Message-ID: <20140415161018.GN1863@htj.dyndns.org>
References: <1397529703-21165-1-git-send-email-shawn.guo@freescale.com>
 <1397529703-21165-2-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:64095 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbaDOQKW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Apr 2014 12:10:22 -0400
Received: by mail-qa0-f47.google.com with SMTP id m5so7527880qaj.20
        for <linux-ide@vger.kernel.org>; Tue, 15 Apr 2014 09:10:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1397529703-21165-2-git-send-email-shawn.guo@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Zhu <r65037@freescale.com>

On Tue, Apr 15, 2014 at 10:41:43AM +0800, Shawn Guo wrote:
> +static int imx_phy_ack_polling(void __iomem *mmio, bool assert)
> +{
> +	int timeout = 100;
> +	u32 srval;
> +
> +	do {
> +		srval = readl(mmio + IMX_SATA_P0PHYSR);
> +		if ((assert ? srval : ~srval) & P0PHYSR_CR_ACK)
> +			break;
> +		usleep_range(100, 200);

What's up with usleep_range() these days?  There's no point in polling
in sub-msec intervals.  Let's please stick to msleep().

> +static int imx_phy_reg_addressing(u16 addr, void __iomem *mmio)
> +{
> +	u32 crval = addr;
> +	int ret;
> +
> +	/* 1. Supply the address on cr_data_in */
> +	writel(crval, mmio + IMX_SATA_P0PHYCR);
> +
> +	/* 2. Assert the cr_cap_addr signal */
> +	crval |= P0PHYCR_CR_CAP_ADDR;
> +	writel(crval, mmio + IMX_SATA_P0PHYCR);
> +
> +	/* 3. Wait for the cr_ack signal to be asserted */
> +	ret = imx_phy_ack_polling(mmio, true);
> +	if (ret)
> +		return ret;
> +
> +	/* 4. Deassert cr_cap_addr */
> +	crval &= ~P0PHYCR_CR_CAP_ADDR;
> +	writel(crval, mmio + IMX_SATA_P0PHYCR);
> +
> +	/* 5. Wait for cr_ack to be deasserted */
> +	ret = imx_phy_ack_polling(mmio, false);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

Wouldn't folding comment 3 and 5 into 2 and 4 respectively make it
easier on the eyes?  They're single operations anyway.

> +static int imx_phy_reg_write(u16 val, void __iomem *mmio)
> +{
...
> +}

Ditto.  Also, maybe it'd be better to create a wrapper to assert/clear
and wait for ack?

...
> +static int imx_sata_phy_reset(struct ahci_host_priv *hpriv)
> +{
> +	void __iomem *mmio = hpriv->mmio;
> +	int timeout = 10;
> +	u16 val;
> +	int ret;
> +
> +	/* Reset SATA PHY by setting RESET bit of PHY register CLOCK_RESET */
> +	ret = imx_phy_reg_addressing(IMX_PHY_CLOCK_RESET, mmio);
> +	if (ret)
> +		return ret;
> +	/*
> +	 * For phy reset operation, we skip the timeout checking, because phy
> +	 * will be unable to acknowledge in this case.
> +	 */
> +	imx_phy_reg_write(CLOCK_RESET_RESET, mmio);
> +
> +	usleep_range(100, 200);
> +
> +	/* Wait for PHY RX_PLL to be stable */
> +	do {
> +		ret = imx_phy_reg_addressing(IMX_PHY_LANE0_OUT_STAT, mmio);
> +		if (ret)
> +			return ret;
> +		ret = imx_phy_reg_read(&val, mmio);
> +		if (ret)
> +			return ret;
> +		if (val & LANE0_OUT_STAT_RX_PLL_STATE)
> +			break;
> +		usleep_range(100, 200);

Ditto with above.

Thanks.

-- 
tejun
