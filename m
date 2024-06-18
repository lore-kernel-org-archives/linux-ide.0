Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418DB4A35
	for <linux-ide@vger.kernel.org>; Tue, 18 Jun 2024 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724956; cv=none; b=M6gnud3qRX0nAFyTpYBslgfqLgeacQEC6rC7KRtmV+sKl0+pjZbjqQpJ8F6om9fy3RWVTLUMzZdcWDrj6lJcZtg3ZGPSJa+WGoo7xRlpAG+kbFpeTnZe1CV0gA9PbOA9CtoL82MuKurtXKaeFMZ2ELpjKW5KWvE4bw/Gf0FXG94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724956; c=relaxed/simple;
	bh=Y44fEDGKN9vffWzBM+sgPUMpgI4qwXdkQx4LvHyvr24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yis0urr1D7DCvK/vicRTHJTm4B6pPHluWuzoQovEVfxc/uA5xdvm/fUHj9F0JqiIoPGdkpxpFmla2SGDkv5dINcRiVh2yzqDBeDJDI0eJMGvxGstBfbzQX/SkJBNyJlb9DJGhl2L51ktUtSYUB5fgGVdOhKJ8tCzYDk6lCpFQJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKmXY7cS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKmXY7cS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7E2C3277B;
	Tue, 18 Jun 2024 15:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718724956;
	bh=Y44fEDGKN9vffWzBM+sgPUMpgI4qwXdkQx4LvHyvr24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TKmXY7cSGshbW27TgXIdH89dliy4vy8ceHzGY/GREdPw69pNtya/wuu8PC0R4wRA4
	 FSaam4ZnItPgKs01H6nPKIJnBEm1ZkLxs6PubKaVDVELqdez+TObRXZFpz5NMYpmdR
	 sHKoZlxsln8GRvSzd4H2NQX71xUyyVq+1e1bPe1gxjb9+Dt7efo0Le9Hqc1+JTapbd
	 wh8/MozYLvJRmfok++zhT0Fq1npBkXVfd+/vYnWs1Zvoic6tW5Qqxq4YPtgIKIckQn
	 ZaFJrjNY/+743zGVD087376TdFSKjtJ3LgYw5gjoaFa9llQcz2C1hPFCNb0MLFfvg7
	 58uD3dbPvhR0Q==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH 2/5] ata: libata-scsi: Remove superfluous assignment in ata_sas_port_alloc()
Date: Tue, 18 Jun 2024 17:35:40 +0200
Message-ID: <20240618153537.2687621-9-cassel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618153537.2687621-7-cassel@kernel.org>
References: <20240618153537.2687621-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=726; i=cassel@kernel.org; h=from:subject; bh=Y44fEDGKN9vffWzBM+sgPUMpgI4qwXdkQx4LvHyvr24=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIKV3r1GieHK2hpfMj+qXlmxesd798FrKp4vm7KAVep7 Ub6y7UqOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjARy4eMDKdllq1NXqFQJ/NO 9Fzb0SstnK0tdjNi+G4c4Jrp8STm+hSG36y/fwVKr0z/L5rfVFT0OLf5Vkapi3WUi8+xhXtqdrw UZgYA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

ata_sas_port_alloc() calls ata_port_alloc() which already assigns ap->lock
so there is no need to ata_sas_port_alloc() to assign it again.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-sata.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 9e047bf912b1..c564eac9d430 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1228,7 +1228,6 @@ struct ata_port *ata_sas_port_alloc(struct ata_host *host,
 		return NULL;
 
 	ap->port_no = 0;
-	ap->lock = &host->lock;
 	ap->pio_mask = port_info->pio_mask;
 	ap->mwdma_mask = port_info->mwdma_mask;
 	ap->udma_mask = port_info->udma_mask;
-- 
2.45.2

