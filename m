Return-Path: <SRS0=AjNr=5C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84322C10F29
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F10F20735
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rOTupMd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgCQOpk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:45:40 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40359 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgCQOno (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Mar 2020 10:43:44 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200317144343euoutp02fbb33b328be055b6a90939ed37575945~9HopasQA91582715827euoutp025
        for <linux-ide@vger.kernel.org>; Tue, 17 Mar 2020 14:43:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200317144343euoutp02fbb33b328be055b6a90939ed37575945~9HopasQA91582715827euoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584456223;
        bh=SD29ru+XPRj8/MpkvAn2nNtxS7lNQ61UJF7W2WDfjqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rOTupMd5v3nBClpACH0hcXL1p2OSYXh78pP4ySS4riI+cCdfnH0cODjfbcdqOiqH0
         +/X180prE7ku5dbBAjt+pBsT6zhf0BtJP6Q89RhudGnPV63cTE5AFzRjwXaKLWJmDl
         NEOuxMdMaK/mO4ku8SxYWh9neNay8NHKpvpXAfL4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200317144343eucas1p1d564b887d8bff2e1a7dca6bc5dc46881~9HopKmVqW1084010840eucas1p1W;
        Tue, 17 Mar 2020 14:43:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6B.D3.61286.F12E07E5; Tue, 17
        Mar 2020 14:43:43 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200317144342eucas1p2fd5c2e6ff69f8e10496d0468f01f5601~9Hoo2GOVe3190831908eucas1p2e;
        Tue, 17 Mar 2020 14:43:42 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200317144342eusmtrp21efe315c8d408ca7ded35e026d0e0220~9Hoo1jatv0147801478eusmtrp2y;
        Tue, 17 Mar 2020 14:43:42 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-1e-5e70e21f08ef
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 59.D4.08375.E12E07E5; Tue, 17
        Mar 2020 14:43:42 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144342eusmtip112aedb345ff113b8f392a881c8d5b260~9HooZ7mjh1029210292eusmtip1B;
        Tue, 17 Mar 2020 14:43:42 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v4 04/27] sata_promise: use ata_cable_sata()
