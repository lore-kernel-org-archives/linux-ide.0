From: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
Subject: [PATCH 1/1] Add CPU temperature sensor support for i.MX53
Date: Wed,  3 Aug 2016 09:35:56 +0200
Message-ID: <1470209756-32705-1-git-send-email-fabien.lahoudere@collabora.co.uk>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58070 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006AbcHCHgz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Aug 2016 03:36:55 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Csaba Kertesz <csaba.kertesz@vincit.fi>, Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>, Tejun Heo <tj@kernel.org>, "open list:LIBATA SUBSYSTEM Serial and
	Parallel ATA drivers" <linux-ide@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

From: Csaba Kertesz <csaba.kertesz@vincit.fi>

The original patch was made by Richard Zhu for kernel 2.6.x:

ENGR00134041-MX53-Add-the-SATA-AHCI-temperature-monitor.patch

The old source code was migrated to the new kernel 3.x. The concept of
value reading was changed a bit:

1. The new 3.x kernel functions (imx_phy_reg_read, imx_phy_reg_write) use
   16 bit registers while the original implementation used 32 bit integers
   for this purpose.
2. The communication is guarded against infinite loop to give up a certain
   register reading after 100000 attempts. This number comes from the
   original implementation. A new variable (read_attempt) is introduced to
   count the trials.

Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
---
 drivers/ata/ahci_imx.c | 203 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 202 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 3f3a7db..b89eb45 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -214,6 +214,194 @@ static int imx_sata_phy_reset(struct ahci_host_priv *hpriv)
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
+/* SATA AHCI temperature monitor */
+static ssize_t sata_ahci_current_tmp(struct device *dev, struct device_attribute
+			      *devattr, char *buf)
+{
+	u16 mpll_test_reg, rtune_ctl_reg, dac_ctl_reg, adc_out_reg, read_sum;
+	u32 str1, str2, str3, str4, index, read_attempt;
+	const u32 attempt_limit = 100000;
+	int m1, m2, a, temp;
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host->private_data;
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
+
+	imx_phy_reg_addressing(SATA_PHY_CR_CLOCK_MPLL_TST, mmio);
+	imx_phy_reg_write(mpll_test_reg, mmio);
+	imx_phy_reg_addressing(SATA_PHY_CR_CLOCK_DAC_CTL, mmio);
+	imx_phy_reg_write(dac_ctl_reg, mmio);
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
+			dev_err(dev, "Read REG more than 100000 times!\n");
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
+			dev_err(dev, "Read REG more than 100000 times!\n");
+			break;
+		}
+	}
+	/* Use the U32 to make 1000 precision */
+	m1 = (read_sum * 1000) / 80;
+
+	/* Calculate the m2 */
+	/* rtune_ctl.sel_atbp */
+	rtune_ctl_reg = (rtune_ctl_reg & 0xFEF) | (1) << 4;
+	imx_phy_reg_addressing(SATA_PHY_CR_CLOCK_RTUNE_CTL, mmio);
+	imx_phy_reg_write(rtune_ctl_reg, mmio);
+
+	/* two dummy read */
+	index = 0;
+	read_attempt = 0;
+	imx_phy_reg_addressing(SATA_PHY_CR_CLOCK_ADC_OUT, mmio);
+	while (index < 2) {
+		imx_phy_reg_read(&adc_out_reg, mmio);
+		/* check if valid */
+		if (adc_out_reg & 0x400)
+			index++;
+
+		read_attempt++;
+		if (read_attempt > attempt_limit) {
+			dev_err(dev, "Read REG more than 100000 times!\n");
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
+			dev_err(dev, "Read REG more than 100000 times!\n");
+			break;
+		}
+	}
+	/* Use the U32 to make 1000 precision */
+	m2 = (read_sum * 1000) / 80;
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
+	a = (m2 - m1) / (m2 / 1000);
+	temp = ((((-559) * a) / 1000) * a) / 1000 + (1379) * a / 1000 + (-458);
+
+	return sprintf(buf, "%d\n", temp);
+}
+
+
+static DEVICE_ATTR(temperature, S_IRUGO, sata_ahci_current_tmp, NULL);
+
+static struct attribute *fsl_sata_ahci_attr[] = {
+	&dev_attr_temperature.attr,
+	NULL
+};
+
+static const struct attribute_group fsl_sata_ahci_group = {
+	.attrs = fsl_sata_ahci_attr,
+};
+
 static int imx_sata_enable(struct ahci_host_priv *hpriv)
 {
 	struct imx_ahci_priv *imxpriv = hpriv->plat_data;
@@ -597,9 +785,16 @@ static int imx_ahci_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (imxpriv->type == AHCI_IMX53) {
+		/* Add the temperature monitor */
+		ret = sysfs_create_group(&dev->kobj, &fsl_sata_ahci_group);
+		if (ret)
+			goto disable_clk;
+	}
+
 	ret = imx_sata_enable(hpriv);
 	if (ret)
-		goto disable_clk;
+		goto disable_sysfs;
 
 	/*
 	 * Configure the HWINIT bits of the HOST_CAP and HOST_PORTS_IMPL,
@@ -631,6 +826,9 @@ static int imx_ahci_probe(struct platform_device *pdev)
 
 disable_sata:
 	imx_sata_disable(hpriv);
+disable_sysfs:
+	if (imxpriv->type == AHCI_IMX53)
+		sysfs_remove_group(&dev->kobj, &fsl_sata_ahci_group);
 disable_clk:
 	clk_disable_unprepare(imxpriv->sata_clk);
 	return ret;
@@ -640,8 +838,11 @@ static void ahci_imx_host_stop(struct ata_host *host)
 {
 	struct ahci_host_priv *hpriv = host->private_data;
 	struct imx_ahci_priv *imxpriv = hpriv->plat_data;
+	struct device *dev = &imxpriv->ahci_pdev->dev;
 
 	imx_sata_disable(hpriv);
+	if (imxpriv->type == AHCI_IMX53)
+		sysfs_remove_group(&dev->kobj, &fsl_sata_ahci_group);
 	clk_disable_unprepare(imxpriv->sata_clk);
 }
 
-- 
2.7.4

