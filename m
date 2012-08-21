From: Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH] ide: fix generic_ide_suspend/resume Oops
Date: Tue, 21 Aug 2012 17:20:30 +0200
Message-ID: <87txvwgtkx.fsf@tucsk.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:54181 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272Ab2HUPTG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Aug 2012 11:19:06 -0400
Received: by weyx8 with SMTP id x8so4636536wey.19
        for <linux-ide@vger.kernel.org>; Tue, 21 Aug 2012 08:19:05 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net
Cc: rjw@sisk.pl, stern@rowland.harvard.edu, hdegoede@redhat.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-ide@vger.kernel.org

From: Miklos Szeredi <mszeredi@suse.cz>

This patch fixes a regresion introduced by commit 0998d063 (device-core: Ensure
drvdata = NULL when no driver is bound).

Suspend oopses in generic_ide_suspend() because dev_get_drvdata()
returns NULL (dev->p->driver_data == NULL) and this function is not
prepared for this.

Fix is based on Alan Stern's suggestion.

Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/ide/ide-pm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ide-pm.c b/drivers/ide/ide-pm.c
index 9240609..8d1e32d 100644
--- a/drivers/ide/ide-pm.c
+++ b/drivers/ide/ide-pm.c
@@ -4,7 +4,7 @@
 
 int generic_ide_suspend(struct device *dev, pm_message_t mesg)
 {
-	ide_drive_t *drive = dev_get_drvdata(dev);
+	ide_drive_t *drive = to_ide_device(dev);
 	ide_drive_t *pair = ide_get_pair_dev(drive);
 	ide_hwif_t *hwif = drive->hwif;
 	struct request *rq;
@@ -40,7 +40,7 @@ int generic_ide_suspend(struct device *dev, pm_message_t mesg)
 
 int generic_ide_resume(struct device *dev)
 {
-	ide_drive_t *drive = dev_get_drvdata(dev);
+	ide_drive_t *drive = to_ide_device(dev);
 	ide_drive_t *pair = ide_get_pair_dev(drive);
 	ide_hwif_t *hwif = drive->hwif;
 	struct request *rq;
-- 
1.7.7

