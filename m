Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760011F419B
	for <linux-ide@vger.kernel.org>; Fri,  4 Jul 2025 10:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751626091; cv=none; b=OB89rJb/9vXECdaYO0f4a6KlqmYuiURhv1z5t1zAHcirUNGneMhTrq1z3NmhJyxsQjiJNte3T8qZGZL++OFJ01+EP4dd5c2ca0rVH9R8QDMUht5jQKql378nHigMs1i2gH1JlBYr/ha+PmosbzswrUYoMF4MTJfRnG8CV9SfG5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751626091; c=relaxed/simple;
	bh=OHMBGAC0EbAxFVfrJPWRD+5gUvoUYKdCpuM85/22q0Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=b1afm3qXFEXMwDEasv1f9xEnKdWfs7OF3uN3UB0LMwaeKmxgwuvmPIT4LfaPX1d1BQt+Ll7UY+0UuKXe3ZIEh1G/6VzVZnwjGRNVvSCmTeKIGM6m7HYcXho32PmfvjGse1bCnfevnnqDBfrrIB9jIiMh728AEGmY2AwgX9Le7Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l32hjWCL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l32hjWCL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AEEC4CEE3;
	Fri,  4 Jul 2025 10:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751626091;
	bh=OHMBGAC0EbAxFVfrJPWRD+5gUvoUYKdCpuM85/22q0Q=;
	h=From:To:Subject:Date:From;
	b=l32hjWCLF1rWPWcacxDifkq4KweGPmJPBcW1VmzplGFbaLX3gY691IH3TDiZEoh2w
	 e2R3mxNK2EwcD4Bom3r+3UvSbzyof+vAInh+q8m8Ur5kFP37ZnLIn+xJYLY/lfsJru
	 WGJWIZIV5fMg32GyU2fx8t8fEHMZsAmDskQxbmWFsdaaGZGEHt+emnrbxjpx1V95z/
	 ArdGzOmfjZ4qRoyLvVCdAoEomApGgBJ2lbEH+GJ6ueLrbAGLKK4bpehX6NmUvvgX/7
	 t06WYQfu8JEpzrHfboq9J2MDZ7zN1TN1C2h6YBpEyrTPpmlZcgZKPZgdJLVVCF/mIW
	 nWw3g8Kburgxw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] ata: libata: Introduce ata_port_eh_scheduled()
Date: Fri,  4 Jul 2025 19:46:00 +0900
Message-ID: <20250704104601.310643-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the inline helper function ata_port_eh_scheduled() to test if
EH is pending (ATA_PFLAG_EH_PENDING port flag is set) or running
(ATA_PFLAG_EH_IN_PROGRESS port flag is set) for a port. Use this helper
in ata_port_wait_eh() and __ata_scsi_queuecmd() to replace the hardcoded
port flag tests.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-eh.c   | 2 +-
 drivers/ata/libata-scsi.c | 5 +++--
 drivers/ata/libata.h      | 5 +++++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 1f8a6b930f5d..42aafb1ddb5a 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -823,7 +823,7 @@ void ata_port_wait_eh(struct ata_port *ap)
  retry:
 	spin_lock_irqsave(ap->lock, flags);
 
-	while (ap->pflags & (ATA_PFLAG_EH_PENDING | ATA_PFLAG_EH_IN_PROGRESS)) {
+	while (ata_port_eh_scheduled(ap)) {
 		prepare_to_wait(&ap->eh_wait_q, &wait, TASK_UNINTERRUPTIBLE);
 		spin_unlock_irqrestore(ap->lock, flags);
 		schedule();
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b502b123008a..27b15176db56 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4316,9 +4316,10 @@ int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev)
 	 * scsi_queue_rq() will defer commands if scsi_host_in_recovery().
 	 * However, this check is done without holding the ap->lock (a libata
 	 * specific lock), so we can have received an error irq since then,
-	 * therefore we must check if EH is pending, while holding ap->lock.
+	 * therefore we must check if EH is pending or running, while holding
+	 * ap->lock.
 	 */
-	if (ap->pflags & (ATA_PFLAG_EH_PENDING | ATA_PFLAG_EH_IN_PROGRESS))
+	if (ata_port_eh_scheduled(ap))
 		return SCSI_MLQUEUE_DEVICE_BUSY;
 
 	if (unlikely(!scmd->cmd_len))
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 135e1e5ee44e..ca44fb792aeb 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -51,6 +51,11 @@ static inline bool ata_dev_is_zac(struct ata_device *dev)
 		ata_id_zoned_cap(dev->id) == 0x01;
 }
 
+static inline bool ata_port_eh_scheduled(struct ata_port *ap)
+{
+	return ap->pflags & (ATA_PFLAG_EH_PENDING | ATA_PFLAG_EH_IN_PROGRESS);
+}
+
 #ifdef CONFIG_ATA_FORCE
 extern void ata_force_cbl(struct ata_port *ap);
 #else
-- 
2.50.0

