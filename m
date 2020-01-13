Return-Path: <SRS0=yvY0=3C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1237DC33CAD
	for <linux-ide@archiver.kernel.org>; Mon, 13 Jan 2020 14:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A442073D
	for <linux-ide@archiver.kernel.org>; Mon, 13 Jan 2020 14:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="e0HEAgvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgAMO1U (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 13 Jan 2020 09:27:20 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44528 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgAMO1U (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 13 Jan 2020 09:27:20 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00DERFVc028525;
        Mon, 13 Jan 2020 08:27:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578925635;
        bh=0LfeQ9z3KBGEFTKm99Ac47ugA4guzHZ+rkdS+dKsngA=;
        h=From:To:CC:Subject:Date;
        b=e0HEAgvSpHId2kyYjIb1VKj52KVXGNsNSM/3bFLTlOahm0fJMPekr0RbmFSJ9Te31
         GXsvQZQ8/ABiIh4gJp3yLAK86a0cCfKW8iiuvqpddxoV0lvCZNM4R411aGLpqJje4+
         rlfRBxFbVdAnZvij2nCR+tVgl9890zA2FMwnmlho=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00DERE1w049457
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Jan 2020 08:27:15 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 13
 Jan 2020 08:27:14 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 13 Jan 2020 08:27:13 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00DERBHt123819;
        Mon, 13 Jan 2020 08:27:12 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vireshk@kernel.org>, <b.zolnierkie@samsung.com>, <axboe@kernel.dk>
CC:     <vkoul@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] ata: pata_arasan_cf: Use dma_request_chan() instead dma_request_slave_channel()
Date:   Mon, 13 Jan 2020 16:27:47 +0200
Message-ID: <20200113142747.15240-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

dma_request_slave_channel() is a wrapper on top of dma_request_chan()
eating up the error code.

The dma_request_chan() is the standard API to request slave channel,
clients should be moved away from the legacy API to allow us to retire
them.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

Changes since v1:
- Fixed type in subject
- Removed reference to deferred probing in commit message

Regards,
Peter

 drivers/ata/pata_arasan_cf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index 391dff0f25a2..e9cf31f38450 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -526,9 +526,10 @@ static void data_xfer(struct work_struct *work)
 
 	/* request dma channels */
 	/* dma_request_channel may sleep, so calling from process context */
-	acdev->dma_chan = dma_request_slave_channel(acdev->host->dev, "data");
-	if (!acdev->dma_chan) {
+	acdev->dma_chan = dma_request_chan(acdev->host->dev, "data");
+	if (IS_ERR(acdev->dma_chan)) {
 		dev_err(acdev->host->dev, "Unable to get dma_chan\n");
+		acdev->dma_chan = NULL;
 		goto chan_request_fail;
 	}
 
@@ -539,6 +540,7 @@ static void data_xfer(struct work_struct *work)
 	}
 
 	dma_release_channel(acdev->dma_chan);
+	acdev->dma_chan = NULL;
 
 	/* data xferred successfully */
 	if (!ret) {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

