Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034B752F6E
	for <linux-ide@vger.kernel.org>; Wed, 14 Feb 2024 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915683; cv=none; b=s6kMKAH70T7PqlXogvuRRwSMXdSzyDh3UhOzSro8wH6iIV1eSUyLYDcGdEGQYzSHkPnREUPygJwYDf7xK8I8C7NnDngsrrSIVt7wVVVlZWOI3HE4YsogaTtF+ox5iw6pF5RqXHY2CDn/S0/e+5jp8ZZpNBEcOIRiPC84gl1ib/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915683; c=relaxed/simple;
	bh=6NgQKlzYmOU6+vffAr++oN2Zi/2QxjKiPC8KoDmxzPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wk4k7AYSRoeEsuXIe4WnC/UoG/OrwpZ5GRtQu5BBeA6YF8lc1csuosxpOLngoYnkVScfvTJ/FWIkstdZrHex2qHVoADqylVgQz98OMcqE/uxtB/va28Xs2kSebPFsgp+nOH/0s8JtZoNF3XYqQptb95wOxNmQ7rDMKvFxrTSXdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7yIt3iu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7yIt3iu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462E7C433F1;
	Wed, 14 Feb 2024 13:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707915682;
	bh=6NgQKlzYmOU6+vffAr++oN2Zi/2QxjKiPC8KoDmxzPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T7yIt3iuuU6alxe9g1bsYATBxQ/+l22XXPJvqzKvz+HWuUAbbyq3kmTNBmcQhqQ+f
	 UPfqS9nhhz809BM4oqpheeXBAUw78FVa7vCvOjuw8Segp3IS+pcF+XSGcER/wuXHj0
	 l0gGs18y1qwIXlsNs7+sgxiPitfzWXVZ9fduYe861Cr3HggtFheCu6aHymsPh0v/Sm
	 aEG+H5OuDpD5u0KZea4h5fxrqU0cDjuqPweZ0cNnQ4BidZ4ahJDSXcvO1fEpF7jIce
	 B6NKcpEbGWtO3zlse3jNcFG+VmvIz1+LgvjdCxDvqpiNeA3/GBBs4v5GtwCEMg+/ts
	 eCe5Hnv5nHHCA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH v2 3/4] ahci: drop unused board_ahci_noncq
Date: Wed, 14 Feb 2024 14:00:11 +0100
Message-ID: <20240214130015.952685-4-cassel@kernel.org>
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

Since commit 66a7cbc303f4 ("ahci: disable MSI instead of NCQ on Samsung
pci-e SSDs on macbooks") there is not a single entry in ahci_pci_tbl
which uses board_ahci_noncq.

Since this is dead code, let's remove it.
We cannot remove AHCI_HFLAG_NO_NCQ, as this flag is still used by other
boards.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index d8e5b26524f6..9bff90fb0591 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -52,7 +52,6 @@ enum board_ids {
 	board_ahci_ign_iferr,
 	board_ahci_no_debounce_delay,
 	board_ahci_nomsi,
-	board_ahci_noncq,
 	/*
 	 * board_ahci_pcs_quirk is for legacy Intel platforms.
 	 * Modern Intel platforms should use board_ahci instead.
@@ -159,13 +158,6 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
-	[board_ahci_noncq] = {
-		AHCI_HFLAGS	(AHCI_HFLAG_NO_NCQ),
-		.flags		= AHCI_FLAG_COMMON,
-		.pio_mask	= ATA_PIO4,
-		.udma_mask	= ATA_UDMA6,
-		.port_ops	= &ahci_ops,
-	},
 	[board_ahci_pcs_quirk] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_INTEL_PCS_QUIRK),
 		.flags		= AHCI_FLAG_COMMON,
-- 
2.43.0

