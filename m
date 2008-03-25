From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 15/27] libata: move generic hardreset code from sata_sff_hardreset() to sata_link_hardreset()
Date: Tue, 25 Mar 2008 22:16:53 +0900
Message-ID: <12064510273824-git-send-email-htejun@gmail.com>
References: <1206451025926-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:16486 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754823AbYCYNRj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:17:39 -0400
Received: by wr-out-0506.google.com with SMTP id c48so2257952wra.1
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:17:39 -0700 (PDT)
In-Reply-To: <1206451025926-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com
Cc: Tejun Heo <htejun@gmail.com>

sata_sff_hardreset() contains link readiness wait logic which isn't
SFF specific.  Move that part into sata_link_hardreset(), which now
takes two more parameters - @online and @check_ready.  Both are
optional.  The former is out parameter for link onlineness after
reset.  The latter is used to wait for link readiness after hardreset.

Users of sata_link_hardreset() is updated to use new funtionality and
ahci_hardreset() is updated to use sata_link_hardreset() instead of
sata_sff_hardreset().  This doesn't really cause any behavior change.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c        |   35 ++++++++++++++++++-------------
 drivers/ata/ata_piix.c    |    2 +-
 drivers/ata/libata-core.c |   50 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/ata/libata-pmp.c  |    7 +++--
 drivers/ata/libata-sff.c  |   49 ++++++++------------------------------------
 include/linux/libata.h    |   10 ++++++++-
 6 files changed, 92 insertions(+), 61 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 7e251a2..0f553aa 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1343,10 +1343,12 @@ static int ahci_softreset(struct ata_link *link, unsigned int *class,
 static int ahci_hardreset(struct ata_link *link, unsigned int *class,
 			  unsigned long deadline)
 {
+	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
 	struct ata_port *ap = link->ap;
 	struct ahci_port_priv *pp = ap->private_data;
 	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
 	struct ata_taskfile tf;
+	bool online;
 	int rc;
 
 	DPRINTK("ENTER\n");
@@ -1358,14 +1360,14 @@ static int ahci_hardreset(struct ata_link *link, unsigned int *class,
 	tf.command = 0x80;
 	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
 
-	rc = sata_sff_hardreset(link, class, deadline);
+	rc = sata_link_hardreset(link, timing, deadline, &online,
+				 ahci_check_ready);
 
 	ahci_start_engine(ap);
 
-	if (rc == 0 && ata_link_online(link))
+	*class = ATA_DEV_NONE;
+	if (online)
 		*class = ahci_dev_classify(ap);
-	if (rc != -EAGAIN && *class == ATA_DEV_UNKNOWN)
-		*class = ATA_DEV_NONE;
 
 	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
 	return rc;
@@ -1376,6 +1378,7 @@ static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
 {
 	struct ata_port *ap = link->ap;
 	u32 serror;
+	bool online;
 	int rc;
 
 	DPRINTK("ENTER\n");
@@ -1383,7 +1386,7 @@ static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
 	ahci_stop_engine(ap);
 
 	rc = sata_link_hardreset(link, sata_ehc_deb_timing(&link->eh_context),
-				 deadline);
+				 deadline, &online, NULL);
 
 	/* vt8251 needs SError cleared for the port to operate */
 	ahci_scr_read(ap, SCR_ERROR, &serror);
@@ -1396,7 +1399,8 @@ static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
 	/* vt8251 doesn't clear BSY on signature FIS reception,
 	 * request follow-up softreset.
 	 */
-	return rc ?: -EAGAIN;
+	*class = ATA_DEV_NONE;
+	return online ? -EAGAIN : rc;
 }
 
 static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
@@ -1406,6 +1410,7 @@ static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
 	struct ahci_port_priv *pp = ap->private_data;
 	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
 	struct ata_taskfile tf;
+	bool online;
 	int rc;
 
 	ahci_stop_engine(ap);
@@ -1416,13 +1421,10 @@ static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
 	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
 
 	rc = sata_link_hardreset(link, sata_ehc_deb_timing(&link->eh_context),
-				 deadline);
+				 deadline, &online, NULL);
 
 	ahci_start_engine(ap);
 
-	if (rc || ata_link_offline(link))
-		return rc;
-
 	/* The pseudo configuration device on SIMG4726 attached to
 	 * ASUS P5W-DH Deluxe doesn't send signature FIS after
 	 * hardreset if no device is attached to the first downstream
@@ -1436,11 +1438,14 @@ static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
 	 * have to be reset again.  For most cases, this should
 	 * suffice while making probing snappish enough.
 	 */
-	rc = ata_wait_after_reset(link, jiffies + 2 * HZ, ahci_check_ready);
-	if (rc)
-		ahci_kick_engine(ap, 0);
-
-	return 0;
+	if (online) {
+		rc = ata_wait_after_reset(link, jiffies + 2 * HZ,
+					  ahci_check_ready);
+		if (rc)
+			ahci_kick_engine(ap, 0);
+	}
+	*class = ATA_DEV_NONE;
+	return rc;
 }
 
 static void ahci_postreset(struct ata_link *link, unsigned int *class)
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index aa66848..16cb5b2 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1036,7 +1036,7 @@ static int piix_sidpr_hardreset(struct ata_link *link, unsigned int *class,
 	int rc;
 
 	/* do hardreset */
-	rc = sata_link_hardreset(link, timing, deadline);
+	rc = sata_link_hardreset(link, timing, deadline, NULL, NULL);
 	if (rc) {
 		ata_link_printk(link, KERN_ERR,
 				"COMRESET failed (errno=%d)\n", rc);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9064b3e..6982b91 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3519,8 +3519,18 @@ int ata_std_prereset(struct ata_link *link, unsigned long deadline)
  *	@link: link to reset
  *	@timing: timing parameters { interval, duratinon, timeout } in msec
  *	@deadline: deadline jiffies for the operation
+ *	@online: optional out parameter indicating link onlineness
+ *	@check_ready: optional callback to check link readiness
  *
  *	SATA phy-reset @link using DET bits of SControl register.
+ *	After hardreset, link readiness is waited upon using
+ *	ata_wait_ready() if @check_ready is specified.  LLDs are
+ *	allowed to not specify @check_ready and wait itself after this
+ *	function returns.  Device classification is LLD's
+ *	responsibility.
+ *
+ *	*@online is set to one iff reset succeeded and @link is online
+ *	after reset.
  *
  *	LOCKING:
  *	Kernel thread context (may sleep)
@@ -3529,13 +3539,17 @@ int ata_std_prereset(struct ata_link *link, unsigned long deadline)
  *	0 on success, -errno otherwise.
  */
 int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
-			unsigned long deadline)
+			unsigned long deadline,
+			bool *online, int (*check_ready)(struct ata_link *))
 {
 	u32 scontrol;
 	int rc;
 
 	DPRINTK("ENTER\n");
 
+	if (online)
+		*online = false;
+
 	if (sata_set_spd_needed(link)) {
 		/* SATA spec says nothing about how to reconfigure
 		 * spd.  To be on the safe side, turn off phy during
@@ -3569,7 +3583,41 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
 
 	/* bring link back */
 	rc = sata_link_resume(link, timing, deadline);
+	if (rc)
+		goto out;
+	/* if link is offline nothing more to do */
+	if (ata_link_offline(link))
+		goto out;
+
+	/* Link is online.  From this point, -ENODEV too is an error. */
+	if (online)
+		*online = true;
+
+	if ((link->ap->flags & ATA_FLAG_PMP) && ata_is_host_link(link)) {
+		/* If PMP is supported, we have to do follow-up SRST.
+		 * Some PMPs don't send D2H Reg FIS after hardreset if
+		 * the first port is empty.  Wait only for
+		 * ATA_TMOUT_PMP_SRST_WAIT.
+		 */
+		if (check_ready) {
+			unsigned long pmp_deadline;
+
+			pmp_deadline = jiffies + ATA_TMOUT_PMP_SRST_WAIT;
+			if (time_after(pmp_deadline, deadline))
+				pmp_deadline = deadline;
+			ata_wait_ready(link, pmp_deadline, check_ready);
+		}
+		rc = -EAGAIN;
+		goto out;
+	}
+
+	rc = 0;
+	if (check_ready)
+		rc = ata_wait_ready(link, deadline, check_ready);
  out:
+	if (rc && rc != -EAGAIN)
+		ata_link_printk(link, KERN_ERR,
+				"COMRESET failed (errno=%d)\n", rc);
 	DPRINTK("EXIT, rc=%d\n", rc);
 	return rc;
 }
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index a7cb149..7f1a87f 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -239,13 +239,14 @@ int sata_pmp_std_hardreset(struct ata_link *link, unsigned int *class,
 			   unsigned long deadline)
 {
 	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
+	bool online;
 	u32 tmp;
 	int rc;
 
 	DPRINTK("ENTER\n");
 
 	/* do hardreset */
-	rc = sata_link_hardreset(link, timing, deadline);
+	rc = sata_link_hardreset(link, timing, deadline, &online, NULL);
 	if (rc) {
 		ata_link_printk(link, KERN_ERR,
 				"COMRESET failed (errno=%d)\n", rc);
@@ -261,7 +262,7 @@ int sata_pmp_std_hardreset(struct ata_link *link, unsigned int *class,
 	}
 
 	/* if device is present, follow up with srst to wait for !BSY */
-	if (ata_link_online(link))
+	if (online)
 		rc = -EAGAIN;
  out:
 	/* if SCR isn't accessible, we need to reset the PMP */
@@ -916,7 +917,7 @@ static int sata_pmp_eh_handle_disabled_links(struct ata_port *ap)
 		 * SError.N working.
 		 */
 		sata_link_hardreset(link, sata_deb_timing_normal,
-				    jiffies + ATA_TMOUT_INTERNAL_QUICK);
+				jiffies + ATA_TMOUT_INTERNAL_QUICK, NULL, NULL);
 
 		/* unconditionally clear SError.N */
 		rc = sata_scr_write(link, SCR_ERROR, SERR_PHYRDY_CHG);
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 78912c5..0b97e84 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1921,50 +1921,19 @@ int ata_sff_softreset(struct ata_link *link, unsigned int *classes,
 int sata_sff_hardreset(struct ata_link *link, unsigned int *class,
 		       unsigned long deadline)
 {
-	struct ata_port *ap = link->ap;
-	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
+	struct ata_eh_context *ehc = &link->eh_context;
+	const unsigned long *timing = sata_ehc_deb_timing(ehc);
+	bool online;
 	int rc;
 
-	DPRINTK("ENTER\n");
-
-	/* do hardreset */
-	rc = sata_link_hardreset(link, timing, deadline);
-	if (rc) {
-		ata_link_printk(link, KERN_ERR,
-				"COMRESET failed (errno=%d)\n", rc);
-		return rc;
-	}
-
-	/* TODO: phy layer with polling, timeouts, etc. */
-	if (ata_link_offline(link)) {
-		*class = ATA_DEV_NONE;
-		DPRINTK("EXIT, link offline\n");
-		return 0;
-	}
-
-	/* If PMP is supported, we have to do follow-up SRST.  Note
-	 * that some PMPs don't send D2H Reg FIS after hardreset at
-	 * all if the first port is empty.  Wait for it just for a
-	 * second and request follow-up SRST.
-	 */
-	if (ap->flags & ATA_FLAG_PMP) {
-		ata_sff_wait_after_reset(link, 1, jiffies + HZ);
-		return -EAGAIN;
-	}
-
-	/* wait for the link to become online */
-	rc = ata_sff_wait_after_reset(link, 1, deadline);
-	/* link occupied, -ENODEV too is an error */
-	if (rc) {
-		ata_link_printk(link, KERN_ERR,
-				"COMRESET failed (errno=%d)\n", rc);
-		return rc;
-	}
-
-	*class = ata_sff_dev_classify(link->device, 1, NULL);
+	rc = sata_link_hardreset(link, timing, deadline, &online,
+				 ata_sff_check_ready);
+	*class = ATA_DEV_NONE;
+	if (online)
+		*class = ata_sff_dev_classify(link->device, 1, NULL);
 
 	DPRINTK("EXIT, class=%u\n", *class);
-	return 0;
+	return rc;
 }
 
 /**
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 2638e35..b51aaba 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -260,6 +260,13 @@ enum {
 	 */
 	ATA_WAIT_AFTER_RESET_MSECS = 150,
 
+	/* If PMP is supported, we have to do follow-up SRST.  As some
+	 * PMPs don't send D2H Reg FIS after hardreset, LLDs are
+	 * advised to wait only for the following duration before
+	 * doing SRST.
+	 */
+	ATA_TMOUT_PMP_SRST_WAIT	= 1 * HZ,
+
 	/* ATA bus states */
 	BUS_UNKNOWN		= 0,
 	BUS_DMA			= 1,
@@ -842,7 +849,8 @@ extern int sata_link_debounce(struct ata_link *link,
 extern int sata_link_resume(struct ata_link *link, const unsigned long *params,
 			    unsigned long deadline);
 extern int sata_link_hardreset(struct ata_link *link,
-			const unsigned long *timing, unsigned long deadline);
+			const unsigned long *timing, unsigned long deadline,
+			bool *online, int (*check_ready)(struct ata_link *));
 extern void ata_std_postreset(struct ata_link *link, unsigned int *classes);
 extern void ata_port_disable(struct ata_port *);
 
-- 
1.5.2.4

