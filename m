Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FDC40DFB9
	for <linux-ide@vger.kernel.org>; Sat, 25 Apr 2026 06:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777100189; cv=none; b=Po2ImHJVvQKr7tzqi7GSoccjwILz3w5cbpHm16qVDuR6D7hKFWr0teGXNixRnLpgEXGQOMzggsna0YifJ6rhVki69fLcXf9/J2CypWuppEp0iz3FFFLS6A0k5jL1jrJrOkJ6Ow4TFHCH5s2blR+vAEGV81ks8Sd0xLOv9enyB3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777100189; c=relaxed/simple;
	bh=snJGRbmvJsbYuKsGTG19GwkPxd5gMzlvXbfxs0ydHs8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NJdA0m1xrPqLu28v9CquuY8HqwK4p9LiyRcKW+jIDJ09Z4Ytc5GZEUxRDav0zI4SBig0KWF6q6Xkpqxj9x9PO9sTn3eh0kDYrJC1XfkmB6+t1e5luY3Ln8itnPTqys2r724vN44XyVwZAsyt9W5QEwkRg9+V63j7kpAdlZ0qX+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ParYK4ks; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ParYK4ks"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=IS
	SqXdS4KGQqvbpOPr80nM+mCUTCiZX6ouWTLo7K4s4=; b=ParYK4ksirkC6Y7h80
	iO/ercMnHiGYzAPXFNv5NIKW9HYDwYXi5w1Es378Bej5gocVGcQQnXKzUwJmovTO
	lN9kvRgaaXQ5urChjYhphtrfLsB2zZoz4TWsbj7o+jRJIeQFmZpz6yrpWXPrzIEe
	eQTflLwIl8pghoGKgUtyo9nK4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wC3NNBOZexpnzCLBg--.21294S2;
	Sat, 25 Apr 2026 14:55:11 +0800 (CST)
From: dayou5941@163.com
To: linux-ide@vger.kernel.org
Cc: damien.lemoal@opensource.wdc.com,
	niklas.soderlund@corigine.com,
	liyouhong@kylinos.cn,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH v2] ata: ahci: fail probe if BAR too small for claimed ports
Date: Sat, 25 Apr 2026 14:55:09 +0800
Message-Id: <20260425065509.733544-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3NNBOZexpnzCLBg--.21294S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF4DCryfZF1fKFWDKFW5GFg_yoW5GrW3pF
	W7KFsYkrWjgFy7Xa18Aan7Zry3GwsxWa47trZ8Gan3trn0k3s7WF1Sya47Aay3J3s8G3WI
	q3yqqr1rur1UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jozuXUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+g8CsGnsZU-t1wAA3S

From: liyouhong <liyouhong@kylinos.cn>

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

v2:
- Complete rewrite based on community feedback
- Move check from libahci.c to ahci.c
- Fail probe early instead of attempting to work around invalid state
- Implement BAR size validation as suggested

Reported-by: liyouhong <liyouhong@kylinos.cn>
Suggested-by: Damien Le Moal <dlemoal@kernel.org>
Suggested-by: Niklas Cassel <niklas.soderlund@corigine.com>
Signed-off-by: liyouhong <liyouhong@kylinos.cn>

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 1d73a53370cf..09026ea12cde 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1888,6 +1888,23 @@ static ssize_t remapped_nvme_show(struct device *dev,
 
 static DEVICE_ATTR_RO(remapped_nvme);
 
+static int ahci_validate_bar_size(struct pci_dev *pdev, void __iomem *mmio)
+{
+	u32 cap = readl(mmio + HOST_CAP);
+	unsigned int max_ports = ahci_nr_ports(cap);
+	u32 last_port_end = 0x100 + (max_ports * 0x80);
+	resource_size_t bar_size = pci_resource_len(pdev, AHCI_PCI_BAR_STANDARD);
+
+	if (last_port_end > bar_size) {
+		dev_err(&pdev->dev,
+			"AHCI: BAR5 too small for %u ports (last port ends at %u, BAR %llu)\n",
+			max_ports, last_port_end, (unsigned long long)bar_size);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	unsigned int board_id = ent->driver_data;
@@ -1988,6 +2005,10 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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

