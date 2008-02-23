From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] qd65xx: fix setup of QD6580 Control register
Date: Sat, 23 Feb 2008 16:03:34 +0100
Message-ID: <200802231603.34732.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:8334 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757540AbYBWS6Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Feb 2008 13:58:24 -0500
Received: by ug-out-1314.google.com with SMTP id z38so219644ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 23 Feb 2008 10:58:21 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Control register of QD6580 should be setup before probing for devices.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
goes after "ide: skip probing port if "hdx=noprobe" was used for both
devices on it" patch in the IDE quilt tree

 drivers/ide/legacy/qd65xx.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: b/drivers/ide/legacy/qd65xx.c
===================================================================
--- a/drivers/ide/legacy/qd65xx.c
+++ b/drivers/ide/legacy/qd65xx.c
@@ -444,6 +444,8 @@ static int __init qd_probe(int base)
 		printk(KERN_DEBUG "qd6580: config=%#x, control=%#x, ID3=%u\n",
 			config, control, QD_ID3);
 
+		outb(QD_DEF_CONTR, QD_CONTROL_PORT);
+
 		if (control & QD_CONTR_SEC_DISABLED) {
 			/* secondary disabled */
 
@@ -460,8 +462,6 @@ static int __init qd_probe(int base)
 
 			ide_device_add(idx, &qd65xx_port_info);
 
-			outb(QD_DEF_CONTR, QD_CONTROL_PORT);
-
 			return 1;
 		} else {
 			ide_hwif_t *mate;
@@ -487,8 +487,6 @@ static int __init qd_probe(int base)
 
 			ide_device_add(idx, &qd65xx_port_info);
 
-			outb(QD_DEF_CONTR, QD_CONTROL_PORT);
-
 			return 0; /* no other qd65xx possible */
 		}
 	}
