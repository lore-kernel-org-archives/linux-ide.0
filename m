Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AB01CACD3;
	Mon, 14 Oct 2024 11:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903676; cv=none; b=LBMW0enOB9iOdIJ6RfOEYF8/W6mrjcEoxEYn/b/UH6pl29mSP/f6vDsuHIxSmVxVBgiR/K4DM+5t7Wyu0VMzQVjrOTOa1EQxB+ejresY0Q/xaVb38dg4Ehg5w8kz0dBYS1bXnAOD6T5G7uZmKorKbpllaFabdw3EiTjQdFk405U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903676; c=relaxed/simple;
	bh=1SsPpanNuV5EagXX5c22RJuoRdQa8WgepP88w60YNwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P72bnP6JnHM7GdkfQ5SkYl0LtNskQhn2ezK7dqLZIVRpgLFtiYhmaiCB2mmmJqmv2BdtB9zgfHpRBFQAV9J0TG8hR1Ic19bvlxGv/aiRumnvkd3yb32gB82aOpZd3tlUeQttWl1JZw3WIEuKpuuh8WakkJ8WUZEpNxPrRsLaxuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C49D916F8;
	Mon, 14 Oct 2024 04:01:43 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 679B23F51B;
	Mon, 14 Oct 2024 04:01:11 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Niklas Cassel <cassel@kernel.org>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 34/57] sata_sil24: Remove PAGE_SIZE compile-time constant assumption
Date: Mon, 14 Oct 2024 11:58:41 +0100
Message-ID: <20241014105912.3207374-34-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for supporting boot-time page size selection, refactor code
to remove assumptions about PAGE_SIZE being compile-time constant. Code
intended to be equivalent when compile-time page size is active.

Convert "struct sil24_ata_block" and "struct sil24_atapi_block" to use a
flexible array member for their sge[] array. The previous static size of
SIL24_MAX_SGE depends on PAGE_SIZE so doesn't work for boot-time page
size.

Wrap global variables that are initialized with PAGE_SIZE derived values
using DEFINE_GLOBAL_PAGE_SIZE_VAR() so their initialization can be
deferred for boot-time page size builds.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 drivers/ata/sata_sil24.c | 46 +++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 72c03cbdaff43..85c6382976626 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -42,26 +42,25 @@ struct sil24_sge {
 	__le32	flags;
 };
 
+/*
+ * sil24 fetches in chunks of 64bytes.  The first block
+ * contains the PRB and two SGEs.  From the second block, it's
+ * consisted of four SGEs and called SGT.  Calculate the
+ * number of SGTs that fit into one page.
+ */
+#define SIL24_PRB_SZ	(sizeof(struct sil24_prb) + 2 * sizeof(struct sil24_sge))
+#define SIL24_MAX_SGT	((PAGE_SIZE - SIL24_PRB_SZ) / (4 * sizeof(struct sil24_sge)))
+
+/*
+ * This will give us one unused SGEs for ATA.  This extra SGE
+ * will be used to store CDB for ATAPI devices.
+ */
+#define SIL24_MAX_SGE	(4 * SIL24_MAX_SGT + 1)
 
 enum {
 	SIL24_HOST_BAR		= 0,
 	SIL24_PORT_BAR		= 2,
 
-	/* sil24 fetches in chunks of 64bytes.  The first block
-	 * contains the PRB and two SGEs.  From the second block, it's
-	 * consisted of four SGEs and called SGT.  Calculate the
-	 * number of SGTs that fit into one page.
-	 */
-	SIL24_PRB_SZ		= sizeof(struct sil24_prb)
-				  + 2 * sizeof(struct sil24_sge),
-	SIL24_MAX_SGT		= (PAGE_SIZE - SIL24_PRB_SZ)
-				  / (4 * sizeof(struct sil24_sge)),
-
-	/* This will give us one unused SGEs for ATA.  This extra SGE
-	 * will be used to store CDB for ATAPI devices.
-	 */
-	SIL24_MAX_SGE		= 4 * SIL24_MAX_SGT + 1,
-
 	/*
 	 * Global controller registers (128 bytes @ BAR0)
 	 */
@@ -244,13 +243,13 @@ enum {
 
 struct sil24_ata_block {
 	struct sil24_prb prb;
-	struct sil24_sge sge[SIL24_MAX_SGE];
+	struct sil24_sge sge[];
 };
 
 struct sil24_atapi_block {
 	struct sil24_prb prb;
 	u8 cdb[16];
-	struct sil24_sge sge[SIL24_MAX_SGE];
+	struct sil24_sge sge[];
 };
 
 union sil24_cmd_block {
@@ -373,7 +372,7 @@ static struct pci_driver sil24_pci_driver = {
 #endif
 };
 
-static const struct scsi_host_template sil24_sht = {
+static DEFINE_GLOBAL_PAGE_SIZE_VAR_CONST(struct scsi_host_template, sil24_sht, {
 	__ATA_BASE_SHT(DRV_NAME),
 	.can_queue		= SIL24_MAX_CMDS,
 	.sg_tablesize		= SIL24_MAX_SGE,
@@ -382,7 +381,7 @@ static const struct scsi_host_template sil24_sht = {
 	.sdev_groups		= ata_ncq_sdev_groups,
 	.change_queue_depth	= ata_scsi_change_queue_depth,
 	.device_configure	= ata_scsi_device_configure
-};
+});
 
 static struct ata_port_operations sil24_ops = {
 	.inherits		= &sata_pmp_port_ops,
@@ -1193,7 +1192,7 @@ static int sil24_port_start(struct ata_port *ap)
 	struct device *dev = ap->host->dev;
 	struct sil24_port_priv *pp;
 	union sil24_cmd_block *cb;
-	size_t cb_size = sizeof(*cb) * SIL24_MAX_CMDS;
+	size_t cb_size = PAGE_SIZE * SIL24_MAX_CMDS;
 	dma_addr_t cb_dma;
 
 	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
@@ -1258,7 +1257,6 @@ static void sil24_init_controller(struct ata_host *host)
 
 static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
-	extern int __MARKER__sil24_cmd_block_is_sized_wrongly;
 	struct ata_port_info pi = sil24_port_info[ent->driver_data];
 	const struct ata_port_info *ppi[] = { &pi, NULL };
 	void __iomem * const *iomap;
@@ -1266,9 +1264,9 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	int rc;
 	u32 tmp;
 
-	/* cause link error if sil24_cmd_block is sized wrongly */
-	if (sizeof(union sil24_cmd_block) != PAGE_SIZE)
-		__MARKER__sil24_cmd_block_is_sized_wrongly = 1;
+	/* union sil24_cmd_block must be PAGE_SIZE */
+	BUG_ON(struct_size_t(struct sil24_atapi_block, sge, SIL24_MAX_SGE) != PAGE_SIZE);
+	BUG_ON(struct_size_t(struct sil24_ata_block, sge, SIL24_MAX_SGE) > PAGE_SIZE);
 
 	ata_print_version_once(&pdev->dev, DRV_VERSION);
 
-- 
2.43.0

