Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61F72ED16D
	for <linux-ide@vger.kernel.org>; Tue,  8 Sep 2026 02:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788836378; cv=none; b=uKh6/mQJ//Qxx037el1B1dqtwqwtC+WpiZbWnjmzbJ8pDSekS9X5hm6Ks03kDAr3GvByVsYCln+8iyR1JuRXARa2gPPKgc2lgwjY0QezQVcokCdiZgYqImak1ME6ebyRPvd2Fk57OJl/Mi7nXI+qpLYiH8MbHgv5u2p9vv3YT84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788836378; c=relaxed/simple;
	bh=JWT4gl7gyDzRXpzPhjcgK6zt6pMuPQ4jYBEutm0ElcM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=FE22HRGKpQmhyT72tocGP58EbvZxKozJFIxtzvBj+7NRgIlmK+p4Mw+eWCiJauCCfcUSQhGfsZuvdJUAOTiEVk+Z/IELTZ+XgT50BdPbsV46d7NkrSrzFkGZdAB+ZTU9Hi9+n+u/Uz+iWnKaiJvXa+0ioHRXvdVs7spgJSekCDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4f4291e4ab3111f19a56ed5b684f684d-20260908
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:45d7621f-c0d0-45c3-9270-812f2dbe9555,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:a81ce100c26c13f40273423c26f10959,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:5,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4f4291e4ab3111f19a56ed5b684f684d-20260908
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 977404547; Tue, 08 Sep 2026 10:59:29 +0800
From: Li Jun <lijun01@kylinos.cn>
To: lijun01@kylinos.cn,
	dlemoal@kernel.org,
	cassel@kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH v2] ata: ahci_da850: switch to DEFINE_SIMPLE_DEV_PM_OPS
Date: Tue,  8 Sep 2026 10:59:15 +0800
Message-Id: <20260908025915.955528-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated SIMPLE_DEV_PM_OPS macro with the recommended
DEFINE_SIMPLE_DEV_PM_OPS.use pm_ptr(&ahci_da850_pm_ops) to complete
the API migration and allow the structure to be correctly dropped
when CONFIG_PM=n.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
changelogs:
-add pm_ptr for ahci_da850_pm_ops in ahci_da850_driver.
---
 drivers/ata/ahci_da850.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
index 4e53ff96d712..0b390395679e 100644
--- a/drivers/ata/ahci_da850.c
+++ b/drivers/ata/ahci_da850.c
@@ -218,7 +218,7 @@ static int ahci_da850_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static SIMPLE_DEV_PM_OPS(ahci_da850_pm_ops, ahci_platform_suspend,
+static DEFINE_SIMPLE_DEV_PM_OPS(ahci_da850_pm_ops, ahci_platform_suspend,
 			 ahci_platform_resume);
 
 static const struct of_device_id ahci_da850_of_match[] = {
@@ -233,7 +233,7 @@ static struct platform_driver ahci_da850_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = ahci_da850_of_match,
-		.pm = &ahci_da850_pm_ops,
+		.pm = pm_ptr(&ahci_da850_pm_ops),
 	},
 };
 module_platform_driver(ahci_da850_driver);
-- 
2.25.1

