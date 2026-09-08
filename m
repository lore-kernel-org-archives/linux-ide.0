Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A9D39099C
	for <linux-ide@vger.kernel.org>; Tue,  8 Sep 2026 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788858604; cv=none; b=TMyQ2DFzH5JSTwAnjYa9y9Sn5JbNAHGVxHXQVdZZROXlf8F21wPTMRmPhBjFxP0jZxRT3lLOChVc2YqAfeQoqCmUfZtMZfyPu1YJGJJ7AB1zNMez/mzW4Fi/cUdOtSPvNWv5B2jVG6tx0OeUBtveDkI32Yf8NFBVs577UbkJIrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788858604; c=relaxed/simple;
	bh=FDFFaVDl4D1GcwbSfXKasg3MnhfQrdv4xwTv5MaM2S8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=D1pwOJYZu+nz4CJbheeXcy6DXvIBDZ9z0VnUxZL60mWECK4gTzYTN/ToopOdcOP2+vTXfLH9Jh7qv6LzPYBTHpSqkta1/IRQChkNPbKPIMQXn3YbFl7NVMXAQMiG3MzkO4fhwOKST5Y0Ja/R1wI0LxC1eCjXmGuL013JgZKHleo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0c454542ab6511f19a56ed5b684f684d-20260908
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:b5b5e0f2-b5f9-493c-9a6c-7bdd28964b01,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:f9e7bca6b0a109169fb1a2423d6ea48b,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:5,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0c454542ab6511f19a56ed5b684f684d-20260908
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 612520456; Tue, 08 Sep 2026 17:09:51 +0800
From: Li Jun <lijun01@kylinos.cn>
To: lijun01@kylinos.cn,
	dlemoal@kernel.org,
	cassel@kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH v4] ata: ahci_da850: switch to DEFINE_SIMPLE_DEV_PM_OPS
Date: Tue,  8 Sep 2026 17:09:36 +0800
Message-Id: <20260908090936.1961634-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated SIMPLE_DEV_PM_OPS macro with the recommended
DEFINE_SIMPLE_DEV_PM_OPS. Use pm_ptr(&ahci_da850_pm_ops) to complete
the API migration and allow the structure to be correctly dropped
when CONFIG_PM=n.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
changelogs:
-add pm_ptr for ahci_da850_pm_ops in ahci_da850_driver.
-revise grammar and alignment issues.
-Align parentheses
---
 drivers/ata/ahci_da850.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
index 4e53ff96d712..febebf713748 100644
--- a/drivers/ata/ahci_da850.c
+++ b/drivers/ata/ahci_da850.c
@@ -218,8 +218,8 @@ static int ahci_da850_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static SIMPLE_DEV_PM_OPS(ahci_da850_pm_ops, ahci_platform_suspend,
-			 ahci_platform_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(ahci_da850_pm_ops, ahci_platform_suspend,
+				ahci_platform_resume);
 
 static const struct of_device_id ahci_da850_of_match[] = {
 	{ .compatible = "ti,da850-ahci", },
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

