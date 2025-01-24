Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF78824A0
	for <linux-ide@vger.kernel.org>; Fri, 24 Jan 2025 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737727884; cv=none; b=YV/ThKhKEVBaOlAiOAaxaA6ouDH+u7qbivH1UOhpcyLEMh/jb27q+72WGi0Dk1JJKqSYbuMHJoctD+MQt+5cDiSJCBf7h4+5vRabJMkMX0hxJlaPWASuIDWSM7kS2L9O1hznflTZxQgb9r+NRbkdTK+fwDRr5Gfs8LGJVHerpVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737727884; c=relaxed/simple;
	bh=01h9ZTThVr3uF3LRia91YSW0KPvZbgYsg9oIvI479Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZcyGEGY76oT0j7wAOO5RPi1ZgyptnzOsSH5xlMVLaj9L4jKQVC930bNyBYIB+BqbnR0BESnbIaRE3R5Eb4GoHd1p3CCbyFF0WnalOmHf9rnvacnx52jJsDqvz9wHaUvuCbCsOdHir3ovpriCOW2Un2yfQhmMzVt1NTPdi762ljk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbK6Awg/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbK6Awg/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8D0C4CED2;
	Fri, 24 Jan 2025 14:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737727883;
	bh=01h9ZTThVr3uF3LRia91YSW0KPvZbgYsg9oIvI479Rk=;
	h=From:To:Cc:Subject:Date:From;
	b=kbK6Awg/ZNrl34B35Xc80KJVuQr53mJ0H35QHSwyaSBZlHKETELScS0CfWHEV6Fu1
	 sDLHV8k+Nh0187c7ONaCpWmSqH0nTJNlVag/FeCb7Cc8Lfck/xPh/p6h+b4DG9M6Y1
	 S7P0gfTZkHOWr6PIQx0CKD1jEMise/RHQRzc7Z+Kt3Jjk3tmSOpMBkQOhSHcBypbbE
	 RJnmgcDemLCIV/DdqEuUfBUI9O4tb982gv/212Jb6izheCgSOqiw9knQ/r5RC14HCp
	 171q7lMZ8UVh9sScP2faVtY+X/On9z1fMZ70GFlHxA5gzDdQEvWnkMaHovCW7TnYg4
	 wKraG07TnfBNQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	reveliofuzzing <reveliofuzzing@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata-sff: Ensure that we cannot write outside the allocated buffer
Date: Fri, 24 Jan 2025 15:11:19 +0100
Message-ID: <20250124141118.3722754-2-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2780; i=cassel@kernel.org; h=from:subject; bh=01h9ZTThVr3uF3LRia91YSW0KPvZbgYsg9oIvI479Rk=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNInz29b98t2TdA3f+2LC5w5pm9JYuSP85x9iu9ITGbdT Y/ZU75u6ChlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEQt4x/I8+3MPRMKPhtr/Z f62ZZ7n2tNyYsGrpcUm2A4XJdhemrZjN8D9EvnSna/G9m0qHVX+uEHubseK5+E75/X+/rtqQ+m+ V521+AA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

reveliofuzzing reported that a SCSI_IOCTL_SEND_COMMAND ioctl with out_len
set to 0xd42, SCSI command set to ATA_16 PASS-THROUGH, ATA command set to
ATA_NOP, and protocol set to ATA_PROT_PIO, can cause ata_pio_sector() to
write outside the allocated buffer, overwriting random memory.

While a ATA device is supposed to abort a ATA_NOP command, there does seem
to be a bug either in libata-sff or QEMU, where either this status is not
set, or the status is cleared before read by ata_sff_hsm_move().
Anyway, that is most likely a separate bug.

Looking at __atapi_pio_bytes(), it already has a safety check to ensure
that __atapi_pio_bytes() cannot write outside the allocated buffer.

Add a similar check to ata_pio_sector(), such that also ata_pio_sector()
cannot write outside the allocated buffer.

Reported-by: reveliofuzzing <reveliofuzzing@gmail.com>
Closes: https://lore.kernel.org/linux-ide/CA+-ZZ_jTgxh3bS7m+KX07_EWckSnW3N2adX3KV63y4g7M4CZ2A@mail.gmail.com/
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-sff.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 67f277e1c3bf..5a46c066abc3 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -601,7 +601,7 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct page *page;
-	unsigned int offset;
+	unsigned int offset, count;
 
 	if (!qc->cursg) {
 		qc->curbytes = qc->nbytes;
@@ -617,25 +617,27 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 	page = nth_page(page, (offset >> PAGE_SHIFT));
 	offset %= PAGE_SIZE;
 
-	trace_ata_sff_pio_transfer_data(qc, offset, qc->sect_size);
+	/* don't overrun current sg */
+	count = min(qc->cursg->length - qc->cursg_ofs, qc->sect_size);
+
+	trace_ata_sff_pio_transfer_data(qc, offset, count);
 
 	/*
 	 * Split the transfer when it splits a page boundary.  Note that the
 	 * split still has to be dword aligned like all ATA data transfers.
 	 */
 	WARN_ON_ONCE(offset % 4);
-	if (offset + qc->sect_size > PAGE_SIZE) {
+	if (offset + count > PAGE_SIZE) {
 		unsigned int split_len = PAGE_SIZE - offset;
 
 		ata_pio_xfer(qc, page, offset, split_len);
-		ata_pio_xfer(qc, nth_page(page, 1), 0,
-			     qc->sect_size - split_len);
+		ata_pio_xfer(qc, nth_page(page, 1), 0, count - split_len);
 	} else {
-		ata_pio_xfer(qc, page, offset, qc->sect_size);
+		ata_pio_xfer(qc, page, offset, count);
 	}
 
-	qc->curbytes += qc->sect_size;
-	qc->cursg_ofs += qc->sect_size;
+	qc->curbytes += count;
+	qc->cursg_ofs += count;
 
 	if (qc->cursg_ofs == qc->cursg->length) {
 		qc->cursg = sg_next(qc->cursg);
-- 
2.48.1

