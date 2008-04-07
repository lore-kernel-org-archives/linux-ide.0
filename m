From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream 2/2] libata: move link onlineness check out of softreset
 methods
Date: Tue, 08 Apr 2008 01:46:56 +0900
Message-ID: <47FA5000.8010201@gmail.com>
References: <47FA4AFF.2010209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:4165 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbYDGQrD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Apr 2008 12:47:03 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1523804wff.4
        for <linux-ide@vger.kernel.org>; Mon, 07 Apr 2008 09:47:02 -0700 (PDT)
In-Reply-To: <47FA4AFF.2010209@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>

Currently, SATA softresets should do link onlineness check before
actually performing SRST protocol but it doesn't really belong to
softreset.

This patch moves onlineness check in softreset to ata_eh_reset() and
ata_eh_followup_srst_needed() to clean up code and help future sata_mv
changes which need clear separation between SCR and TF accesses.

sata_fsl is peculiar in that its softreset really isn't softreset but
combination of hardreset and softreset.  This patch adds dummy private
->prereset to keep the current behavior but the driver really should
implement separate hard and soft resets and return -EAGAIN from
hardreset if it should be follwed by softreset.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Jeff, this and the previous patch are on top of the modularize
patchset.  Mark, does this look good enough?  Here's git tree
containing everything.

  http://git.kernel.org/?p=linux/kernel/git/tj/libata-dev.git;a=shortlog;h=for-mlord
  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata-dev.git for-mlord

Thanks.

 drivers/ata/ahci.c        |    6 ------
 drivers/ata/libata-core.c |    4 ++++
 drivers/ata/libata-eh.c   |    2 +-
 drivers/ata/libata-sff.c  |    6 ------
 drivers/ata/pata_bf54x.c  |    6 ------
 drivers/ata/pata_scc.c    |    6 ------
 drivers/ata/sata_fsl.c    |   10 ++++++++++
 drivers/ata/sata_sil24.c  |    7 -------
 8 files changed, 15 insertions(+), 32 deletions(-)

Index: work/drivers/ata/ahci.c
===================================================================
--- work.orig/drivers/ata/ahci.c
+++ work/drivers/ata/ahci.c
@@ -1273,12 +1273,6 @@ static int ahci_softreset(struct ata_lin
 
 	DPRINTK("ENTER\n");
 
-	if (ata_link_offline(link)) {
-		DPRINTK("PHY reports no device\n");
-		*class = ATA_DEV_NONE;
-		return 0;
-	}
-
 	/* prepare for SRST (AHCI-1.1 10.4.1) */
 	rc = ahci_kick_engine(ap, 1);
 	if (rc && rc != -EOPNOTSUPP)
Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -3541,6 +3541,10 @@ int ata_std_prereset(struct ata_link *li
 					"link for reset (errno=%d)\n", rc);
 	}
 
+	/* no point in trying softreset on offline link */
+	if (ata_link_offline(link))
+		ehc->i.action &= ~ATA_EH_SOFTRESET;
+
 	return 0;
 }
 
