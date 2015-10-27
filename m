From: vinayak.kale@gmail.com
Subject: [PATCH] libata: enable LBA flag in taskfile for ata_scsi_pass_thru()
Date: Tue, 27 Oct 2015 13:11:46 +0530
Message-ID: <1445931706-9436-1-git-send-email-vinayak.kale@seagate.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: sumit.g.gupta@seagate.com, Vinayak Kale <vinayak.kale@seagate.com>
List-Id: linux-ide@vger.kernel.org

From: Vinayak Kale <vinayak.kale@seagate.com>

Enable LBA in taskfile flags for ata_scsi_pass_thru()

Signed-off-by: Vinayak Kale <vinayak.kale@seagate.com>
---
 drivers/ata/libata-scsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index c2af592..ff75cb6 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2949,6 +2949,9 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 	if ((tf->protocol = ata_scsi_map_proto(cdb[1])) == ATA_PROT_UNKNOWN)
 		goto invalid_fld;
 
+	/* enable LBA */
+	tf->flags |= ATA_TFLAG_LBA;
+
 	/*
 	 * 12 and 16 byte CDBs use different offsets to
 	 * provide the various register values.
-- 
1.9.1
