From: akpm@linux-foundation.org
Subject: [patch 1/3] libata-scsi: don't start hotplug work queue if hotplug is disabled
Date: Wed, 20 Aug 2008 16:48:33 -0700
Message-ID: <200808202348.m7KNmXHq005814@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43515 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754112AbYHTXtO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Aug 2008 19:49:14 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, chunbo.luo@windriver.com, tj@kernel.org

From: Chunbo Luo <chunbo.luo@windriver.com>

Previously, queue_delayed_work() was started unconditionally, but if
ATA_PFLAG_SCSI_HOTPLUG is not set and we do this, the work queue may cause
multiple messages like this:

ata3.00: WARNING: ATAPI is not supported with this driver, device ignored.

So now,it is only started when the hotplug flag is actually set.

Signed-off-by: Chunbo Luo <chunbo.luo@windriver.com>
Cc: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/libata-scsi.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff -puN drivers/ata/libata-scsi.c~libata-scsi-dont-start-hotplug-work-queue-if-hotplug-is-disabled drivers/ata/libata-scsi.c
--- a/drivers/ata/libata-scsi.c~libata-scsi-dont-start-hotplug-work-queue-if-hotplug-is-disabled
+++ a/drivers/ata/libata-scsi.c
@@ -3176,8 +3176,9 @@ void ata_scsi_scan_host(struct ata_port 
 				"                  switching to async\n");
 	}
 
-	queue_delayed_work(ata_aux_wq, &ap->hotplug_task,
-			   round_jiffies_relative(HZ));
+	if (ap->pflags & ATA_PFLAG_SCSI_HOTPLUG)
+		queue_delayed_work(ata_aux_wq, &ap->hotplug_task,
+				round_jiffies_relative(HZ));
 }
 
 /**
_
