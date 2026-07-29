Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F0746D54F;
	Wed, 29 Jul 2026 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323621; cv=none; b=N2MkiAyWKD2mRSZh7IaVI02zvAGEgfEqq2P1mEC8jNZUQRUUvMCMa/1oyHtAsf5XETrDw2XBA3m0R2NTx6rDFirW5XswI8auvkPsqYqBugup1bTIetXtLk2Pfb4sStPdGNApTShKDLgvkJw0pLqL5AUCVlXe9wDUw81adqMmjf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323621; c=relaxed/simple;
	bh=WA8MWqZ8BDratl74keXID81J7QzvGxXI8tmHv1jdFH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r3c/LtMJ7Uxou43UDi8dkG/VeJKuQrft4QXfryzokb2JzODN3HPhiwlF3+hz9gXKDQMKqoPyVKxWWCbDEB3QTydjF0gRbcbG0MQ54fcdqJLfGyFpBvWLCJjlpKfgftYBDtQqzKDWq84NZK2fqP7AEr9tGT8FqCHdBj7t/+8WenQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 84cd14b48b3e11f1aa26b74ffac11d73-20260729
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:37466d99-cbec-4ce6-85f3-3000ec2d20c3,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:0213709af1d73f8c68f4b871e10b9034,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 84cd14b48b3e11f1aa26b74ffac11d73-20260729
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 121648841; Wed, 29 Jul 2026 19:13:25 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: shuangpeng.kernel@gmail.com
Cc: cassel@kernel.org,
	dlemoal@kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] test: ata
Date: Wed, 29 Jul 2026 19:13:07 +0800
Message-Id: <170fe5b11ca8bffc32b4ec6588c289b29da11896.1785323372.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <69B390E9-F5AA-4B22-AF50-070612603F51@gmail.com>
References: <69B390E9-F5AA-4B22-AF50-070612603F51@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi maintainer and shuangpeng,

I tested this patch passed.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/ata/pata_parport/pata_parport.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
index 40baeac594a9..34f09192a419 100644
--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -3,6 +3,7 @@
  * Copyright 2023 Ondrej Zary
  * based on paride.c by Grant R. Guenther <grant@torque.net>
  */
+#include <linux/cleanup.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/parport.h>
@@ -618,8 +619,9 @@ void pata_parport_unregister_driver(struct pi_protocol *pr)
 			break;
 	}
 	idr_remove(&protocols, id);
-	mutex_unlock(&pi_mutex);
 	driver_unregister(&pr->driver);
+	mutex_unlock(&pi_mutex);
+
 }
 EXPORT_SYMBOL_GPL(pata_parport_unregister_driver);
 
@@ -646,6 +648,7 @@ static ssize_t new_device_store(const struct bus_type *bus, const char *buf, siz
 		port_wanted = -1;
 	}
 
+	guard(mutex)(&pi_mutex);
 	drv = driver_find(protocol, &pata_parport_bus_type);
 	if (!drv) {
 		if (strcmp(protocol, "auto")) {
@@ -656,15 +659,12 @@ static ssize_t new_device_store(const struct bus_type *bus, const char *buf, siz
 	} else {
 		pr_wanted = container_of(drv, struct pi_protocol, driver);
 	}
-
-	mutex_lock(&pi_mutex);
 	/* walk all parports */
 	idr_for_each_entry(&parport_list, parport, port_num) {
 		if (port_num == port_wanted || port_wanted == -1) {
 			parport = parport_find_number(port_num);
 			if (!parport) {
 				pr_err("no such port %s\n", port);
-				mutex_unlock(&pi_mutex);
 				return -ENODEV;
 			}
 			/* walk all protocols */
@@ -677,7 +677,6 @@ static ssize_t new_device_store(const struct bus_type *bus, const char *buf, siz
 			parport_put_port(parport);
 		}
 	}
-	mutex_unlock(&pi_mutex);
 	if (!ok)
 		return -ENODEV;
 
-- 
2.25.1

