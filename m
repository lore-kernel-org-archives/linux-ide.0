From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes 1/2] libata: invert ATA_PFLAG_INITIALIZING to RUNNING
Date: Mon, 20 Aug 2007 20:50:00 +0900
Message-ID: <20070820115000.GA2909@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:33980 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbXHTLuG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Aug 2007 07:50:06 -0400
Received: by rv-out-0910.google.com with SMTP id k20so948884rvb
        for <linux-ide@vger.kernel.org>; Mon, 20 Aug 2007 04:50:06 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Invert the meaning of ATA_PFLAG_INITIALIZING and rename it to
ATA_PFLAG_RUNNING.  This will be used to prevent EH from being
scheduled during host removal.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    4 +---
 drivers/ata/libata-eh.c   |    2 +-
 include/linux/libata.h    |    2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -6052,7 +6052,6 @@ struct ata_port *ata_port_alloc(struct a
 	if (!ap)
 		return NULL;
 
-	ap->pflags |= ATA_PFLAG_INITIALIZING;
 	ap->lock = &host->lock;
 	ap->flags = ATA_FLAG_DISABLED;
 	ap->print_id = -1;
@@ -6428,8 +6427,7 @@ int ata_host_register(struct ata_host *h
 			ehi->action |= ATA_EH_SOFTRESET;
 			ehi->flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET;
 
-			ap->pflags &= ~ATA_PFLAG_INITIALIZING;
-			ap->pflags |= ATA_PFLAG_LOADING;
+			ap->pflags |= ATA_PFLAG_LOADING | ATA_PFLAG_RUNNING;
 			ata_port_schedule_eh(ap);
 
 			spin_unlock_irqrestore(ap->lock, flags);
Index: work/drivers/ata/libata-eh.c
===================================================================
--- work.orig/drivers/ata/libata-eh.c
+++ work/drivers/ata/libata-eh.c
@@ -709,7 +709,7 @@ void ata_port_schedule_eh(struct ata_por
 {
 	WARN_ON(!ap->ops->error_handler);
 
-	if (ap->pflags & ATA_PFLAG_INITIALIZING)
+	if (!(ap->pflags & ATA_PFLAG_RUNNING))
 		return;
 
 	ata_eh_set_pending(ap, 1);
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -194,7 +194,7 @@ enum {
 	ATA_PFLAG_LOADING	= (1 << 4), /* boot/loading probe */
 	ATA_PFLAG_UNLOADING	= (1 << 5), /* module is unloading */
 	ATA_PFLAG_SCSI_HOTPLUG	= (1 << 6), /* SCSI hotplug scheduled */
-	ATA_PFLAG_INITIALIZING	= (1 << 7), /* being initialized, don't touch */
+	ATA_PFLAG_RUNNING	= (1 << 7), /* port up & running */
 
 	ATA_PFLAG_SUSPENDED	= (1 << 17), /* port is suspended (power) */
 	ATA_PFLAG_PM_PENDING	= (1 << 18), /* PM operation pending */
