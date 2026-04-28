Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FB72D5C8E
	for <linux-ide@vger.kernel.org>; Tue, 28 Apr 2026 02:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777342204; cv=none; b=p/b4doZpKjATBd9Vxz93P08v1zQMhOEAP/mUYp82EQZXXHAn6iRdeJvIttI235eclLSnitXB155CXdNGTYwr+BBWMk4SUE/8i0ENg80av8xidThNwGRG+sMScC2Kna/aKEEACAVKNk9qCm5ix8gCRH8gijYJRPuiudDa5O5/k5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777342204; c=relaxed/simple;
	bh=+0l37V+xusQpwt0Vx5kF+e4tMleGYK7y88Bk4YbZ4jM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oXZt47esKD6OahpBH5VjuDGWoYWT8KwmCybNgYuwL+p/JpRR1BfU7QzdzdQZrLYFhyaBCz6h5G8cs2ibg1lNentJbyzFbUGIrivghg8/NpCuzlAqcNrRRpZOv2cuQ0VBGcdVvT5NqU1v1SX8hSeH5GXTkNSme/HtPnkYnXOT0Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=a602enSk; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="a602enSk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=60
	g8PUvRpsOCkXClbZjQeBO2lU1sq8Zq+H84NrQdzM4=; b=a602enSkVlS6LRXRb9
	Ybl3enhsyGhWRHWsZ0ZxMUqvXtBjZsDd0mNeZ9CLm7bEYNjNXsQn1euJiIpII7Qp
	msMql+4SPUPYRokKNvtY7lgG+G/TOPkr7aR5x5q5Ti4xgLkG7ddsG+n8ag3eEdre
	/badoNzs2bafeTgW18rWlYG1I=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3d1jhFvBp44XFCA--.27144S2;
	Tue, 28 Apr 2026 10:09:37 +0800 (CST)
From: dayou5941@163.com
To: linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org,
	cassel@kernel.org,
	liyouhong@kylinos.cn
Subject: [PATCH v5] ata: ahci: fail probe if BAR too small for claimed ports
Date: Tue, 28 Apr 2026 10:09:35 +0800
Message-Id: <20260428020935.2049617-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3d1jhFvBp44XFCA--.27144S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF4DCryfZF1fKFWDZF18Krg_yoW5uF1xpF
	WxGa9YkrWUWry7Xay8Aan7Z343Cws5JFW7t343J3ZayFs0kry8WF1Ska47Ca98J34qka42
	qr1qqr18ur1UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1rWrUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC3gNUA2nwFuOj8AAA31

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
Closes: https://lore.kernel.org/all/20260422080322.1006592-1-dayou5941@163.com/
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

v5:
- Update function signature to match ahci_remap_check() pattern
- Use hpriv->mmio instead of separate mmio parameter
- Use %pa format specifier for resource_size_t
- Use %#x for hexadecimal port offset
- Dynamically show BAR number in error message
- Add Closes: tag as suggested by checkpatch.pl

---
 drivers/ata/ahci.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 1d73a53370cf..b4e5d347151a 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1888,6 +1888,24 @@ static ssize_t remapped_nvme_show(struct device *dev,
 
 static DEVICE_ATTR_RO(remapped_nvme);
 
+static int ahci_validate_bar_size(struct pci_dev *pdev, int bar,
+				  struct ahci_host_priv *hpriv)
+{
+	u32 cap = readl(hpriv->mmio + HOST_CAP);
+	unsigned int max_ports = ahci_nr_ports(cap);
+	u32 last_port_end = 0x100 + (max_ports * 0x80);
+	resource_size_t bar_size = pci_resource_len(pdev, bar);
+
+	if (last_port_end > bar_size) {
+		dev_warn(&pdev->dev,
+			 "BAR%d too small for %u ports (last port ends at %#x, BAR %pa)\n",
+			 bar, max_ports, last_port_end, &bar_size);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	unsigned int board_id = ent->driver_data;
@@ -1988,6 +2006,10 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!hpriv->mmio)
 		return -ENOMEM;
 
+	rc = ahci_validate_bar_size(pdev, ahci_pci_bar, hpriv);
+	if (rc)
+		return rc;
+
 	/* detect remapped nvme devices */
 	ahci_remap_check(pdev, ahci_pci_bar, hpriv);
 
-- 
2.25.1

