From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/4] qd65xx: cleanup qd_probe()
Date: Wed, 27 Feb 2008 23:21:56 +0100
Message-ID: <200802272321.56276.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:47795 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760769AbYB0WI1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Feb 2008 17:08:27 -0500
Received: by ug-out-1314.google.com with SMTP id z38so568670ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 27 Feb 2008 14:08:26 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

* Replace 'if ()'-s by 'switch ()' block.

* Merge common code for QD6500/QD6580A/QD6580B.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/legacy/qd65xx.c |   52 ++++++++++++++------------------------------
 1 file changed, 17 insertions(+), 35 deletions(-)

Index: b/drivers/ide/legacy/qd65xx.c
===================================================================
--- a/drivers/ide/legacy/qd65xx.c
+++ b/drivers/ide/legacy/qd65xx.c
@@ -334,7 +334,7 @@ static const struct ide_port_info qd65xx
 static int __init qd_probe(int base)
 {
 	int rc;
-	u8 config, unit;
+	u8 config, unit, control;
 	struct ide_port_info d = qd65xx_port_info;
 
 	config = inb(QD_CONFIG_PORT);
@@ -347,13 +347,11 @@ static int __init qd_probe(int base)
 	if (unit)
 		d.host_flags |= IDE_HFLAG_QD_2ND_PORT;
 
-	if ((config & 0xf0) == QD_CONFIG_QD6500) {
-
+	switch (config & 0xf0) {
+	case QD_CONFIG_QD6500:
 		if (qd_testreg(base))
 			 return -ENODEV;	/* bad register */
 
-		/* qd6500 found */
-
 		if (config & QD_CONFIG_DISABLED) {
 			printk(KERN_WARNING "qd6500 is disabled !\n");
 			return -ENODEV;
@@ -365,22 +363,12 @@ static int __init qd_probe(int base)
 
 		d.port_ops = &qd6500_port_ops;
 		d.host_flags |= IDE_HFLAG_SINGLE;
-
-		rc = ide_legacy_device_add(&d, (base << 8) | config);
-
-		return (rc == 0) ? 1 : rc;
-	}
-
-	if (((config & 0xf0) == QD_CONFIG_QD6580_A) ||
-	    ((config & 0xf0) == QD_CONFIG_QD6580_B)) {
-
-		u8 control;
-
+		break;
+	case QD_CONFIG_QD6580_A:
+	case QD_CONFIG_QD6580_B:
 		if (qd_testreg(base) || qd_testreg(base + 0x02))
 			return -ENODEV;	/* bad registers */
 
-		/* qd6580 found */
-
 		control = inb(QD_CONTROL_PORT);
 
 		printk(KERN_NOTICE "qd6580 at %#x\n", base);
@@ -390,28 +378,22 @@ static int __init qd_probe(int base)
 		outb(QD_DEF_CONTR, QD_CONTROL_PORT);
 
 		d.port_ops = &qd6580_port_ops;
-
-		if (control & QD_CONTR_SEC_DISABLED) {
-			/* secondary disabled */
-
-			printk(KERN_INFO "qd6580: single IDE board\n");
-
+		if (control & QD_CONTR_SEC_DISABLED)
 			d.host_flags |= IDE_HFLAG_SINGLE;
 
-			rc = ide_legacy_device_add(&d, (base << 8) | config);
+		printk(KERN_INFO "qd6580: %s IDE board\n",
+			(control & QD_CONTR_SEC_DISABLED) ? "single" : "dual");
+		break;
+	default:
+		return -ENODEV;
+	}
 
-			return (rc == 0) ? 1 : rc;
-		} else {
-			/* secondary enabled */
-			printk(KERN_INFO "qd6580: dual IDE board\n");
+	rc = ide_legacy_device_add(&d, (base << 8) | config);
 
-			rc = ide_legacy_device_add(&d, (base << 8) | config);
+	if (d.host_flags & IDE_HFLAG_SINGLE)
+		return (rc == 0) ? 1 : rc;
 
-			return rc; /* no other qd65xx possible */
-		}
-	}
-	/* no qd65xx found */
-	return -ENODEV;
+	return rc;
 }
 
 int probe_qd65xx = 0;
