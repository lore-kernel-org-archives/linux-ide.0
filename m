Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E22720B00
	for <linux-ide@vger.kernel.org>; Wed,  7 Feb 2024 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297066; cv=none; b=fS3rAcDeCYxL7+/RDuOdz0LVVbPrFq5DdBvrFU1Uo/cXawfnzWepSoGDtqSivf6byAqdgWHITwRX2o1iHGDcMmlgw1Z/1EHq5GQSwO7218zIOe0pRS8mpwyfhRLeTas2e1TeaBPgIiIUffJxzVq1gCTa/zrsGgYaxQpOkozqxM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297066; c=relaxed/simple;
	bh=42wBY9/V8c/T6FEP/zDlhweZdk/nbI78of/6m6fE6rc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sw6UO/iSumVDXiX9qkJXfiDN8cqy2Zv/C7TwTnKM4DR8qcxl/++HigPMaJItoKA9Sm+LjzZghRhcl9V9kYFhvO57MaS0nS/0rfmmOkfNiSnZMysWYVjEAxvsw2ZALhUY6X0PylrYaf2vZKfLGRkM+9tZxthlvxVE4ZkitqJC6Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyReCYPX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyReCYPX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D47C433C7;
	Wed,  7 Feb 2024 09:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707297065;
	bh=42wBY9/V8c/T6FEP/zDlhweZdk/nbI78of/6m6fE6rc=;
	h=From:To:Cc:Subject:Date:From;
	b=dyReCYPXlOZVrz6FZO+7auj/EjXNz2RY5TJ9v9eCYwm6gZdfsicoWrdSH8OfyC1pc
	 QKTeySiOd1/UDR6YZ4KMFxeDzW851bQ35Vgahn5oukOA0iNq1wpRubvEmceKX6FBU5
	 mRAsbJI9Ynt3Hl3AraBlb0vGeOp+BSJ9VITsLmQ8SAIpRrrbA/+xYsoGE7osriWVSH
	 9t6VQDFMqoIN6HFLt1ven3qZxX0MOrF6v0HenJXmiscGxGtwKajlCtv8NHugE4WjZy
	 3+jKDW1uXnpqisD8018LZ7IaARPO/dBQvJ0uJNdqiYBe3DFyPRnVXZsZ7S9Sg4PVbt
	 7eOG69vMZvRFw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ahci: document and clarify unconventional intel quirk
Date: Wed,  7 Feb 2024 10:10:53 +0100
Message-ID: <20240207091054.1697236-1-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ahci_intel_pcs_quirk is unconventional in several ways:
First of all because it has a board ID for which the quirk should NOT be
applied (board_ahci_pcs7), instead of the usual way where we have a board
ID for which the quirk should be applied.

The second reason is that other than only excluding board_ahci_pcs7 from
the quirk, PCI devices that make use of the generic entry in ahci_pci_tbl
(which matches on AHCI class code) are also excluded.

This can of course lead to very subtle breakage, and did indeed do so in:
commit 104ff59af73a ("ata: ahci: Add Tiger Lake UP{3,4} AHCI controller"),
which added an explicit entry with board_ahci_low_power to ahci_pci_tbl.

This caused many users to complain that their SATA drives disappeared.
The logical assumption was of course that the issue was related to LPM,
and was therefore reverted in commit 6210038aeaf4 ("ata: ahci: Revert
"ata: ahci: Add Tiger Lake UP{3,4} AHCI controller"").

It took a lot of time to figure out that this was all completely unrelated
to LPM, and was instead caused by an unconventional Intel quirk.

While this quirk should definitely be cleaned up to be implemented like
all other quirks, for now, at least document the behavior of this quirk.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217114
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index da2e74fce2d9..122278438092 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -69,8 +69,8 @@ enum board_ids {
 	board_ahci_vt8251,
 
 	/*
-	 * board IDs for Intel chipsets that support more than 6 ports
-	 * *and* end up needing the PCS quirk.
+	 * board IDs for Intel chipsets that should NOT have the
+	 * ahci_intel_pcs_quirk applied. Yes, this is not a typo.
 	 */
 	board_ahci_pcs7,
 
@@ -1670,14 +1670,33 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap,
 		ap->target_lpm_policy = policy;
 }
 
+/*
+ * NOTE: this quirk is applied for all board IDs in ahci_pci_tbl, where
+ * the PCI vendor ID == PCI_VENDOR_ID_INTEL (except for board_ahci_pcs7).
+ *
+ * This quirk causes some Intel AHCI controllers (e.g. Intel Tiger Lake)
+ * to not get a link up when Intel VMD is enabled, see:
+ * https://bugzilla.kernel.org/show_bug.cgi?id=217114
+ *
+ * Since the quirk is only applied for explicit entries in ahci_pci_tbl
+ * (it does not apply to the generic entry in ahci_pci_tbl that matches on
+ * AHCI class code), if your Intel AHCI controller does not get a link up
+ * because of this quirk, try to remove the explicit entry from ahci_pci_tbl.
+ */
 static void ahci_intel_pcs_quirk(struct pci_dev *pdev, struct ahci_host_priv *hpriv)
 {
-	const struct pci_device_id *id = pci_match_id(ahci_pci_tbl, pdev);
+	const struct pci_device_id *id;
 	u16 tmp16;
 
+	/* If the detected PCI device is not an Intel device, skip. */
+	if (pdev->vendor != PCI_VENDOR_ID_INTEL)
+		return;
+
 	/*
-	 * Only apply the 6-port PCS quirk for known legacy platforms.
+	 * See if there is an explicit entry for this PCI device in
+	 * ahci_pci_tbl, if there is not, do not apply the quirk.
 	 */
+	id = pci_match_id(ahci_pci_tbl, pdev);
 	if (!id || id->vendor != PCI_VENDOR_ID_INTEL)
 		return;
 
-- 
2.43.0

