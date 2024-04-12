Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6F9161
	for <linux-ide@vger.kernel.org>; Fri, 12 Apr 2024 00:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712880931; cv=none; b=US6weqCa+oDoAv1kxrhSRMfQx1AcR7/fmFItf2n9BkENebRH3iFOD+x64+mL0OUuXw+NbO+Iy3Qfs0Dr3jT5nxwPwBX4M2ALG8Ts2Hxk2lBNQCHx/ptF84chTeTrFtIfT9syemwEEQUQbGA9kNFyg1qXHoaTj6KZytryzCSv320=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712880931; c=relaxed/simple;
	bh=9nCuTYoIE/mOSlQJhevqpAPjOIlqY6wwwyZANDjR7Do=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CsBFkXpnBYJ39REPnSxXThFsQAIlJeDRWWh0rv4AjAxo22mznrycggydsPZuWMjclzIfOw9AZ7VD0UDQwOf/fk4CVbKeAezcuocPIhtRUj3gFmkwKAVe/Oe+jkmKZzO40tMiou44I9rCqSvUfexC6aigAgjL5e6Lsk5AlN7qeCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYR3/+lR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYR3/+lR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A3BC072AA;
	Fri, 12 Apr 2024 00:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712880930;
	bh=9nCuTYoIE/mOSlQJhevqpAPjOIlqY6wwwyZANDjR7Do=;
	h=From:To:Subject:Date:From;
	b=OYR3/+lR7NYfWdc1RzRkfWuqPidPU4cNSCAvqiG7ifNv/u2vNimGfzC8i62dQKY08
	 1uDoVjycfHsIus35oUwIIeQyodt46CvcAj3pxGVwqYkVj0X25JPFdeqbI39yFF35sY
	 4tCCFcpHXoxeZWUrFT6Ywb0EAnLjOxHAvBATDZZsJVSN8UdkTrD38koiJD2FpbZq+i
	 //wHgS6d1+4CBdtGqAb8nRUnMrYHi18Uy7LKfcc91WEAMMeCXgWJKBiU7ryfbUgHRc
	 41ymyVNyYTYQ36aRNBb0wEjTsqs+NUWc0HcR6QiIMu52u6Wo/msTtjufs5P5+H3cfO
	 pfMohTKwawGAg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2] ata: libata-core: Remove ata_exec_internal_sg()
Date: Fri, 12 Apr 2024 09:15:28 +0900
Message-ID: <20240412001528.964063-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ata_exec_internal() is the only caller of ata_exec_internal_sg() and
always calls this function with a single element scattergather list.
Remove ata_exec_internal_sg() and code it directly in
ata_exec_internal(), simplifying a little the sgl handling for the
command.

While at it, change the function signature to use the proper enum
dma_data_direction type for the dma_dir argument, cleanup comments
(capitalization and remove useless comments) and change the variable
auto_timeout type to a boolean.

No functional change.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: John Garry <john.g.garry@oracle.com>
---

Changes from v1:
 - Moved declaration of sgl (Niklas comment)
 - Addressed John's comment and added his review tag

 drivers/ata/libata-core.c | 108 +++++++++++---------------------------
 drivers/ata/libata.h      |   8 +--
 2 files changed, 36 insertions(+), 80 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index be3412cdb22e..d668a21d294a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1480,19 +1480,19 @@ static void ata_qc_complete_internal(struct ata_queued_cmd *qc)
 }
 
 /**
- *	ata_exec_internal_sg - execute libata internal command
+ *	ata_exec_internal - execute libata internal command
  *	@dev: Device to which the command is sent
  *	@tf: Taskfile registers for the command and the result
  *	@cdb: CDB for packet command
  *	@dma_dir: Data transfer direction of the command
- *	@sgl: sg list for the data buffer of the command
- *	@n_elem: Number of sg entries
+ *	@buf: Data buffer of the command
+ *	@buflen: Length of data buffer
  *	@timeout: Timeout in msecs (0 for default)
  *
- *	Executes libata internal command with timeout.  @tf contains
- *	command on entry and result on return.  Timeout and error
- *	conditions are reported via return value.  No recovery action
- *	is taken after a command times out.  It's caller's duty to
+ *	Executes libata internal command with timeout. @tf contains
+ *	the command on entry and the result on return. Timeout and error
+ *	conditions are reported via the return value. No recovery action
+ *	is taken after a command times out. It is the caller's duty to
  *	clean up after timeout.
  *
  *	LOCKING:
@@ -1501,34 +1501,38 @@ static void ata_qc_complete_internal(struct ata_queued_cmd *qc)
  *	RETURNS:
  *	Zero on success, AC_ERR_* mask on failure
  */
