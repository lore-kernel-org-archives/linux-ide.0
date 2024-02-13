Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F88C50A99
	for <linux-ide@vger.kernel.org>; Tue, 13 Feb 2024 13:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829667; cv=none; b=EayoneT+qk5I+pK23Hu3Am3XBkUsnRnhc1HSHfkGTw6Ebr1ZbXeQ57WB5qQg4a4YCoPacT4KNJiWe2sJUc7HP5oAXAWmnWBK3xqqD3GJ22xXGwA1xqlQT1IwK5St7nqUxi2G9WFz+x2Gd6qO1LvaawThTWDEfIIxb480zcOu+tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829667; c=relaxed/simple;
	bh=ZcWhaKYaaRTI+n+DJjlGOLWb9vNfQZYd+RGuGXGlPYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ikn+6MmFbR1EKcdRBy8+y2S3lNz5HFI3hpPSDkfS6srSJjblUeRQAFEuMcpqzNPl610dsv8vWzo1E7CMdfN8F5PkBtB7F/8rG390ZBkw1Q+oA3qbzsGuZabDDdpaYOpYfK29EBBK4TxkHG/IBSLQyz+itBvxLmQL7neGioLMLEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTLMY0Kb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTLMY0Kb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEF8C433F1;
	Tue, 13 Feb 2024 13:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707829667;
	bh=ZcWhaKYaaRTI+n+DJjlGOLWb9vNfQZYd+RGuGXGlPYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OTLMY0KbfHqho69azm+kQyk6PNAquO+zLjXahThjYsCEqO5gGx7BJOu1hIS7og1AG
	 R5GuBzqobhItdnwuezA5eAPnlwHii5YS69WZF5aic137HyJUmD7olCv62k+yQdFSI7
	 vBC6B6whe4WhRcbQ92Zr8y0TbGY3NKom69gwMPSULNSSAsM2zreMTRIUHvQApcb/MR
	 T0j9iNYPIb2/GXwnqTD6en1/FjVYDXl/PJMKVDRuJBG72s5ex1JUQjbYsq0o/4uwTb
	 l2+k6L0glBUXLSX0sFFozaM89v9mZEbQu+kskdvSmKAvClfW5TPCF0+ZLbWl6mm9XC
	 GIbbQlqJwAsYQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH 2/2] ahci: clean up ahci_broken_devslp quirk
Date: Tue, 13 Feb 2024 14:07:31 +0100
Message-ID: <20240213130733.819524-3-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213130733.819524-1-cassel@kernel.org>
References: <20240213130733.819524-1-cassel@kernel.org>
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
index c28ad3f4b59e..1e1533d01803 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -51,6 +51,7 @@ enum board_ids {
 	board_ahci_43bit_dma,
 	board_ahci_ign_iferr,
 	board_ahci_no_debounce_delay,
+	board_ahci_no_devslp_pcs_quirk,
 	board_ahci_nomsi,
 	board_ahci_noncq,
 	board_ahci_nosntf_pcs_quirk,
@@ -151,6 +152,14 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
+	[board_ahci_no_devslp_pcs_quirk] = {
+		AHCI_HFLAGS	(AHCI_HFLAG_NO_DEVSLP |
+				 AHCI_HFLAG_INTEL_PCS_QUIRK),
+		.flags		= AHCI_FLAG_COMMON,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
 	[board_ahci_nomsi] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_MSI),
 		.flags		= AHCI_FLAG_COMMON,
@@ -420,7 +429,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x06d7), board_ahci_pcs_quirk }, /* Comet Lake-H RAID */
 	{ PCI_VDEVICE(INTEL, 0xa386), board_ahci_pcs_quirk }, /* Comet Lake PCH-V RAID */
 	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci_pcs_quirk }, /* Bay Trail AHCI */
-	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci_pcs_quirk }, /* Bay Trail AHCI */
+	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci_no_devslp_pcs_quirk }, /* Bay Trail AHCI */
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

