From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] libata-scsi: use %*ph to dump small buffers
Date: Fri,  6 May 2016 21:40:40 +0300
Message-ID: <1462560040-103475-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56070 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758152AbcEFSko (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 6 May 2016 14:40:44 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Replace custom approach by %*ph specifier to dump small buffers in hex format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/libata-scsi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index c7d0fc1..5bef807 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3646,14 +3646,11 @@ static inline void ata_scsi_dump_cdb(struct ata_port *ap,
 {
 #ifdef ATA_DEBUG
 	struct scsi_device *scsidev = cmd->device;
-	u8 *scsicmd = cmd->cmnd;
 
-	DPRINTK("CDB (%u:%d,%d,%d) %02x %02x %02x %02x %02x %02x %02x %02x %02x\n",
+	DPRINTK("CDB (%u:%d,%d,%d) %9ph\n",
 		ap->print_id,
 		scsidev->channel, scsidev->id, scsidev->lun,
-		scsicmd[0], scsicmd[1], scsicmd[2], scsicmd[3],
-		scsicmd[4], scsicmd[5], scsicmd[6], scsicmd[7],
-		scsicmd[8]);
+		cmd->cmnd);
 #endif
 }
 
-- 
2.8.1

