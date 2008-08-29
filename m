From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] sata_nv: disable hardreset for generic
Date: Fri, 29 Aug 2008 16:13:12 +0200
Message-ID: <48B803F8.8000306@kernel.org>
References: <4895407B.5030602@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58494 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756310AbYH2OQc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Aug 2008 10:16:32 -0400
In-Reply-To: <4895407B.5030602@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux@sun7.cn, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Peer Chen <pchen@nvidia.com>, Kuan Luo <kluo@nvidia.com>

>From 2.6.26, libata is defaulting to hardreset for various reasons one
of them being unifying probing, hotplug and EH reset paths uniform.
Previously, broken hardreset could go unnoticed as it wasn't used
during probing but when something goes wrong or after hotplug the
problem will surface and bite hard.

OSDL bug 11195 reports that sata_nv generic flavor falls into this
category.  Hardreset itself succeeds but PHY stays offline after
hardreset.  I tried longer debounce timing but the result was the
same.

  http://bugzilla.kernel.org/show_bug.cgi?id=11195

So, it seems we'll have to drop hardreset from the generic flavor.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Peer Chen <pchen@nvidia.com>
---
There have been more than three reports of this problem and there just
isn't good reason to defer this workaround anymore.  Once this gets
into #upstream-fixes, I think this should go to -stable too.

Thanks.

 drivers/ata/sata_nv.c |   19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 858f706..1e1f3f3 100644
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
@@ -407,7 +405,7 @@ static struct scsi_host_template nv_swncq_sht = {
 
 static struct ata_port_operations nv_generic_ops = {
 	.inherits		= &ata_bmdma_port_ops,
-	.hardreset		= nv_hardreset,
+	.hardreset		= ATA_OP_NULL,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
 };
@@ -1588,21 +1586,6 @@ static void nv_mcp55_thaw(struct ata_port *ap)
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
