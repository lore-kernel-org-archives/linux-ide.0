Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFB7566A;
	Tue, 11 Mar 2025 03:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741662160; cv=none; b=fqsTqHBKlgQp/8jTvtyEAGpxI7bfoUqHSIymoqzq5wzyaBvaGVqSgb6RZu9Dj7Q3qgcrZTCOJCIwuHo5MoNM89FHOBui8JwalFKBCjmWEEkmMebbExVgODuEXhFJUF2LFO7F1PH6wPPx2K/ks9HMr1UQpL+ZGS5EuQihg4PE/rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741662160; c=relaxed/simple;
	bh=iEVYhP9aOFIypShC1CexYSkBukl52OlAM4gwvDer6II=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eRKDIVZhZTtkOKx+JOwCWrX7DC0swXmJJKZIDzyaoOz1PFQ7xeEeUqvjOxDTiNT7NeVCSWD+aKkOECSOTBsy0iJxyEMv7/YkVZkPfVtlwQUWqgaCqTi9izXvWeDfeulYfHVBQwduedx4jAQFP3pexfT6sD7CAiJD4nR/jvQf9z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAFDC4CEE5;
	Tue, 11 Mar 2025 03:02:37 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	Yuli Wang <wangyuli@uniontech.com>,
	Jie Fan <fanjie@uniontech.com>,
	Erpeng Xu <xuerpeng@uniontech.com>
Subject: [PATCH V2] ahci: Marvell 88SE9215 controllers prefer DMA for ATAPI
Date: Tue, 11 Mar 2025 11:02:17 +0800
Message-ID: <20250311030217.4177569-1-chenhuacai@loongson.cn>
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
opposite its DMA seems work very well. We don't know the detail of the
88SE9215 SATA controller, but we have tested different CD/DVD drives
and they all have problems under 88SE9215 (but they all work well under
an Intel SATA controller). So we can define a new AHCI board id named
board_ahci_atapi_dma, and for this id we set the ATA_FLAG_ATAPI_DMA and
ATA_QUIRK_ATAPI_MOD16_DMA flags on the SATA controller to prefer ATAPI
DMA.

BTW, return -EOPNOTSUPP instead of 1 if ATAPI DMA is not supported in
atapi_check_dma().

Reported-by: Yuli Wang <wangyuli@uniontech.com>
Tested-by: Jie Fan <fanjie@uniontech.com>
Tested-by: Erpeng Xu <xuerpeng@uniontech.com>
Tested-by: Yuli Wang <wangyuli@uniontech.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/ata/ahci.c        | 12 ++++++++++++
 drivers/ata/libata-core.c |  6 +++++-
 include/linux/libata.h    |  1 +
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index f813dbdc2346..a64db28549d8 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -49,6 +49,7 @@ enum board_ids {
 	/* board IDs by feature in alphabetical order */
 	board_ahci,
 	board_ahci_43bit_dma,
+	board_ahci_atapi_dma,
 	board_ahci_ign_iferr,
 	board_ahci_no_debounce_delay,
 	board_ahci_no_msi,
@@ -137,6 +138,12 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
+	[board_ahci_atapi_dma] = {
+		.flags		= AHCI_FLAG_COMMON,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
 	[board_ahci_ign_iferr] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_IGN_IRQ_IF_ERR),
 		.flags		= AHCI_FLAG_COMMON,
@@ -591,6 +598,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
 	  .driver_data = board_ahci_yes_fbs },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9215),
+	  .driver_data = board_ahci_atapi_dma },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9235),
 	  .driver_data = board_ahci_no_debounce_delay },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642), /* highpoint rocketraid 642L */
@@ -1917,6 +1926,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* save initial config */
 	ahci_pci_save_initial_config(pdev, hpriv);
 
+	if (board_id == board_ahci_atapi_dma)
+		pi.flags |= ATA_FLAG_ATAPI_DMA;
+
 	/* prepare host */
 	if (hpriv->cap & HOST_CAP_NCQ) {
 		pi.flags |= ATA_FLAG_NCQ;
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c085dd81ebe7..87a3dbf3ac93 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3029,6 +3029,10 @@ int ata_dev_configure(struct ata_device *dev)
 		dev->max_sectors = ATA_MAX_SECTORS;
 	}
 
+	if ((dev->class == ATA_DEV_ATAPI) &&
+	    (ap->flags & ATA_FLAG_ATAPI_DMA))
+		dev->quirks |= ATA_QUIRK_ATAPI_MOD16_DMA;
+
 	if ((dev->class == ATA_DEV_ATAPI) &&
 	    (atapi_command_packet_set(id) == TYPE_TAPE)) {
 		dev->max_sectors = ATA_MAX_SECTORS_TAPE;
@@ -4544,7 +4548,7 @@ int atapi_check_dma(struct ata_queued_cmd *qc)
 	 */
 	if (!(qc->dev->quirks & ATA_QUIRK_ATAPI_MOD16_DMA) &&
 	    unlikely(qc->nbytes & 15))
-		return 1;
+		return -EOPNOTSUPP;
 
 	if (ap->ops->check_atapi_dma)
 		return ap->ops->check_atapi_dma(qc);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c1c57f814b98..67d374279a65 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -194,6 +194,7 @@ enum {
 					    /* (doesn't imply presence) */
 	ATA_FLAG_SATA		= (1 << 1),
 	ATA_FLAG_NO_LPM		= (1 << 2), /* host not happy with LPM */
+	ATA_FLAG_ATAPI_DMA	= (1 << 4), /* ATAPI use DMA */
 	ATA_FLAG_NO_LOG_PAGE	= (1 << 5), /* do not issue log page read */
 	ATA_FLAG_NO_ATAPI	= (1 << 6), /* No ATAPI support */
 	ATA_FLAG_PIO_DMA	= (1 << 7), /* PIO cmds via DMA */
-- 
2.47.1

