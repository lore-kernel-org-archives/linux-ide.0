From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2 1/1] ahci: imx: Add imx53 SATA temperature sensor support
Date: Fri, 21 Oct 2016 12:56:54 +0200
Message-ID: <2364981.7VqghJWO9f@amdc3058>
References: <20161019173137.GE18532@htj.duckdns.org>
 <1477034768-11721-1-git-send-email-fabien.lahoudere@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:38951 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755237AbcJUK5K (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 21 Oct 2016 06:57:10 -0400
In-reply-to: <1477034768-11721-1-git-send-email-fabien.lahoudere@collabora.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, Csaba Kertesz <csaba.kertesz@vincit.fi>


Hi,

On Friday, October 21, 2016 09:26:08 AM Fabien Lahoudere wrote:
> From: Csaba Kertesz <csaba.kertesz@vincit.fi>
> 
> Add a hwmon entry to get the temperature from the die of imx53
> SATA.
> 
> The original patch was made by Richard Zhu for kernel 2.6.x:
> ENGR00134041-MX53-Add-the-SATA-AHCI-temperature-monitor.patch
> 
> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
> ---
>  drivers/ata/ahci_imx.c | 225 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 225 insertions(+)
> 
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index 3f3a7db..a2a8c63 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -26,6 +26,9 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
>  #include <linux/libata.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/thermal.h>
>  #include "ahci.h"
>  
>  #define DRV_NAME "ahci-imx"
> @@ -214,6 +217,210 @@ static int imx_sata_phy_reset(struct ahci_host_priv *hpriv)
>  	return timeout ? 0 : -ETIMEDOUT;
>  }
>  
> +enum {
> +	/* SATA PHY Register */
> +	SATA_PHY_CR_CLOCK_CRCMP_LT_LIMIT = 0x0001,
> +	SATA_PHY_CR_CLOCK_DAC_CTL = 0x0008,
> +	SATA_PHY_CR_CLOCK_RTUNE_CTL = 0x0009,
> +	SATA_PHY_CR_CLOCK_ADC_OUT = 0x000A,
> +	SATA_PHY_CR_CLOCK_MPLL_TST = 0x0017,
> +};
> +
> +/* SATA AHCI temperature monitor */
> +static int sata_ahci_read_temperature(void *dev, int *temp)
> +{
> +	u16 mpll_test_reg, rtune_ctl_reg, dac_ctl_reg, adc_out_reg, read_sum;
> +	u32 str1, str2, str3, str4, index, read_attempt;
> +	const u32 attempt_limit = 100;
> +	int m1, m2, a;
> +	struct ahci_host_priv *hpriv = dev_get_drvdata(dev);
> +	void __iomem *mmio = hpriv->mmio;
> +
> +	/* check rd-wr to reg */
> +	read_sum = 0;
> +	imx_phy_reg_addressing(SATA_PHY_CR_CLOCK_CRCMP_LT_LIMIT, mmio);
> +	imx_phy_reg_write(read_sum, mmio);
> +	imx_phy_reg_read(&read_sum, mmio);
> +	if ((read_sum & 0xffff) != 0)
> +		dev_err(dev, "Read/Write REG error, 0x%x!\n", read_sum);
> +
> +	imx_phy_reg_write(0x5A5A, mmio);
> +	imx_phy_reg_read(&read_sum, mmio);
> +	if ((read_sum & 0xffff) != 0x5A5A)
> +		dev_err(dev, "Read/Write REG error, 0x%x!\n", read_sum);
> +
> +	imx_phy_reg_write(0x1234, mmio);
> +	imx_phy_reg_read(&read_sum, mmio);
> +	if ((read_sum & 0xffff) != 0x1234)
> +		dev_err(dev, "Read/Write REG error, 0x%x!\n", read_sum);
> +
> +	/* start temperature test */
> +	imx_phy_reg_addressing(SATA_PHY_CR_CLOCK_MPLL_TST, mmio);
> +	imx_phy_reg_read(&mpll_test_reg, mmio);
> +	imx_phy_reg_addressing(SATA_PHY_CR_CLOCK_RTUNE_CTL, mmio);
> +	imx_phy_reg_read(&rtune_ctl_reg, mmio);
> +	imx_phy_reg_addressing(SATA_PHY_CR_CLOCK_DAC_CTL, mmio);
> +	imx_phy_reg_read(&dac_ctl_reg, mmio);
> +
> +	/* mpll_tst.meas_iv   ([12:2]) */
> +	str1 = (mpll_test_reg >> 2) & 0x7FF;
> +	/* rtune_ctl.mode     ([1:0]) */
> +	str2 = (rtune_ctl_reg) & 0x3;
> +	/* dac_ctl.dac_mode   ([14:12]) */
> +	str3 = (dac_ctl_reg >> 12)  & 0x7;
> +	/* rtune_ctl.sel_atbp ([4]) */
> +	str4 = (rtune_ctl_reg >> 4);
> +
> +	/* Calculate the m1 */
> +	/* mpll_tst.meas_iv */
> +	mpll_test_reg = (mpll_test_reg & 0xE03) | (512) << 2;
> +	/* rtune_ctl.mode */
> +	rtune_ctl_reg = (rtune_ctl_reg & 0xFFC) | (1);
> +	/* dac_ctl.dac_mode */
> +	dac_ctl_reg = (dac_ctl_reg & 0x8FF) | (4) << 12;
> +	/* rtune_ctl.sel_atbp */
> +	rtune_ctl_reg = (rtune_ctl_reg & 0xFEF) | (0) << 4;
> +
> +	imx_phy_reg_addressing(SATA_PHY_CR_CLOCK_MPLL_TST, mmio);
> +	imx_phy_reg_write(mpll_test_reg, mmio);
> +	imx_phy_reg_addressing(SATA_PHY_CR_CLOCK_DAC_CTL, mmio);
> +	imx_phy_reg_write(dac_ctl_reg, mmio);

The code below is duplicated later for obtaining m2.
It should be moved to a common helper function.

> +	imx_phy_reg_addressing(SATA_PHY_CR_CLOCK_RTUNE_CTL, mmio);
> +	imx_phy_reg_write(rtune_ctl_reg, mmio);
> +
> +	/* two dummy read */
> +	index = 0;
> +	read_attempt = 0;
> +	adc_out_reg = 0;
> +	imx_phy_reg_addressing(SATA_PHY_CR_CLOCK_ADC_OUT, mmio);
> +	while (index < 2) {
> +		imx_phy_reg_read(&adc_out_reg, mmio);
> +		/* check if valid */
> +		if (adc_out_reg & 0x400)
> +			index++;
> +
> +		read_attempt++;
> +		if (read_attempt > attempt_limit) {
> +			dev_err(dev, "Read REG more than %d times!\n",
> +				attempt_limit);
> +			break;
> +		}
> +	}
> +
> +	index = 0;
> +	read_attempt = 0;
> +	read_sum = 0;
> +	while (index < 80) {
> +		imx_phy_reg_read(&adc_out_reg, mmio);
> +		if (adc_out_reg & 0x400) {
> +			read_sum = read_sum + (adc_out_reg & 0x3FF);
> +			index++;
> +		}
> +		read_attempt++;
> +		if (read_attempt > attempt_limit) {
> +			dev_err(dev, "Read REG more than %d times!\n",
> +				attempt_limit);
> +			break;
> +		}
> +	}

(end of duplicated code)

> +	/* Use the U32 to make 1000 precision */
> +	m1 = (read_sum * 1000) / 80;
> +
> +	/* Calculate the m2 */
> +	/* rtune_ctl.sel_atbp */
> +	rtune_ctl_reg = (rtune_ctl_reg & 0xFEF) | (1) << 4;
> +	imx_phy_reg_addressing(SATA_PHY_CR_CLOCK_RTUNE_CTL, mmio);
> +	imx_phy_reg_write(rtune_ctl_reg, mmio);
> +
> +	/* two dummy read */
> +	index = 0;
> +	read_attempt = 0;

adc_out_reg zeroing is missing here

> +	imx_phy_reg_addressing(SATA_PHY_CR_CLOCK_ADC_OUT, mmio);
> +	while (index < 2) {
> +		imx_phy_reg_read(&adc_out_reg, mmio);
> +		/* check if valid */
> +		if (adc_out_reg & 0x400)
> +			index++;
> +
> +		read_attempt++;
> +		if (read_attempt > attempt_limit) {
> +			dev_err(dev, "Read REG more than %d times!\n",
> +				attempt_limit);
> +			break;
> +		}
> +	}
> +
> +	index = 0;
> +	read_attempt = 0;
> +	read_sum = 0;
> +	while (index < 80) {
> +		imx_phy_reg_read(&adc_out_reg, mmio);
> +		if (adc_out_reg & 0x400) {
> +			read_sum = read_sum + (adc_out_reg & 0x3FF);
> +			index++;
> +		}
> +		read_attempt++;
> +		if (read_attempt > attempt_limit) {
> +			dev_err(dev, "Read REG more than %d times!\n",
> +				attempt_limit);
> +			break;
> +		}
> +	}
> +	/* Use the U32 to make 1000 precision */
> +	m2 = (read_sum * 1000) / 80;

The rest looks fine to me.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

