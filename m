From: Daniel Walker <danielwa@cisco.com>
Subject: [PATCH 1/2] drivers: pata_octeon_cf : Switch IO mode depending on model number
Date: Thu,  7 Jan 2016 21:18:51 -0800
Message-ID: <1452230332-14926-1-git-send-email-danielwa@cisco.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>
Cc: Anil Veliyankara Madam <aveliyan@cisco.com>, xe-kernel@external.cisco.com, Shikha Jain <shikjain@cisco.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Anil Veliyankara Madam <aveliyan@cisco.com>

Since viking flash has a problem in the MWDMA mode which causes data
corruption, this patch allows the driver to detect the model number
and switch the IO mode to PIO6 if it's a viking flash.

Cc: xe-kernel@external.cisco.com
Signed-off-by: Anil Veliyankara Madam <aveliyan@cisco.com>
Signed-off-by: Shikha Jain <shikjain@cisco.com>
---
 drivers/ata/pata_octeon_cf.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index 2724595..9d05bc9 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -826,6 +826,30 @@ static unsigned int octeon_cf_qc_issue(struct ata_queued_cmd *qc)
 	return 0;
 }
 
+static unsigned long octeon_cf_mode_filter(struct ata_device *dev,
+						unsigned long mask)
+{
+	const char viking_model_num[] = "VRFDFC22048UCHC-TE";
+	unsigned char model_num[ATA_ID_PROD_LEN + 1];
+
+	if (dev->class != ATA_DEV_ATA)
+		return mask;
+
+	ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
+	/*
+	 * Viking flash with SMI controller causes read errors in
+	 * MWDMA modes.  Force PIO mode.
+	 */
+	if (strncmp(model_num, viking_model_num,
+				strlen(viking_model_num)) == 0) {
+		DPRINTK("Viking flash with SMI controller detected.");
+		DPRINTK("Forcing PIO mode.\n");
+		mask &= ATA_MASK_PIO;
+	}
+
+	return mask;
+}
+
 static struct ata_port_operations octeon_cf_ops = {
 	.inherits		= &ata_sff_port_ops,
 	.check_atapi_dma	= octeon_cf_check_atapi_dma,
@@ -835,6 +859,7 @@ static struct ata_port_operations octeon_cf_ops = {
 	.sff_irq_on		= octeon_cf_ata_port_noaction,
 	.sff_irq_clear		= octeon_cf_ata_port_noaction,
 	.cable_detect		= ata_cable_40wire,
+	.mode_filter		= octeon_cf_mode_filter,
 	.set_piomode		= octeon_cf_set_piomode,
 	.set_dmamode		= octeon_cf_set_dmamode,
 	.dev_config		= octeon_cf_dev_config,
-- 
2.1.4
