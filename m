From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] sata_nv: fix generic, nf2/3 detection regression
Date: Mon, 03 Nov 2008 12:14:11 +0900
Message-ID: <490E6C83.3010309@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56269 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754303AbYKCDOm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Nov 2008 22:14:42 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, stable@kernel.org, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

All three flavors of sata_nv's are different in how their hardreset
behaves.

* generic: Hardreset is not reliable.  Link often doesn't come online
  after hardreset.

* nf2/3: A little bit better - link comes online.  However, nf2/3
  can't reliable wait for the first D2H Register FIS, so it can't wait
  for device readiness or classify the device after hardreset.
  Follow-up SRST required.

* ck804: Hardreset finally works.

The core layer change to prefer hardreset and follow up changes
exposed the above issues and caused various detection regressions for
all three flavors.  This patch, hopefully, fixes all the known issues
and should make sata_nv error handling more reliable.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/sata_nv.c |   48 ++++++++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index fae3841..f734dd0 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -307,10 +307,10 @@ static int nv_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val);
 
 static void nv_nf2_freeze(struct ata_port *ap);
 static void nv_nf2_thaw(struct ata_port *ap);
+static int nv_nf2_hardreset(struct ata_link *link, unsigned int *class,
+			    unsigned long deadline);
 static void nv_ck804_freeze(struct ata_port *ap);
 static void nv_ck804_thaw(struct ata_port *ap);
-static int nv_hardreset(struct ata_link *link, unsigned int *class,
-			unsigned long deadline);
 static int nv_adma_slave_config(struct scsi_device *sdev);
 static int nv_adma_check_atapi_dma(struct ata_queued_cmd *qc);
 static void nv_adma_qc_prep(struct ata_queued_cmd *qc);
@@ -405,17 +405,8 @@ static struct scsi_host_template nv_swncq_sht = {
 	.slave_configure	= nv_swncq_slave_config,
 };
 
-/* OSDL bz3352 reports that some nv controllers can't determine device
- * signature reliably and nv_hardreset is implemented to work around
- * the problem.  This was reported on nf3 and it's unclear whether any
- * other controllers are affected.  However, the workaround has been
- * applied to all variants and there isn't much to gain by trying to
- * find out exactly which ones are affected at this point especially
- * because NV has moved over to ahci for newer controllers.
- */
 static struct ata_port_operations nv_common_ops = {
 	.inherits		= &ata_bmdma_port_ops,
-	.hardreset		= nv_hardreset,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
 };
@@ -429,12 +420,17 @@ static struct ata_port_operations nv_generic_ops = {
 	.hardreset		= ATA_OP_NULL,
 };
 
+/* OSDL bz3352 reports that nf2/3 controllers can't determine device
+ * signature reliably.  Use sata_std_hardreset().
+ */
 static struct ata_port_operations nv_nf2_ops = {
 	.inherits		= &nv_common_ops,
 	.freeze			= nv_nf2_freeze,
 	.thaw			= nv_nf2_thaw,
+	.hardreset		= nv_nf2_hardreset,
 };
 
+/* CK804 finally gets hardreset right */
 static struct ata_port_operations nv_ck804_ops = {
 	.inherits		= &nv_common_ops,
 	.freeze			= nv_ck804_freeze,
@@ -443,7 +439,7 @@ static struct ata_port_operations nv_ck804_ops = {
 };
 
 static struct ata_port_operations nv_adma_ops = {
-	.inherits		= &nv_common_ops,
+	.inherits		= &nv_ck804_ops,
 
 	.check_atapi_dma	= nv_adma_check_atapi_dma,
 	.sff_tf_read		= nv_adma_tf_read,
@@ -467,7 +463,7 @@ static struct ata_port_operations nv_adma_ops = {
 };
 
 static struct ata_port_operations nv_swncq_ops = {
-	.inherits		= &nv_common_ops,
+	.inherits		= &nv_generic_ops,
 
 	.qc_defer		= ata_std_qc_defer,
 	.qc_prep		= nv_swncq_qc_prep,
@@ -1553,6 +1549,17 @@ static void nv_nf2_thaw(struct ata_port *ap)
 	iowrite8(mask, scr_addr + NV_INT_ENABLE);
 }
 
+static int nv_nf2_hardreset(struct ata_link *link, unsigned int *class,
+			    unsigned long deadline)
+{
+	bool online;
+	int rc;
+
+	rc = sata_link_hardreset(link, sata_deb_timing_hotplug, deadline,
+				 &online, NULL);
+	return online ? -EAGAIN : rc;
+}
+
 static void nv_ck804_freeze(struct ata_port *ap)
 {
 	void __iomem *mmio_base = ap->host->iomap[NV_MMIO_BAR];
@@ -1605,21 +1612,6 @@ static void nv_mcp55_thaw(struct ata_port *ap)
 	ata_sff_thaw(ap);
 }
 
-static int nv_hardreset(struct ata_link *link, unsigned int *class,
-			unsigned long deadline)
-{
-	int rc;
-
-	/* SATA hardreset fails to retrieve proper device signature on
-	 * some controllers.  Request follow up SRST.  For more info,
-	 * see http://bugzilla.kernel.org/show_bug.cgi?id=3352
-	 */
-	rc = sata_sff_hardreset(link, class, deadline);
-	if (rc)
-		return rc;
-	return -EAGAIN;
-}
-
 static void nv_adma_error_handler(struct ata_port *ap)
 {
 	struct nv_adma_port_priv *pp = ap->private_data;
