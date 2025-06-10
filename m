Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAD228B3FF;
	Tue, 10 Jun 2025 13:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749563698; cv=none; b=stta/ntNO5Us90Nuvis4utyosEAHPLXmz9Xlqt0LoCfrV1LKVkP/of/ESKfBQ+mtPd9OOITsIlh9MUVeOTV9ea4I4sNY21bDf9V1BkGaikvvgStDyGK4IDunMRtUlmwK5t0R+QdYQipSCoVxn+sX7ekqeyRNmSOxKvCgJvrDYIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749563698; c=relaxed/simple;
	bh=UH/SWMNQuHkmIFjSb5OHrseeivBEWLX+7koxjrjy+SY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nFHZlRICvm3f83pm/amMm6+RYMyn8RFEGMOynSPvvB/1tUL4my5pIDmSiSebvbbjve9Nv0/0+QdNle0crtm9ih8bxFJfaskj2FZwIA/NEjcFSeoQrNpPKX6uGuLXvl+wptpgQUxtbjQLsq5EVwVHH57cKfqYTGxWiW8YGwFWLIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xla/ulEj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xla/ulEj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DE3C4CEEF;
	Tue, 10 Jun 2025 13:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749563698;
	bh=UH/SWMNQuHkmIFjSb5OHrseeivBEWLX+7koxjrjy+SY=;
	h=From:To:Cc:Subject:Date:From;
	b=Xla/ulEjtKn2jsB7jesIe7qVHSQzoUM1BTrXv0lUU9d2WIgC9wC+A9CJmWNemObIB
	 sazXbV+vjOxVhLVy6hJIByiznTNTV8A+YT8q4D1k2oHfd0PQv8e65RTbH5faALYB+E
	 1XMpws5w1E2aitb8o8WfA6j95YJ5+gCqPRY+pD67ViPIf7acbggYuRmRdMtvMGZ4zI
	 MabCzFqKacrG4lGGPfygNT9+7Ui6PPJ3JV3PYGS2dp00Spjz4Kmg8Jbt5sPgIuD9XR
	 riLk78DUI7ZapH7UhuITySgO2XRC4MxlhjK/GUIPTZ7asvWFgeqN7dBr5WqYxDysAZ
	 +MsS04xL6x6zg==
From: Philipp Stanner <phasta@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ata: pata_macio: Fix PCI region leak
Date: Tue, 10 Jun 2025 15:54:14 +0200
Message-ID: <20250610135413.35930-2-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_request_regions() became a managed devres functions if the PCI
device was enabled with pcim_enable_device(), which is the case for
pata_macio.

The PCI subsystem recently removed this hybrid feature from
pci_request_region(). When doing so, pata_macio was forgotten to be
ported to use pcim_request_all_regions(). If that function is not used,
pata_macio will fail on driver-reload because the PCI regions will
remain blocked.

Fix the region leak by replacing pci_request_regions() with its managed
counterpart, pcim_request_all_regions().

Fixes: 51f6aec99cb0 ("PCI: Remove hybrid devres nature from request functions")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
Changes in v2:
  - Add Fixes: tag and rephrase commit message, since the merge window
    closed already. (Niklas)
---
 drivers/ata/pata_macio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index fbf5f07ea357..f7a933eefe05 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -1298,7 +1298,7 @@ static int pata_macio_pci_attach(struct pci_dev *pdev,
 	priv->dev = &pdev->dev;
 
 	/* Get MMIO regions */
-	if (pci_request_regions(pdev, "pata-macio")) {
+	if (pcim_request_all_regions(pdev, "pata-macio")) {
 		dev_err(&pdev->dev,
 			"Cannot obtain PCI resources\n");
 		return -EBUSY;
-- 
2.49.0

