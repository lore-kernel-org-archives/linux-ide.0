From: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
Subject: [PATCH v3 1/1] ahci: imx: Add imx53 SATA temperature sensor support
Date: Tue, 25 Oct 2016 22:08:07 +0200
Message-ID: <1477426087-20263-1-git-send-email-fabien.lahoudere@collabora.co.uk>
References: <2364981.7VqghJWO9f@amdc3058>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39642 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932338AbcJYUIw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 25 Oct 2016 16:08:52 -0400
In-Reply-To: <2364981.7VqghJWO9f@amdc3058>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, Csaba Kertesz <csaba.kertesz@vincit.fi>, Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>

From: Csaba Kertesz <csaba.kertesz@vincit.fi>

Add a hwmon entry to get the temperature from the die of imx53
SATA.

The original patch was made by Richard Zhu for kernel 2.6.x:
ENGR00134041-MX53-Add-the-SATA-AHCI-temperature-monitor.patch

Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
---
 drivers/ata/ahci_imx.c | 195 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 195 insertions(+)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 3f3a7db..420f065 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -26,6 +26,9 @@
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 #include <linux/libata.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/thermal.h>
 #include "ahci.h"
 
 #define DRV_NAME "ahci-imx"
@@ -214,6 +217,180 @@ static int imx_sata_phy_reset(struct ahci_host_priv *hpriv)
 	return timeout ? 0 : -ETIMEDOUT;
 }
 
