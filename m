Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B0F140E5F
	for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2025 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744795900; cv=none; b=OKLWveTGq2SQ1wEOSPx0krlhbLdonM56hDW6nLYEQulEE45FL5CEyKOrexpy1Kom13LZyox+eq337zagVWLreuaSSVulyhnOKt+UbflPCGFSHW801s0QlSOcT+zTHEc1XkQJpbiDyiqUD8OezPb3Q8YPFeJ++nbclthCh6c5otA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744795900; c=relaxed/simple;
	bh=/VX9vFfl2tswwHcuk9WHl4haJeoP4oRCjezyiPR0kPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BknwKmLYbRTzUSBLJMfuv960oLZHLeKC91b00Tfn9A73uMEBkFZFDEx2FueCIfJEmaFevBu5gBl/dNSOLXijDbu603lC1Tnb/cw2JODxksvg+vzkh/C/cmiZYjNlmmI5td+xnvzAu0DLBi49Beeg4zr2LDMU35WnTEmyzy6FKRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9rM/S/3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9rM/S/3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59677C4CEED;
	Wed, 16 Apr 2025 09:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744795899;
	bh=/VX9vFfl2tswwHcuk9WHl4haJeoP4oRCjezyiPR0kPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r9rM/S/3RTG5pw2wBR6pNZZcVUV+TSRmz1OXIH6YD6UH0NQKd5GXCtr/QEPdYofoE
	 Fvp58IQ+YKOJgRBxP2v+uCwQxkHSXJIwuQVPsVwOMQgLQjUNoO+4LnFzJ3KHO39nvz
	 WpyOc1BK1gZEqzSjPb6lIMVMGb5z9w1QBq+QTYjk9VAj+itBtP/RK6O/baBXzuPM4F
	 ka1erR9JVIRuCjHF/eMGXLPPw1FvDSFAwX+zOX2Rf41xcB85g7Nb7YIWpUTZUopuBP
	 5pO5c6OX59cDLWcHrt1Vyi0CRkKcFznmsWrFMHBWtqmUPOXhCa7f0CzKPl3K0Rzp7t
	 9orFIPU4V3kfg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Igor Pylypiv <ipylypiv@google.com>,
	Hannes Reinecke <hare@suse.de>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 1/3] ata: libata-sata: Save all fields from sense data descriptor
Date: Wed, 16 Apr 2025 11:31:29 +0200
Message-ID: <20250416093127.63666-6-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416093127.63666-5-cassel@kernel.org>
References: <20250416093127.63666-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2653; i=cassel@kernel.org; h=from:subject; bh=/VX9vFfl2tswwHcuk9WHl4haJeoP4oRCjezyiPR0kPM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNL/V3yRPhPeVlmz8Uhkwi/HflN7pekPXZ1fnc2ufBSxc UuX6Ly2jlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEwktoDhn7lHotT7czU6/ytr H72sSznzy3/lz0L9+tBZ/47v+2HufZfhD1flfONVdgcDVQwqUtTPKHw+rLQuyNdKvvqn3zrz33P nMQIA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

When filling the taskfile result for a successful NCQ command, we use
the SDB FIS from the FIS Receive Area, see e.g. ahci_qc_ncq_fill_rtf().

However, the SDB FIS only has fields STATUS and ERROR.

For a successful NCQ command that has sense data, we will have a
successful sense data descriptor, in the Sense Data for Successful NCQ
Commands log.

Since we have access to additional taskfile result fields, fill in these
additional fields in qc->result_tf.

This matches how for failing/aborted NCQ commands, we will use e.g.
ahci_qc_fill_rtf() to fill in some fields, but then for the command that
actually caused the NCQ error, we will use ata_eh_read_log_10h(), which
provides additional fields, saving additional fields/overriding the
qc->result_tf that was fetched using ahci_qc_fill_rtf().

Fixes: 18bd7718b5c4 ("scsi: ata: libata: Handle completion of CDL commands using policy 0xD")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Igor Pylypiv <ipylypiv@google.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-sata.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index ba300cc0a3a3..2e4463d3a356 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1510,6 +1510,8 @@ int ata_eh_get_ncq_success_sense(struct ata_link *link)
 	unsigned int err_mask, tag;
 	u8 *sense, sk = 0, asc = 0, ascq = 0;
 	u64 sense_valid, val;
+	u16 extended_sense;
+	bool aux_icc_valid;
 	int ret = 0;
 
 	err_mask = ata_read_log_page(dev, ATA_LOG_SENSE_NCQ, 0, buf, 2);
@@ -1529,6 +1531,8 @@ int ata_eh_get_ncq_success_sense(struct ata_link *link)
 
 	sense_valid = (u64)buf[8] | ((u64)buf[9] << 8) |
 		((u64)buf[10] << 16) | ((u64)buf[11] << 24);
+	extended_sense = get_unaligned_le16(&buf[14]);
+	aux_icc_valid = extended_sense & BIT(15);
 
 	ata_qc_for_each_raw(ap, qc, tag) {
 		if (!(qc->flags & ATA_QCFLAG_EH) ||
@@ -1556,6 +1560,17 @@ int ata_eh_get_ncq_success_sense(struct ata_link *link)
 			continue;
 		}
 
+		qc->result_tf.nsect = sense[6];
+		qc->result_tf.hob_nsect = sense[7];
+		qc->result_tf.lbal = sense[8];
+		qc->result_tf.lbam = sense[9];
+		qc->result_tf.lbah = sense[10];
+		qc->result_tf.hob_lbal = sense[11];
+		qc->result_tf.hob_lbam = sense[12];
+		qc->result_tf.hob_lbah = sense[13];
+		if (aux_icc_valid)
+			qc->result_tf.auxiliary = get_unaligned_le32(&sense[16]);
+
 		/* Set sense without also setting scsicmd->result */
 		scsi_build_sense_buffer(dev->flags & ATA_DFLAG_D_SENSE,
 					qc->scsicmd->sense_buffer, sk,
-- 
2.49.0

