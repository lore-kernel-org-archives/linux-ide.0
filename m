From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/3] libata: fix ata_scmd_need_defer()
Date: Tue, 20 Feb 2007 23:27:06 +0900
Message-ID: <20070220142706.GQ1625@htj.dyndns.org>
References: <20070220142027.GP1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:31001 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964923AbXBTO1J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Feb 2007 09:27:09 -0500
Received: by an-out-0708.google.com with SMTP id b33so361758ana
        for <linux-ide@vger.kernel.org>; Tue, 20 Feb 2007 06:27:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20070220142027.GP1625@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
Cc: haebler@gmail.com, lkml@fliagreco.com.ar

Fix ata_scmd_need_defer() such that...

* whether NCQ is used or not is exactly determined using the same
  criteria as the issue path.

* defer-check is performed in all cases.

This fixes race condition where turning off NCQ on the fly causes
non-NCQ commands sneak into NCQ phase.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-scsi.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: work/drivers/ata/libata-scsi.c
===================================================================
--- work.orig/drivers/ata/libata-scsi.c
+++ work/drivers/ata/libata-scsi.c
@@ -1495,11 +1495,9 @@ static void ata_scsi_qc_complete(struct 
 static int ata_scmd_need_defer(struct ata_device *dev, int is_io)
 {
 	struct ata_port *ap = dev->ap;
+	int is_ncq = is_io && ata_ncq_enabled(dev);
 
-	if (!(dev->flags & ATA_DFLAG_NCQ))
-		return 0;
-
-	if (is_io) {
+	if (is_ncq) {
 		if (!ata_tag_valid(ap->active_tag))
 			return 0;
 	} else {
