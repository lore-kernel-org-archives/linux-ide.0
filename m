Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF58524CF
	for <linux-ide@vger.kernel.org>; Wed, 14 Feb 2024 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915676; cv=none; b=usnktEz7K542NZvYJg3e6DC+XLkWq7BHGbTx6VHFsSpgfJnrKS3taxUUEN69Zx8uKu1i6/smMZ5nPr+HYLiY5Czqf4KV6l59qL3APsXtdRTj/buNkVWlJX3yac4BmXnt7yGhUWy5yud3djPwqDVK/uP+9+H+fhN99nleFpGkQ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915676; c=relaxed/simple;
	bh=pzUGy3QoYut1UhUr+3npruNiDitOvErQ46ai3tD8zOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAUMNjF6dExHEQhKfIS9qrEHUXi9fModM+DQd6rojT00huqkxm3nRWIhidHUbIT8lrgCUxdJm9oCJdzkHTpOHoO2QlZgbpkAC2TLipospEjGYVQPdmY7Q0S6B1bz3wI6AB6ECny1uFveWzlPgbOISYehrzMXe3+uBtNZBgmhLoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAixjuOD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAixjuOD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F6FC433F1;
	Wed, 14 Feb 2024 13:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707915675;
	bh=pzUGy3QoYut1UhUr+3npruNiDitOvErQ46ai3tD8zOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gAixjuODWeiHyVN2nVAvt9I94W1YFGnxBam8x0t1SdcEHkc9OUZGoyAvbnnKdKaGc
	 j15j+uuNxjCM/1Lkv1nS8o8YQNAkqSDcBA4x/LY8+KtLyE2o/EhcvP7RjxLE5bY7W7
	 4sybDkGnd+mDhY4v8V0fKtOYv60L3TGezx+TF1iEpwdi3klSfSUs/g9CgWfmkACdLF
	 dit0HEP6Tl9eibSBmns6Tro25bQH8/jKn8JGf9Ijqvi0p80JxFKax6ONSY0ljmNvJE
	 r7fcXsgM7MML1uz0t3oPIC7YZCMrIJi62UsWLI6TJWoNN1MragNHz1CpjrDg1cY17f
	 o4MRTBUmOEOAg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-ide@vger.kernel.org
Subject: [PATCH v2 1/4] ahci: rename board_ahci_nosntf
Date: Wed, 14 Feb 2024 14:00:09 +0100
Message-ID: <20240214130015.952685-2-cassel@kernel.org>
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

Commit 7edbb6059274 ("ahci: clean up intel_pcs_quirk") added a new board
type (board_ahci_pcs_quirk) which applies the Intel PCS quirk for legacy
platforms. However, it also modified board_ahci_avn and board_ahci_nosntf
to apply the same quirk.

board_ahci_avn is defined under the label:
/* board IDs for specific chipsets in alphabetical order */
This is a board for a specific chipset, so the naming is perfectly fine.
(The name does not need to be suffixed with _pcs_quirk, since all
controllers for this chipset require the quirk to be applied).

board_ahci_nosntf is defined under the label:
/* board IDs by feature in alphabetical order */
This is a board for a specific feature/quirk. However, it is used to
apply two different quirks.

Rename board_ahci_nosntf to more clearly highlight that this board ID
applies two different quirks.

Fixes: 7edbb6059274 ("ahci: clean up intel_pcs_quirk")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 41b4c9777c85..a2efe916c6e2 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -53,7 +53,6 @@ enum board_ids {
 	board_ahci_no_debounce_delay,
 	board_ahci_nomsi,
 	board_ahci_noncq,
-	board_ahci_nosntf,
 	/*
 	 * board_ahci_pcs_quirk is for legacy Intel platforms.
 	 * Modern Intel platforms should use board_ahci instead.
@@ -62,6 +61,7 @@ enum board_ids {
 	 * without testing that the platform actually works without the quirk.)
 	 */
 	board_ahci_pcs_quirk,
+	board_ahci_pcs_quirk_no_sntf,
 	board_ahci_yes_fbs,
 
 	/* board IDs for specific chipsets in alphabetical order */
@@ -165,16 +165,16 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
-	[board_ahci_nosntf] = {
-		AHCI_HFLAGS	(AHCI_HFLAG_NO_SNTF |
-				 AHCI_HFLAG_INTEL_PCS_QUIRK),
+	[board_ahci_pcs_quirk] = {
+		AHCI_HFLAGS	(AHCI_HFLAG_INTEL_PCS_QUIRK),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
-	[board_ahci_pcs_quirk] = {
-		AHCI_HFLAGS	(AHCI_HFLAG_INTEL_PCS_QUIRK),
+	[board_ahci_pcs_quirk_no_sntf] = {
+		AHCI_HFLAGS	(AHCI_HFLAG_INTEL_PCS_QUIRK |
+				 AHCI_HFLAG_NO_SNTF),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
@@ -271,7 +271,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x2683), board_ahci_pcs_quirk }, /* ESB2 */
 	{ PCI_VDEVICE(INTEL, 0x27c6), board_ahci_pcs_quirk }, /* ICH7-M DH */
 	{ PCI_VDEVICE(INTEL, 0x2821), board_ahci_pcs_quirk }, /* ICH8 */
-	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci_nosntf }, /* ICH8/Lewisburg RAID*/
+	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci_pcs_quirk_no_sntf }, /* ICH8/Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0x2824), board_ahci_pcs_quirk }, /* ICH8 */
 	{ PCI_VDEVICE(INTEL, 0x2829), board_ahci_pcs_quirk }, /* ICH8M */
 	{ PCI_VDEVICE(INTEL, 0x282a), board_ahci_pcs_quirk }, /* ICH8M */
-- 
2.43.0

