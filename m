From: akpm@linux-foundation.org
Subject: [patch 1/2] libata-scsi: don't start hotplug work queue if hotplug is disabled
Date: Wed, 30 Jul 2008 12:32:38 -0700
Message-ID: <200807301932.m6UJWcBV012122@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39622 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754481AbYG3Tdm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jul 2008 15:33:42 -0400
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
@@ -3206,8 +3206,9 @@ void ata_scsi_scan_host(struct ata_port 
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
