Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416CA130E27;
	Sun,  8 Sep 2024 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725788795; cv=none; b=JBHb4k/VGuLXM1xeldYk6RoGACQx/FzTmrZNsVd9xmA5uCcJFNiwqRIR89Q7Gs9q+FuOMT5mTZFHkYssf638tnBBRL6MS8GxkfvqVT4VF9MgLUzccr2wHXpLdcmIolyV/nmifj0SWZRF8CSKNJxVuBXMpU6QMlaxEYr3JXmGJ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725788795; c=relaxed/simple;
	bh=HPB6S1zTcBrTniRyCdi2PB/DUIQzNIeGo660PwAq+C4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RxdUm59iMvw7r/YZquxo4qkmHEZL015M4ZUgOJHV5FpR3J3QOCCyJPm2Rn0AYCZj7eoz8Wp70Z4gSCxD24XlMBBNfZVuy8O+pGjiFS83zev0YeKSE2ouRow3MDlXP1kG3y9ARGnK8nHo8qKp1qeHxMOdCY0cjwvK+yqkCQEBTdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C145EC4CEC3;
	Sun,  8 Sep 2024 09:46:32 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] ahci: Marvell controllers prefer DMA for ATAPI
Date: Sun,  8 Sep 2024 17:46:04 +0800
Message-ID: <20240908094604.433035-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We use Marvell CD/DVD controllers on many Loongson-based machines. We
found its PIO doesn't work well, and on the opposite its DMA seems work
very well. We don't know the detail of the controller, but we can set
the ATA_FLAG_ATAPI_DMA and ATA_HORKAGE_ATAPI_MOD16_DMA flags on these
controllers to prefer ATAPI DMA.

BTW, return -EOPNOTSUPP instead of 1 if ATAPI DMA is not supported in
atapi_check_dma().

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/ata/ahci.c        | 3 +++
 drivers/ata/libata-core.c | 6 +++++-
 include/linux/libata.h    | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index a05c17249448..b195e87e7109 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1939,6 +1939,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (hpriv->cap & HOST_CAP_PMP)
 		pi.flags |= ATA_FLAG_PMP;
 
+	if (pdev->vendor == PCI_VENDOR_ID_MARVELL_EXT)
+		pi.flags |= ATA_FLAG_ATAPI_DMA;
+
 	ahci_set_em_messages(hpriv, &pi);
 
 	if (ahci_broken_system_poweroff(pdev)) {
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 30932552437a..49d7d064f31b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3040,6 +3040,10 @@ int ata_dev_configure(struct ata_device *dev)
 		dev->max_sectors = ATA_MAX_SECTORS;
 	}
 
+	if ((dev->class == ATA_DEV_ATAPI) &&
+	    (ap->flags & ATA_FLAG_ATAPI_DMA))
+		dev->horkage |= ATA_HORKAGE_ATAPI_MOD16_DMA;
+
 	if ((dev->class == ATA_DEV_ATAPI) &&
 	    (atapi_command_packet_set(id) == TYPE_TAPE)) {
 		dev->max_sectors = ATA_MAX_SECTORS_TAPE;
@@ -4590,7 +4594,7 @@ int atapi_check_dma(struct ata_queued_cmd *qc)
 	 */
 	if (!(qc->dev->horkage & ATA_HORKAGE_ATAPI_MOD16_DMA) &&
 	    unlikely(qc->nbytes & 15))
-		return 1;
+		return -EOPNOTSUPP;
 
 	if (ap->ops->check_atapi_dma)
 		return ap->ops->check_atapi_dma(qc);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 17394098bee9..e2834c7564df 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -154,6 +154,7 @@ enum {
 					    /* (doesn't imply presence) */
 	ATA_FLAG_SATA		= (1 << 1),
 	ATA_FLAG_NO_LPM		= (1 << 2), /* host not happy with LPM */
+	ATA_FLAG_ATAPI_DMA	= (1 << 4), /* ATAPI use DMA */
 	ATA_FLAG_NO_LOG_PAGE	= (1 << 5), /* do not issue log page read */
 	ATA_FLAG_NO_ATAPI	= (1 << 6), /* No ATAPI support */
 	ATA_FLAG_PIO_DMA	= (1 << 7), /* PIO cmds via DMA */
-- 
2.43.5