-static unsigned ata_exec_internal_sg(struct ata_device *dev,
-				     struct ata_taskfile *tf, const u8 *cdb,
-				     int dma_dir, struct scatterlist *sgl,
-				     unsigned int n_elem, unsigned int timeout)
+unsigned int ata_exec_internal(struct ata_device *dev, struct ata_taskfile *tf,
+			       const u8 *cdb, enum dma_data_direction dma_dir,
+			       void *buf, unsigned int buflen,
+			       unsigned int timeout)
 {
 	struct ata_link *link = dev->link;
 	struct ata_port *ap = link->ap;
 	u8 command = tf->command;
-	int auto_timeout = 0;
 	struct ata_queued_cmd *qc;
+	struct scatterlist sgl;
 	unsigned int preempted_tag;
 	u32 preempted_sactive;
 	u64 preempted_qc_active;
 	int preempted_nr_active_links;
+	bool auto_timeout = false;
 	DECLARE_COMPLETION_ONSTACK(wait);
 	unsigned long flags;
 	unsigned int err_mask;
 	int rc;
 
+	if (WARN_ON(dma_dir != DMA_NONE && !buf))
+		return AC_ERR_INVALID;
+
 	spin_lock_irqsave(ap->lock, flags);
 
-	/* no internal command while frozen */
+	/* No internal command while frozen */
 	if (ata_port_is_frozen(ap)) {
 		spin_unlock_irqrestore(ap->lock, flags);
 		return AC_ERR_SYSTEM;
 	}
 
-	/* initialize internal qc */
+	/* Initialize internal qc */
 	qc = __ata_qc_from_tag(ap, ATA_TAG_INTERNAL);
 
 	qc->tag = ATA_TAG_INTERNAL;
@@ -1547,12 +1551,12 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
 	ap->qc_active = 0;
 	ap->nr_active_links = 0;
 
-	/* prepare & issue qc */
+	/* Prepare and issue qc */
 	qc->tf = *tf;
 	if (cdb)
 		memcpy(qc->cdb, cdb, ATAPI_CDB_LEN);
 
-	/* some SATA bridges need us to indicate data xfer direction */
+	/* Some SATA bridges need us to indicate data xfer direction */
 	if (tf->protocol == ATAPI_PROT_DMA && (dev->flags & ATA_DFLAG_DMADIR) &&
 	    dma_dir == DMA_FROM_DEVICE)
 		qc->tf.feature |= ATAPI_DMADIR;
@@ -1560,13 +1564,8 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
 	qc->flags |= ATA_QCFLAG_RESULT_TF;
 	qc->dma_dir = dma_dir;
 	if (dma_dir != DMA_NONE) {
-		unsigned int i, buflen = 0;
-		struct scatterlist *sg;
-
-		for_each_sg(sgl, sg, n_elem, i)
-			buflen += sg->length;
-
-		ata_sg_init(qc, sgl, n_elem);
+		sg_init_one(&sgl, buf, buflen);
+		ata_sg_init(qc, &sgl, 1);
 		qc->nbytes = buflen;
 	}
 
@@ -1578,11 +1577,11 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
 	spin_unlock_irqrestore(ap->lock, flags);
 
 	if (!timeout) {
-		if (ata_probe_timeout)
+		if (ata_probe_timeout) {
 			timeout = ata_probe_timeout * 1000;
-		else {
+		} else {
 			timeout = ata_internal_cmd_timeout(dev, command);
-			auto_timeout = 1;
+			auto_timeout = true;
 		}
 	}
 
@@ -1595,30 +1594,25 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
 	ata_sff_flush_pio_task(ap);
 
 	if (!rc) {
-		spin_lock_irqsave(ap->lock, flags);
-
-		/* We're racing with irq here.  If we lose, the
-		 * following test prevents us from completing the qc
-		 * twice.  If we win, the port is frozen and will be
-		 * cleaned up by ->post_internal_cmd().
+		/*
+		 * We are racing with irq here. If we lose, the following test
+		 * prevents us from completing the qc twice. If we win, the port
+		 * is frozen and will be cleaned up by ->post_internal_cmd().
 		 */
+		spin_lock_irqsave(ap->lock, flags);
 		if (qc->flags & ATA_QCFLAG_ACTIVE) {
 			qc->err_mask |= AC_ERR_TIMEOUT;
-
 			ata_port_freeze(ap);
-
 			ata_dev_warn(dev, "qc timeout after %u msecs (cmd 0x%x)\n",
 				     timeout, command);
 		}
-
 		spin_unlock_irqrestore(ap->lock, flags);
 	}
 
-	/* do post_internal_cmd */
 	if (ap->ops->post_internal_cmd)
 		ap->ops->post_internal_cmd(qc);
 
-	/* perform minimal error analysis */
+	/* Perform minimal error analysis */
 	if (qc->flags & ATA_QCFLAG_EH) {
 		if (qc->result_tf.status & (ATA_ERR | ATA_DF))
 			qc->err_mask |= AC_ERR_DEV;
@@ -1632,7 +1626,7 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
 		qc->result_tf.status |= ATA_SENSE;
 	}
 
-	/* finish up */
+	/* Finish up */
 	spin_lock_irqsave(ap->lock, flags);
 
 	*tf = qc->result_tf;
@@ -1652,44 +1646,6 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
 	return err_mask;
 }
 
-/**
- *	ata_exec_internal - execute libata internal command
- *	@dev: Device to which the command is sent
- *	@tf: Taskfile registers for the command and the result
- *	@cdb: CDB for packet command
- *	@dma_dir: Data transfer direction of the command
- *	@buf: Data buffer of the command
- *	@buflen: Length of data buffer
- *	@timeout: Timeout in msecs (0 for default)
- *
- *	Wrapper around ata_exec_internal_sg() which takes simple
- *	buffer instead of sg list.
- *
- *	LOCKING:
- *	None.  Should be called with kernel context, might sleep.
- *
- *	RETURNS:
- *	Zero on success, AC_ERR_* mask on failure
- */
-unsigned ata_exec_internal(struct ata_device *dev,
-			   struct ata_taskfile *tf, const u8 *cdb,
-			   int dma_dir, void *buf, unsigned int buflen,
-			   unsigned int timeout)
-{
-	struct scatterlist *psg = NULL, sg;
-	unsigned int n_elem = 0;
-
-	if (dma_dir != DMA_NONE) {
-		WARN_ON(!buf);
-		sg_init_one(&sg, buf, buflen);
-		psg = &sg;
-		n_elem++;
-	}
-
-	return ata_exec_internal_sg(dev, tf, cdb, dma_dir, psg, n_elem,
-				    timeout);
-}
-
 /**
  *	ata_pio_need_iordy	-	check if iordy needed
  *	@adev: ATA device
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 5c685bb1939e..1a9881dc2aa1 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -50,10 +50,10 @@ extern int ata_build_rw_tf(struct ata_queued_cmd *qc, u64 block, u32 n_block,
 			   unsigned int tf_flags, int dld, int class);
 extern u64 ata_tf_read_block(const struct ata_taskfile *tf,
 			     struct ata_device *dev);
-extern unsigned ata_exec_internal(struct ata_device *dev,
-				  struct ata_taskfile *tf, const u8 *cdb,
-				  int dma_dir, void *buf, unsigned int buflen,
-				  unsigned int timeout);
+unsigned int ata_exec_internal(struct ata_device *dev, struct ata_taskfile *tf,
+			       const u8 *cdb, enum dma_data_direction dma_dir,
+			       void *buf, unsigned int buflen,
+			       unsigned int timeout);
 extern int ata_wait_ready(struct ata_link *link, unsigned long deadline,
 			  int (*check_ready)(struct ata_link *link));
 extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
-- 
2.44.0

