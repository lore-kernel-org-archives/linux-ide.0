Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9548B231C8D
	for <linux-ide@vger.kernel.org>; Mon, 17 Mar 2025 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210280; cv=none; b=QIWpFXb1IE9BK2QABaK70c8wRjTNl4VAI9bxwEB0KEVXtq+JccGv0ISEhvyA5U+i9UAy6E8u9+tsIGnGfOlCCW1z5NOMALezPNGkcmgFZ9PmztFpoeCdkTqtlOUZbjoJdjvYAcQD3XqfWhtKW3BCx2WsrJV9KA8xzzhYOQQ079A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210280; c=relaxed/simple;
	bh=I1vhSdUwsE9ZrD56e9nBNdKT5ekJCp/puRbz9j156eo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=agd5Newl93YtB6J25V9hRK16VW4YJCg5uhz+pbCAEdx1TL1HQCk0ikIPM52+mkhn3PUPGU4hEKp32sXHapmBPA86j3XC/vZ3fZ5yeTXcaHU2N0mhlEThVzdOU+/H1mE8gxb2fPrOHfjUS46CUAKU9eyugCHYkwbV1TorqjQzVB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zotvqb8R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zotvqb8R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3646C4CEF6;
	Mon, 17 Mar 2025 11:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742210280;
	bh=I1vhSdUwsE9ZrD56e9nBNdKT5ekJCp/puRbz9j156eo=;
	h=From:To:Cc:Subject:Date:From;
	b=Zotvqb8RX1hc5yxKX34MAymcDg7zbZnlLJLY61/qwOX24CHACD+q+wkya0L87eC2R
	 y+J0oTlQu+BTvsATz4zJ306kRgDVmLwLBc/c+XtoIO/H8WN55KlQZQLElpRW21QE1U
	 J2z9i932RQqHKOOfpObB/LFp5Ev6pnpCU9CFpMWcTawN3meJoAwhzsfe7DwFSJNuBu
	 88RwxvPLX/S3grXFUQvv1Lv4cpWYselb2OPQiWnMb3+6mBd7pAVRz0w3Ec7FQtoY3f
	 Qh8lwhAnQoHFwr9Ai3Uk44SlFifkx3T7F7taTVq1p210r6NyfLmWaiEzup9fhpZDJB
	 WTot0v30ieq8g==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] ata: libata: Fix NCQ Non-Data log not supported print
Date: Mon, 17 Mar 2025 12:17:55 +0100
Message-ID: <20250317111754.1666084-2-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=cassel@kernel.org; h=from:subject; bh=I1vhSdUwsE9ZrD56e9nBNdKT5ekJCp/puRbz9j156eo=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJvsDw6dnNPxAWrh5eMBebm80ybEq4z9wOj8Q/dKeWp0 9jsl+ce7ChlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEWO4wMqyWn31/7frwpSdv nbu4b/MfiXaHytXbhX7Gn/Y8Vfsrz0eYkeGZsmt27P6d5RZ9T1P1asyfxj2YpNJe31T/6eYHdUn dTA4A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Currently, both ata_dev_config_ncq_send_recv() - which checks for NCQ
Send/Recv Log (Log Address 13h) and ata_dev_config_ncq_non_data() -
which checks for NCQ Non-Data Log (Log Address 12h), uses the same
print when the log is not supported:

  "NCQ Send/Recv Log not supported"

This seems like a copy paste error, since NCQ Non-Data Log is actually
a separate log.

Fix the print the reference the correct log.

Fixes: 284b3b77ea88 ("libata: NCQ encapsulation for ZAC MANAGEMENT OUT")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 193fc3942fd3a..e17e16706db70 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2274,7 +2274,7 @@ static void ata_dev_config_ncq_non_data(struct ata_device *dev)
 
 	if (!ata_log_supported(dev, ATA_LOG_NCQ_NON_DATA)) {
 		ata_dev_warn(dev,
-			     "NCQ Send/Recv Log not supported\n");
+			     "NCQ Non-Data Log not supported\n");
 		return;
 	}
 	err_mask = ata_read_log_page(dev, ATA_LOG_NCQ_NON_DATA,
-- 
2.48.1

