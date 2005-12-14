From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 2.6.14.3] Necessary evil to get sata_vsc to initialize with Intel iq3124h hba
Date: Wed, 14 Dec 2005 13:10:49 -0700
Message-ID: <20051214201049.GA20640@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr13.intel.com ([192.55.52.67]:55276 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S964862AbVLNUKz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Dec 2005 15:10:55 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jeremy@sgi.com

* libata does not care about error interrupts, so handle them locally
* the interrupts that are ignored only appear to happen at init time

Signed-off-by: Dan Williams <dan.j.williams@intel.com>

---

 drivers/scsi/sata_vsc.c |   30 +++++++++++++++++++++++++++++-
 1 files changed, 29 insertions(+), 1 deletions(-)

applies-to: 90d8277c8775f3c09655df3b48c37fe07504d162
710b992dc354832bb854b9fb05c8fc73c15664d8
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index cf94e01..7dcc486 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -81,6 +81,19 @@
 /* Port stride */
 #define VSC_SATA_PORT_OFFSET		0x200
 
+/* Error interrupt status bit offsets */
+#define VSC_SATA_INT_ERROR_E_OFFSET	2
+#define VSC_SATA_INT_ERROR_P_OFFSET	4
+#define VSC_SATA_INT_ERROR_T_OFFSET	5
+#define VSC_SATA_INT_ERROR_M_OFFSET	1
+#define is_vsc_sata_int_err(port_idx, int_status) \
+	 (int_status & ((1 << (VSC_SATA_INT_ERROR_E_OFFSET + (8 * port_idx))) | \
+		        (1 << (VSC_SATA_INT_ERROR_P_OFFSET + (8 * port_idx))) | \
+		        (1 << (VSC_SATA_INT_ERROR_T_OFFSET + (8 * port_idx))) | \
+		        (1 << (VSC_SATA_INT_ERROR_M_OFFSET + (8 * port_idx)))   \
+		       )\
+ 	 )
+
 
 static u32 vsc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
@@ -193,13 +206,28 @@ static irqreturn_t vsc_sata_interrupt (i
 			struct ata_port *ap;
 
 			ap = host_set->ports[i];
+
+			if (is_vsc_sata_int_err(i, int_status)) {
+				u32 err_status;
+				printk(KERN_DEBUG "%s: ignoring interrupt(s)\n", __FUNCTION__);
+				err_status = ap ? vsc_sata_scr_read(ap, SCR_ERROR) : 0;
+				vsc_sata_scr_write(ap, SCR_ERROR, err_status);
+				handled++;
+			}
+
 			if (ap && !(ap->flags &
 				    (ATA_FLAG_PORT_DISABLED|ATA_FLAG_NOINTR))) {
 				struct ata_queued_cmd *qc;
 
 				qc = ata_qc_from_tag(ap, ap->active_tag);
-				if (qc && (!(qc->tf.ctl & ATA_NIEN)))
+				if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
 					handled += ata_host_intr(ap, qc);
+				} else {
+					printk(KERN_DEBUG "%s: ignoring interrupt(s)\n", __FUNCTION__);
+					ata_chk_status(ap);
+					handled++;
+				}
+
 			}
 		}
 	}
---
0.99.9a

