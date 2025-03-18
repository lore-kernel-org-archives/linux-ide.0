Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD14B209692;
	Tue, 18 Mar 2025 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294611; cv=none; b=hhTWRqUDiRX1QgF902UK7/srgcoXqqD0y5IlQXUrNNWDerpNS6orAIrXO8FMlNGJ/olMwehp8J4Jm+Kw+EP629rFYCVX3TMHj9UWisZoPHEIdzsoxlXbBa95oI+tPrQwex0jVQd2r2mzLAR8V6KwBS8ef5MSawABbCBZQLlZVwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294611; c=relaxed/simple;
	bh=GQESFm5xXK0HxnEUgsMuSTIkriJaDW3id7OyUxuOkWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k7BWoJ8B50tcRf3tYqIUUerEMbNuPI9HWWKMKBcpqAgyKz1heT6yuf+0brwrMorsMO3d7LnEvfeqdteiHu1oiAJY6mgrpJxkETLNrcu1i/37xubB9dWAAdieRZ9zGxGw4vGJD0gsq12OhOPw/FGab2YdutN92oRoOpd87ReCfq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F0EC4CEDD;
	Tue, 18 Mar 2025 10:43:28 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Daniel Kral <d.kral@proxmox.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	Yuli Wang <wangyuli@uniontech.com>,
	Jie Fan <fanjie@uniontech.com>,
	Erpeng Xu <xuerpeng@uniontech.com>
Subject: [PATCH V4] ahci: Marvell 88SE9215 controllers prefer DMA for ATAPI
Date: Tue, 18 Mar 2025 18:43:14 +0800
Message-ID: <20250318104314.2160526-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We use CD/DVD drives under Marvell 88SE9215 SATA controller on many
Loongson-based machines. We found its PIO doesn't work well, and on the
opposite its DMA seems work very well.

We don't know the detail of the 88SE9215 SATA controller, but we have
tested different CD/DVD drives and they all have problems under 88SE9215
(but they all work well under an Intel SATA controller). So, we consider
this problem is bound to 88SE9215 SATA controller rather than bound to
CD/DVD drives.

As a solution, we define a new dedicated AHCI board id which is named
board_ahci_yes_fbs_atapi_dma for 88SE9215, and for this id we set the
AHCI_HFLAG_ATAPI_DMA_QUIRK and ATA_QUIRK_ATAPI_MOD16_DMA flags on the
SATA controller in order to prefer ATAPI DMA.

Reported-by: Yuli Wang <wangyuli@uniontech.com>
Tested-by: Jie Fan <fanjie@uniontech.com>
Tested-by: Erpeng Xu <xuerpeng@uniontech.com>
Tested-by: Yuli Wang <wangyuli@uniontech.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/ata/ahci.c    | 11 ++++++++++-
 drivers/ata/ahci.h    |  1 +
 drivers/ata/libahci.c |  4 ++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 52ae8f9a7dd6..f3a6bfe098cd 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -63,6 +63,7 @@ enum board_ids {
 	board_ahci_pcs_quirk_no_devslp,
 	board_ahci_pcs_quirk_no_sntf,
 	board_ahci_yes_fbs,
+	board_ahci_yes_fbs_atapi_dma,
 
 	/* board IDs for specific chipsets in alphabetical order */
 	board_ahci_al,
@@ -188,6 +189,14 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
+	[board_ahci_yes_fbs_atapi_dma] = {
+		AHCI_HFLAGS	(AHCI_HFLAG_YES_FBS |
+				 AHCI_HFLAG_ATAPI_DMA_QUIRK),
+		.flags		= AHCI_FLAG_COMMON,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
 	/* by chipsets */
 	[board_ahci_al] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_PMP | AHCI_HFLAG_NO_MSI),
@@ -590,7 +599,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x91a3),
 	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9215),
-	  .driver_data = board_ahci_yes_fbs },
+	  .driver_data = board_ahci_yes_fbs_atapi_dma },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
 	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9235),
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index c842e2de6ef9..2c10c8f440d1 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -246,6 +246,7 @@ enum {
 	AHCI_HFLAG_NO_SXS		= BIT(26), /* SXS not supported */
 	AHCI_HFLAG_43BIT_ONLY		= BIT(27), /* 43bit DMA addr limit */
 	AHCI_HFLAG_INTEL_PCS_QUIRK	= BIT(28), /* apply Intel PCS quirk */
+	AHCI_HFLAG_ATAPI_DMA_QUIRK	= BIT(29), /* force ATAPI to use DMA */
 
 	/* ap->flags bits */
 
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index e7ace4b10f15..22afa4ff860d 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1322,6 +1322,10 @@ static void ahci_dev_config(struct ata_device *dev)
 {
 	struct ahci_host_priv *hpriv = dev->link->ap->host->private_data;
 
+	if ((dev->class == ATA_DEV_ATAPI) &&
+	    (hpriv->flags & AHCI_HFLAG_ATAPI_DMA_QUIRK))
+		dev->quirks |= ATA_QUIRK_ATAPI_MOD16_DMA;
+
 	if (hpriv->flags & AHCI_HFLAG_SECT255) {
 		dev->max_sectors = 255;
 		ata_dev_info(dev,
-- 
2.47.1

