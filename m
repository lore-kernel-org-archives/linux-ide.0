From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: initialize port_task when !CONFIG_ATA_SFF
Date: Mon, 20 Oct 2008 13:11:56 +0900
Message-ID: <48FC050C.3000207@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55662 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750776AbYJTEOF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Oct 2008 00:14:05 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: stable@kernel.org, Larry Finger <Larry.Finger@lwfinger.net>

Subject: libata: initialize port_task when !CONFIG_ATA_SFF

ap->port_task was not initialized if !CONFIG_ATA_SFF later triggering
lockdep warning.  Make sure it's initialized.

Reported by Larry Finger.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/ata/libata-core.c |    2 ++
 1 file changed, 2 insertions(+)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -5373,6 +5373,8 @@ struct ata_port *ata_port_alloc(struct a
 
 #ifdef CONFIG_ATA_SFF
 	INIT_DELAYED_WORK(&ap->port_task, ata_pio_task);
+#else
+	INIT_DELAYED_WORK(&ap->port_task, NULL);
 #endif
 	INIT_DELAYED_WORK(&ap->hotplug_task, ata_scsi_hotplug);
 	INIT_WORK(&ap->scsi_rescan_task, ata_scsi_dev_rescan);
