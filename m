From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/2 #upstream-fixes] sata_nv: rename nv_nf2_hardreset()
Date: Sun, 25 Jan 2009 11:25:22 +0900
Message-ID: <497BCD92.2050707@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48917 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755204AbZAYCZd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Jan 2009 21:25:33 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Robert Hancock <hancockr@shaw.ca>, gpanco@tiscali.it

nv_nf2_hardreset() will be used by other flavors too.  Rename it to
nv_noclassify_hardreset().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/sata_nv.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

Index: work1/drivers/ata/sata_nv.c
===================================================================
--- work1.orig/drivers/ata/sata_nv.c
+++ work1/drivers/ata/sata_nv.c
@@ -305,10 +305,10 @@ static irqreturn_t nv_ck804_interrupt(in
 static int nv_scr_read(struct ata_link *link, unsigned int sc_reg, u32 *val);
 static int nv_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val);
 
+static int nv_noclassify_hardreset(struct ata_link *link, unsigned int *class,
+				   unsigned long deadline);
 static void nv_nf2_freeze(struct ata_port *ap);
 static void nv_nf2_thaw(struct ata_port *ap);
-static int nv_nf2_hardreset(struct ata_link *link, unsigned int *class,
-			    unsigned long deadline);
 static void nv_ck804_freeze(struct ata_port *ap);
 static void nv_ck804_thaw(struct ata_port *ap);
 static int nv_adma_slave_config(struct scsi_device *sdev);
@@ -432,7 +432,7 @@ static struct ata_port_operations nv_nf2
 	.inherits		= &nv_common_ops,
 	.freeze			= nv_nf2_freeze,
 	.thaw			= nv_nf2_thaw,
-	.hardreset		= nv_nf2_hardreset,
+	.hardreset		= nv_noclassify_hardreset,
 };
 
 /* CK804 finally gets hardreset right */
@@ -1530,6 +1530,17 @@ static int nv_scr_write(struct ata_link
 	return 0;
 }
 
+static int nv_noclassify_hardreset(struct ata_link *link, unsigned int *class,
+				   unsigned long deadline)
+{
+	bool online;
+	int rc;
+
+	rc = sata_link_hardreset(link, sata_deb_timing_hotplug, deadline,
+				 &online, NULL);
+	return online ? -EAGAIN : rc;
+}
+
 static void nv_nf2_freeze(struct ata_port *ap)
 {
 	void __iomem *scr_addr = ap->host->ports[0]->ioaddr.scr_addr;
@@ -1554,17 +1565,6 @@ static void nv_nf2_thaw(struct ata_port
 	iowrite8(mask, scr_addr + NV_INT_ENABLE);
 }
 
-static int nv_nf2_hardreset(struct ata_link *link, unsigned int *class,
-			    unsigned long deadline)
-{
-	bool online;
-	int rc;
-
-	rc = sata_link_hardreset(link, sata_deb_timing_hotplug, deadline,
-				 &online, NULL);
-	return online ? -EAGAIN : rc;
-}
-
 static void nv_ck804_freeze(struct ata_port *ap)
 {
 	void __iomem *mmio_base = ap->host->iomap[NV_MMIO_BAR];