+enum {
+	/* SATA PHY Register */
+	SATA_PHY_CR_CLOCK_CRCMP_LT_LIMIT = 0x0001,
+	SATA_PHY_CR_CLOCK_DAC_CTL = 0x0008,
+	SATA_PHY_CR_CLOCK_RTUNE_CTL = 0x0009,
+	SATA_PHY_CR_CLOCK_ADC_OUT = 0x000A,
+	SATA_PHY_CR_CLOCK_MPLL_TST = 0x0017,
+};
+
+static int read_adc_sum(void *dev, u16 rtune_ctl_reg, void __iomem * mmio)
+{
+	u16 adc_out_reg, read_sum;
+	u32 index, read_attempt;
+	const u32 attempt_limit = 100;
+
+	imx_phy_reg_addressing(SATA_PHY_CR_CLOCK_RTUNE_CTL, mmio);
+	imx_phy_reg_write(rtune_ctl_reg, mmio);
+
+	/* two dummy read */
+	index = 0;
+	read_attempt = 0;
+	adc_out_reg = 0;
+	imx_phy_reg_addressing(SATA_PHY_CR_CLOCK_ADC_OUT, mmio);
+	while (index < 2) {
+		imx_phy_reg_read(&adc_out_reg, mmio);
+		/* check if valid */
+		if (adc_out_reg & 0x400)
+			index++;
+
+		read_attempt++;
+		if (read_attempt > attempt_limit) {
+			dev_err(dev, "Read REG more than %d times!\n",
+				attempt_limit);
+			break;
+		}
+	}
+
+	index = 0;
+	read_attempt = 0;
+	read_sum = 0;
+	while (index < 80) {
+		imx_phy_reg_read(&adc_out_reg, mmio);
+		if (adc_out_reg & 0x400) {
+			read_sum = read_sum + (adc_out_reg & 0x3FF);
+			index++;
+		}
+		read_attempt++;
+		if (read_attempt > attempt_limit) {
+			dev_err(dev, "Read REG more than %d times!\n",
+				attempt_limit);
+			break;
+		}
+	}
+
+	/* Use the U32 to make 1000 precision */
+	return (read_sum * 1000) / 80;
+}
+
+/* SATA AHCI temperature monitor */
+static int sata_ahci_read_temperature(void *dev, int *temp)
+{
+	u16 mpll_test_reg, rtune_ctl_reg, dac_ctl_reg, read_sum;
+	u32 str1, str2, str3, str4;
+	int m1, m2, a;
+	struct ahci_host_priv *hpriv = dev_get_drvdata(dev);
+	void __iomem *mmio = hpriv->mmio;
+
+	/* check rd-wr to reg */
+	read_sum = 0;
+	imx_phy_reg_addressing(SATA_PHY_CR_CLOCK_CRCMP_LT_LIMIT, mmio);
+	imx_phy_reg_write(read_sum, mmio);
+	imx_phy_reg_read(&read_sum, mmio);
+	if ((read_sum & 0xffff) != 0)
+		dev_err(dev, "Read/Write REG error, 0x%x!\n", read_sum);
+
+	imx_phy_reg_write(0x5A5A, mmio);
+	imx_phy_reg_read(&read_sum, mmio);
+	if ((read_sum & 0xffff) != 0x5A5A)
+		dev_err(dev, "Read/Write REG error, 0x%x!\n", read_sum);
+
+	imx_phy_reg_write(0x1234, mmio);
+	imx_phy_reg_read(&read_sum, mmio);
+	if ((read_sum & 0xffff) != 0x1234)
+		dev_err(dev, "Read/Write REG error, 0x%x!\n", read_sum);
+
+	/* start temperature test */
+	imx_phy_reg_addressing(SATA_PHY_CR_CLOCK_MPLL_TST, mmio);
+	imx_phy_reg_read(&mpll_test_reg, mmio);
+	imx_phy_reg_addressing(SATA_PHY_CR_CLOCK_RTUNE_CTL, mmio);
+	imx_phy_reg_read(&rtune_ctl_reg, mmio);
+	imx_phy_reg_addressing(SATA_PHY_CR_CLOCK_DAC_CTL, mmio);
+	imx_phy_reg_read(&dac_ctl_reg, mmio);
+
+	/* mpll_tst.meas_iv   ([12:2]) */
+	str1 = (mpll_test_reg >> 2) & 0x7FF;
+	/* rtune_ctl.mode     ([1:0]) */
+	str2 = (rtune_ctl_reg) & 0x3;
+	/* dac_ctl.dac_mode   ([14:12]) */
+	str3 = (dac_ctl_reg >> 12)  & 0x7;
+	/* rtune_ctl.sel_atbp ([4]) */
+	str4 = (rtune_ctl_reg >> 4);
+
+	/* Calculate the m1 */
+	/* mpll_tst.meas_iv */
+	mpll_test_reg = (mpll_test_reg & 0xE03) | (512) << 2;
+	/* rtune_ctl.mode */
+	rtune_ctl_reg = (rtune_ctl_reg & 0xFFC) | (1);
+	/* dac_ctl.dac_mode */
+	dac_ctl_reg = (dac_ctl_reg & 0x8FF) | (4) << 12;
+	/* rtune_ctl.sel_atbp */
+	rtune_ctl_reg = (rtune_ctl_reg & 0xFEF) | (0) << 4;
+	imx_phy_reg_addressing(SATA_PHY_CR_CLOCK_MPLL_TST, mmio);
+	imx_phy_reg_write(mpll_test_reg, mmio);
+	imx_phy_reg_addressing(SATA_PHY_CR_CLOCK_DAC_CTL, mmio);
+	imx_phy_reg_write(dac_ctl_reg, mmio);
+	m1 = read_adc_sum(dev, rtune_ctl_reg, mmio);
+
+	/* Calculate the m2 */
+	/* rtune_ctl.sel_atbp */
+	rtune_ctl_reg = (rtune_ctl_reg & 0xFEF) | (1) << 4;
+	m2 = read_adc_sum(dev, rtune_ctl_reg, mmio);
+
+	/* restore the status  */
+	/* mpll_tst.meas_iv */
+	mpll_test_reg = (mpll_test_reg & 0xE03) | (str1) << 2;
+	/* rtune_ctl.mode */
+	rtune_ctl_reg = (rtune_ctl_reg & 0xFFC) | (str2);
+	/* dac_ctl.dac_mode */
+	dac_ctl_reg = (dac_ctl_reg & 0x8FF) | (str3) << 12;
+	/* rtune_ctl.sel_atbp */
+	rtune_ctl_reg = (rtune_ctl_reg & 0xFEF) | (str4) << 4;
+
+	imx_phy_reg_addressing(SATA_PHY_CR_CLOCK_MPLL_TST, mmio);
+	imx_phy_reg_write(mpll_test_reg, mmio);
+	imx_phy_reg_addressing(SATA_PHY_CR_CLOCK_DAC_CTL, mmio);
+	imx_phy_reg_write(dac_ctl_reg, mmio);
+	imx_phy_reg_addressing(SATA_PHY_CR_CLOCK_RTUNE_CTL, mmio);
+	imx_phy_reg_write(rtune_ctl_reg, mmio);
+
+	/* Compute temperature */
+	if (!(m2 / 1000))
+		m2 = 1000;
+	a = (m2 - m1) / (m2/1000);
+	*temp = ((-559) * a * a) / 1000 + (1379) * a + (-458000);
+
+	return 0;
+}
+
+static ssize_t sata_ahci_show_temp(struct device *dev,
+				   struct device_attribute *da,
+				   char *buf)
+{
+	unsigned int temp = 0;
+	int err;
+
+	err = sata_ahci_read_temperature(dev, &temp);
+	if (err < 0)
+		return err;
+
+	return sprintf(buf, "%u\n", temp);
+}
+
+static const struct thermal_zone_of_device_ops fsl_sata_ahci_of_thermal_ops = {
+	.get_temp = sata_ahci_read_temperature,
+};
+
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, sata_ahci_show_temp, NULL, 0);
+
+static struct attribute *fsl_sata_ahci_attrs[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(fsl_sata_ahci);
+
 static int imx_sata_enable(struct ahci_host_priv *hpriv)
 {
 	struct imx_ahci_priv *imxpriv = hpriv->plat_data;
@@ -597,6 +774,24 @@ static int imx_ahci_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (imxpriv->type == AHCI_IMX53) {
+		/* Add the temperature monitor */
+		struct device *hwmon_dev;
+
+		hwmon_dev =
+			devm_hwmon_device_register_with_groups(dev,
+							"sata_ahci",
+							hpriv,
+							fsl_sata_ahci_groups);
+		if (IS_ERR(hwmon_dev)) {
+			ret = PTR_ERR(hwmon_dev);
+			goto disable_clk;
+		}
+		devm_thermal_zone_of_sensor_register(hwmon_dev, 0, hwmon_dev,
+					     &fsl_sata_ahci_of_thermal_ops);
+		dev_info(dev, "%s: sensor 'sata_ahci'\n", dev_name(hwmon_dev));
+	}
+
 	ret = imx_sata_enable(hpriv);
 	if (ret)
 		goto disable_clk;
-- 
2.1.4

