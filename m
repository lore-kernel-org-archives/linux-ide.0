From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: allow ->probe_reset to return ATA_DEV_UNKNOWN
Date: Sun, 12 Feb 2006 15:01:49 +0900
Message-ID: <20060212060149.GA20025@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.183]:32201 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964804AbWBLGBz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2006 01:01:55 -0500
Received: by pproxy.gmail.com with SMTP id f25so465318pyf
        for <linux-ide@vger.kernel.org>; Sat, 11 Feb 2006 22:01:52 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

[PATCH] libata: allow ->probe_reset to return ATA_DEV_UNKNOWN

This patch makes ata_bus_probe() normalize classes[] returned by
->probe_reset such that ->probe_reset can return ATA_DEV_UNKNOWN.
This eases implementation of ->probe_reset's which don't directly use
ata_drive_probe_reset().

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work1/drivers/scsi/libata-core.c
===================================================================
--- work1.orig/drivers/scsi/libata-core.c	2006-02-12 14:23:22.000000000 +0900
+++ work1/drivers/scsi/libata-core.c	2006-02-12 14:29:47.000000000 +0900
@@ -1142,8 +1142,11 @@ static int ata_bus_probe(struct ata_port
 
 		rc = ap->ops->probe_reset(ap, classes);
 		if (rc == 0) {
-			for (i = 0; i < ATA_MAX_DEVICES; i++)
+			for (i = 0; i < ATA_MAX_DEVICES; i++) {
+				if (classes[i] == ATA_DEV_UNKNOWN)
+					classes[i] = ATA_DEV_NONE;
 				ap->device[i].class = classes[i];
+			}
 		} else {
 			printk(KERN_ERR "ata%u: probe reset failed, "
 			       "disabling port\n", ap->id);
