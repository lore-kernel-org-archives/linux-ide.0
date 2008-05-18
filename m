From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 27/40] ide-scsi: set drive->scsi flag for devices handled by the driver
Date: Sun, 18 May 2008 20:58:31 +0200
Message-ID: <20080518185831.5636.90545.sendpatchset@localhost.localdomain>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:17236 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757926AbYERSlG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 14:41:06 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1473278fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 11:41:05 -0700 (PDT)
In-Reply-To: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

This is a preparation for adding generic ide_transfer_pc() helper.

There should be no functional changes caused by this patch.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/scsi/ide-scsi.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: b/drivers/scsi/ide-scsi.c
===================================================================
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -629,6 +629,8 @@ static void ide_scsi_remove(ide_drive_t 
 	put_disk(g);
 
 	ide_scsi_put(scsi);
+
+	drive->scsi = 0;
 }
 
 static int ide_scsi_probe(ide_drive_t *);
@@ -969,6 +971,8 @@ static int ide_scsi_probe(ide_drive_t *d
 	    !(host = scsi_host_alloc(&idescsi_template,sizeof(idescsi_scsi_t))))
 		return -ENODEV;
 
+	drive->scsi = 1;
+
 	g = alloc_disk(1 << PARTN_BITS);
 	if (!g)
 		goto out_host_put;
@@ -1009,6 +1013,7 @@ static int ide_scsi_probe(ide_drive_t *d
 
 	put_disk(g);
 out_host_put:
+	drive->scsi = 0;
 	scsi_host_put(host);
 	return err;
 }
