From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/3] libata: separate out and export sata_port_hardreset()
Date: Fri, 13 Oct 2006 11:18:08 +0900
Message-ID: <11607058882906-git-send-email-htejun@gmail.com>
References: <11607058883329-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:15839 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751507AbWJMCSR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Oct 2006 22:18:17 -0400
Received: by nf-out-0910.google.com with SMTP id x30so780170nfb
        for <linux-ide@vger.kernel.org>; Thu, 12 Oct 2006 19:18:16 -0700 (PDT)
In-Reply-To: <11607058883329-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, aalderd.boac@wanadoo.nl, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Separate out sata_port_hardreset() from sata_std_hardreset().  This
wil be used by LLD hardreset implementation and later by PMP.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   52 ++++++++++++++++++++++++++++++++++++---------
 include/linux/libata.h    |    2 ++
 2 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c127d6f..acb9903 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2777,9 +2777,9 @@ int ata_std_softreset(struct ata_port *a
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
@@ -2789,10 +2789,8 @@ int ata_std_softreset(struct ata_port *a
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
 
@@ -2805,24 +2803,24 @@ int sata_std_hardreset(struct ata_port *
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
@@ -2830,7 +2828,40 @@ int sata_std_hardreset(struct ata_port *
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
@@ -6127,6 +6158,7 @@ EXPORT_SYMBOL_GPL(__sata_phy_reset);
 EXPORT_SYMBOL_GPL(ata_bus_reset);
 EXPORT_SYMBOL_GPL(ata_std_prereset);
 EXPORT_SYMBOL_GPL(ata_std_softreset);
+EXPORT_SYMBOL_GPL(sata_port_hardreset);
 EXPORT_SYMBOL_GPL(sata_std_hardreset);
 EXPORT_SYMBOL_GPL(ata_std_postreset);
 EXPORT_SYMBOL_GPL(ata_dev_revalidate);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d0a7ad5..c475c65 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -700,6 +700,8 @@ extern int sata_phy_debounce(struct ata_
 extern int sata_phy_resume(struct ata_port *ap, const unsigned long *param);
 extern int ata_std_prereset(struct ata_port *ap);
 extern int ata_std_softreset(struct ata_port *ap, unsigned int *classes);
+extern int sata_port_hardreset(struct ata_port *ap,
+			       const unsigned long *timing);
 extern int sata_std_hardreset(struct ata_port *ap, unsigned int *class);
 extern void ata_std_postreset(struct ata_port *ap, unsigned int *classes);
 extern int ata_dev_revalidate(struct ata_device *dev, int post_reset);
-- 
1.4.2.3


