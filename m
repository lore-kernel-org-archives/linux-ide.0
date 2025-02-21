Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40B91BEF8A
	for <linux-ide@vger.kernel.org>; Fri, 21 Feb 2025 01:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740102868; cv=none; b=DdYm9l1K4a1ORGMlJDd/SYdGy647nrlZP9gkCrppXSw+JXiwPcE+m/PNTKDekVwS7zN2jiv0zYKkGUwwBbKG6teZFJFOMhIxJWSgVellCiQAULkPo5BPpU4qLbH27P+jVZzO4FV//CE05MMd/jeeWqgZagjDJ7JPIkRGIgOhLcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740102868; c=relaxed/simple;
	bh=fufAntR8nLPFeqgMuXx46QWPVLjoi5MaKAju54ZEPB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H72A46jj1oUJEER08Q93guG60lebwSwkuNZcJukeLBCYTCRJM0RusTIlk91VGG1+zsba2aj7LLBy3RZ/P/0vRsh5hoSWjxQBIyBIps54VDM+lR2ZYgLCjg8cWL1nlFTOw8Ng5UHNplSCjpH4aBUqXj4zC0uHpBGa0NGXnwo/I80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+FrJBvg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+FrJBvg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC47C4CED1;
	Fri, 21 Feb 2025 01:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740102867;
	bh=fufAntR8nLPFeqgMuXx46QWPVLjoi5MaKAju54ZEPB4=;
	h=From:To:Cc:Subject:Date:From;
	b=Y+FrJBvg7pvSgHdK6BoIFEgikJyIHL5a2kzG6uYF658SELB5cbcFdYbPwUCimt+ss
	 b1f+Bc/q2YcRyENygI7ah/l021d4UYBurS7m0Rdlgm4XLh7uxLIoW+M5qlCIUbYY2W
	 gCUv2ViUuyeov48cAlP5LnPBBcgNtY0s6TSlT5EZXBUeDPSTj/ikYFsI9mAuW5nbLr
	 8nP5YK6ZeuREoMpx2DfMnKLIdIrVJr++y3RRYdJi8uGwUpd/x1fUXox7TYov31BqE1
	 4XCpDR86jF+J6ssDlJ6k3AUeHCA9BNxE05T/ZG6+4fz4oA5Oozm9xg2SDnwpnEkryU
	 mdLoclGJ2Ep9Q==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Philip Pemberton <lists@philpem.me.uk>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata-eh: Do not use ATAPI DMA for a device limited to PIO mode
Date: Fri, 21 Feb 2025 02:54:23 +0100
Message-ID: <20250221015422.20687-2-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1721; i=cassel@kernel.org; h=from:subject; bh=fufAntR8nLPFeqgMuXx46QWPVLjoi5MaKAju54ZEPB4=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNK33zn3JG6+wHv3r6/snAIzVi99se/j6WeiC90yvGI0C nldZjHu6ShlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEuiwZ/sembl6/aeORCbxT FnX8rZZZ+le9zOtu1w/7swGhrcH7H3kwMnw03Nz55pPRzDMTpivO5D5wZq9CsVJJS8gTDU72RJ8 D1lwA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

atapi_eh_request_sense() currently uses ATAPI DMA if the SATA controller
has ATA_FLAG_PIO_DMA (PIO cmds via DMA) set.

However, ATA_FLAG_PIO_DMA is a flag that can be set by a low-level driver
on a port at initialization time, before any devices are scanned.

If a controller detects a connected device that only supports PIO, we set
the flag ATA_DFLAG_PIO.

Modify atapi_eh_request_sense() to not use ATAPI DMA if the connected
device only supports PIO.

Reported-by: Philip Pemberton <lists@philpem.me.uk>
Closes: https://lore.kernel.org/linux-ide/c6722ee8-5e21-4169-af59-cbbae9edc02f@philpem.me.uk/
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-eh.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 3b303d4ae37a..16cd676eae1f 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1542,8 +1542,15 @@ unsigned int atapi_eh_request_sense(struct ata_device *dev,
 	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf.command = ATA_CMD_PACKET;
 
-	/* is it pointless to prefer PIO for "safety reasons"? */
-	if (ap->flags & ATA_FLAG_PIO_DMA) {
+	/*
+	 * Do not use DMA if the connected device only supports PIO, even if the
+	 * port prefers PIO commands via DMA.
+	 *
+	 * Ideally, we should call atapi_check_dma() to check if it is safe for
+	 * the LLD to use DMA for REQUEST_SENSE, but we don't have a qc.
+	 * Since we can't check the command, perhaps we should only use pio?
+	 */
+	if ((ap->flags & ATA_FLAG_PIO_DMA) && !(dev->flags & ATA_DFLAG_PIO)) {
 		tf.protocol = ATAPI_PROT_DMA;
 		tf.feature |= ATAPI_PKT_DMA;
 	} else {
-- 
2.48.1

