From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 18/27] libata: move PMP SCR access failure during reset to ata_eh_reset()
Date: Tue, 25 Mar 2008 22:16:56 +0900
Message-ID: <12064510284074-git-send-email-htejun@gmail.com>
References: <1206451025926-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:16439 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755770AbYCYNR5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:17:57 -0400
Received: by wr-out-0506.google.com with SMTP id c48so2257948wra.1
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:17:56 -0700 (PDT)
In-Reply-To: <1206451025926-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com
Cc: Tejun Heo <htejun@gmail.com>

If PMP fan-out reset fails and SCR isn't accessible, PMP should be
reset.  This used to be tested by sata_pmp_std_hardreset() and
communicated to EH by -ERESTART.  However, this logic is generic and
doesn't really have much to do with specific hardreset implementation.

This patch moves SCR access failure detection logic to ata_eh_reset()
where it belongs.  As this makes sata_pmp_std_hardreset() identical to
sata_std_hardreset(), the function is killed and replaced with the
standard method.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    3 +--
 drivers/ata/libata-eh.c   |    5 +++++
 drivers/ata/libata-pmp.c  |   35 -----------------------------------
 drivers/ata/sata_sil24.c  |    2 +-
 include/linux/libata.h    |    2 --
 5 files changed, 7 insertions(+), 40 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2637733..3b89539 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -91,7 +91,7 @@ const struct ata_port_operations sata_pmp_port_ops = {
 	.inherits		= &sata_port_ops,
 
 	.pmp_prereset		= ata_std_prereset,
-	.pmp_hardreset		= sata_pmp_std_hardreset,
+	.pmp_hardreset		= sata_std_hardreset,
 	.pmp_postreset		= ata_std_postreset,
 	.error_handler		= sata_pmp_error_handler,
 };
@@ -6254,7 +6254,6 @@ EXPORT_SYMBOL_GPL(ata_pci_device_resume);
 #endif /* CONFIG_PCI */
 
 EXPORT_SYMBOL_GPL(sata_pmp_qc_defer_cmd_switch);
-EXPORT_SYMBOL_GPL(sata_pmp_std_hardreset);
 EXPORT_SYMBOL_GPL(sata_pmp_error_handler);
 
 EXPORT_SYMBOL_GPL(__ata_ehi_push_desc);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 777aa38..621c6e4 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2271,6 +2271,11 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	return rc;
 
  fail:
+	/* if SCR isn't accessible on a fan-out port, PMP needs to be reset */
+	if (!ata_is_host_link(link) &&
+	    sata_scr_read(link, SCR_STATUS, &sstatus))
+		rc = -ERESTART;
+
 	if (rc == -ERESTART || try >= max_tries)
 		goto out;
 
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 2f8a957..9c99861 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -176,41 +176,6 @@ int sata_pmp_scr_write(struct ata_link *link, int reg, u32 val)
 }
 
 /**
- *	sata_pmp_std_hardreset - standard hardreset method for PMP link
- *	@link: link to be reset
- *	@class: resulting class of attached device
- *	@deadline: deadline jiffies for the operation
- *
- *	Hardreset PMP port @link.  Note that this function doesn't
- *	wait for BSY clearance.  There simply isn't a generic way to
- *	wait the event.  Instead, this function return -EAGAIN thus
- *	telling libata-EH to followup with softreset.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep)
- *
- *	RETURNS:
- *	0 on success, -errno otherwise.
- */
-int sata_pmp_std_hardreset(struct ata_link *link, unsigned int *class,
-			   unsigned long deadline)
-{
-	u32 tmp;
-	int rc;
-
-	DPRINTK("ENTER\n");
-
-	rc = sata_std_hardreset(link, class, deadline);
-
-	/* if SCR isn't accessible, we need to reset the PMP */
-	if (rc && rc != -EAGAIN && sata_scr_read(link, SCR_STATUS, &tmp))
-		rc = -ERESTART;
-
-	DPRINTK("EXIT, rc=%d\n", rc);
-	return rc;
-}
-
-/**
  *	sata_pmp_read_gscr - read GSCR block of SATA PMP
  *	@dev: PMP device
  *	@gscr: buffer to read GSCR block into
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index b83851f..fc9d48c 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -944,7 +944,7 @@ static int sil24_pmp_hardreset(struct ata_link *link, unsigned int *class,
 		return rc;
 	}
 
-	return sata_pmp_std_hardreset(link, class, deadline);
+	return sata_std_hardreset(link, class, deadline);
 }
 
 static void sil24_freeze(struct ata_port *ap)
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 20b2612..e232140 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1022,8 +1022,6 @@ static inline int ata_acpi_cbl_80wire(struct ata_port *ap,
  * PMP - drivers/ata/libata-pmp.c
  */
 extern int sata_pmp_qc_defer_cmd_switch(struct ata_queued_cmd *qc);
-extern int sata_pmp_std_hardreset(struct ata_link *link, unsigned int *class,
-				  unsigned long deadline);
 extern void sata_pmp_error_handler(struct ata_port *ap);
 
 /*
-- 
1.5.2.4

