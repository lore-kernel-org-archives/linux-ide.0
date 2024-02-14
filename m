Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CA2604BC
	for <linux-ide@vger.kernel.org>; Wed, 14 Feb 2024 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929888; cv=none; b=k9sCTKnN6yizsvMi0Oj4YWAyg3FSRxoGr+g/VVKTXmAFGOfouNBJKr8nSDP4vqCHZ8hb+6a5iBlSangVaa9LQQRZOpea+WEgbBlBTVy2Sv9qV6l+xOEq7smujvVfUUbyY/nCedqmkXzAdfXV+36q376fNdd1s+dX02Mz6vJK61k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929888; c=relaxed/simple;
	bh=P0k7KUwfeq6RDV3dv0nHDLPXAAT4qrr6qzWT/OKwSO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JXBFBRWh7JDVBhNe2QxEZQ7xrAxvo7a56XtGe7A9o51AD60mvnCsmJ92Ur38prc5HKXC9B1YGRfd4juYE6ADp7AjY8QMfiKXLIOtNZAR0DkSNRSIpckGEZ37T31MRG+fS+B+y/EEijV3K+ihJPj5/9h7SlNRdMTSEluV3QPCFus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=id7xxQEW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="id7xxQEW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D82C433C7;
	Wed, 14 Feb 2024 16:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707929887;
	bh=P0k7KUwfeq6RDV3dv0nHDLPXAAT4qrr6qzWT/OKwSO8=;
	h=From:To:Cc:Subject:Date:From;
	b=id7xxQEWmBwlvK7e4b3DSsMKgnxgP/0kPv7QievJkUGL8nBZz5cUvYFFvOFuSZ5/z
	 +F3EBQdASYm0DrEPHBOEIogs20LUTstUNv5qmUk1x1WOt4XhdAFGyYWfwqi23Wg+5T
	 GfY3UQB6SsCpS+zd7nXTrdE+/TgI9QaGgke1rKTAHwwWdrF7vKpjjpmdbk6fOMY/pS
	 apc9IYKi6t+aq9v8U9HUVlol4JqS1jcSsWCa/B24Ennr4dzgSAItS4gEd1IDl5dhQp
	 rVLs6FQqmMqf771cgrOIpAzpXWRpy1WKqbyJOcQDvKqycElbyuLaIcWFvutVbph7ro
	 wpfumPREIqt6g==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: "Andrey Jr. Melnikov" <temnota.am@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH v2] ahci: asm1064: correct count of reported ports
Date: Wed, 14 Feb 2024 17:57:57 +0100
Message-ID: <20240214165758.986896-1-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Andrey Jr. Melnikov" <temnota.am@gmail.com>

The ASM1064 SATA host controller always reports wrongly,
that it has 24 ports. But in reality, it only has four ports.

before:
ahci 0000:04:00.0: SSS flag set, parallel bus scan disabled
ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xffff0f impl SATA mode
ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led only pio sxs deso sadm sds apst

after:
ahci 0000:04:00.0: ASM1064 has only four ports
ahci 0000:04:00.0: forcing port_map 0xffff0f -> 0xf
ahci 0000:04:00.0: SSS flag set, parallel bus scan disabled
ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xf impl SATA mode
ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led only pio sxs deso sadm sds apst

Signed-off-by: Andrey Jr. Melnikov <temnota.am@gmail.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes since V1: use switch case.

 drivers/ata/ahci.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index da2e74fce2d9..682ff550ccfb 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -671,9 +671,17 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
 static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 					 struct ahci_host_priv *hpriv)
 {
-	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA && pdev->device == 0x1166) {
-		dev_info(&pdev->dev, "ASM1166 has only six ports\n");
-		hpriv->saved_port_map = 0x3f;
+	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA) {
+		switch (pdev->device) {
+		case 0x1166:
+			dev_info(&pdev->dev, "ASM1166 has only six ports\n");
+			hpriv->saved_port_map = 0x3f;
+			break;
+		case 0x1064:
+			dev_info(&pdev->dev, "ASM1064 has only four ports\n");
+			hpriv->saved_port_map = 0xf;
+			break;
+		}
 	}
 
 	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361) {
-- 
2.43.0

