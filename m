From: Marcos Paulo de Souza <marcos.mage@gmail.com>
Subject: [PATCH 3/3] drivers: ata: libata-scsi.c: Add function parameter documentation
Date: Mon, 31 Oct 2011 23:50:16 -0200
Message-ID: <1320112216-23810-1-git-send-email-marcos.mage@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: jgarzik@pobox.com
Cc: rdunlap@xenotime.net, linux-doc@vger.kernel.org, linux-ide@vger.kernel.org, Marcos Paulo de Souza <marcos.mage@gmail.com>
List-Id: linux-ide@vger.kernel.org

Add the documentation of parameters of ata_change_queue_depth to silence the warning of make xmldocs

Signed-off-by: Marcos paulo de Souza <marcos.mage@gmail.com>
---
 drivers/ata/libata-scsi.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 19ba770..5eceb23 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1216,6 +1216,10 @@ void ata_scsi_slave_destroy(struct scsi_device *sdev)
 
 /**
  *	__ata_change_queue_depth - helper for ata_scsi_change_queue_depth
+ *	@ap: ATA port to which the device change the queue depth
+ *	@sdev: SCSI device to configure queue depth for
+ *	@queue_depth: new queue depth
+ *	@reason: calling context
  *
  *	libsas and libata have different approaches for associating a sdev to
  *	its ata_port.
-- 
1.7.4.1

