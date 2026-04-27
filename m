Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D9A223708
	for <linux-ide@vger.kernel.org>; Mon, 27 Apr 2026 05:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777268308; cv=none; b=G8WgyIZSN3I4a2jngTnqRiNQXkKtKQVfgjpS+NwdDSu/jJl8yHTTUxmJen056STAG1iAL2zA9Yv7nyfUvtQ9RPyHtT4wsI9cTizitYHUC9rcT5tkEKhCR6XumAJbT5IypE06eGHWsr42bER1vGc9rrfFkk/+zK/wr55NhdoAM9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777268308; c=relaxed/simple;
	bh=4vrungAFMDSFJMS4VWWxF37qjeJgD35eGndwMe1zdhE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DcHHB4mi4FmUNogW7U+Sw3hEr4KdEWH7IAH87/DyONTB1uVTQWgbmHJ+Q8VE17SfvYvBfbrCgQ5llM2/+MAC+Mu5W2emdV4dOZgxQ9wzk6/DDOr0ltYL/pX1okXNUwj5/mEIXG2/OB6g9h4whHvzTCoVG5Cdo/L1E/4QuJLnZmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nAfqOvkI; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nAfqOvkI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=z+
	lX1RX3c8LLaUmdkZlIqR+h1uFs58E3RZKvVuZyh1A=; b=nAfqOvkI5M7JKq/sfk
	b0EQJY/KnQqN8AmuwFZcPWDfDEpD70CRIGe4p0cfHAySkWtYcmzZXvYFGTIB0apk
	U2CrVOrqDDbzjXAI4MdY0oCaooyyok1+3a9Sg991xw8kpocFOJ+7Fesjb6WpEvAV
	zDTmk0HPWd6EuGBAXE4ms04jU=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDnt0ky9u5p32pTBg--.97S2;
	Mon, 27 Apr 2026 13:37:57 +0800 (CST)
From: dayou5941@163.com
To: linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org,
	cassel@kernel.org,
	liyouhong@kylinos.cn
Subject: [PATCH v3] ata: ahci: fail probe if BAR too small for claimed ports
Date: Mon, 27 Apr 2026 13:37:52 +0800
Message-Id: <20260427053752.613848-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDnt0ky9u5p32pTBg--.97S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF4DCryfZF1fKFWkGFy8Zrb_yoW5GrWUpF
	W7KFZYyrWUWF47X3W5AFs29ry3Gws3Wa47tay7Ga93trn0k34xWF1fta47Aay3J3s7G3WI
	q34qqr18ur4UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbCztUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC3hbgj2nu9jaj7wAA3s

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

Reported-by: liyouhong <liyouhong@kylinos.cn>
Suggested-by: Damien Le Moal <dlemoal@kernel.org>
Suggested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: liyouhong <liyouhong@kylinos.cn>
---
v3:
- Fix patch format: add "---" separator and move changelog to correct location
- Change dev_err to dev_warn as suggested

---
 drivers/ata/ahci.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 1d73a53370cf..e5eff7e3d66b 100644
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
+		dev_warn(&pdev->dev,
+			 "BAR5 too small for %u ports (last port ends at %u, BAR %llu)\n",
+			 max_ports, last_port_end, (unsigned long long)bar_size);
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

