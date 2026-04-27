Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535FE33B97F
	for <linux-ide@vger.kernel.org>; Mon, 27 Apr 2026 06:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777269975; cv=none; b=KAc8cxxOlCMJZn80SRpduGF6Y6qiKvftUfr5dqV2c5Kd/WaM3yyY7yT9GPefqLa7eBGfA32ITi42NC5RDgolktLbXDJunerScEIKIKKhQBLMAd867/zXdatCxo1Nplzl4RNAZlprijaUEfZkshHCHj0ygTCB9WWMlLSgefm5ZXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777269975; c=relaxed/simple;
	bh=kUmAnBbcNX8fuGV5z/55Xzzf8/BTD3UaldPCZW3B+SA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qEvQWPy9VhRM1Fe025pYBe+08j0Lh8NlOTAZTCWAxZE3eM6sn5qFyUdoMJ8cohir1AZMgBkoalIK4gUdE3j/DL1V+y5QNOSnl032hYaNUFmSdYOIeL89K0DLZsZ71DUBfVuXXTYjYBbBPnKonZ6IvEmgzdTlRplbxFyMClyx/LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QwDFK7ut; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QwDFK7ut"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Sz
	kDcbEkKbEI9PF0QuJp3rJEm8DC3zbBZX3utA/tH9E=; b=QwDFK7utIspX30hX+g
	6B0MCoaXoceQA3nTqiH5cCRpZGcypV8IKOI4vnlYdX5JpcE3VgsZ/RIJbrtIxSS4
	t65IUQwa4KUelTGwXz3M4vuDWlAzNHTeQn2Bi29p99jxlbMgYqguPH+p7Pf2R8ff
	whDwLd3GVTrK8EOfpQIDKt32k=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAHVOS9_O5pN53SBw--.40422S2;
	Mon, 27 Apr 2026 14:05:51 +0800 (CST)
From: dayou5941@163.com
To: linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org,
	cassel@kernel.org,
	liyouhong@kylinos.cn
Subject: [PATCH v4] ata: ahci: fail probe if BAR too small for claimed ports
Date: Mon, 27 Apr 2026 14:05:46 +0800
Message-Id: <20260427060546.1407439-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHVOS9_O5pN53SBw--.40422S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF4DCryfZF1fKFWkGFy8Zrb_yoW5Ar47pF
	WxGFZYyrWUWF47XayrAanrZry3Gws5GFW7trW3Ja93trn8K34kXr1fKa47Aay3J3ykG3WI
	qryqqr1rur1UZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1pBfUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC3h+EM2nu-L9MUQAA3v

From: Youhong Li <liyouhong@kylinos.cn>

When an AHCI controller is disabled in BIOS, its HOST_CAP register may
contain invalid values (e.g., 0xFFFFFFFF) indicating an impossibly large
number of ports. If CAP.NP claims more ports than can physically fit
within the mapped BAR region, accessing port registers beyond the BAR
boundary causes a kernel panic.

Add validation in ahci_init_one() to check that the BAR size is
sufficient for the number of ports claimed in CAP.NP. The check
calculates the required MMIO size as:

  required_size = 0x100 (global registers) + max_ports * 0x80

If required_size exceeds the actual BAR size, the probe fails with
-ENODEV, preventing the panic and providing a clear error message.

This solution follows the suggestion by Damien Le Moal and Niklas Cassel
to detect and reject obviously broken controller configurations early.

Reported-by: liyouhong <liyouhong@kylinos.cn>
Suggested-by: Damien Le Moal <dlemoal@kernel.org>
Suggested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: liyouhong <liyouhong@kylinos.cn>
---
v2:
- Complete rewrite based on community feedback
- Move check from libahci.c to ahci.c
- Fail probe early instead of attempting to work around invalid state
- Implement BAR size validation as suggested

v3:
- Fix patch format: add "---" separator and move changelog to correct location
- Change dev_err to dev_warn as suggested

v4:
- Break long lines as suggested by Damien
- Keep complete changelog history

---
 drivers/ata/ahci.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 1d73a53370cf..c04bee682605 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1888,6 +1888,25 @@ static ssize_t remapped_nvme_show(struct device *dev,
 
 static DEVICE_ATTR_RO(remapped_nvme);
 
+static int ahci_validate_bar_size(struct pci_dev *pdev, void __iomem *mmio)
+{
+	u32 cap = readl(mmio + HOST_CAP);
+	unsigned int max_ports = ahci_nr_ports(cap);
+	u32 last_port_end = 0x100 + (max_ports * 0x80);
+	resource_size_t bar_size =
+		pci_resource_len(pdev, AHCI_PCI_BAR_STANDARD);
+
+	if (last_port_end > bar_size) {
+		dev_warn(&pdev->dev,
+			 "BAR5 too small for %u ports (last port ends at %u, BAR %llu)\n",
+			 max_ports, last_port_end,
+			 (unsigned long long)bar_size);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	unsigned int board_id = ent->driver_data;
@@ -1988,6 +2007,10 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!hpriv->mmio)
 		return -ENOMEM;
 
+	rc = ahci_validate_bar_size(pdev, hpriv->mmio);
+	if (rc)
+		return rc;
+
 	/* detect remapped nvme devices */
 	ahci_remap_check(pdev, ahci_pci_bar, hpriv);
 
-- 
2.25.1

