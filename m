Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC511FECAE;
	Tue,  4 Mar 2025 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080435; cv=none; b=r3SgqaYvui3mi5cJnQODJXdn3qTuui/CF/0DDqWx1Jg82xzv/UYbI+Vx4SKVnkEqyQUoQHzzuPLAWeRTieKTYcL7NvzpV/IV+2xcAlJVCmkfxbUr+JsX0EeDjJfrmboo0ukKduIswnY/AQKQchSv/eFPFespsn+Q5e79ujSe3Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080435; c=relaxed/simple;
	bh=2vCR1OREsmenthZ/QsIRThBG4kKXOUqkGPtrlpvkQ3g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iI6C6zePGdlWzDrZY0J8jhk9K2bzIpySK0OrfLp8rs+FwanSGvwuOmqfcWzdmiYXU0nSxcac0/uY42ihT0/721jjNWd+rWTWeMp06wc6wvayJyr1sa3qnyo8aCdaT1ByelrIXJDlwOZzsYQHgqukPTzu8TvRXPRvCcLRVoC8NUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 5C7994884C;
	Tue,  4 Mar 2025 10:20:53 +0100 (CET)
From: Daniel Kral <d.kral@proxmox.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ahci: add PCI ID for Marvell 88SE9215 SATA Controller
Date: Tue,  4 Mar 2025 10:20:30 +0100
Message-Id: <20250304092030.37108-1-d.kral@proxmox.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for Marvell Technology Group Ltd. 88SE9215 SATA 6 Gb/s
controller, which is e.g. used in the DAWICONTROL DC-614e RAID bus
controller and was not automatically recognized before.

Tested with a DAWICONTROL DC-614e RAID bus controller.

Originally-by: Johannes Keßler <mail@bananas-playground.net>
Link: https://www.bananas-playground.net/2022/11/worknote-debian-dawicontrol-88se9215/
Tested-by: Johannes Keßler <mail@bananas-playground.net>
Signed-off-by: Daniel Kral <d.kral@proxmox.com>
---
 drivers/ata/ahci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index f813dbdc2346..52ae8f9a7dd6 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -589,6 +589,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x91a3),
 	  .driver_data = board_ahci_yes_fbs },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9215),
+	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
 	  .driver_data = board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9235),
-- 
2.39.5


