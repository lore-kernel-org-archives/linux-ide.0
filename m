Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1718CC3F68F
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AFB218AC
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bbiZ5MXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgBGO3j (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:29:39 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49568 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbgBGO1z (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:27:55 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142753euoutp021b5404179f27f4ddcccad9b4946017a5~xJQsV0Spq2564025640euoutp02O
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:27:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200207142753euoutp021b5404179f27f4ddcccad9b4946017a5~xJQsV0Spq2564025640euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085673;
        bh=SD29ru+XPRj8/MpkvAn2nNtxS7lNQ61UJF7W2WDfjqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bbiZ5MXIeC1IGbP6BXOFK/JLIMhZlfYRFmon6IG1oGwxi9rjnTsJHPjHSxdDiYRXo
         wwv0mmngV/tUCOW2Q51Vow4EhG1WmOpzDN3+4hZsDLEyKbw90zP0Brmptf95aMFAdT
         q0mPonu/zAglx8Q4pmVpq3tPEQR5eViAw4IuU4O8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200207142753eucas1p16169fa8501bbf900b1686249896d06f8~xJQsGjvQ82611726117eucas1p1c;
        Fri,  7 Feb 2020 14:27:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 1C.4D.60679.9E37D3E5; Fri,  7
        Feb 2020 14:27:53 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142753eucas1p2c4310ddbb52c5eed02974fc2738c8a58~xJQr2BW5r3244032440eucas1p2n;
        Fri,  7 Feb 2020 14:27:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200207142753eusmtrp2c75c5ab87a59973de678410264a81ccc~xJQr1N4dE1102911029eusmtrp23;
        Fri,  7 Feb 2020 14:27:53 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-6d-5e3d73e985a3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EC.C5.07950.9E37D3E5; Fri,  7
        Feb 2020 14:27:53 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142752eusmtip2e7f47254e012842ebc9aed27e4acdc6d~xJQrWpAPO2944029440eusmtip2Y;
        Fri,  7 Feb 2020 14:27:52 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v2 04/26] sata_promise: use ata_cable_sata()
Date:   Fri,  7 Feb 2020 15:27:12 +0100
Message-Id: <20200207142734.8431-5-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207142734.8431-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djPc7ovi23jDDY8krRYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBlNn3YwF2zkrpjx5zB7A+Nhzi5GTg4J
        AROJU/tvMHYxcnEICaxglNiweisbhPOFUeLZkQVQzmdGicUvr7PDtBxeu4sFIrGcUeLen9PM
        cC2Pl3UxgVSxCVhJTGxfxQhiiwgoSPT8Xgk2ilngPaPEikl7WUASwgI2EvOmtoGNZRFQlZj6
        YzVYAy9QfP+1kywQ6+Qltn77xApicwrYSnyc8pcNokZQ4uTMJ2A1zEA1zVtng10hIbCKXWLn
        x8XMEM0uErf7P0HdLSzx6vgWKFtG4v/O+UwQDesYJf52vIDq3s4osXzyPzaIKmuJO+d+Adkc
        QCs0Jdbv0ocIO0rsugJyEQeQzSdx460gxBF8EpO2TWeGCPNKdLQJQVSrSWxYtoENZm3XzpVQ
        p3lI/F11gm0Co+IsJO/MQvLOLIS9CxiZVzGKp5YW56anFhvlpZbrFSfmFpfmpesl5+duYgQm
        o9P/jn/ZwbjrT9IhRgEORiUe3gRHmzgh1sSy4srcQ4wSHMxKIrx9qrZxQrwpiZVVqUX58UWl
        OanFhxilOViUxHmNF72MFRJITyxJzU5NLUgtgskycXBKNTB27f3JvX7agiYBm3m5J07X3SnY
        przowEVRu4AOJj5F5d1Fz1apNRzoWfFPcucCQek86xnm7P3/rymcerbP+8wqkdbmZsNJM878
        3Lmu5r1Y38yQziMnXv1ndLCNk5rc+fDGJqX3EfcUb127ddDn/iHmpXXXzrEt2P4wOFjZ20er
        sF/587TtpWKHlFiKMxINtZiLihMBGp3MpUIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xe7ovi23jDI52sVusvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYymTzuYCzZyV8z4c5i9gfEwZxcjJ4eEgInE4bW7WLoYuTiEBJYySqze
        tIe5i5EDKCEjcXx9GUSNsMSfa11sEDWfGCW6+ycygSTYBKwkJravYgSxRQQUJHp+rwQrYhb4
        yiixdFI3M0hCWMBGYt7UNnYQm0VAVWLqj9VgDbxA8f3XTrJAbJCX2PrtEyuIzSlgK/Fxyl82
        EFsIqOb7+0nsEPWCEidnPgGrZwaqb946m3kCo8AsJKlZSFILGJlWMYqklhbnpucWG+kVJ+YW
        l+al6yXn525iBEbMtmM/t+xg7HoXfIhRgINRiYc3wdEmTog1say4MvcQowQHs5IIb5+qbZwQ
        b0piZVVqUX58UWlOavEhRlOgJyYyS4km5wOjOa8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6
        YklqdmpqQWoRTB8TB6dUA+P67Ow7G3lCWTVPKmw5/Dk1e3vpkx2Bu9+Vy/YfiOaf3CgQHHZ4
        j/NHe17PE9HPu5rUvlzgjXpzWosrKsE64HXdvVncR99uqd30VkxA09Zh16+NH+QeWdemNMbU
        rqqq4jzHfnv77q8rGF4+PBy8qcJqm+yfU3k+Mlue8rm+DDlZtFq5e3+Ul48SS3FGoqEWc1Fx
        IgAwu+xZrgIAAA==
X-CMS-MailID: 20200207142753eucas1p2c4310ddbb52c5eed02974fc2738c8a58
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200207142753eucas1p2c4310ddbb52c5eed02974fc2738c8a58
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200207142753eucas1p2c4310ddbb52c5eed02974fc2738c8a58
References: <20200207142734.8431-1-b.zolnierkie@samsung.com>
        <CGME20200207142753eucas1p2c4310ddbb52c5eed02974fc2738c8a58@eucas1p2.samsung.com>
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

