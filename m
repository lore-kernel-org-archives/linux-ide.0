From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/4] libata: implement ata_exec_internal_sg()
Date: Tue, 14 Nov 2006 22:47:09 +0900
Message-ID: <11635120293623-git-send-email-htejun@gmail.com>
References: <1163512029469-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:62599 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965810AbWKNNrR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Nov 2006 08:47:17 -0500
Received: by wr-out-0506.google.com with SMTP id i22so143727wra
        for <linux-ide@vger.kernel.org>; Tue, 14 Nov 2006 05:47:16 -0800 (PST)
In-Reply-To: <1163512029469-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Sg'ify ata_exec_internal() and call it ata_exec_internal_sg().
Wrapper function around ata_exec_internal_sg() is implemented to
provide ata_exec_internal() interface.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   49 ++++++++++++++++++++++++++++++++++++++------
 drivers/ata/libata.h      |    4 +++
 2 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index dab577c..9ddc512 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1042,13 +1042,13 @@ void ata_qc_complete_internal(struct ata
 }
 
 /**
- *	ata_exec_internal - execute libata internal command
+ *	ata_exec_internal_sg - execute libata internal command
  *	@dev: Device to which the command is sent
  *	@tf: Taskfile registers for the command and the result
  *	@cdb: CDB for packet command
  *	@dma_dir: Data tranfer direction of the command
- *	@buf: Data buffer of the command
- *	@buflen: Length of data buffer
+ *	@sg: sg list for the data buffer of the command
+ *	@n_elem: Number of sg entries
  *
  *	Executes libata internal command with timeout.  @tf contains
  *	command on entry and result on return.  Timeout and error
@@ -1062,9 +1062,10 @@ void ata_qc_complete_internal(struct ata
  *	RETURNS:
  *	Zero on success, AC_ERR_* mask on failure
  */
-unsigned ata_exec_internal(struct ata_device *dev,
-			   struct ata_taskfile *tf, const u8 *cdb,
-			   int dma_dir, void *buf, unsigned int buflen)
+unsigned ata_exec_internal_sg(struct ata_device *dev,
+			      struct ata_taskfile *tf, const u8 *cdb,
+			      int dma_dir, struct scatterlist *sg,
+			      unsigned int n_elem)
 {
 	struct ata_port *ap = dev->ap;
 	u8 command = tf->command;
@@ -1120,7 +1121,12 @@ unsigned ata_exec_internal(struct ata_de
 	qc->flags |= ATA_QCFLAG_RESULT_TF;
 	qc->dma_dir = dma_dir;
 	if (dma_dir != DMA_NONE) {
-		ata_sg_init_one(qc, buf, buflen);
+		unsigned int i, buflen = 0;
+
+		for (i = 0; i < n_elem; i++)
+			buflen += sg[i].length;
+
+		ata_sg_init(qc, sg, n_elem);
 		qc->nsect = buflen / ATA_SECT_SIZE;
 	}
 
@@ -1204,6 +1210,35 @@ unsigned ata_exec_internal(struct ata_de
 }
 
 /**
+ *	ata_exec_internal_sg - execute libata internal command
+ *	@dev: Device to which the command is sent
+ *	@tf: Taskfile registers for the command and the result
+ *	@cdb: CDB for packet command
+ *	@dma_dir: Data tranfer direction of the command
+ *	@buf: Data buffer of the command
+ *	@buflen: Length of data buffer
+ *
+ *	Wrapper around ata_exec_internal_sg() which takes simple
+ *	buffer instead of sg list.
+ *
+ *	LOCKING:
+ *	None.  Should be called with kernel context, might sleep.
+ *
+ *	RETURNS:
+ *	Zero on success, AC_ERR_* mask on failure
+ */
+unsigned ata_exec_internal(struct ata_device *dev,
+			   struct ata_taskfile *tf, const u8 *cdb,
+			   int dma_dir, void *buf, unsigned int buflen)
+{
+	struct scatterlist sg;
+
+	sg_init_one(&sg, buf, buflen);
+
+	return ata_exec_internal_sg(dev, tf, cdb, dma_dir, &sg, 1);
+}
+
+/**
  *	ata_do_simple_cmd - execute simple internal command
  *	@dev: Device to which the command is sent
  *	@cmd: Opcode to execute
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 0549b19..c82318b 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -51,6 +51,10 @@ extern void ata_port_flush_task(struct a
 extern unsigned ata_exec_internal(struct ata_device *dev,
 				  struct ata_taskfile *tf, const u8 *cdb,
 				  int dma_dir, void *buf, unsigned int buflen);
+extern unsigned ata_exec_internal_sg(struct ata_device *dev,
+				     struct ata_taskfile *tf, const u8 *cdb,
+				     int dma_dir, struct scatterlist *sg,
+				     unsigned int n_elem);
 extern unsigned int ata_do_simple_cmd(struct ata_device *dev, u8 cmd);
 extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 			   int post_reset, u16 *id);
-- 
1.4.3.3


