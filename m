Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9538317A31F
	for <linux-ide@vger.kernel.org>; Tue, 15 Apr 2025 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744702229; cv=none; b=Q5ZEc4V2d2uXlDnj9bg2BYZAK8F7hSUgVTiK6EYnyq12AJfNFIuFw3G+XpjjS5ZrulS8UjdMJhNE0+lBf6y1nrR7X7ZEoMDoyzVZZybsQJVrQf8Ily5SLyygRP3Qfnxe8xqXa/p+/O7tCla3+TkT2BVOdUJQQEypchpx54O5mh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744702229; c=relaxed/simple;
	bh=/VX9vFfl2tswwHcuk9WHl4haJeoP4oRCjezyiPR0kPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIvw7VoqUzVUzvviM09YqS4FrFvcmh9muUSwgr2LgGm1laZvtb4CSsY+18AnUXbyJWHDUgyfBmhsJ+LDcx0UFGWfLNGEMnX4XnejjKh2SZtz//kbiKITlgL4GarFp3PjoXDv4kupJpxFZhIXDKpKwysGK4uTWB65OtAukdO2so0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbGlBSPP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbGlBSPP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71FEC4CEEB;
	Tue, 15 Apr 2025 07:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744702229;
	bh=/VX9vFfl2tswwHcuk9WHl4haJeoP4oRCjezyiPR0kPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XbGlBSPPkOs53hYcRh2zF+17TAmqVs/9UNRWDb8GfZxuOkvPkFrMK8QB0uVcjP8Yb
	 BRUusVYrO0BUBlVKHwmJ1HKYytGIov0GezCb3mL4LHMxEVGZbLoN/iPlkZ9eUUjTyv
	 01LgOPv2KA3ob14sIpQZQ9p27QvsuZzZY9/e0kYgwXzSqs+eXneNzPZwCh8AhaZov7
	 JWZJg8aPrDxR0xT01izYoOjQDPhMbalZ6eBD5sf78VUQtfy3eZ5PAy0GY4jyZrgnIO
	 NBNsPR5rfQkTbmDbsZml7e4SobpVlRCQu+rBvxExi9vjwTiEa66tRGKux2/fpkxnbA
	 wfykRmr8VRiWg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Igor Pylypiv <ipylypiv@google.com>,
	Hannes Reinecke <hare@suse.de>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 1/3] ata: libata-sata: Save all fields from sense data descriptor
Date: Tue, 15 Apr 2025 09:30:15 +0200
Message-ID: <20250415073013.414987-6-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415073013.414987-5-cassel@kernel.org>
References: <20250415073013.414987-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2653; i=cassel@kernel.org; h=from:subject; bh=/VX9vFfl2tswwHcuk9WHl4haJeoP4oRCjezyiPR0kPM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNL/cXNKnwlvq6zZeCQy4Zdjv6m90vSHrs6vzmZXPorYu KVLdF5bRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACZSfYyR4czEE7s/fNyy+p36 H/nzE+dp+vlXhyg7SducsFivXM1rUsrIsO/VhQhmkbtai3krHO91ihm2X9O8GbDqtwSX3dSZG0O SGAA=
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

