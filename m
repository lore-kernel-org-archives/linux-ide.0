From: "John W. Linville" <linville@tuxdriver.com>
Subject: [patch 2.6.12-rc4 1/1] libata: stop setting sdev->host->max_sectors for lba48 drives
Date: Thu, 12 May 2005 15:49:54 -0400
Message-ID: <20050512194953.GA8587@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ra.tuxdriver.com ([24.172.12.4]:1042 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261978AbVELTuC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 May 2005 15:50:02 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, stuart_hayes@Dell.com

Avoid changing sdev->host->max_sectors because it can prevent use of
non-lba48 drives on other ports of the same adapter.

Signed-off-by: Stuart Hayes <stuart_hayes@Dell.com>
Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/scsi/libata-scsi.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

--- linux-2.6.12-rc4/drivers/scsi/libata-scsi.c.orig	2005-05-12 15:13:51.414435435 -0400
+++ linux-2.6.12-rc4/drivers/scsi/libata-scsi.c	2005-05-12 15:22:55.813648107 -0400
@@ -347,7 +347,10 @@ int ata_scsi_slave_config(struct scsi_de
 		 */
 		if ((dev->flags & ATA_DFLAG_LBA48) &&
 		    ((dev->flags & ATA_DFLAG_LOCK_SECTORS) == 0)) {
-			sdev->host->max_sectors = 2048;
+			/*
+			 * do not overwrite sdev->host->max_sectors, since
+			 * other drives on this host may not support LBA48
+			 */
 			blk_queue_max_sectors(sdev->request_queue, 2048);
 		}
 	}
-- 
John W. Linville
linville@tuxdriver.com
