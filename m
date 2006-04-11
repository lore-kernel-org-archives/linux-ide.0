From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/3] libata: kill @verbose from ata_reset_fn_t
Date: Tue, 11 Apr 2006 22:16:45 +0900
Message-ID: <11447614052864-git-send-email-htejun@gmail.com>
References: <11447614041095-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.239]:52599 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750815AbWDKNQt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:16:49 -0400
Received: by wproxy.gmail.com with SMTP id i11so920393wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:16:49 -0700 (PDT)
In-Reply-To: <11447614041095-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

@verbose was added to ata_reset_fn_t because AHCI complained during
probing if no device was attached to the port.  However, muting
failure message isn't the correct approach.  Reset methods are
responsible for detecting no device condition and finishing
successfully.  Now that AHCI softreset is fixed, kill @verbose.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c        |   13 +++++--------
 drivers/scsi/libata-core.c |   36 ++++++++++++------------------------
 drivers/scsi/libata.h      |    6 ++----
 drivers/scsi/sata_sil24.c  |    8 +++-----
 include/linux/libata.h     |    8 +++-----
 5 files changed, 25 insertions(+), 46 deletions(-)

ec5e2b0375c15dce9eb83607ddf9864bfb20bc85
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index ff48066..8f06375 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -535,7 +535,7 @@ static int ahci_poll_register(void __iom
 	return -1;
 }
 
