From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/10] libata: don't schedule LPM action seperately during probing
Date: Mon, 19 May 2008 01:15:12 +0900
Message-ID: <12111273201019-git-send-email-htejun@gmail.com>
References: <12111273141039-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:52674 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754724AbYERQP0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 12:15:26 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1010109wfd.4
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 09:15:26 -0700 (PDT)
In-Reply-To: <12111273141039-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: liml@rtr.ca, Tejun Heo <htejun@gmail.com>

There's no reason to schedule LPM action after probing is complete
causing another EH iteration.  Just schedule it together with probing
itself.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ffc689d..a12a27e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5615,7 +5615,7 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 			spin_lock_irqsave(ap->lock, flags);
 
 			ehi->probe_mask |= ATA_ALL_DEVICES;
-			ehi->action |= ATA_EH_RESET;
+			ehi->action |= ATA_EH_RESET | ATA_EH_LPM;
 			ehi->flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET;
 
 			ap->pflags &= ~ATA_PFLAG_INITIALIZING;
@@ -5648,7 +5648,6 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 		struct ata_port *ap = host->ports[i];
 
 		ata_scsi_scan_host(ap, 1);
-		ata_lpm_schedule(ap, ap->pm_policy);
 	}
 
 	return 0;
-- 
1.5.2.4

