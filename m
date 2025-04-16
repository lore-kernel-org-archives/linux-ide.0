Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A9C140E5F
	for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2025 09:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744795901; cv=none; b=Cr1C7QREEY2ciuMHKOM8sOK2cbjg/VjvEfVIDGzGssV4eNvIOyselketCjyQy1sHwMnXV4Sfe9MT6hllGjcZ19SaP6TDcbgCLY8aOl2u9Dv6Z6z0gM2Ij0+u07BsBA1/kTQziYynpqmHLUcbuRXjGySq8iN1nE/haAop4oFqyCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744795901; c=relaxed/simple;
	bh=SxGDxesBuOrQMQ4ndt0+cpwVugmTRwb32y6/Gks+PI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lkc4K+Trz/ZjZSCwUUHw/E36C8mqLuaiBKgv+/ypeBEIKc2pCMbgiPRV2tIdGStX2/6FflUoET3gCEY3Ilc4ejV3JpywhSjMAx+6wvmD83zS8UUmZOPL3JDs72cUdJsjqWLlW3RXSYlZDDNlejSZ2kOn1ama/l+tGE+Y/LIXSQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtzgC9bw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtzgC9bw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0512DC4CEE9;
	Wed, 16 Apr 2025 09:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744795901;
	bh=SxGDxesBuOrQMQ4ndt0+cpwVugmTRwb32y6/Gks+PI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jtzgC9bw6HhiOk1UJLb/GyWvHA884mu97NLFevLA9+urTOUzY1uPVf/oaLp7ftzLA
	 hqmoQ+/QJzdhyTb42uP8L2cYtSX17gFpOaLFFTo1CvgErgvFwkNzzkBXbpbXq8PwPT
	 G664EH/6L3vaENu0Ktu3x8U4OtEIrCiX8+1TFqg10XEcPuk3J8tk7tKgxD9eGKP3dQ
	 /ENjQsmzzfFLvuJ8XOQ8khi3reNLyA/MSrWmTbi+44BuVkT0ymUok8jPOxDwu9I2tT
	 Qp6mT5xPdKu8IkwmsSMXghaO0lKylOAgJTwCqK4xKitfCrJw/xEuV4p65gMZNUunCT
	 H5aCmds57ygrA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Igor Pylypiv <ipylypiv@google.com>,
	Hannes Reinecke <hare@suse.de>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 2/3] ata: libata-sata: Simplify sense_valid fetching
Date: Wed, 16 Apr 2025 11:31:30 +0200
Message-ID: <20250416093127.63666-7-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416093127.63666-5-cassel@kernel.org>
References: <20250416093127.63666-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1865; i=cassel@kernel.org; h=from:subject; bh=SxGDxesBuOrQMQ4ndt0+cpwVugmTRwb32y6/Gks+PI0=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNL/V3z5/+XB1a0yzL9Ox4ap7jtdwPvWZn1BTqSeRJ/1D 6PzXe1KHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZjIfXuG/0Wnt9Q951qQsevH vQulcgsCTTccrnfvNvBqym/+dSmI+RQjw+r4CRfddD8eebSdY37xRu2bvmvq5kyyTf6UYRlbz1P 9kREA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

While the SENSE DATA VALID field in the ACS-6 specification is 47 bits,
we are currently only fetching 32 bits, because these are the only bits
that we care about (these bits represent the tags (which can be 0-31)).

Thus, replace the existing logic with a simple get_unaligned_le32().

While at it, change the type of sense_valid to u32.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-sata.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 2e4463d3a356..89d3b784706b 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1509,9 +1509,10 @@ int ata_eh_get_ncq_success_sense(struct ata_link *link)
 	struct ata_queued_cmd *qc;
 	unsigned int err_mask, tag;
 	u8 *sense, sk = 0, asc = 0, ascq = 0;
-	u64 sense_valid, val;
 	u16 extended_sense;
 	bool aux_icc_valid;
+	u32 sense_valid;
+	u64 val;
 	int ret = 0;
 
 	err_mask = ata_read_log_page(dev, ATA_LOG_SENSE_NCQ, 0, buf, 2);
@@ -1529,8 +1530,7 @@ int ata_eh_get_ncq_success_sense(struct ata_link *link)
 		return -EIO;
 	}
 
-	sense_valid = (u64)buf[8] | ((u64)buf[9] << 8) |
-		((u64)buf[10] << 16) | ((u64)buf[11] << 24);
+	sense_valid = get_unaligned_le32(&buf[8]);
 	extended_sense = get_unaligned_le16(&buf[14]);
 	aux_icc_valid = extended_sense & BIT(15);
 
@@ -1545,7 +1545,7 @@ int ata_eh_get_ncq_success_sense(struct ata_link *link)
 		 * If the command does not have any sense data, clear ATA_SENSE.
 		 * Keep ATA_QCFLAG_EH_SUCCESS_CMD so that command is finished.
 		 */
-		if (!(sense_valid & (1ULL << tag))) {
+		if (!(sense_valid & (1 << tag))) {
 			qc->result_tf.status &= ~ATA_SENSE;
 			continue;
 		}
-- 
2.49.0

