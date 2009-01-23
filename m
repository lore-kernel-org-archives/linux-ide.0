From: Ian Campbell <Ian.Campbell@citrix.com>
Subject: [PATCH] IDE: Unregister devices if initialization fails.
Date: Fri, 23 Jan 2009 13:04:29 +0000
Message-ID: <1232715869-31039-1-git-send-email-Ian.Campbell@citrix.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp02.citrix.com ([66.165.176.63]:42802 "EHLO
	SMTP02.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755962AbZAWNFB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Jan 2009 08:05:01 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Ian Campbell <Ian.Campbell@citrix.com>, Ian Campbell <ian.campbell@citrix.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On reboot the loop in device_shutdown gets confused by these devices
and goes into an infinite loop. I think this is because they don't
have dev->bus or dev->driver which is because hwif_register_devices
doesn't get called if !hwif->present.

Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 312127e..120f65b 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1520,6 +1520,8 @@ int ide_host_register(struct ide_host *host, const struct ide_port_info *d,
 		if (hwif_init(hwif) == 0) {
 			printk(KERN_INFO "%s: failed to initialize IDE "
 					 "interface\n", hwif->name);
+			device_unregister(&hwif->gendev);
+			device_destroy(ide_port_class, MKDEV(0, 0));
 			hwif->present = 0;
 			continue;
 		}
@@ -1550,11 +1552,11 @@ int ide_host_register(struct ide_host *host, const struct ide_port_info *d,
 		if (hwif == NULL)
 			continue;
 
-		ide_sysfs_register_port(hwif);
-		ide_proc_register_port(hwif);
-
-		if (hwif->present)
+		if (hwif->present) {
+			ide_sysfs_register_port(hwif);
+			ide_proc_register_port(hwif);
 			ide_proc_port_register_devices(hwif);
+		}
 	}
 
 	return j ? 0 : -1;
-- 
1.5.6.5

