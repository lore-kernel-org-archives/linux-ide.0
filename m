Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF387480961;
	Wed,  2 Sep 2026 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788349888; cv=none; b=dAOxt9LgmURfxV+x+9AVXhasGByMjkAKPpnnr/HBxJ3RWlB9+m539IIsTkc2x+WCBgULbckHOE6pKh+sRUF5mocSj6aPHonJ6qTx0umtPesIM4Og87lzZVT+9hEsauWRNRdt/bUfG1MVPOkoHVdpNI5XeMCGZ0uSZnYXZKVqW3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788349888; c=relaxed/simple;
	bh=2AxfjnYrKKDTq4fC5zkKNyv6KV5kv0hx4+aoaYr3fbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HCOD4suwqcV+vyDJlCLtM1TK4LnVRjVZytiXEHDQj7ug3aMBzbb8EE0kcIFFABo0ezJhPOaBpidUBIze7W6XTDKqGMUT1QgWBqaTGCtSqKnw8iGFFU38rwV0J7prm82IlW1wajIq9H0w4/L/hcEpnbe8fSXWaIBiZm8rboXijDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8c115612a6c411f19a56ed5b684f684d-20260902
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:2631583f-13b2-4781-aac4-e953d390709d,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:5db4fd9df2bbaeda130dbd3614bd6df1,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|850|865|898,TC:nil,Content:0|15|50,EDM:5
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8c115612a6c411f19a56ed5b684f684d-20260902
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1329336197; Wed, 02 Sep 2026 19:50:51 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: dlemoal@kernel.org,
	cassel@kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: shuangpeng.kernel@gmail.com,
	Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH 1/2] ata: pata_parport: pin the protocol module before device_register()
Date: Wed,  2 Sep 2026 19:50:26 +0800
Message-Id: <eae63a4231a9d669f3dc140f34c7b90c860cad72.1788349317.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1788349317.git.xiaopei01@kylinos.cn>
References: <cover.1788349317.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pi_init_one() calls device_register() before try_module_get(). Between
these two calls the device is already visible but the module is not
pinned yet, so an unload in this window leaves pi->proto dangling:

    pi_init_one()                       rmmod -f <proto>
    --------------------------------------------------------
    device_register(&pi->dev)
         device visible on the bus
                                           module memory freed
         pi->proto = pr        <- writes into freed memory / dangles
         try_module_get(...)   <- too late, module already gone

Take the module reference before registering the device, and drop it
on the device_register() failure path.

Fixes: 246a1c4c6b7f ("ata: pata_parport: add driver (PARIDE replacement)")
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/ata/pata_parport/pata_parport.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
index cf81a6128f55..7462f9b1acc5 100644
--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -509,6 +509,14 @@ static struct pi_adapter *pi_init_one(struct parport *parport,
 		return NULL;
 	}
 
+	pi->proto = pr;
+
+	if (!try_module_get(pi->proto->owner)) {
+		kfree(pi);
+		ida_free(&pata_parport_bus_dev_ids, id);
+		return NULL;
+	}
+
 	/* set up pi->dev before pi_probe_unit() so it can use dev_printk() */
 	pi->dev.parent = pata_parport_bus;
 	pi->dev.bus = &pata_parport_bus_type;
@@ -517,15 +525,12 @@ static struct pi_adapter *pi_init_one(struct parport *parport,
 	pi->dev.id = id;
 	dev_set_name(&pi->dev, "pata_parport.%u", pi->dev.id);
 	if (device_register(&pi->dev)) {
+		module_put(pi->proto->owner);
 		put_device(&pi->dev);
 		/* pata_parport_dev_release will do ida_free(dev->id) and kfree(pi) */
 		return NULL;
 	}
 
-	pi->proto = pr;
-
-	if (!try_module_get(pi->proto->owner))
-		goto out_unreg_dev;
 	if (pi->proto->init_proto && pi->proto->init_proto(pi) < 0)
 		goto out_module_put;
 
-- 
2.25.1

