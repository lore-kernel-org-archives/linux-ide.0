From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: use ata_scsi_find_dev() in ata_scsi_slave_config()
Date: Tue, 12 Dec 2006 13:29:07 +0900
Message-ID: <20061212042907.GE18947@htj.dyndns.org>
References: <20061120092534.GP2184@htj.dyndns.org> <456C43BF.4060807@rtr.ca> <456C6E93.9040203@gmail.com> <20061212042431.GD18947@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.231]:33890 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbWLLE3N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Dec 2006 23:29:13 -0500
Received: by wx-out-0506.google.com with SMTP id h27so1779255wxd
        for <linux-ide@vger.kernel.org>; Mon, 11 Dec 2006 20:29:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20061212042431.GD18947@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

It is wrong to configure SCSI device according to disabled ATA device.
Use regular ata_scsi_find_dev() instead of the underbarred version in
ata_scsi_slave_config().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-scsi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/ata/libata-scsi.c
===================================================================
--- work.orig/drivers/ata/libata-scsi.c
+++ work/drivers/ata/libata-scsi.c
@@ -868,7 +868,7 @@ int ata_scsi_slave_alloc(struct scsi_dev
 int ata_scsi_slave_config(struct scsi_device *sdev)
 {
 	struct ata_port *ap = ata_shost_to_port(sdev->host);
-	struct ata_device *dev = __ata_scsi_find_dev(ap, sdev);
+	struct ata_device *dev = ata_scsi_find_dev(ap, sdev);
 
 	ata_scsi_sdev_config(sdev);
 
