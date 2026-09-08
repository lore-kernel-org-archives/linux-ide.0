Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F06530E15;
	Tue,  8 Sep 2026 11:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788868068; cv=none; b=nmBPj+yztEhOXewZzUrDXRP62FmwfTGVzsQlHEMxY4bY70BP5jGm0Zn59vnfw8bRrF/IIyKOoE93+5C22fiDmXY7KxA8SgklwCVLDPsvsPzMrA8MH3G/cx0lvKHOSi1agUqMHZdVt8bcmwJWN8La9QJRNH+8PoSuGzhRsRXxUYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788868068; c=relaxed/simple;
	bh=RepKNe2IPUziqdF1SwNKt2eTdYG6RJHGVUBaLjF3xIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ReK5AIb28vtych+FDX6EWXtm++bBM94NqQ6POhOS9xq+oDuKudhURd5ZBEs0qWmod4LD4W5gpgMJT5hLaIXXUOF3lw6ZXrCk6Yxvjr34PqJ7Dzsn1DqX8JLJrTyQ5eBdklw6oyt4b8Abm7+ESxoGzNv+belCgrN2l4Nf7YS5XZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1397c3b8ab7b11f19a56ed5b684f684d-20260908
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:4724b2e0-6f74-4022-99fa-f527c2ed9d9b,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:47d28a05b131a71146b4e6e0943d5b51,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|850|865|898,TC:nil,Content:0|15|50|99,ED
	M:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1397c3b8ab7b11f19a56ed5b684f684d-20260908
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 610756961; Tue, 08 Sep 2026 19:47:32 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: dlemoal@kernel.org,
	cassel@kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH v2 2/2] ata: pata_parport: unregister devices on protocol unregister
Date: Tue,  8 Sep 2026 19:47:28 +0800
Message-Id: <cec58ea83362df88f516ba7a5b895cf07edd7728.1788867690.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1788867690.git.xiaopei01@kylinos.cn>
References: <cover.1788867690.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a protocol module registers multiple protocols and a later
registration fails (e.g. kbic_init registering k951 then k971), the
rollback path calls pata_parport_unregister_driver() on the already
registered protocol. This removes the protocol from the IDR and
unregisters the driver, but leaves the dynamically created pi_adapter
devices untouched.

Since the module init then fails, the module loader frees the module
memory, bypassing the references held by the devices. Any later removal
of these dangling devices (e.g. via sysfs delete_device or parport
detach) hits pi_remove_one() -> pi_disconnect() -> pi->proto->disconnect,
dereferencing the freed module memory and crashing the kernel.

Tear down all pi_adapters using the protocol in
pata_parport_unregister_driver(), before driver_unregister(), while the
module is still alive so the ->disconnect / ->release_proto callbacks
are safe to call.

Fixes: 246a1c4c6b7f ("ata: pata_parport: add driver (PARIDE replacement)")
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/ata/pata_parport/pata_parport.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
index 046ab7e3adbc..712209882ab7 100644
--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -611,6 +611,18 @@ int pata_parport_register_driver(struct pi_protocol *pr)
 }
 EXPORT_SYMBOL_GPL(pata_parport_register_driver);
 
+static int pi_remove_by_proto(struct device *dev, void *data)
+{
+	struct pi_protocol *pr = data;
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct pi_adapter *pi = host->private_data;
+
+	if (pi->proto == pr)
+		pi_remove_one(dev);
+
+	return 0;
+}
+
 void pata_parport_unregister_driver(struct pi_protocol *pr)
 {
 	struct pi_protocol *pr_iter;
@@ -622,6 +634,8 @@ void pata_parport_unregister_driver(struct pi_protocol *pr)
 			break;
 	}
 	idr_remove(&protocols, id);
+	/* remove adapters using this protocol while the module is still alive */
+	bus_for_each_dev(&pata_parport_bus_type, NULL, pr, pi_remove_by_proto);
 	driver_unregister(&pr->driver);
 	mutex_unlock(&pi_mutex);
 
-- 
2.25.1

