From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [patch 3/4] libata: expose AN to user space
Date: Wed, 8 Aug 2007 12:08:29 -0700
Message-ID: <20070808120829.97022745.kristen.c.accardi@intel.com>
References: <20070808190613.616085010@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <20070808190613.616085010@localhost.localdomain>
Sender: linux-scsi-owner@vger.kernel.org
To: jeff@garzik.org
Cc: James.Bottomley@steeleye.com, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Kristen Carlson Accardi <kristen.c.accardi@intel.com>
List-Id: linux-ide@vger.kernel.org

If Asynchronous Notification of media change events is supported,
pass that information up to the SCSI layer.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Index: 2.6-git/drivers/ata/libata-scsi.c
===================================================================
--- 2.6-git.orig/drivers/ata/libata-scsi.c
+++ 2.6-git/drivers/ata/libata-scsi.c
@@ -771,6 +771,9 @@ static void ata_scsi_dev_config(struct s
 		blk_queue_max_hw_segments(q, q->max_hw_segments - 1);
 	}
 
+	if (dev->flags & ATA_DFLAG_AN)
+		sdev->media_change_notify = 1;
+
 	if (dev->flags & ATA_DFLAG_NCQ) {
 		int depth;
 

-- 