Index: work/drivers/ata/libata-eh.c
===================================================================
--- work.orig/drivers/ata/libata-eh.c
+++ work/drivers/ata/libata-eh.c
@@ -2065,7 +2065,7 @@ static int ata_eh_followup_srst_needed(s
 				       int rc, int classify,
 				       const unsigned int *classes)
 {
-	if (link->flags & ATA_LFLAG_NO_SRST)
+	if ((link->flags & ATA_LFLAG_NO_SRST) || ata_link_offline(link))
 		return 0;
 	if (rc == -EAGAIN) {
 		if (classify)
Index: work/drivers/ata/libata-sff.c
===================================================================
--- work.orig/drivers/ata/libata-sff.c
+++ work/drivers/ata/libata-sff.c
@@ -1889,11 +1889,6 @@ int ata_sff_softreset(struct ata_link *l
 
 	DPRINTK("ENTER\n");
 
-	if (ata_link_offline(link)) {
-		classes[0] = ATA_DEV_NONE;
-		goto out;
-	}
-
 	/* determine if device 0/1 are present */
 	if (ata_devchk(ap, 0))
 		devmask |= (1 << 0);
@@ -1919,7 +1914,6 @@ int ata_sff_softreset(struct ata_link *l
 		classes[1] = ata_sff_dev_classify(&link->device[1],
 						  devmask & (1 << 1), &err);
 
- out:
 	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
 	return 0;
 }
Index: work/drivers/ata/pata_bf54x.c
===================================================================
--- work.orig/drivers/ata/pata_bf54x.c
+++ work/drivers/ata/pata_bf54x.c
@@ -1103,11 +1103,6 @@ static int bfin_softreset(struct ata_lin
 	unsigned int devmask = 0, err_mask;
 	u8 err;
 
-	if (ata_link_offline(link)) {
-		classes[0] = ATA_DEV_NONE;
-		goto out;
-	}
-
 	/* determine if device 0/1 are present */
 	if (bfin_devchk(ap, 0))
 		devmask |= (1 << 0);
@@ -1132,7 +1127,6 @@ static int bfin_softreset(struct ata_lin
 		classes[1] = ata_sff_dev_classify(&ap->link.device[1],
 					devmask & (1 << 1), &err);
 
- out:
 	return 0;
 }
 
Index: work/drivers/ata/pata_scc.c
===================================================================
--- work.orig/drivers/ata/pata_scc.c
+++ work/drivers/ata/pata_scc.c
@@ -615,11 +615,6 @@ static int scc_softreset(struct ata_link
 
 	DPRINTK("ENTER\n");
 
-	if (ata_link_offline(link)) {
-		classes[0] = ATA_DEV_NONE;
-		goto out;
-	}
-
 	/* determine if device 0/1 are present */
 	if (scc_devchk(ap, 0))
 		devmask |= (1 << 0);
@@ -645,7 +640,6 @@ static int scc_softreset(struct ata_link
 		classes[1] = ata_sff_dev_classify(&ap->link.device[1],
 						  devmask & (1 << 1), &err);
 
- out:
 	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
 	return 0;
 }
Index: work/drivers/ata/sata_fsl.c
===================================================================
--- work.orig/drivers/ata/sata_fsl.c
+++ work/drivers/ata/sata_fsl.c
@@ -678,6 +678,15 @@ static unsigned int sata_fsl_dev_classif
 	return ata_dev_classify(&tf);
 }
 
+static int sata_fsl_prereset(struct ata_linke *link, unsigned long deadline)
+{
+	/* FIXME: Never skip softreset, sata_fsl_softreset() is
+	 * combination of soft and hard resets.  sata_fsl_softreset()
+	 * needs to be splitted into soft and hard resets.
+	 */
+	return 0;
+}
+
 static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
 			      unsigned long deadline)
 {
@@ -1157,6 +1166,7 @@ static const struct ata_port_operations 
 
 	.freeze = sata_fsl_freeze,
 	.thaw = sata_fsl_thaw,
+	.prereset = sata_fsl_prereset,
 	.softreset = sata_fsl_softreset,
 	.post_internal_cmd = sata_fsl_post_internal_cmd,
 
Index: work/drivers/ata/sata_sil24.c
===================================================================
--- work.orig/drivers/ata/sata_sil24.c
+++ work/drivers/ata/sata_sil24.c
@@ -663,12 +663,6 @@ static int sil24_softreset(struct ata_li
 
 	DPRINTK("ENTER\n");
 
-	if (ata_link_offline(link)) {
-		DPRINTK("PHY reports no device\n");
-		*class = ATA_DEV_NONE;
-		goto out;
-	}
-
 	/* put the port into known state */
 	if (sil24_init_port(ap)) {
 		reason = "port not ready";
@@ -693,7 +687,6 @@ static int sil24_softreset(struct ata_li
 	sil24_read_tf(ap, 0, &tf);
 	*class = ata_dev_classify(&tf);
 
- out:
 	DPRINTK("EXIT, class=%u\n", *class);
 	return 0;
 