-static int ahci_softreset(struct ata_port *ap, int verbose, unsigned int *class)
+static int ahci_softreset(struct ata_port *ap, unsigned int *class)
 {
 	struct ahci_host_priv *hpriv = ap->host_set->private_data;
 	struct ahci_port_priv *pp = ap->private_data;
@@ -647,22 +647,19 @@ static int ahci_softreset(struct ata_por
  fail_restart:
 	ahci_start_engine(ap);
  fail:
-	if (verbose)
-		printk(KERN_ERR "ata%u: softreset failed (%s)\n",
-		       ap->id, reason);
-	else
-		DPRINTK("EXIT, rc=%d reason=\"%s\"\n", rc, reason);
+	printk(KERN_ERR "ata%u: softreset failed (%s)\n",
+	       ap->id, reason);
 	return rc;
 }
 
-static int ahci_hardreset(struct ata_port *ap, int verbose, unsigned int *class)
+static int ahci_hardreset(struct ata_port *ap, unsigned int *class)
 {
 	int rc;
 
 	DPRINTK("ENTER\n");
 
 	ahci_stop_engine(ap);
-	rc = sata_std_hardreset(ap, verbose, class);
+	rc = sata_std_hardreset(ap, class);
 	ahci_start_engine(ap);
 
 	if (rc == 0)
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 8d3fed4..9e49251 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2387,7 +2387,6 @@ void ata_std_probeinit(struct ata_port *
 /**
  *	ata_std_softreset - reset host port via ATA SRST
  *	@ap: port to reset
- *	@verbose: fail verbosely
  *	@classes: resulting classes of attached devices
  *
  *	Reset host port using ATA SRST.  This function is to be used
@@ -2399,7 +2398,7 @@ void ata_std_probeinit(struct ata_port *
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int ata_std_softreset(struct ata_port *ap, int verbose, unsigned int *classes)
+int ata_std_softreset(struct ata_port *ap, unsigned int *classes)
 {
 	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
 	unsigned int devmask = 0, err_mask;
@@ -2425,12 +2424,8 @@ int ata_std_softreset(struct ata_port *a
 	DPRINTK("about to softreset, devmask=%x\n", devmask);
 	err_mask = ata_bus_softreset(ap, devmask);
 	if (err_mask) {
-		if (verbose)
-			printk(KERN_ERR "ata%u: SRST failed (err_mask=0x%x)\n",
-			       ap->id, err_mask);
-		else
-			DPRINTK("EXIT, softreset failed (err_mask=0x%x)\n",
-				err_mask);
+		printk(KERN_ERR "ata%u: SRST failed (err_mask=0x%x)\n",
+		       ap->id, err_mask);
 		return -EIO;
 	}
 
@@ -2447,7 +2442,6 @@ int ata_std_softreset(struct ata_port *a
 /**
  *	sata_std_hardreset - reset host port via SATA phy reset
  *	@ap: port to reset
- *	@verbose: fail verbosely
  *	@class: resulting class of attached device
  *
  *	SATA phy-reset host port using DET bits of SControl register.
@@ -2460,7 +2454,7 @@ int ata_std_softreset(struct ata_port *a
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int sata_std_hardreset(struct ata_port *ap, int verbose, unsigned int *class)
+int sata_std_hardreset(struct ata_port *ap, unsigned int *class)
 {
 	u32 scontrol;
 
@@ -2500,11 +2494,8 @@ int sata_std_hardreset(struct ata_port *
 	}
 
 	if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
-		if (verbose)
-			printk(KERN_ERR "ata%u: COMRESET failed "
-			       "(device not ready)\n", ap->id);
-		else
-			DPRINTK("EXIT, device not ready\n");
+		printk(KERN_ERR "ata%u: COMRESET failed "
+		       "(device not ready)\n", ap->id);
 		return -EIO;
 	}
 
@@ -2592,16 +2583,15 @@ int ata_std_probe_reset(struct ata_port 
 				     ata_std_postreset, classes);
 }
 
-int ata_do_reset(struct ata_port *ap,
-		 ata_reset_fn_t reset, ata_postreset_fn_t postreset,
-		 int verbose, unsigned int *classes)
+int ata_do_reset(struct ata_port *ap, ata_reset_fn_t reset,
+		 ata_postreset_fn_t postreset, unsigned int *classes)
 {
 	int i, rc;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
 		classes[i] = ATA_DEV_UNKNOWN;
 
-	rc = reset(ap, verbose, classes);
+	rc = reset(ap, classes);
 	if (rc)
 		return rc;
 
@@ -2645,8 +2635,6 @@ int ata_do_reset(struct ata_port *ap,
  *	- If classification is supported, fill classes[] with
  *	  recognized class codes.
  *	- If classification is not supported, leave classes[] alone.
- *	- If verbose is non-zero, print error message on failure;
- *	  otherwise, shut up.
  *
  *	LOCKING:
  *	Kernel thread context (may sleep)
@@ -2666,7 +2654,7 @@ int ata_drive_probe_reset(struct ata_por
 		probeinit(ap);
 
 	if (softreset && !ata_set_sata_spd_needed(ap)) {
-		rc = ata_do_reset(ap, softreset, postreset, 0, classes);
+		rc = ata_do_reset(ap, softreset, postreset, classes);
 		if (rc == 0 && classes[0] != ATA_DEV_UNKNOWN)
 			goto done;
 		printk(KERN_INFO "ata%u: softreset failed, will try "
@@ -2678,7 +2666,7 @@ int ata_drive_probe_reset(struct ata_por
 		goto done;
 
 	while (1) {
-		rc = ata_do_reset(ap, hardreset, postreset, 0, classes);
+		rc = ata_do_reset(ap, hardreset, postreset, classes);
 		if (rc == 0) {
 			if (classes[0] != ATA_DEV_UNKNOWN)
 				goto done;
@@ -2699,7 +2687,7 @@ int ata_drive_probe_reset(struct ata_por
 		       ap->id);
 		ssleep(5);
 
-		rc = ata_do_reset(ap, softreset, postreset, 0, classes);
+		rc = ata_do_reset(ap, softreset, postreset, classes);
 	}
 
  done:
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index 652c08e..4299aa1 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -56,10 +56,8 @@ extern int ata_set_sata_spd_needed(struc
 extern int ata_down_xfermask_limit(struct ata_port *ap, struct ata_device *dev,
 				   int force_pio0);
 extern int ata_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev);
-extern int ata_do_reset(struct ata_port *ap,
-			ata_reset_fn_t reset,
-			ata_postreset_fn_t postreset,
-			int verbose, unsigned int *classes);
+extern int ata_do_reset(struct ata_port *ap, ata_reset_fn_t reset,
+			ata_postreset_fn_t postreset, unsigned int *classes);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern void ata_qc_issue(struct ata_queued_cmd *qc);
 extern int ata_check_atapi_dma(struct ata_queued_cmd *qc);
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 646756a..7f3fbac 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -427,8 +427,7 @@ static void sil24_tf_read(struct ata_por
 	*tf = pp->tf;
 }
 
-static int sil24_softreset(struct ata_port *ap, int verbose,
-			   unsigned int *class)
+static int sil24_softreset(struct ata_port *ap, unsigned int *class)
 {
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
 	struct sil24_port_priv *pp = ap->private_data;
@@ -490,13 +489,12 @@ static int sil24_softreset(struct ata_po
 	return 0;
 }
 
-static int sil24_hardreset(struct ata_port *ap, int verbose,
-			   unsigned int *class)
+static int sil24_hardreset(struct ata_port *ap, unsigned int *class)
 {
 	unsigned int dummy_class;
 
 	/* sil24 doesn't report device signature after hard reset */
-	return sata_std_hardreset(ap, verbose, &dummy_class);
+	return sata_std_hardreset(ap, &dummy_class);
 }
 
 static int sil24_probe_reset(struct ata_port *ap, unsigned int *classes)
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 03231cb..6954852 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -251,7 +251,7 @@ struct ata_queued_cmd;
 /* typedefs */
 typedef void (*ata_qc_cb_t) (struct ata_queued_cmd *qc);
 typedef void (*ata_probeinit_fn_t)(struct ata_port *);
-typedef int (*ata_reset_fn_t)(struct ata_port *, int, unsigned int *);
+typedef int (*ata_reset_fn_t)(struct ata_port *, unsigned int *);
 typedef void (*ata_postreset_fn_t)(struct ata_port *ap, unsigned int *);
 
 struct ata_ioports {
@@ -508,10 +508,8 @@ extern int ata_drive_probe_reset(struct 
 			ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 			ata_postreset_fn_t postreset, unsigned int *classes);
 extern void ata_std_probeinit(struct ata_port *ap);
-extern int ata_std_softreset(struct ata_port *ap, int verbose,
-			     unsigned int *classes);
-extern int sata_std_hardreset(struct ata_port *ap, int verbose,
-			      unsigned int *class);
+extern int ata_std_softreset(struct ata_port *ap, unsigned int *classes);
+extern int sata_std_hardreset(struct ata_port *ap, unsigned int *class);
 extern void ata_std_postreset(struct ata_port *ap, unsigned int *classes);
 extern int ata_dev_revalidate(struct ata_port *ap, struct ata_device *dev,
 			      int post_reset);
-- 
1.2.4


