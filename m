Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523A154BD3;
	Wed, 13 Mar 2024 21:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366422; cv=none; b=q0D4hCSL2rSw1MyNmOV/W+yOxPjNUug9rg5NgGcV2GKAuymYX3PozzuLsTZveMZBVeTRrg7QK84EVJQProCeNHvphpjcRjMykbe4RNH8OAqNUV+GNmY7J73iQompp8P1508uwPYWxQcL2CWU/tkassyYxBhBzh1FUocIAXECIhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366422; c=relaxed/simple;
	bh=YnTsv4l7YntrlQny1K+MvgOeYZrWvQDqmF/Vt3RmSIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gqixkebpR9SdomXhrL/CEPtQwevlCS+ZGPBP8NMc19i1CbxBym49mtjph/6vzFMo6IK/xX1xvxKrhzvoPa0nMCkMsmy1hgO45cn1fStp5odtK0W9rNWytjuX9j5MgBbdyrUxrLyWkfIFhbmz27Mb5yZHsjoD6DuVuKfjLpXFAJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Conrad Kostecki <conikost@gentoo.org>
To: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	dlemoal@kernel.org,
	hdegoede@redhat.com,
	cryptearth@googlemail.com
Subject: [PATCH] ahci: asm1064: asm1166: don't limit reported ports
Date: Wed, 13 Mar 2024 22:46:50 +0100
Message-ID: <20240313214650.2165-1-conikost@gentoo.org>
X-Mailer: git-send-email 2.44.0
Reply-To: linux-ide@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, patches have been added to limit the reported count of SATA
ports for asm1064 and asm1166 SATA controllers, as those controllers do
report more ports than physical having.

Unfortunately, this causes trouble for users, which are using SATA
controllers, which provide more ports through SATA PMP
(Port-MultiPlier) and are now not any more recognized.

This happens, as asm1064 and 1166 are handling SATA PMP transparently,
so all non-physical ports needs to be enabled to use that feature.

This patch reverts both patches for asm1064 and asm1166, so old
behavior is restored and SATA PMP will work again, so all physical and
non-physical ports will work again.

Fixes: 0077a504e1a4 ("ahci: asm1166: correct count of reported ports")
Fixes: 9815e3961754 ("ahci: asm1064: correct count of reported ports")
Cc: stable@vger.kernel.org
Reported-by: Matt <cryptearth@googlemail.com>
Signed-off-by: Conrad Kostecki <conikost@gentoo.org>
---
 drivers/ata/ahci.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 78570684ff68..562302e2e57c 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -669,19 +669,6 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
 static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 					 struct ahci_host_priv *hpriv)
 {
-	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA) {
-		switch (pdev->device) {
-		case 0x1166:
-			dev_info(&pdev->dev, "ASM1166 has only six ports\n");
-			hpriv->saved_port_map = 0x3f;
-			break;
-		case 0x1064:
-			dev_info(&pdev->dev, "ASM1064 has only four ports\n");
-			hpriv->saved_port_map = 0xf;
-			break;
-		}
-	}
-
 	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361) {
 		dev_info(&pdev->dev, "JMB361 has only one port\n");
 		hpriv->saved_port_map = 1;
-- 
2.44.0

