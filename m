Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F578524CF
	for <linux-ide@vger.kernel.org>; Wed, 14 Feb 2024 13:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915679; cv=none; b=hz2FAj0rtlQfjMogU+D/Ey+ADBOKES8FqFo1J92NR6MpKOAKF4GtJD8IaFegrewiJ6GHVVv/M7R3URVvqWtftjW8mqbfgduTAri6t1MTaOeQNm05vD/vUhhnhYe4kiWcdy7+8x85lf96IQY5aNh4eIxQTLMAec3xL2fDrcpmfvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915679; c=relaxed/simple;
	bh=L20ciClvYZHH9gtUIEiC0xm2wBDQdImDTyV5f7Kmm2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTQD7BnWi6Ww9cJ03Rg1W4r5BRM2zarQFet0kUfneagYiiH3DTGLD0Yqbaoo4WrkC6icHWUbVhysDVHKpVGKrWsBn1yp6d4TSL3YvtbKjBKGzSMswfcahcOqZ33vAEkBmcW094XHsoP97xgwGKlErhUdksC7jVHPAPtdtsSORfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6LwmzkN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6LwmzkN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026F9C433C7;
	Wed, 14 Feb 2024 13:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707915678;
	bh=L20ciClvYZHH9gtUIEiC0xm2wBDQdImDTyV5f7Kmm2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r6LwmzkNc23oQVMEg4Ab3qsqtLHEVXIeAKzydJUKbAX1HoUm+a5lWcE6N0W40zSXP
	 cJvmjGKUHCYU5OslnfSUwXAvwlUj1I91IPeVqr3ZEjK/Yiks6JG8YBzBmMjmUTlXmj
	 pxup4W8TGipiExkaZwi+wqRCU8xnQ4JgU3TNvmfzBOg/Gne9iAUm50OBrUcu0mZ1v2
	 WEH/wuE9kXG/ovLXRDuWmwwJNGvqhPLymBlPA9FQw8n3MLkocKm8Uxie4PK54Yz6UP
	 Jmz7mcjeiV8qxev+NcSWw8tlBHHut1WXgRXA6F0uyhgLwDTDLlBSlfzYcYGKt/cCG7
	 ks73RFZfd5f6g==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH v2 2/4] ahci: clean up ahci_broken_devslp quirk
Date: Wed, 14 Feb 2024 14:00:10 +0100
Message-ID: <20240214130015.952685-3-cassel@kernel.org>
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

Most quirks are applied using a specific board type board_ahci_no*
(e.g. board_ahci_nomsi, board_ahci_noncq), which then sets a flag
representing the specific quirk.

ahci_pci_tbl (which is the table of all supported PCI devices), then
uses that board type for the PCI vendor and device IDs which need to
be quirked.

The ahci_broken_devslp quirk is not implemented in this standard way.

Modify the ahci_broken_devslp quirk to be implemented like the other
quirks. This way, we will not have the same PCI device and vendor ID
scattered over ahci.c. It will simply be defined in a single location.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index a2efe916c6e2..d8e5b26524f6 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -61,6 +61,7 @@ enum board_ids {
 	 * without testing that the platform actually works without the quirk.)
 	 */
 	board_ahci_pcs_quirk,
+	board_ahci_pcs_quirk_no_devslp,
 	board_ahci_pcs_quirk_no_sntf,
 	board_ahci_yes_fbs,
 
@@ -172,6 +173,14 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
+	[board_ahci_pcs_quirk_no_devslp] = {
+		AHCI_HFLAGS	(AHCI_HFLAG_INTEL_PCS_QUIRK |
+				 AHCI_HFLAG_NO_DEVSLP),
+		.flags		= AHCI_FLAG_COMMON,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
 	[board_ahci_pcs_quirk_no_sntf] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_INTEL_PCS_QUIRK |
 				 AHCI_HFLAG_NO_SNTF),
@@ -420,7 +429,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x06d7), board_ahci_pcs_quirk }, /* Comet Lake-H RAID */
 	{ PCI_VDEVICE(INTEL, 0xa386), board_ahci_pcs_quirk }, /* Comet Lake PCH-V RAID */
 	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci_pcs_quirk }, /* Bay Trail AHCI */
-	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci_pcs_quirk }, /* Bay Trail AHCI */
+	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci_pcs_quirk_no_devslp }, /* Bay Trail AHCI */
 	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci_pcs_quirk }, /* Cherry Tr. AHCI */
 	{ PCI_VDEVICE(INTEL, 0x5ae3), board_ahci_pcs_quirk }, /* ApolloLake AHCI */
 	{ PCI_VDEVICE(INTEL, 0x34d3), board_ahci_pcs_quirk }, /* Ice Lake LP AHCI */
@@ -1420,17 +1429,6 @@ static bool ahci_broken_online(struct pci_dev *pdev)
 	return pdev->bus->number == (val >> 8) && pdev->devfn == (val & 0xff);
 }
 
-static bool ahci_broken_devslp(struct pci_dev *pdev)
-{
-	/* device with broken DEVSLP but still showing SDS capability */
-	static const struct pci_device_id ids[] = {
-		{ PCI_VDEVICE(INTEL, 0x0f23)}, /* Valleyview SoC */
-		{}
-	};
-
-	return pci_match_id(ids, pdev);
-}
-
 #ifdef CONFIG_ATA_ACPI
 static void ahci_gtf_filter_workaround(struct ata_host *host)
 {
@@ -1823,10 +1821,6 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 				&dev_attr_remapped_nvme.attr,
 				NULL);
 
-	/* must set flag prior to save config in order to take effect */
-	if (ahci_broken_devslp(pdev))
-		hpriv->flags |= AHCI_HFLAG_NO_DEVSLP;
-
 #ifdef CONFIG_ARM64
 	if (pdev->vendor == PCI_VENDOR_ID_HUAWEI &&
 	    pdev->device == 0xa235 &&
-- 
2.43.0

