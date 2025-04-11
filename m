Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353DA189520
	for <linux-ide@vger.kernel.org>; Fri, 11 Apr 2025 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377933; cv=none; b=e7Nxw/P6BQZA40CPDYeWiRu4jEmH38v6zwQrxsOeydp22PZBMea52RYKypMKJCKW3fm90JuDn3ZYcqBMXuygcomSYEqLBQci+ON6ZL81CjwncpqUYw6mal2cZoeoPWPcG60brQYDMrxyuofUeMTujYS4oRP0Da5uMT3v0OmOmDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377933; c=relaxed/simple;
	bh=R8br4nKJaZoYacb3ZCqyKKEst1kugM2uj4PZfGX0v50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pUllc6Q0dISr85TS/uaKK9FAyswfXZ42sCwdgtY6MxT7P58OO+y3gbu2g0JDu+K5oeatTxpkE6nIURxJdDDFTrBaa7se6OtQ2/Avs8Y16dQAlORHTirln0Qt2LZmb61T2rlNN/JgnH4C84Ena9rzvYiT1G/+VPeaXQ8OcBOtFKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDAZ/aF0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDAZ/aF0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A1DC4CEE2;
	Fri, 11 Apr 2025 13:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744377932;
	bh=R8br4nKJaZoYacb3ZCqyKKEst1kugM2uj4PZfGX0v50=;
	h=From:To:Cc:Subject:Date:From;
	b=QDAZ/aF0W6fLRTkJHiHHfrei6rGP+v1VUB43IA62l4ZQ5ifzM2grxphWeAgo501z7
	 dZEpnN3iOqmChsQTI+mR1sAmpp3rDcGmih5cfb8y4vIhPCpkLp7TWii6Nx3wbQIRrb
	 2b1lrfbxw/LXOP8rwvdc9nWibf7BXRK0qWHOmLd5I2rKyR6ZX36cngjLS35HBCL/kU
	 Oy1LGY7FHT9Yv3bDwbRUGzhFscC4QJvJBFkhA4f8xBxZbH4YON6Fh75er0ln+VjGpf
	 iM9a8p6DkWh8bgbeEWVUZN+xtBtrILrbG2AeO/dadKp+z8liIzlurszO8h3Rowl8wY
	 8WKM664hyuuGQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Igor Pylypiv <ipylypiv@google.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 1/2] ata: libata-sata: Save all fields from sense data descriptor
Date: Fri, 11 Apr 2025 15:25:23 +0200
Message-ID: <20250411132522.126316-3-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2709; i=cassel@kernel.org; h=from:subject; bh=R8br4nKJaZoYacb3ZCqyKKEst1kugM2uj4PZfGX0v50=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJ/Sjjt4rj3/XTQ31tFxfJsPsFls1MX/SwU3KLgkzlZZ P/sJREKHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZhIPxsjw46Fezvm7Oqonc5y 5KnpX8H9ep4bpfY8TFG4Z6Z+/OzOfayMDNvyeJesEO69bLFVcr/stZXfOb03W21e1m+UvTBIdc4 zeQ4A
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
---
This is basically v3 of the patch that was previously sent out here:
https://lore.kernel.org/linux-ide/20250409084546.121694-2-cassel@kernel.org/

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

