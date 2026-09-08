Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D138923394A
	for <linux-ide@vger.kernel.org>; Tue,  8 Sep 2026 02:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788834671; cv=none; b=c24qo9b5V3OhNxREF2AHrPBxiVRw4lVCVNhHRUs2lXsaJvhVUTDLigG03rz9yvEkOLEOJ0Ib/CpCIdhFyl4zR+2DNxW6BsiErQC6bNIFwW4hboJqs8TwW7NZtMSEz2xYVxdnsHzZl8uMTe1su4krp2C+qLKpUGXmaLMD4oCudBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788834671; c=relaxed/simple;
	bh=lnOhpYhH1jkAEei9ze5bOC2kxUt3Jz9HmV6YFR0gsv8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=MU75vjExLLl6Pjy2TTmJnwpG12S7fhs2JDirtLhZu6Fdno+m4/UOwoFyPnXfuySA3Yj4cLx8x48qHtV86bLeDZmYSTO2HZ/Tv9Hx1gA7AclgSGCRXOvMYBmf2TXDDxUSnusrWEYBMo6G1Z2uF9tGq4TFuyArN0DSZ4LKJpwMDeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 564cd494ab2d11f19a56ed5b684f684d-20260908
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:4676db1f-3baf-4828-abee-d84e22cc3ea5,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:76d31c4af927962f6193aa4c1d60fb86,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:5,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 564cd494ab2d11f19a56ed5b684f684d-20260908
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1952640643; Tue, 08 Sep 2026 10:31:03 +0800
From: Li Jun <lijun01@kylinos.cn>
To: lijun01@kylinos.cn,
	dlemoal@kernel.org,
	cassel@kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: ahci_da850: switch to DEFINE_SIMPLE_DEV_PM_OPS
Date: Tue,  8 Sep 2026 10:30:54 +0800
Message-Id: <20260908023054.574049-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated SIMPLE_DEV_PM_OPS macro with the recommended
DEFINE_SIMPLE_DEV_PM_OPS.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 drivers/ata/ahci_da850.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
index 4e53ff96d712..9c8b4f9eb9fe 100644
--- a/drivers/ata/ahci_da850.c
+++ b/drivers/ata/ahci_da850.c
@@ -218,7 +218,7 @@ static int ahci_da850_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static SIMPLE_DEV_PM_OPS(ahci_da850_pm_ops, ahci_platform_suspend,
+static DEFINE_SIMPLE_DEV_PM_OPS(ahci_da850_pm_ops, ahci_platform_suspend,
 			 ahci_platform_resume);
 
 static const struct of_device_id ahci_da850_of_match[] = {
-- 
2.25.1

