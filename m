Return-Path: <SRS0=dw68=3R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122A0C2D0DB
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDC224688
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lJfh/2Tn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgA1Nfs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:35:48 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52328 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgA1NeO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jan 2020 08:34:14 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200128133412euoutp026fe36d36c671c4971328d533d5d3b933~uEE9_A0gf2858228582euoutp026
        for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2020 13:34:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200128133412euoutp026fe36d36c671c4971328d533d5d3b933~uEE9_A0gf2858228582euoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580218452;
        bh=H4QrtVL61FUm03xLuWQqA31QHy5dP4mqpTAK4yNgYiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lJfh/2TnO9ri6N6FXG5TF7Yg2nreU0sG+O3B+r/ezH+isuhPVQH/5/1B+hLfAX/JB
         hPeBaNCy4Z6UFN0m1JrDSOXyM2E6xDWRV9VBMfJfn1NvGX7yj9gNRM12dWVZwcKo+D
         0ZgGKXNTkWUzMCFA9OyLVfYJt6KqqpiTpeqk15KA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200128133412eucas1p2591cc02d579aab2c4e4bbb8f95ed73e3~uEE9liTEM2264122641eucas1p2-;
        Tue, 28 Jan 2020 13:34:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A5.DA.60698.458303E5; Tue, 28
        Jan 2020 13:34:12 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133412eucas1p2c79626824fcadc63c133548cd2e7d8cf~uEE9Ow2xZ0474204742eucas1p2O;
        Tue, 28 Jan 2020 13:34:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200128133412eusmtrp28a80fb3382759d075c0ed3a6243050ed~uEE9OLG3V0330003300eusmtrp2r;
        Tue, 28 Jan 2020 13:34:12 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-b0-5e303854941c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8E.72.07950.358303E5; Tue, 28
        Jan 2020 13:34:11 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133411eusmtip2d0054da31de363afae1c6eada367454b~uEE8zeF0J3275932759eusmtip2k;
        Tue, 28 Jan 2020 13:34:11 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, Mikael Pettersson <mikpelinux@gmail.com>
Subject: [PATCH 04/28] sata_promise: use ata_cable_sata()
Date:   Tue, 28 Jan 2020 14:33:19 +0100
Message-Id: <20200128133343.29905-5-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128133343.29905-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju29nOzqwjn1PwxaJyZGCYLjRcN7HSGNSPiIKMtJYeLzQvbM6c
        /ZG0snnPcDoTxR95A53mZRMnNEMLNSOlpiilRakl0XTi3dyOlv+e97nwvC+8FCEs53lQcQnJ
        jCJBJheRTty2nqXBo1cl4ghx/xpI6sfzSUlTSSNP8n3UxJH0GCY5kqGO56Qkt7qNkJQ/1PKD
        +VKjbpwvHRpQSc3dWUia11KHpHPN+y/zbjidjmLkcSmMwi/otlPsq0oNJ+nz7lTLSHQ6+iXQ
        IAEFOAD08zakQU6UENcgmMj+yGeHeQSjpjWCHeYQ5Bt/ou1Iee4fBxbiagTmzKB/iYHOMcIu
        kPgkFD6uc5jc8EHIWakl7SYCWxB0mwtIu+CKT8DQSLcDc7EXTL62dwsoGp+BB7aZrbYD0Lpg
        5WkQRQlwEOSYAlmLC7wt/ca1Y2LTktFa5tgUcD4fbHM6ks2GwGJeO5fFrjDT28Jn8T7YMFZw
        2EADgrWsqa10O4LqovWt9CkYe7dM2psJ7A2NHX4sfRaG5+sdNGBnsMy6sEs4w9M2LcHSNGQ9
        ErLuw6B/oSe3azXGWoLFUrDaCskC5KnbcY5uxzm6/72ViKhD7oxKGR/DKP0TmHu+Slm8UpUQ
        4xuZGN+MNp+mb73XZkBdq3fMCFNItIcOFokjhDxZilIdb0ZAESI3+glnk6KjZOo0RpF4S6GS
        M0oz2ktxRe60f9V0uBDHyJKZuwyTxCi2VQ4l8EhHXd4+0z44cPCrunTYedTL9/4nwxe5x4ew
        VL/fxyOjbQ1W6eIFsQ95pZjObKq8vrCrhn5vzC+6WWaZ7qcO+QcYMypwpcePpbDZEkOwVXzu
        0stwfalfWuZUqDp0Iz2k1LSatCi/VkV6nleY2rXPJlo7Rdq+5ZleeHMx21K8IqZFXGWs7NgR
        QqGU/QXEa81uMAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42I5/e/4Pd1gC4M4g3X9Vhar7/azWWycsZ7V
        4tmtvUwWx3Y8YrK4vGsOm0Xv8m3MFnNbp7M7sHvsnHWX3ePy2VKPQ4c7GD36tqxi9Pi8SS6A
        NUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv4+CC
        LqaC+9wVN26mNTC+4exi5OSQEDCRmNv7kbGLkYtDSGApo8SlG+uYuxg5gBIyEsfXl0HUCEv8
        udbFBmILCXxilNhyQAzEZhOwkpjYvooRxBYRUJDo+b2SDWQOs8AdRomWJROYQRLCApYSl28e
        BmtmEVCVeHTkGjuIzStgK9H09RUjxAJ5ia3fPrGC7OUUsJPo2WsOsctWYv2Zp6wQ5YISJ2c+
        YQGxmYHKm7fOZp7AKDALSWoWktQCRqZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgdGw7djP
        LTsYu94FH2IU4GBU4uF1UDKIE2JNLCuuzD3EKMHBrCTC28kEFOJNSaysSi3Kjy8qzUktPsRo
        CvTDRGYp0eR8YKTmlcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpg
        bGbfpnT1SWb5oVuJ/XcdLvfm/d6pKdaVvPdCf7ZTu6tlnEjcj55piiKLdk/l+nprayLLy/m7
        zLWuiJtmVgdEfT1af/vy2pawpO23k9LqC1YV3WpOU2LX/r018ntz6OxQaeW6cyUWOW9q/sZI
        cs333rNhycHHyk4MUtwnkxwv+9jLPeY+ZrxOiaU4I9FQi7moOBEAKsLVBZwCAAA=
X-CMS-MailID: 20200128133412eucas1p2c79626824fcadc63c133548cd2e7d8cf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133412eucas1p2c79626824fcadc63c133548cd2e7d8cf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133412eucas1p2c79626824fcadc63c133548cd2e7d8cf
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133412eucas1p2c79626824fcadc63c133548cd2e7d8cf@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Use core helper instead of open-coding it.

Cc: Mikael Pettersson <mikpelinux@gmail.com>
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

