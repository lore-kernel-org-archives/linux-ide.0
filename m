From: Tejun Heo <tj@kernel.org>
Subject: Can you please test the attached patch for nv hardreset problem?
Date: Sun, 05 Oct 2008 09:49:21 +0900
Message-ID: <48E80F11.3060101@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040404060404070906000207"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37746 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754053AbYJEAv2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 4 Oct 2008 20:51:28 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, lists@ku-gbr.de, linux@sun7.cn, gettinther@gmail.com
Cc: Robert Hancock <hancockr@shaw.ca>

This is a multi-part message in MIME format.
--------------040404060404070906000207
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

Please verify whether the attached patch fixes all hardreset / probing
related issues.  The patch is on top of v2.6.27-rc8.  Sorry about all
the mess but it was quite a confusing problem.  Here's what went down.

* During 2.6.27-rcX, libata switched to prefer hardreset.

* Which broke, generic flavor of sata_nv.  Some sata_nv's fail to
  bring the link up after hardreset.

* A fix patch went in to disable hardreset for generic flavor.  But it
  accidentaly disabled hardreset for all flavors.

* Which broke nf2/3 and CK804, because their hotplug interrupt bits
  never get cleared.  They're apparently cleared by hardreset
  sequence.

* Another fix patch went in to reinstate nv_hardreset for nf2/3 and
  CK804.

* Which broke nf2/3, which was because nf2/3's hardreset was broken in
  different way.

So, to sum up, each generation of sata_nv controllers exhibits
different hardreset behaviors.

* generic: doesn't work.

* nf2/3: signature D2H Reg FIS delivery doesn't work.

* ck804: works.

So, all three require different treatments to prefer hardreset and any
solution which didn't do that was broken.  The attached patch should
solve all the problems.

It was messy but this at least fixes hardreset for all flavors of nv
controllers, so it will generally improve reliability.

Thanks.

-- 
tejun

--------------040404060404070906000207
Content-Type: text/x-patch;
 name="nv-hardreset.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nv-hardreset.patch"

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 14601dc..ce77619 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -309,8 +309,6 @@ static void nv_nf2_freeze(struct ata_port *ap);
 static void nv_nf2_thaw(struct ata_port *ap);
 static void nv_ck804_freeze(struct ata_port *ap);
 static void nv_ck804_thaw(struct ata_port *ap);
-static int nv_hardreset(struct ata_link *link, unsigned int *class,
-			unsigned long deadline);
 static int nv_adma_slave_config(struct scsi_device *sdev);
 static int nv_adma_check_atapi_dma(struct ata_queued_cmd *qc);
 static void nv_adma_qc_prep(struct ata_queued_cmd *qc);
@@ -405,17 +403,8 @@ static struct scsi_host_template nv_swncq_sht = {
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
@@ -429,12 +418,17 @@ static struct ata_port_operations nv_generic_ops = {
 	.hardreset		= ATA_OP_NULL,
 };
 
+/* OSDL bz3352 reports that nf2/3 controllers can't determine device
+ * signature reliably.  Use sata_std_hardreset().
+ */
 static struct ata_port_operations nv_nf2_ops = {
 	.inherits		= &nv_common_ops,
 	.freeze			= nv_nf2_freeze,
 	.thaw			= nv_nf2_thaw,
+	.hardreset		= sata_std_hardreset,
 };
 
+/* CK804 finally gets hardreset right */
 static struct ata_port_operations nv_ck804_ops = {
 	.inherits		= &nv_common_ops,
 	.freeze			= nv_ck804_freeze,
@@ -443,7 +437,7 @@ static struct ata_port_operations nv_ck804_ops = {
 };
 
 static struct ata_port_operations nv_adma_ops = {
-	.inherits		= &nv_common_ops,
+	.inherits		= &nv_ck804_ops,
 
 	.check_atapi_dma	= nv_adma_check_atapi_dma,
 	.sff_tf_read		= nv_adma_tf_read,
@@ -467,7 +461,7 @@ static struct ata_port_operations nv_adma_ops = {
 };
 
 static struct ata_port_operations nv_swncq_ops = {
-	.inherits		= &nv_common_ops,
+	.inherits		= &nv_generic_ops,
 
 	.qc_defer		= ata_std_qc_defer,
 	.qc_prep		= nv_swncq_qc_prep,
@@ -1605,21 +1599,6 @@ static void nv_mcp55_thaw(struct ata_port *ap)
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

--------------040404060404070906000207--
