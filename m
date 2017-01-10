From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/6] libata: move struct ata_scsi_args to libata-scsi.c
Date: Tue, 10 Jan 2017 09:41:44 +0100
Message-ID: <1484037708-654-3-git-send-email-hch@lst.de>
References: <1484037708-654-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:36036 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030266AbdAJImA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jan 2017 03:42:00 -0500
In-Reply-To: <1484037708-654-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: geert@linux-m68k.org, linux-ide@vger.kernel.org

It's only used in libata-scsi.c, so move it closer to the users.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ata/libata-scsi.c | 7 +++++++
 drivers/ata/libata.h      | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 031a77a..43694f5 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2057,6 +2057,13 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 		return SCSI_MLQUEUE_HOST_BUSY;
 }
 
+struct ata_scsi_args {
+	struct ata_device	*dev;
+	u16			*id;
+	struct scsi_cmnd	*cmd;
+	void			(*done)(struct scsi_cmnd *);
+};
+
 /**
  *	ata_scsi_rbuf_get - Map response buffer.
  *	@cmd: SCSI command containing buffer to be mapped.
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 8f3a559..9943772 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -31,13 +31,6 @@
 #define DRV_NAME	"libata"
 #define DRV_VERSION	"3.00"	/* must be exactly four chars */
 
-struct ata_scsi_args {
-	struct ata_device	*dev;
-	u16			*id;
-	struct scsi_cmnd	*cmd;
-	void			(*done)(struct scsi_cmnd *);
-};
-
 /* libata-core.c */
 enum {
 	/* flags for ata_dev_read_id() */
-- 
2.1.4

