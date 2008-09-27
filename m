From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] sata_nv: reinstate nv_hardreset() for non
 generic controllers
Date: Sun, 28 Sep 2008 07:39:01 +0900
Message-ID: <48DEB605.6090504@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48511 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753448AbYI0WlI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 Sep 2008 18:41:08 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org

Commit 2fd673ecf0378ddeeeb87b3605e50212e0c0ddc6 which tried to remove
hardreset for generic accidentally removed it for all flavors as all
others were inheriting from nv_generic_ops.  This patch reinstates
nv_hardreset() and puts it into nv_common_ops which all flavors
inherit from.  nv_generic_ops now inherits from nv_common_ops and
overrides .hardreset to ATA_OP_NULL.

While at it, explain why nv_hardreset and ATA_OP_NULL override are
necessary.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
This fixes the following regression.

  http://bugzilla.kernel.org/show_bug.cgi?id=11615

Jeff, are you off for the vacation already?

Thanks.

 drivers/ata/sata_nv.c |   46 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 1e1f3f3..14601dc 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -309,6 +309,8 @@ static void nv_nf2_freeze(struct ata_port *ap);
 static void nv_nf2_thaw(struct ata_port *ap);
 static void nv_ck804_freeze(struct ata_port *ap);
 static void nv_ck804_thaw(struct ata_port *ap);
+static int nv_hardreset(struct ata_link *link, unsigned int *class,
+			unsigned long deadline);
 static int nv_adma_slave_config(struct scsi_device *sdev);
 static int nv_adma_check_atapi_dma(struct ata_queued_cmd *qc);
 static void nv_adma_qc_prep(struct ata_queued_cmd *qc);
@@ -403,28 +405,45 @@ static struct scsi_host_template nv_swncq_sht = {
 	.slave_configure	= nv_swncq_slave_config,
 };
 
-static struct ata_port_operations nv_generic_ops = {
+/* OSDL bz3352 reports that some nv controllers can't determine device
+ * signature reliably and nv_hardreset is implemented to work around
+ * the problem.  This was reported on nf3 and it's unclear whether any
+ * other controllers are affected.  However, the workaround has been
+ * applied to all variants and there isn't much to gain by trying to
+ * find out exactly which ones are affected at this point especially
+ * because NV has moved over to ahci for newer controllers.
+ */
+static struct ata_port_operations nv_common_ops = {
 	.inherits		= &ata_bmdma_port_ops,
-	.hardreset		= ATA_OP_NULL,
+	.hardreset		= nv_hardreset,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
 };
 
+/* OSDL bz11195 reports that link doesn't come online after hardreset
+ * on generic nv's and there have been several other similar reports
+ * on linux-ide.  Disable hardreset for generic nv's.
+ */
+static struct ata_port_operations nv_generic_ops = {
+	.inherits		= &nv_common_ops,
+	.hardreset		= ATA_OP_NULL,
+};
+
 static struct ata_port_operations nv_nf2_ops = {
-	.inherits		= &nv_generic_ops,
+	.inherits		= &nv_common_ops,
 	.freeze			= nv_nf2_freeze,
 	.thaw			= nv_nf2_thaw,
 };
 
 static struct ata_port_operations nv_ck804_ops = {
-	.inherits		= &nv_generic_ops,
+	.inherits		= &nv_common_ops,
 	.freeze			= nv_ck804_freeze,
 	.thaw			= nv_ck804_thaw,
 	.host_stop		= nv_ck804_host_stop,
 };
 
 static struct ata_port_operations nv_adma_ops = {
-	.inherits		= &nv_generic_ops,
+	.inherits		= &nv_common_ops,
 
 	.check_atapi_dma	= nv_adma_check_atapi_dma,
 	.sff_tf_read		= nv_adma_tf_read,
@@ -448,7 +467,7 @@ static struct ata_port_operations nv_adma_ops = {
 };
 
 static struct ata_port_operations nv_swncq_ops = {
-	.inherits		= &nv_generic_ops,
+	.inherits		= &nv_common_ops,
 
 	.qc_defer		= ata_std_qc_defer,
 	.qc_prep		= nv_swncq_qc_prep,
@@ -1586,6 +1605,21 @@ static void nv_mcp55_thaw(struct ata_port *ap)
 	ata_sff_thaw(ap);
 }
 
+static int nv_hardreset(struct ata_link *link, unsigned int *class,
+			unsigned long deadline)
+{
+	int rc;
+
+	/* SATA hardreset fails to retrieve proper device signature on
+	 * some controllers.  Request follow up SRST.  For more info,
+	 * see http://bugzilla.kernel.org/show_bug.cgi?id=3352
+	 */
+	rc = sata_sff_hardreset(link, class, deadline);
+	if (rc)
+		return rc;
+	return -EAGAIN;
+}
+
 static void nv_adma_error_handler(struct ata_port *ap)
 {
 	struct nv_adma_port_priv *pp = ap->private_data;
