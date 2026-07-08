Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC8C405C3B;
	Wed,  8 Jul 2026 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502848; cv=none; b=swjPCkBqsKn9/jhJVkVOYwg6M1QUoO9rcasVIJOMUUS/UiUuDNRkrlOIte51Mo5ftvyqRWgJ5xrLWhyo0vQMCW1CdXKs9qNzy7hjSVkQ4GCb7luXqjeWxjq8kjpgasW/hJaublGpxoMUQsLjHiyhsIuJ+jRZppYU2HD/8+a//Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502848; c=relaxed/simple;
	bh=aQavpBqCPrfqinuvLBp0pc8r5aZKuAf8jSg+zbb2XDE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d2ml7MrehNhKJrR500MLEd2ZybC1FsAHLcnF6uheYy/TQaPDHNrC/zk6S5Os7HoYgPkAFAgfSz6crSI6WQbW4pd5bq96UImX7WuPjvV8g24eBpCYaR9I9DIHNYxJzPoLaF7MhrctuqH9LIJmx9tz4GqxLPvp4DdSO65tAUcVSbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 341a293e7aaf11f1aa26b74ffac11d73-20260708
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:89cf63eb-972c-41da-9d29-dd7699f1f44b,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:91fe2bf6a95ae0902b3914c889351518,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 341a293e7aaf11f1aa26b74ffac11d73-20260708
X-User: chenchangcheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenchangcheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1180036344; Wed, 08 Jul 2026 17:27:13 +0800
From: Chen Changcheng <chenchangcheng@kylinos.cn>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Nikita Shubin <nikita.shubin@maquefel.me>,
	Vinod Koul <vkoul@kernel.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Changcheng <chenchangcheng@kylinos.cn>
Subject: [PATCH] ata: pata_ep93xx: fix double-free of DMA channel on error path
Date: Wed,  8 Jul 2026 17:27:04 +0800
Message-Id: <20260708092704.60815-1-chenchangcheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ep93xx_pata_dma_init() error path, when dma_request_chan() for the tx
channel fails, the code jumps to fail_release_rx which releases the rx
channel via dma_release_channel() and then falls through to
fail_release_dma, which calls ep93xx_pata_release_dma(). This causes a
double-free of dma_rx_channel. Additionally, drv_data->dma_tx_channel
holds an ERR_PTR at this point, so ep93xx_pata_release_dma() would also
attempt to dma_release_channel() on it.

Fix by removing the fail_release_rx label and jumping directly to
fail_release_dma instead. Make ep93xx_pata_release_dma() use
IS_ERR_OR_NULL() so that it safely handles channels that may be
ERR_PTR rather than valid pointers.

Fixes: 9963113e3a92 ("ata: pata_ep93xx: add device tree support")
Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
---
 drivers/ata/pata_ep93xx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index 42a24dc51d26..b4fb89481b7e 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -629,11 +629,11 @@ static int ep93xx_pata_bus_softreset(struct ata_port *ap, unsigned int devmask,
 
 static void ep93xx_pata_release_dma(struct ep93xx_pata_data *drv_data)
 {
-	if (drv_data->dma_rx_channel) {
+	if (!IS_ERR_OR_NULL(drv_data->dma_rx_channel)) {
 		dma_release_channel(drv_data->dma_rx_channel);
 		drv_data->dma_rx_channel = NULL;
 	}
-	if (drv_data->dma_tx_channel) {
+	if (!IS_ERR_OR_NULL(drv_data->dma_tx_channel)) {
 		dma_release_channel(drv_data->dma_tx_channel);
 		drv_data->dma_tx_channel = NULL;
 	}
@@ -664,7 +664,7 @@ static int ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 	if (IS_ERR(drv_data->dma_tx_channel)) {
 		ret = dev_err_probe(dev, PTR_ERR(drv_data->dma_tx_channel),
 				    "tx DMA setup failed\n");
-		goto fail_release_rx;
+		goto fail_release_dma;
 	}
 
 	/* Configure receive channel direction and source address */
@@ -691,8 +691,6 @@ static int ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
 
 	return 0;
 
-fail_release_rx:
-	dma_release_channel(drv_data->dma_rx_channel);
 fail_release_dma:
 	ep93xx_pata_release_dma(drv_data);
 
-- 
2.25.1

