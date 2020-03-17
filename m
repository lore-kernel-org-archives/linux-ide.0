Return-Path: <SRS0=AjNr=5C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE374C10F29
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E5C206EC
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UEcdXctH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgCQOoy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:44:54 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40416 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgCQOnt (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Mar 2020 10:43:49 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200317144348euoutp02a401401a950ac7d0b5dd2ff317f0dde6~9HoubB3yB1583015830euoutp02-
        for <linux-ide@vger.kernel.org>; Tue, 17 Mar 2020 14:43:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200317144348euoutp02a401401a950ac7d0b5dd2ff317f0dde6~9HoubB3yB1583015830euoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584456228;
        bh=Zt5dZyRSh0h2WkEyTuKME9bSUAZq7YPuiOv8QeN7Rww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UEcdXctHO16DPt9b/rTuyXR+tzCfZuxtgGoGCjlR6vrlaDMp0tgoMkV7VPWJEncVq
         4R55Zo5uSsYaxgPvg4QJ9QJxFNv12yGM71i7Z9KxMWZsNZlBpRebz7pKHTmL+rl3m7
         9sqTwuriHl/2I9fpFXTqBCgsJOwBs6iPhGSwMBiQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200317144348eucas1p2994982b7ae142e337a8de1157ea699bb~9HouJxOjX2984729847eucas1p22;
        Tue, 17 Mar 2020 14:43:48 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E3.E9.60698.422E07E5; Tue, 17
        Mar 2020 14:43:48 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144348eucas1p14ad861316b19edaf885a52f9beb5dd2a~9Hotr6VuJ1084410844eucas1p1V;
        Tue, 17 Mar 2020 14:43:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200317144348eusmtrp286d31294178a2c49772d9e087e286d29~9HotrVeVN0146401464eusmtrp2P;
        Tue, 17 Mar 2020 14:43:48 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-ed-5e70e224ffd4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3C.23.07950.322E07E5; Tue, 17
        Mar 2020 14:43:48 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144347eusmtip1c29e405f20cf87b0b2eee65e5b1357b4~9HotNaOaA0962809628eusmtip1P;
        Tue, 17 Mar 2020 14:43:47 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v4 14/27] ata: let compiler optimize out
 ata_dev_config_ncq() on non-SATA hosts
Date:   Tue, 17 Mar 2020 15:43:20 +0100
Message-Id: <20200317144333.2904-15-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317144333.2904-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djP87oqjwriDGbNkLFYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBlv7nayFXxkr9h3yLaBcR5bFyMnh4SA
        icSGN+tYuhi5OIQEVjBKHL67mB3C+cIosbjtHyuE85lRYv2mBUBlHGAt/Q8MIeLLGSVmX7jM
        CNdxYvlzJpC5bAJWEhPbVzGC2CICChI9v1eygRQxC7xnlFgxaS8LSEJYIFFi246JYEUsAqoS
        Dy4vZAaxeQVsJaYceQZ1oLzE1m+fWEFsTqD4tcP/2CBqBCVOznwCNocZqKZ562xmkAUSAovY
        JXpPbmeCaHaReHpwPjuELSzx6vgWKFtG4v/O+UwQDesYJf52vIDq3s4osXzyP6jV1hJ3zv1i
        A3maWUBTYv0ufYiwo8SNQ6/YIWHBJ3HjrSDEEXwSk7ZNZ4YI80p0tAlBVKtJbFi2gQ1mbdfO
        lcwQtofE99cfWCcwKs5C8s4sJO/MQti7gJF5FaN4amlxbnpqsXFearlecWJucWleul5yfu4m
        RmAiOv3v+NcdjPv+JB1iFOBgVOLhTdhUECfEmlhWXJl7iFGCg1lJhHdxYX6cEG9KYmVValF+
        fFFpTmrxIUZpDhYlcV7jRS9jhQTSE0tSs1NTC1KLYLJMHJxSDYz8UauU3u9dV/tZcvmLox+M
        vwe/CLjcXVjEvOl1l1robUvNh48CJi9terSh8OIcPoFfZzbd5jhyb17IoWd34/82XZ0/76//
        1fy6I2tzcuo/OU9NrjKueqNvN3tqs0lnn8cR4QN67ut3J/8oXcJ0bu+lYyfYxBh92OLcVl5r
        6pu7iSF8nskRYZ/9SizFGYmGWsxFxYkArAwXikADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xu7oqjwriDBb1MFmsvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYw3dzvZCj6yV+w7ZNvAOI+ti5GDQ0LARKL/gWEXIxeHkMBSRontj25C
        xWUkjq8v62LkBDKFJf5c62KDqPnEKNF4eBorSIJNwEpiYvsqRhBbREBBouf3SrAiZoGvjBJL
        J3UzgySEBeIlLrf/ZwGxWQRUJR5cXggW5xWwlZhy5BkbxAZ5ia3fPoEN5QSKXzv8DywuJGAj
        8eLNfyaIekGJkzOfgM1hBqpv3jqbeQKjwCwkqVlIUgsYmVYxiqSWFuem5xYb6RUn5haX5qXr
        JefnbmIERsu2Yz+37GDsehd8iFGAg1GJh5djQ0GcEGtiWXFl7iFGCQ5mJRHexYX5cUK8KYmV
        ValF+fFFpTmpxYcYTYGemMgsJZqcD4zkvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZ
        qakFqUUwfUwcnFINjFq5k3TWM904tsxcpqTiSaUAu5nPz71T/swoYIoNPbuG2Z0n2X39vp/W
        E60mbTCKS1E1l9bsPFcWsXVeTyJzYdSRZ+9nBT1oi1ygnVK+eM5z13vOXffcMxVFEkz+uc2f
        sF8o+NTVwi/pjXO/BpW+/2kcefzE8mXHjySF9pQ+kpINuF668KB9vxJLcUaioRZzUXEiAHii
        HfGsAgAA
X-CMS-MailID: 20200317144348eucas1p14ad861316b19edaf885a52f9beb5dd2a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200317144348eucas1p14ad861316b19edaf885a52f9beb5dd2a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200317144348eucas1p14ad861316b19edaf885a52f9beb5dd2a
References: <20200317144333.2904-1-b.zolnierkie@samsung.com>
        <CGME20200317144348eucas1p14ad861316b19edaf885a52f9beb5dd2a@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add !IS_ENABLED(CONFIG_SATA_HOST) to ata_dev_config_ncq() to allow
compiler to optimize out the function for non-SATA configs.

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  37582     572      40   38194    9532 drivers/ata/libata-core.o
after:
  36462     572      40   37074    90d2 drivers/ata/libata-core.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f88fa4db2cab..fa1fd0735321 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2301,6 +2301,8 @@ static int ata_dev_config_ncq(struct ata_device *dev,
 		desc[0] = '\0';
 		return 0;
 	}
+	if (!IS_ENABLED(CONFIG_SATA_HOST))
+		return 0;
 	if (dev->horkage & ATA_HORKAGE_NONCQ) {
 		snprintf(desc, desc_sz, "NCQ (not used)");
 		return 0;
-- 
2.24.1

