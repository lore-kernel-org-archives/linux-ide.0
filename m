Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB78F3859DC
	for <linux-ide@vger.kernel.org>; Thu,  6 Aug 2026 06:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785996409; cv=none; b=Mwhjq1UFgliyaQCKez8Q+5uNfswETXHQ6VZIllH9gbe1/d34DTl5enayL3rFxRfiZwtRTDYlYTnb3uFqjscRNc7ATmPAC1gl+44EmQrbCaa0+pprBGXr3eeL9RjfVxQ8+lhDhTQ8MXi545xeoYQGPjgdz4JG6+YfDddqaI4Twvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785996409; c=relaxed/simple;
	bh=K3D2G2rrsaXoVYbKbRzztZhwXchlqjxiN4t5foSjAsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q6tXP8W5+fgFff0QlCS1gpni4oq2ZjbOOg3Cd0xC8EjwUfHCgmFlJJ0YfwmgJtsC5y8S0BO1jNZVX/2BZ9UYcVZGtnS8xvl7fnmBSpEfPWO4QAxrdYWjdUVbtvFRDDWcxiowmKx200MSarG+x+AYduS+CN11Ylw2HHfYN/Ggmao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=arXc3MzE; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="arXc3MzE"
Received: from LAPTOP-99KJFSET (unknown [36.153.54.46])
	by smtp.qiye.163.com (Hmail) with ESMTP id 48fb94a2c;
	Thu, 6 Aug 2026 14:06:41 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH] ata: pata_sl82c105: fix bridge revision use-after-free
Date: Thu,  6 Aug 2026 14:06:28 +0800
Message-ID: <20260806060628.1658-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fd5ae499203a1kunm3926e9b128936d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaH0NCVhhISEsaS0kZGR1IGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VT01ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=arXc3MzEP5L41d+4O5uZpwXzIy27lWIIp/F6dTw1MOlkpKklw42Mm5jh1Ha+poHf47whGCsLsXN2IekKv6RuyfR2MHv8V29wuJHHsJUP4Q/jbdme9zL2DMZMAUDBVDzJUs5gNfZPqbQPgmyqYKWxTz9n3Dae1jdg7jgGDNf8rVc=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=2N1OCWO9nq7UsG/qW/Ty3OOSvCOIhqvQIrwKIEgxhdE=;
	h=date:mime-version:subject:message-id:from;

pci_get_slot() returns a referenced PCI device. Commit 44c10138fd4b
("PCI: Change all drivers to use pci_device->revision") replaced a
configuration-space read with direct access to the cached revision field,
but left that access after pci_dev_put(). The bridge may therefore be freed
before its revision is read.

Read the revision before dropping the reference.

Fixes: 44c10138fd4b ("PCI: Change all drivers to use pci_device->revision")
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/ata/pata_sl82c105.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_sl82c105.c b/drivers/ata/pata_sl82c105.c
index 2d24c6b3e9d9..25bce3fe2a10 100644
--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -264,6 +264,7 @@ static struct ata_port_operations sl82c105_port_ops = {
 static int sl82c105_bridge_revision(struct pci_dev *pdev)
 {
 	struct pci_dev *bridge;
+	u8 revision;
 
 	/*
 	 * The bridge should be part of the same device, but function 0.
@@ -285,8 +286,9 @@ static int sl82c105_bridge_revision(struct pci_dev *pdev)
 	/*
 	 * We need to find function 0's revision, not function 1
 	 */
+	revision = bridge->revision;
 	pci_dev_put(bridge);
-	return bridge->revision;
+	return revision;
 }
 
 static void sl82c105_fixup(struct pci_dev *pdev)
-- 
2.50.1.windows.1

