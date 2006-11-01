From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/3 #upstream] libata: separate out and export sata_port_hardreset()
Date: Wed, 1 Nov 2006 17:59:53 +0900
Message-ID: <20061101085953.GQ13677@htj.dyndns.org>
References: <20061101085833.GP13677@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:19541 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423958AbWKAJAC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Nov 2006 04:00:02 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1664614ugm
        for <linux-ide@vger.kernel.org>; Wed, 01 Nov 2006 01:00:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20061101085833.GP13677@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Separate out sata_port_hardreset() from sata_std_hardreset().  This
will be used by LLD hardreset implementation and later by PMP.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   52 +++++++++++++++++++++++++++++++++++++---------
 include/linux/libata.h    |    2 +
 2 files changed, 44 insertions(+), 10 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -2786,9 +2786,9 @@ int ata_std_softreset(struct ata_port *a
 }
 
 /**
- *	sata_std_hardreset - reset host port via SATA phy reset
+ *	sata_port_hardreset - reset port via SATA phy reset
  *	@ap: port to reset
- *	@class: resulting class of attached device
+ *	@timing: timing parameters { interval, duratinon, timeout } in msec
  *
  *	SATA phy-reset host port using DET bits of SControl register.
  *
@@ -2798,10 +2798,8 @@ int ata_std_softreset(struct ata_port *a
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int sata_std_hardreset(struct ata_port *ap, unsigned int *class)
+int sata_port_hardreset(struct ata_port *ap, const unsigned long *timing)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
-	const unsigned long *timing = sata_ehc_deb_timing(ehc);
 	u32 scontrol;
 	int rc;
 
@@ -2814,24 +2812,24 @@ int sata_std_hardreset(struct ata_port *
 		 * and Sil3124.
 		 */
 		if ((rc = sata_scr_read(ap, SCR_CONTROL, &scontrol)))
-			return rc;
+			goto out;
 
 		scontrol = (scontrol & 0x0f0) | 0x304;
 
 		if ((rc = sata_scr_write(ap, SCR_CONTROL, scontrol)))
-			return rc;
+			goto out;
 
 		sata_set_spd(ap);
 	}
 
 	/* issue phy wake/reset */
 	if ((rc = sata_scr_read(ap, SCR_CONTROL, &scontrol)))
-		return rc;
+		goto out;
 
 	scontrol = (scontrol & 0x0f0) | 0x301;
 
 	if ((rc = sata_scr_write_flush(ap, SCR_CONTROL, scontrol)))
-		return rc;
+		goto out;
 
 	/* Couldn't find anything in SATA I/II specs, but AHCI-1.1
 	 * 10.4.2 says at least 1 ms.
@@ -2839,7 +2837,40 @@ int sata_std_hardreset(struct ata_port *
 	msleep(1);
 
 	/* bring phy back */
-	sata_phy_resume(ap, timing);
+	rc = sata_phy_resume(ap, timing);
+ out:
+	DPRINTK("EXIT, rc=%d\n", rc);
+	return rc;
+}
+
+/**
+ *	sata_std_hardreset - reset host port via SATA phy reset
+ *	@ap: port to reset
+ *	@class: resulting class of attached device
+ *
+ *	SATA phy-reset host port using DET bits of SControl register,
+ *	wait for !BSY and classify the attached device.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int sata_std_hardreset(struct ata_port *ap, unsigned int *class)
+{
+	const unsigned long *timing = sata_ehc_deb_timing(&ap->eh_context);
+	int rc;
+
+	DPRINTK("ENTER\n");
+
+	/* do hardreset */
+	rc = sata_port_hardreset(ap, timing);
+	if (rc) {
+		ata_port_printk(ap, KERN_ERR,
+				"COMRESET failed (errno=%d)\n", rc);
+		return rc;
+	}
 
 	/* TODO: phy layer with polling, timeouts, etc. */
 	if (ata_port_offline(ap)) {
@@ -6159,6 +6190,7 @@ EXPORT_SYMBOL_GPL(__sata_phy_reset);
 EXPORT_SYMBOL_GPL(ata_bus_reset);
 EXPORT_SYMBOL_GPL(ata_std_prereset);
 EXPORT_SYMBOL_GPL(ata_std_softreset);
+EXPORT_SYMBOL_GPL(sata_port_hardreset);
 EXPORT_SYMBOL_GPL(sata_std_hardreset);
 EXPORT_SYMBOL_GPL(ata_std_postreset);
 EXPORT_SYMBOL_GPL(ata_dev_classify);
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -702,6 +702,8 @@ extern int sata_phy_debounce(struct ata_
 extern int sata_phy_resume(struct ata_port *ap, const unsigned long *param);
 extern int ata_std_prereset(struct ata_port *ap);
 extern int ata_std_softreset(struct ata_port *ap, unsigned int *classes);
+extern int sata_port_hardreset(struct ata_port *ap,
+			       const unsigned long *timing);
 extern int sata_std_hardreset(struct ata_port *ap, unsigned int *class);
 extern void ata_std_postreset(struct ata_port *ap, unsigned int *classes);
 extern void ata_port_disable(struct ata_port *);
