From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH] ata/pata_arasan_cf: fill dma chan->private from pdata->dma_priv
Date: Fri, 4 Mar 2011 16:39:29 +0530
Message-ID: <aef168cd6b2fd8f73bc559c0413dda003fcd09d7.1299236795.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:41720 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759005Ab1CDLKK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Mar 2011 06:10:10 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: shiraz.hashim@st.com, amit.goel@st.com, armando.visconti@st.com, viresh.linux@gmail.com, Viresh Kumar <viresh.kumar@st.com>

Some DMA controllers (eg: drivers/dma/dw_dmac*) allow platform specific
configuration for dma transfers. User drivers need to set chan->private field
of channel with pointer to configuration data. This patch takes dma_priv data
from platform data and passes it to chan->private_data, in order to pass
platform specific configuration to DMAC controller.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/ata/pata_arasan_cf.c        |    7 ++++++-
 include/linux/pata_arasan_cf_data.h |    2 ++
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index b99b3fc..d67bff7 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -210,6 +210,8 @@ struct arasan_cf_dev {
 	struct dma_chan *dma_chan;
 	/* Mask for DMA transfers */
 	dma_cap_mask_t mask;
+	/* dma channel private data */
+	void *dma_priv;
 	/* DMA transfer work */
 	struct work_struct work;
 	/* DMA delayed finish work */
@@ -356,6 +358,7 @@ static void dma_callback(void *dev)
 
 static bool filter(struct dma_chan *chan, void *slave)
 {
+	chan->private = slave;
 	return true;
 }
 
@@ -526,7 +529,8 @@ static void data_xfer(struct work_struct *work)
 
 	/* request dma channels */
 	/* dma_request_channel may sleep, so calling from process context */
-	acdev->dma_chan = dma_request_channel(acdev->mask, filter, NULL);
+	acdev->dma_chan = dma_request_channel(acdev->mask, filter,
+			acdev->dma_priv);
 	if (!acdev->dma_chan) {
 		dev_err(acdev->host->dev, "Unable to get dma_chan\n");
 		goto chan_request_fail;
@@ -853,6 +857,7 @@ static int __devinit arasan_cf_probe(struct platform_device *pdev)
 	INIT_WORK(&acdev->work, data_xfer);
 	INIT_DELAYED_WORK(&acdev->dwork, delayed_finish);
 	dma_cap_set(DMA_MEMCPY, acdev->mask);
+	acdev->dma_priv = pdata->dma_priv;
 
 	/* Handle platform specific quirks */
 	if (pdata->quirk) {
diff --git a/include/linux/pata_arasan_cf_data.h b/include/linux/pata_arasan_cf_data.h
index d979fe6..a6ee9aa 100644
--- a/include/linux/pata_arasan_cf_data.h
+++ b/include/linux/pata_arasan_cf_data.h
@@ -37,6 +37,8 @@ struct arasan_cf_pdata {
 	#define CF_BROKEN_PIO			(1)
 	#define CF_BROKEN_MWDMA			(1 << 1)
 	#define CF_BROKEN_UDMA			(1 << 2)
+	/* This is platform specific data for the DMA controller */
+	void *dma_priv;
 };
 
 static inline void
-- 
1.7.2.2

