Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B46E52F7C
	for <linux-ide@vger.kernel.org>; Wed, 14 Feb 2024 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915686; cv=none; b=jQ1VP6oISSL1B/fpg1Mh2EeyB577fJn8r/Cf78BNIDvk/r5v5OlYxD8bBAwGNJIhbUesZyGUqK5pJt7LCLlcLpKVTc/H67hgZpu+NTVgdenE6SVwsfNx/Cq2jzMNo9VHgHOUjuNHior2iFHbkzz/5FtODFIlRXwzg1OXDNcIuVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915686; c=relaxed/simple;
	bh=PvHGi+JDdKZZF6VbMXBXMx1RFAPK0PLlLCK2+SPKpmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUjq7D/3IRMNGAGZtjhForKwOmJd1ZRHeifPqdKsRTw5+jFJfu0wXynICzxMxGpEIZTpvciu+HSGX0B/JLhtQrbCbN+W/V5sbq9pEmGTLdp37W7IzaCkl/mX6ztagz8qvCG4KNLong2cxkKWuxI1tcDo2ZA6MrXvKZyPN508ru0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W85qg4gp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W85qg4gp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D9BC433C7;
	Wed, 14 Feb 2024 13:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707915685;
	bh=PvHGi+JDdKZZF6VbMXBXMx1RFAPK0PLlLCK2+SPKpmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W85qg4gpepZLhKZxXcQX/dwuNylQHToqEA9xOHrX7JkLbfH6M4PPYZm1pXvGkqrl5
	 FEL9FRdv4kgWw8z8ay+k+DQ/dCc8FZkHeNgwfCk0bgPLiThs96sLS+aCxNn/B/bLRX
	 Ur5OzkDVz3C0d5/4N5btuEfdUPWV66NcStzRP5pZGGWWeIm1mkcH46dZPQ2XR/vEda
	 4apU/zLBVLY+QbnIFoycoy4nelWsVK2SIq7NY61nLTFu3/oM4QtvZJC3W+p/vzpzIw
	 xXlgZmi9TQZcuRL63uHjgQ0Gw+pF17vHZxX9l+vRwZBp3Oqpeya44TnLdlKUx6Nicg
	 vS3rp17uMlvnw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH v2 4/4] ahci: rename board_ahci_nomsi
Date: Wed, 14 Feb 2024 14:00:12 +0100
Message-ID: <20240214130015.952685-5-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214130015.952685-1-cassel@kernel.org>
References: <20240214130015.952685-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The naming format of the board_ahci_no* boards are:
board_ahci_no_debounce_delay
board_ahci_pcs_quirk_no_devslp
board_ahci_pcs_quirk_no_sntf

Rename board_ahci_nomsi to board_ahci_no_msi to match the other boards.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 9bff90fb0591..006312f5d73c 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -51,7 +51,7 @@ enum board_ids {
 	board_ahci_43bit_dma,
 	board_ahci_ign_iferr,
 	board_ahci_no_debounce_delay,
-	board_ahci_nomsi,
+	board_ahci_no_msi,
 	/*
 	 * board_ahci_pcs_quirk is for legacy Intel platforms.
 	 * Modern Intel platforms should use board_ahci instead.
@@ -151,7 +151,7 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
-	[board_ahci_nomsi] = {
+	[board_ahci_no_msi] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_MSI),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
@@ -621,8 +621,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	 * Samsung SSDs found on some macbooks.  NCQ times out if MSI is
 	 * enabled.  https://bugzilla.kernel.org/show_bug.cgi?id=60731
 	 */
-	{ PCI_VDEVICE(SAMSUNG, 0x1600), board_ahci_nomsi },
-	{ PCI_VDEVICE(SAMSUNG, 0xa800), board_ahci_nomsi },
+	{ PCI_VDEVICE(SAMSUNG, 0x1600), board_ahci_no_msi },
+	{ PCI_VDEVICE(SAMSUNG, 0xa800), board_ahci_no_msi },
 
 	/* Enmotus */
 	{ PCI_DEVICE(0x1c44, 0x8000), board_ahci },
-- 
2.43.0

