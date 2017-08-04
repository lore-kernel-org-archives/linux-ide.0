From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 8/9] ata: ceva: Correct the suspend and resume logic for SATA
Date: Fri,  4 Aug 2017 15:18:17 +0200
Message-ID: <8eed38d9029410035e49b6a5e846923d8eebbbd0.1501852693.git.michal.simek@xilinx.com>
References: <cover.1501852693.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1501852693.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1501852693.git.michal.simek@xilinx.com>
References: <cover.1501852693.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Alexander Graf <agraf@suse.de>, Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>

The present suspend code disables the port interrupts
and stops the HBA. On resume it enables the interrupts and HBA.
This works fine until the FPD power domain is not off.
If FPD is off then the ceva vendor specific configurations like
OOB, AXI settings are lost, they need to be re-programmed and
also since SERDES is also in FPD , SATA lane phy init needs to
be called again (which is not happening in the present sequence)
Because of this incorrect sequence SATA fails to work on resume.

This patch corrects the code to make Suspend & Resume work in normal
and FPD off cases.

Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
Reviewed-by: Shubhrajyoti Datta <shubhraj@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/ata/ahci_ceva.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index 113c1f617da9..c0742cbe4faa 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -298,12 +298,37 @@ static int ceva_ahci_probe(struct platform_device *pdev)
 
 static int __maybe_unused ceva_ahci_suspend(struct device *dev)
 {
-	return ahci_platform_suspend_host(dev);
+	return ahci_platform_suspend(dev);
 }
 
 static int __maybe_unused ceva_ahci_resume(struct device *dev)
 {
-	return ahci_platform_resume_host(dev);
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host->private_data;
+	int rc;
+
+	rc = ahci_platform_enable_resources(hpriv);
+	if (rc)
+		return rc;
+
+	/* Configure CEVA specific config before resuming HBA */
+	ahci_ceva_setup(hpriv);
+
+	rc = ahci_platform_resume_host(dev);
+	if (rc)
+		goto disable_resources;
+
+	/* We resumed so update PM runtime state */
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	return 0;
+
+disable_resources:
+	ahci_platform_disable_resources(hpriv);
+
+	return rc;
 }
 
 static SIMPLE_DEV_PM_OPS(ahci_ceva_pm_ops, ceva_ahci_suspend, ceva_ahci_resume);
-- 
1.9.1
