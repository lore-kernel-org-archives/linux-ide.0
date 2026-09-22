Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5EB3783C1;
	Tue, 22 Sep 2026 03:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790048297; cv=none; b=ky0RF6AHUy8ZRghS7Gsg61n/XuyOESGwGwJme0dlB9yOtMyAh8bHUUtI3DA+404lyYdqmr8gk3qnGyyAuNDRZzo+oIQWpSeCCZUwzVU6iKQdUh+7NK7TGU+99LKUOUMnQ39ejKGpsbC2sGT9IVGptrcN0m4G/cx/RzsqERcpZJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790048297; c=relaxed/simple;
	bh=xN2zkTvPd+onO2/KZqKVWjk8l3OmS4dEBpUh7ugItZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nFb244fKMZPhtg2GwiEIy7cs2albFoWlKs2aYtinGo6Enw6xQWW5b7BFPdEmxsdjzCnHBIUk3LicgHq46gV0pPdmFT4k/r3BbGs4RIPhmKBv3nEwwS/gdFuECYZNR6o53VTrrKWJQeNUalRCPseBuSLTxfEoAoT36I2VfA5V/Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 06301fceb63711f19a56ed5b684f684d-20260922
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:ae91c2bb-a683-4f91-8523-cc1f01088e21,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:3f0b17d375b3652330bdbbfdb3ad2cac,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|850|865|898,TC:nil,Content:0|15|50|99,ED
	M:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 06301fceb63711f19a56ed5b684f684d-20260922
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 707078651; Tue, 22 Sep 2026 11:38:06 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: dlemoal@kernel.org,
	cassel@kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH v3 2/2] ata: pata_parport: fix parport attach idr_alloc for
Date: Tue, 22 Sep 2026 11:38:01 +0800
Message-Id: <cee1a15d98cd0d55f41fd65ca9d222b68a74e7d3.1790047457.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1790047457.git.xiaopei01@kylinos.cn>
References: <cover.1790047457.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

idr_alloc() expects an inclusive start and an exclusive end, so passing
port->number as both arguments produces an empty range. Because
idr_alloc() only falls back to INT_MAX when end <= 0, the allocation
succeeds solely for parport0 and returns -ENOSPC for every other port,
which pata_parport_attach() silently ignores. As a result only
parport0 gets probed and any higher-numbered parports are never
attached.

Use port->number + 1 as the end so the range [port->number,
port->number + 1) contains exactly the desired ID.

Fixes: 246a1c4c6b7f ("ata: pata_parport: add driver (PARIDE replacement)")
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/ata/pata_parport/pata_parport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
index 046ab7e3adbc..6f4e3f47d63e 100644
--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -727,7 +727,7 @@ static void pata_parport_attach(struct parport *port)
 	int pr_num, id;
 
 	mutex_lock(&pi_mutex);
-	id = idr_alloc(&parport_list, port, port->number, port->number,
+	id = idr_alloc(&parport_list, port, port->number, port->number + 1,
 		       GFP_KERNEL);
 	if (id < 0) {
 		mutex_unlock(&pi_mutex);
-- 
2.25.1

