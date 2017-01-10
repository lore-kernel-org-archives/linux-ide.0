From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6/6] libata: switch to dynamic allocation insted of ata_scsi_rbuf
Date: Tue, 10 Jan 2017 09:41:48 +0100
Message-ID: <1484037708-654-7-git-send-email-hch@lst.de>
References: <1484037708-654-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:36520 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030266AbdAJImN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jan 2017 03:42:13 -0500
In-Reply-To: <1484037708-654-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: geert@linux-m68k.org, linux-ide@vger.kernel.org

Note of the emulated commands in the pageout/pagein path, so just do
a GFP_NOIO dynamic allocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ata/libata-scsi.c | 122 ++++++++++++++--------------------------------
 1 file changed, 36 insertions(+), 86 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 395c859..785eb382 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -57,9 +57,6 @@
 
 #define ATA_SCSI_RBUF_SIZE	4096
 
-static DEFINE_SPINLOCK(ata_scsi_rbuf_lock);
-static u8 ata_scsi_rbuf[ATA_SCSI_RBUF_SIZE];
-
 typedef unsigned int (*ata_xlat_func_t)(struct ata_queued_cmd *qc);
 
 static struct ata_device *__ata_scsi_find_dev(struct ata_port *ap,
@@ -2057,53 +2054,6 @@ struct ata_scsi_args {
 };
 
 /**
- *	ata_scsi_rbuf_get - Map response buffer.
- *	@cmd: SCSI command containing buffer to be mapped.
- *	@flags: unsigned long variable to store irq enable status
- *	@copy_in: copy in from user buffer
- *
- *	Prepare buffer for simulated SCSI commands.
- *
- *	LOCKING:
- *	spin_lock_irqsave(ata_scsi_rbuf_lock) on success
- *
- *	RETURNS:
- *	Pointer to response buffer.
- */
-static void *ata_scsi_rbuf_get(struct scsi_cmnd *cmd, bool copy_in,
-			       unsigned long *flags)
-{
-	spin_lock_irqsave(&ata_scsi_rbuf_lock, *flags);
-
-	memset(ata_scsi_rbuf, 0, ATA_SCSI_RBUF_SIZE);
-	if (copy_in)
-		sg_copy_to_buffer(scsi_sglist(cmd), scsi_sg_count(cmd),
-				  ata_scsi_rbuf, ATA_SCSI_RBUF_SIZE);
-	return ata_scsi_rbuf;
-}
-
-/**
- *	ata_scsi_rbuf_put - Unmap response buffer.
- *	@cmd: SCSI command containing buffer to be unmapped.
- *	@copy_out: copy out result
- *	@flags: @flags passed to ata_scsi_rbuf_get()
- *
- *	Returns rbuf buffer.  The result is copied to @cmd's buffer if
- *	@copy_back is true.
- *
- *	LOCKING:
- *	Unlocks ata_scsi_rbuf_lock.
- */
-static inline void ata_scsi_rbuf_put(struct scsi_cmnd *cmd, bool copy_out,
-				     unsigned long *flags)
-{
-	if (copy_out)
-		sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd),
-				    ata_scsi_rbuf, ATA_SCSI_RBUF_SIZE);
-	spin_unlock_irqrestore(&ata_scsi_rbuf_lock, *flags);
-}
-
-/**
  *	ata_scsi_rbuf_fill - wrapper for SCSI command simulators
  *	@args: device IDENTIFY data / SCSI command of interest.
  *	@actor: Callback hook for desired SCSI command simulator
@@ -2121,17 +2071,22 @@ static inline void ata_scsi_rbuf_put(struct scsi_cmnd *cmd, bool copy_out,
 static void ata_scsi_rbuf_fill(struct ata_scsi_args *args,
 		unsigned int (*actor)(struct ata_scsi_args *args, u8 *rbuf))
 {
-	u8 *rbuf;
-	unsigned int rc;
 	struct scsi_cmnd *cmd = args->cmd;
-	unsigned long flags;
+	u8 *buf;
 
-	rbuf = ata_scsi_rbuf_get(cmd, false, &flags);
-	rc = actor(args, rbuf);
-	ata_scsi_rbuf_put(cmd, rc == 0, &flags);
+	buf = kzalloc(ATA_SCSI_RBUF_SIZE, GFP_NOIO);
+	if (!buf) {
+		ata_scsi_set_sense(args->dev, cmd, NOT_READY, 0x08, 0);
+		return;
+	}
 
-	if (rc == 0)
+	if (actor(args, buf) == 0) {
+		sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd),
+				    buf, ATA_SCSI_RBUF_SIZE);
 		cmd->result = SAM_STAT_GOOD;
+	}
+
+	kfree(buf);
 }
 
 /**
@@ -3363,24 +3318,17 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
  *
  * Return: Number of bytes copied into sglist.
  */
