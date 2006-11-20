From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: use ata_scsi_find_dev() in ata_scsi_slave_config()
Date: Mon, 20 Nov 2006 18:25:00 +0900
Message-ID: <20061120092500.GO2184@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:63538 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S934034AbWKTJZN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Nov 2006 04:25:13 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1124201ugc
        for <linux-ide@vger.kernel.org>; Mon, 20 Nov 2006 01:25:11 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

There's no reason to use underscored version in
ata_scsi_slave_config().  Use regular ata_scsi_find_dev().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-scsi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/ata/libata-scsi.c
===================================================================
--- work.orig/drivers/ata/libata-scsi.c
+++ work/drivers/ata/libata-scsi.c
@@ -840,7 +840,7 @@ static void ata_scsi_dev_config(struct s
 int ata_scsi_slave_config(struct scsi_device *sdev)
 {
 	struct ata_port *ap = ata_shost_to_port(sdev->host);
-	struct ata_device *dev = __ata_scsi_find_dev(ap, sdev);
+	struct ata_device *dev = ata_scsi_find_dev(ap, sdev);
 
 	ata_scsi_sdev_config(sdev);
 