Date:   Tue, 17 Mar 2020 15:43:10 +0100
Message-Id: <20200317144333.2904-5-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317144333.2904-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djP87ryjwriDJpPslqsvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoLpuU1JzMstQifbsEroymTzuYCzZyV8z4c5i9gfEwZxcjJ4eE
        gInExS3trF2MXBxCAisYJe53fGeBcL4wStyYeR3K+cwocXX+Q0aYlvn9LcwQieWMEl3nPrDD
        tdxc/pcZpIpNwEpiYvsqsA4RAQWJnt8r2UCKmAXeM0qsmLSXBSQhLGAjMX3OGSCbg4NFQFWi
        tYELJMwLFL6xaCUrxDZ5ia3fPoHZnAK2EtcO/2ODqBGUODnzCdgYZqCa5q2zwS6SEFjGLvG8
        +wEbyEwJAReJ0xd0IOYIS7w6voUdwpaR+L9zPhNE/TpGib8dL6CatzNKLJ8MsUFCwFrizrlf
        YIOYBTQl1u/Shwg7SnydNIkFYj6fxI23ghA38ElM2jadGSLMK9HRJgRRrSaxYdkGNpi1XTtX
        MkPYHhL967rYJjAqzkLyzSwk38xC2LuAkXkVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZG
        YCI6/e/4px2MXy8lHWIU4GBU4uHl2FAQJ8SaWFZcmXuIUYKDWUmEd3FhfpwQb0piZVVqUX58
        UWlOavEhRmkOFiVxXuNFL2OFBNITS1KzU1MLUotgskwcnFINjOKcgrHbc5P8taPW6W997Op2
        Irn3Osej8u+aaXVHI4LTN4jt/PLkZmBJzC3DcouMGVrb26a8Lnt/rP5Ry37Bicvv+iv//D1r
        5Zrjkz63tkZz9B8Tfca8e+ffS1pNxwXvbVH60Fi9ccKntxlPU7qK085ddDK86HakXkWpZkLU
        /LVLjJ7OuDXXl12JpTgj0VCLuag4EQAXXdvJQAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xu7pyjwriDM7cNbJYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehlNn3YwF2zkrpjx5zB7A+Nhzi5GTg4JAROJ+f0tzF2MXBxCAksZJc5e
        eQzkcAAlZCSOry+DqBGW+HOtiw2i5hOjRNvVG0wgCTYBK4mJ7asYQWwRAQWJnt8rwYqYBb4y
        Siyd1M0MkhAWsJGYPucMC8hQFgFVidYGLpAwL1D4xqKVrBAL5CW2fvsEZnMK2EpcO/yPDcQW
        Aqp58eY/E0S9oMTJmU9YQGxmoPrmrbOZJzAKzEKSmoUktYCRaRWjSGppcW56brGhXnFibnFp
        Xrpecn7uJkZgvGw79nPzDsZLG4MPMQpwMCrx8HJsKIgTYk0sK67MPcQowcGsJMK7uDA/Tog3
        JbGyKrUoP76oNCe1+BCjKdAPE5mlRJPzgbGcVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2x
        JDU7NbUgtQimj4mDU6qBsaLc+KFxcfek6tNnwjfpCF//m39IWHDRm1erWvZsnt9102xN36tX
        TzIZy1bfedsjJLw+/s9c3Y6Sgnl2e4wNpeOYtBZPirDZsDrRtbFaXudl0BHxgpar0yeGPM9K
        lPjqwXL4VofIhcbFXRt/Z3QbiXUWL15jvzFcLz/+kd2e7wUnjK9OFONWV2Ipzkg01GIuKk4E
        AIk72rutAgAA
X-CMS-MailID: 20200317144342eucas1p2fd5c2e6ff69f8e10496d0468f01f5601
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200317144342eucas1p2fd5c2e6ff69f8e10496d0468f01f5601
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200317144342eucas1p2fd5c2e6ff69f8e10496d0468f01f5601
References: <20200317144333.2904-1-b.zolnierkie@samsung.com>
        <CGME20200317144342eucas1p2fd5c2e6ff69f8e10496d0468f01f5601@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Use core helper instead of open-coding it.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/sata_promise.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index c451d7d1c817..8729f78cef5f 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -157,7 +157,6 @@ static int pdc_sata_hardreset(struct ata_link *link, unsigned int *class,
 static void pdc_error_handler(struct ata_port *ap);
 static void pdc_post_internal_cmd(struct ata_queued_cmd *qc);
 static int pdc_pata_cable_detect(struct ata_port *ap);
-static int pdc_sata_cable_detect(struct ata_port *ap);
 
 static struct scsi_host_template pdc_ata_sht = {
 	ATA_BASE_SHT(DRV_NAME),
@@ -183,7 +182,7 @@ static const struct ata_port_operations pdc_common_ops = {
 
 static struct ata_port_operations pdc_sata_ops = {
 	.inherits		= &pdc_common_ops,
-	.cable_detect		= pdc_sata_cable_detect,
+	.cable_detect		= ata_cable_sata,
 	.freeze			= pdc_sata_freeze,
 	.thaw			= pdc_sata_thaw,
 	.scr_read		= pdc_sata_scr_read,
@@ -459,11 +458,6 @@ static int pdc_pata_cable_detect(struct ata_port *ap)
 	return ATA_CBL_PATA80;
 }
 
-static int pdc_sata_cable_detect(struct ata_port *ap)
-{
-	return ATA_CBL_SATA;
-}
-
 static int pdc_sata_scr_read(struct ata_link *link,
 			     unsigned int sc_reg, u32 *val)
 {
-- 
2.24.1