-static size_t ata_format_dsm_trim_descr(struct scsi_cmnd *cmd, u32 trmax,
+static ssize_t ata_format_dsm_trim_descr(struct scsi_cmnd *cmd, u32 trmax,
 					u64 sector, u32 count)
 {
-	struct scsi_device *sdp = cmd->device;
-	size_t len = sdp->sector_size;
 	size_t r;
 	__le64 *buf;
 	u32 i = 0;
-	unsigned long flags;
 
-	WARN_ON(len > ATA_SCSI_RBUF_SIZE);
-
-	if (len > ATA_SCSI_RBUF_SIZE)
-		len = ATA_SCSI_RBUF_SIZE;
+	buf = kzalloc(cmd->device->sector_size, GFP_NOFS);
+	if (!buf)
+		return -ENOMEM;
 
-	spin_lock_irqsave(&ata_scsi_rbuf_lock, flags);
-	buf = ((void *)ata_scsi_rbuf);
-	memset(buf, 0, len);
 	while (i < trmax) {
 		u64 entry = sector |
 			((u64)(count > 0xffff ? 0xffff : count) << 48);
@@ -3390,9 +3338,9 @@ static size_t ata_format_dsm_trim_descr(struct scsi_cmnd *cmd, u32 trmax,
 		count -= 0xffff;
 		sector += 0xffff;
 	}
-	r = sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd), buf, len);
-	spin_unlock_irqrestore(&ata_scsi_rbuf_lock, flags);
-
+	r = sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd), buf,
+			cmd->device->sector_size);
+	kfree(buf);
 	return r;
 }
 
@@ -3408,16 +3356,15 @@ static size_t ata_format_dsm_trim_descr(struct scsi_cmnd *cmd, u32 trmax,
  *
  * Return: Number of bytes copied into sglist.
  */
-static size_t ata_format_sct_write_same(struct scsi_cmnd *cmd, u64 lba, u64 num)
+static ssize_t ata_format_sct_write_same(struct scsi_cmnd *cmd, u64 lba,
+		u64 num)
 {
-	struct scsi_device *sdp = cmd->device;
-	size_t len = sdp->sector_size;
 	size_t r;
 	u16 *buf;
-	unsigned long flags;
 
-	spin_lock_irqsave(&ata_scsi_rbuf_lock, flags);
-	buf = ((void *)ata_scsi_rbuf);
+	buf = kzalloc(cmd->device->sector_size, GFP_NOIO);
+	if (!buf)
+		return -ENOMEM;
 
 	put_unaligned_le16(0x0002,  &buf[0]); /* SCT_ACT_WRITE_SAME */
 	put_unaligned_le16(0x0101,  &buf[1]); /* WRITE PTRN FG */
@@ -3425,14 +3372,9 @@ static size_t ata_format_sct_write_same(struct scsi_cmnd *cmd, u64 lba, u64 num)
 	put_unaligned_le64(num,     &buf[6]);
 	put_unaligned_le32(0u,      &buf[10]); /* pattern */
 
-	WARN_ON(len > ATA_SCSI_RBUF_SIZE);
-
-	if (len > ATA_SCSI_RBUF_SIZE)
-		len = ATA_SCSI_RBUF_SIZE;
-
-	r = sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd), buf, len);
-	spin_unlock_irqrestore(&ata_scsi_rbuf_lock, flags);
-
+	r = sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd), buf,
+			cmd->device->sector_size);
+	kfree(buf);
 	return r;
 }
 
@@ -3451,7 +3393,7 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 	struct ata_taskfile *tf = &qc->tf;
 	struct scsi_cmnd *scmd = qc->scsicmd;
 	struct scsi_device *sdp = scmd->device;
-	size_t len = sdp->sector_size;
+	ssize_t len = sdp->sector_size;
 	struct ata_device *dev = qc->dev;
 	const u8 *cdb = scmd->cmnd;
 	u64 block;
@@ -3508,6 +3450,8 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 	 */
 	if (unmap) {
 		size = ata_format_dsm_trim_descr(scmd, trmax, block, n_block);
+		if (size < 0)
+			goto comm_fail;
 		if (size != len)
 			goto invalid_param_len;
 
@@ -3531,6 +3475,8 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 		}
 	} else {
 		size = ata_format_sct_write_same(scmd, block, n_block);
+		if (size < 0)
+			goto comm_fail;
 		if (size != len)
 			goto invalid_param_len;
 
@@ -3569,6 +3515,10 @@ static unsigned int ata_scsi_write_same_xlat(struct ata_queued_cmd *qc)
 	/* "Invalid command operation code" */
 	ata_scsi_set_sense(dev, scmd, ILLEGAL_REQUEST, 0x20, 0x0);
 	return 1;
+comm_fail:
+	/* "Logical unit communication failure" */
+	ata_scsi_set_sense(dev, scmd, NOT_READY, 0x08, 0);
+	return 1;
 }
 
 /**
-- 
2.1.4

