From: Shawn Guo <shawn.guo@freescale.com>
Subject: [PATCH 2/2] ahci: imx: software workaround for phy reset issue in resume
Date: Tue, 15 Apr 2014 10:41:43 +0800
Message-ID: <1397529703-21165-2-git-send-email-shawn.guo@freescale.com>
References: <1397529703-21165-1-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from co9ehsobe001.messaging.microsoft.com ([207.46.163.24]:8296 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750932AbaDOCmQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Apr 2014 22:42:16 -0400
In-Reply-To: <1397529703-21165-1-git-send-email-shawn.guo@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>, Richard Zhu <r65037@freescale.com>

When suspending imx6q systems which have rootfs on SATA, the following
error will likely be seen in resume.  The SATA link will fail to come
up, and it results in an unusable system across the suspend/resume
cycle.

$ echo mem > /sys/power/state
PM: Syncing filesystems ... done.
PM: Preparing system for mem sleep
Freezing user space processes ... (elapsed 0.002 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
PM: Entering mem sleep
sd 0:0:0:0: [sda] Synchronizing SCSI cache
sd 0:0:0:0: [sda] Stopping disk
PM: suspend of devices complete after 61.914 msecs
PM: suspend devices took 0.070 seconds
PM: late suspend of devices complete after 4.906 msecs
PM: noirq suspend of devices complete after 4.521 msecs
Disabling non-boot CPUs ...
CPU1: shutdown
CPU2: shutdown
CPU3: shutdown
Enabling non-boot CPUs ...
CPU1: Booted secondary processor
CPU1 is up
CPU2: Booted secondary processor
CPU2 is up
CPU3: Booted secondary processor
CPU3 is up
PM: noirq resume of devices complete after 10.486 msecs
PM: early resume of devices complete after 4.679 msecs
sd 0:0:0:0: [sda] Starting disk
PM: resume of devices complete after 22.674 msecs
PM: resume devices took 0.030 seconds
PM: Finishing wakeup.
Restarting tasks ... done.
$ ata1: SATA link down (SStatus 1 SControl 300)
ata1: SATA link down (SStatus 1 SControl 300)
ata1: limiting SATA link speed to 1.5 Gbps
ata1: SATA link down (SStatus 1 SControl 310)
ata1.00: disabled
ata1: exception Emask 0x10 SAct 0x0 SErr 0x4040000 action 0xe frozen t4
ata1: irq_stat 0x00000040, connection status changed
ata1: SError: { CommWake DevExch }
ata1: hard resetting link
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: killing request
sd 0:0:0:0: rejecting I/O to offline device
Aborting journal on device sda2-8.
sd 0:0:0:0: rejecting I/O to offline device
EXT4-fs warning (device sda2): ext4_end_bio:317: I/O error writing to inode 132577 (offset 0 size 0 starting block 26235)
Buffer I/O error on device sda2, logical block 10169
...

It's caused by a silicon issue that SATA phy does not get reset by
controller when coming back from LPM.  The patch adds a software
workaround for this issue.  It enforces a software reset on SATA phy
in imx_sata_enable() function, so that we can ensure SATA link will
come up properly in both power-on and resume.

The software reset is implemented by writing phy reset register through
the phy control register bus interface.  Functions
imx_phy_reg_[addressing|write|read]() implement this bus interface, while
imx_sata_phy_reset() performs the actually reset operation.

Signed-off-by: Richard Zhu <r65037@freescale.com>
Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 drivers/ata/ahci_imx.c | 175 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 175 insertions(+)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 39629b4..7d4756d 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -31,6 +31,18 @@
 #define IMX_SATA_TIMER1MS			0x00e0
 #define IMX_SATA_P0PHYCR			0x0178
 #define  P0PHYCR_TEST_PDDQ			(1 << 20)
+#define  P0PHYCR_CR_READ			(1 << 19)
+#define  P0PHYCR_CR_WRITE			(1 << 18)
+#define  P0PHYCR_CR_CAP_DATA			(1 << 17)
+#define  P0PHYCR_CR_CAP_ADDR			(1 << 16)
+#define IMX_SATA_P0PHYSR			0x017c
+#define  P0PHYSR_CR_ACK				(1 << 18)
+#define  P0PHYSR_CR_DATA_OUT			0xffff
+
+#define IMX_PHY_LANE0_OUT_STAT			0x2003
+#define  LANE0_OUT_STAT_RX_PLL_STATE		(1 << 1)
+#define IMX_PHY_CLOCK_RESET			0x7f3f
+#define  CLOCK_RESET_RESET			(1 << 0)
 
 enum ahci_imx_type {
 	AHCI_IMX53,
@@ -52,9 +64,165 @@ MODULE_PARM_DESC(hotplug, "AHCI IMX hot-plug support (0=Don't support, 1=support
 
 static void ahci_imx_host_stop(struct ata_host *host);
 
+static int imx_phy_ack_polling(void __iomem *mmio, bool assert)
+{
+	int timeout = 100;
+	u32 srval;
+
+	do {
+		srval = readl(mmio + IMX_SATA_P0PHYSR);
+		if ((assert ? srval : ~srval) & P0PHYSR_CR_ACK)
+			break;
+		usleep_range(100, 200);
+	} while (--timeout);
+
+	return timeout ? 0 : -ETIMEDOUT;
+}
+
+static int imx_phy_reg_addressing(u16 addr, void __iomem *mmio)
+{
+	u32 crval = addr;
+	int ret;
+
+	/* 1. Supply the address on cr_data_in */
+	writel(crval, mmio + IMX_SATA_P0PHYCR);
+
+	/* 2. Assert the cr_cap_addr signal */
+	crval |= P0PHYCR_CR_CAP_ADDR;
+	writel(crval, mmio + IMX_SATA_P0PHYCR);
+
+	/* 3. Wait for the cr_ack signal to be asserted */
+	ret = imx_phy_ack_polling(mmio, true);
+	if (ret)
+		return ret;
+
+	/* 4. Deassert cr_cap_addr */
+	crval &= ~P0PHYCR_CR_CAP_ADDR;
+	writel(crval, mmio + IMX_SATA_P0PHYCR);
+
+	/* 5. Wait for cr_ack to be deasserted */
+	ret = imx_phy_ack_polling(mmio, false);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int imx_phy_reg_write(u16 val, void __iomem *mmio)
+{
+	u32 crval = val;
+	int ret;
+
+	/* 1. Supply the data on cr_data_in */
+	writel(crval, mmio + IMX_SATA_P0PHYCR);
+
+	/* 2. Assert the cr_cap_data signal */
+	crval |= P0PHYCR_CR_CAP_DATA;
+	writel(crval, mmio + IMX_SATA_P0PHYCR);
+
+	/* 3. Wait for the cr_ack signal to be asserted */
+	ret = imx_phy_ack_polling(mmio, true);
+	if (ret)
+		return ret;
+
+	/* 4. Deassert cr_cap_data */
+	crval &= ~P0PHYCR_CR_CAP_DATA;
+	writel(crval, mmio + IMX_SATA_P0PHYCR);
+
+	/* 5. Wait for cr_ack to be deasserted */
+	ret = imx_phy_ack_polling(mmio, false);
+	if (ret)
+		return ret;
+
+	/* 6. Assert the cr_write signal */
+	crval |= P0PHYCR_CR_WRITE;
+	writel(crval, mmio + IMX_SATA_P0PHYCR);
+
+	/* 7. Wait for cr_ack to be asserted */
+	ret = imx_phy_ack_polling(mmio, true);
+	if (ret)
+		return ret;
+
+	/* 8. Deassert cr_write */
+	crval &= ~P0PHYCR_CR_WRITE;
+	writel(crval, mmio + IMX_SATA_P0PHYCR);
+
+	/* 9. Wait for cr_ack to be deasserted */
+	ret = imx_phy_ack_polling(mmio, false);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int imx_phy_reg_read(u16 *val, void __iomem *mmio)
+{
+	u32 crval = 0;
+	int ret;
+
+	/* 1. Assert the cr_read signal */
+	crval |= P0PHYCR_CR_READ;
+	writel(crval, mmio + IMX_SATA_P0PHYCR);
+
+	/* 2. Wait for the cr_ack signal to be asserted */
+	ret = imx_phy_ack_polling(mmio, true);
+	if (ret)
+		return ret;
+
+	/* 3. Capture the data from cr_data_out[] */
+	*val = readl(mmio + IMX_SATA_P0PHYSR) & P0PHYSR_CR_DATA_OUT;
+
+	/* 4. Deassert cr_read */
+	crval &= ~P0PHYCR_CR_READ;
+	writel(crval, mmio + IMX_SATA_P0PHYCR);
+
+	/* 5. Wait for cr_ack to be deasserted */
+	ret = imx_phy_ack_polling(mmio, false);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int imx_sata_phy_reset(struct ahci_host_priv *hpriv)
+{
+	void __iomem *mmio = hpriv->mmio;
+	int timeout = 10;
+	u16 val;
+	int ret;
+
+	/* Reset SATA PHY by setting RESET bit of PHY register CLOCK_RESET */
+	ret = imx_phy_reg_addressing(IMX_PHY_CLOCK_RESET, mmio);
+	if (ret)
+		return ret;
+	/*
+	 * For phy reset operation, we skip the timeout checking, because phy
+	 * will be unable to acknowledge in this case.
+	 */
+	imx_phy_reg_write(CLOCK_RESET_RESET, mmio);
+
+	usleep_range(100, 200);
+
+	/* Wait for PHY RX_PLL to be stable */
+	do {
+		ret = imx_phy_reg_addressing(IMX_PHY_LANE0_OUT_STAT, mmio);
+		if (ret)
+			return ret;
+		ret = imx_phy_reg_read(&val, mmio);
+		if (ret)
+			return ret;
+		if (val & LANE0_OUT_STAT_RX_PLL_STATE)
+			break;
+		usleep_range(100, 200);
+	} while (--timeout);
+
+	return timeout ? 0 : -ETIMEDOUT;
+}
+
 static int imx_sata_enable(struct ahci_host_priv *hpriv)
 {
 	struct imx_ahci_priv *imxpriv = hpriv->plat_data;
+	struct device *dev = &imxpriv->ahci_pdev->dev;
 	int ret;
 
 	if (imxpriv->no_device)
@@ -99,6 +267,12 @@ static int imx_sata_enable(struct ahci_host_priv *hpriv)
 		regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
 				   IMX6Q_GPR13_SATA_MPLL_CLK_EN,
 				   IMX6Q_GPR13_SATA_MPLL_CLK_EN);
+
+		ret = imx_sata_phy_reset(hpriv);
+		if (ret) {
+			dev_err(dev, "failed to reset phy: %d\n", ret);
+			goto disable_regulator;
+		}
 	}
 
 	usleep_range(1000, 2000);
@@ -215,6 +389,7 @@ static int imx_ahci_probe(struct platform_device *pdev)
 	if (!imxpriv)
 		return -ENOMEM;
 
+	imxpriv->ahci_pdev = pdev;
 	imxpriv->no_device = false;
 	imxpriv->first_time = true;
 	imxpriv->type = (enum ahci_imx_type)of_id->data;
-- 
1.8.3.2


