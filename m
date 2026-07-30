Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1780C3AFCE2;
	Thu, 30 Jul 2026 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785399217; cv=none; b=H6jywLsbfWKdu94GK9Qw1EP44h2Nny0UBDnbeQmIsWmaH+FyrDxZdHTDXDBw8l4fGPdylJ7m9tQ+o8fcT0No7Bm/b/XnfHMUbLYAVU5/vOjOA7ZpqspirpiABX14fFcDzMRKFjR+90pIKE52B9yTsoz/uEjUqser2qbpZaqy95Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785399217; c=relaxed/simple;
	bh=Dtyp+fZUYG4uzTgw0HIVsGptrDfp5/iAHpIBwKseJyI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k+rOKJR5MG28iuncu6uUoX5GCLDIDm6UuEvo0GqYxGMbxt4Nm7fYNr82PJV/PB14RkYVt0o4rLesieLUOxJA2iZsW1MFWfl9/5Lik8vpCjDE0AmZKFMotP9vuPkBuFiwE/G7vtHQ6FpQM3hfTTr5HwiOdCDScbmPrTdUoN5TU4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8a3b13d28bee11f1aa26b74ffac11d73-20260730
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:7f2bb839-9458-4007-a179-389e7e9689c3,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:ff52c6260522e9eb7cb654aa4a176b38,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8a3b13d28bee11f1aa26b74ffac11d73-20260730
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 276443016; Thu, 30 Jul 2026 16:13:26 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: dlemoal@kernel.org,
	cassel@kernel.org,
	linux@zary.sk,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: shuangpeng.kernel@gmail.com,
	Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] ata: pata_parport: Fix missing module refcount for pata_parport itself
Date: Thu, 30 Jul 2026 16:13:22 +0800
Message-Id: <a8d9807618ab786313654099c904d613075e1b63.1785398816.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pata_parport core module can be unloaded while devices are still
attached, because there is no module reference taken for the core
module itself -- only for the protocol driver.

Add a __module_get(THIS_MODULE) in the success path of pi_init_one()
and the corresponding module_put(THIS_MODULE) in
pata_parport_dev_release(), so that rmmod pata_parport is prevented
when devices are present.

In the dev_release callback, the pi->proto guard ensures that
module_put() is skipped for the early error case where
device_register() fails before __module_get() was called.

Fixes: 246a1c4c6b7f ("ata: pata_parport: add driver (PARIDE replacement)")
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/ata/pata_parport/pata_parport.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
index cf81a6128f55..b73b023b0443 100644
--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -455,6 +455,12 @@ static void pata_parport_dev_release(struct device *dev)
 {
 	struct pi_adapter *pi = container_of(dev, struct pi_adapter, dev);
 
+	/*
+	 * pi->proto is NULL when device_register() fails early,
+	 * before __module_get() was called -- skip module_put().
+	 */
+	if (pi->proto)
+		module_put(THIS_MODULE);
 	ida_free(&pata_parport_bus_dev_ids, dev->id);
 	kfree(pi);
 }
@@ -524,6 +530,8 @@ static struct pi_adapter *pi_init_one(struct parport *parport,
 
 	pi->proto = pr;
 
+	__module_get(THIS_MODULE);
+
 	if (!try_module_get(pi->proto->owner))
 		goto out_unreg_dev;
 	if (pi->proto->init_proto && pi->proto->init_proto(pi) < 0)
-- 
2.25.1

