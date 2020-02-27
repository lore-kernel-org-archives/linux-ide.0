Return-Path: <SRS0=ljer=4P=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9411C35E15
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD43C246A9
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Gp3tGCSn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbgB0SYx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:24:53 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39672 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730854AbgB0SWl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Feb 2020 13:22:41 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200227182239euoutp017c84484459853a3813adb54bff825b5b~3VXYcuMG71216412164euoutp01h
        for <linux-ide@vger.kernel.org>; Thu, 27 Feb 2020 18:22:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200227182239euoutp017c84484459853a3813adb54bff825b5b~3VXYcuMG71216412164euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582827759;
        bh=v4csYyuD8B1MOCfQRaKaH7jDwUZRssj28x9Ckhje/Lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gp3tGCSnN0yWZ5gN8LXBBMmz/eF1EwJAvnaL4mdPodzoGsg4Y99Lw7r6k39NQTaZf
         NBzwv2dA+i0t7PcXkWLD+0e82BPcDfizd40UoQB9uz1IUzVhZdiB/HI8SuIizTnmcT
         9a8JZdIgD9TwJTWVZ3QXcs7MO2+4ypeVaNadGYEQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200227182239eucas1p12efef738a4e439dcd40990d9924efab2~3VXYPMwcJ1934219342eucas1p1t;
        Thu, 27 Feb 2020 18:22:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 14.5F.60679.FE8085E5; Thu, 27
        Feb 2020 18:22:39 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200227182239eucas1p1166cd4b92fc84479634d6bcf67a672cf~3VXX2T5Bs1935019350eucas1p1o;
        Thu, 27 Feb 2020 18:22:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200227182239eusmtrp15224c7383911ff1420cbc83735be9b33~3VXX1noXb0110301103eusmtrp1Z;
        Thu, 27 Feb 2020 18:22:39 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-a7-5e5808ef0215
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A0.61.07950.FE8085E5; Thu, 27
        Feb 2020 18:22:39 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182238eusmtip29bcfdead60dc4d5099080709fffe3765~3VXXXOQB33109031090eusmtip2o;
        Thu, 27 Feb 2020 18:22:38 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH v3 01/27] ata: remove stale maintainership information from
 core code
Date:   Thu, 27 Feb 2020 19:22:00 +0100
Message-Id: <20200227182226.19188-2-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227182226.19188-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7djP87rvOSLiDCb8lrVYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09ktfi0/yujA6bFz1l12j8tnSz02repk
        8zh0uIPR42TrNxaP3Tcb2Dz6tqxi9Pi8SS6AI4rLJiU1J7MstUjfLoErY/rVyWwFk4Urut5O
        ZWpgnMffxcjJISFgIvF67lfWLkYuDiGBFYwSXzc0skA4XxglVrw6xAzhfGaUuLHyFDNMS+fS
        OVCJ5YwSs1dPYYdrWXvwMVgVm4CVxMT2VYwgtoiAgkTP75VsIEXMAj1MEpN3XAMq4uAQFgiX
        uP0J7BAWAVWJuf9usoPYvAK2Et9e3WKC2CYvsfXbJ1YQm1PATuJG33Y2iBpBiZMzn7CA2MxA
        Nc1bZ4NdJCGwjV3izr/XrBDNLhKPTm1nhLCFJV4d38IOYctInJ7cwwLRsI5R4m/HC6ju7YwS
        yyf/Y4Oospa4c+4XG8ilzAKaEut36UOEHSWu7LkN9oCEAJ/EjbeCEEfwSUzaNh0qzCvR0SYE
        Ua0msWHZBjaYtV07V0JD0UPi6+KlzBMYFWcheWcWkndmIexdwMi8ilE8tbQ4Nz212CgvtVyv
        ODG3uDQvXS85P3cTIzA9nf53/MsOxl1/kg4xCnAwKvHwLtgRHifEmlhWXJl7iFGCg1lJhHfj
        19A4Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzGi17GCgmkJ5akZqemFqQWwWSZODilGhhXbJXK
        LfMKe/dxjufyz5O9/K3lflh49jNFzeBdsezE1OzvKx5p9TK2fjsmuj2r7yDPXz33+bsnpwn+
        FPpowzz7TPtDzoZ5nDcCfXi+Xbu3wDFg7T3uu45f4xSn7b51Yf7ZHsvzpsxKE64UbK5aP9Pu
        mVxJSX55cfec6NBpOTr3l0ffE/edbMimxFKckWioxVxUnAgANbNB4EsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xe7rvOSLiDC4v57BYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09ktfi0/yujA6bFz1l12j8tnSz02repk
        8zh0uIPR42TrNxaP3Tcb2Dz6tqxi9Pi8SS6AI0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jE
        Us/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY/rVyWwFk4Urut5OZWpgnMffxcjJISFgItG5dA5z
        FyMXh5DAUkaJX1fWsnYxcgAlZCSOry+DqBGW+HOtiw2i5hOjxM59k1hAEmwCVhIT21cxgtgi
        AgoSPb9XghUxC0xiklh9t5EdJCEsECqxtOchM4jNIqAqMfffTbA4r4CtxLdXt5ggNshLbP32
        iRXE5hSwk7jRt50NxBYCqunqeMoIUS8ocXLmE7DFzED1zVtnM09gFJiFJDULSWoBI9MqRpHU
        0uLc9NxiI73ixNzi0rx0veT83E2MwCjaduznlh2MXe+CDzEKcDAq8fB6bAuPE2JNLCuuzD3E
        KMHBrCTCu/FraJwQb0piZVVqUX58UWlOavEhRlOgJyYyS4km5wMjPK8k3tDU0NzC0tDc2NzY
        zEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUAyPnF42m7vaZGjts5TJrV0VY5U7+dt//bvr+
        mRHPo1R2yKTrn86T+J5ZtpfBtF5nT4/tnNcGJ/96tsXcUf0ovnOlTcDMCw4z2w7cDzJTFP50
        /HyyXbp89+pbbjzP2lZMfXZacN7DU3rOT5uWevyy8AqM9vpg1tknbV9Vd6F9slLV1P3z02UK
        tZRYijMSDbWYi4oTAboKsza4AgAA
X-CMS-MailID: 20200227182239eucas1p1166cd4b92fc84479634d6bcf67a672cf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200227182239eucas1p1166cd4b92fc84479634d6bcf67a672cf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200227182239eucas1p1166cd4b92fc84479634d6bcf67a672cf
References: <20200227182226.19188-1-b.zolnierkie@samsung.com>
        <CGME20200227182239eucas1p1166cd4b92fc84479634d6bcf67a672cf@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

In commit 7634ccd2da97 ("libata: maintainership update") from 2018
Jens has officially taken over libata maintainership from Tejun so
remove stale information from core libata code.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 4 ----
 drivers/ata/libata-eh.c   | 4 ----
 drivers/ata/libata-scsi.c | 4 ----
 drivers/ata/libata-sff.c  | 4 ----
 4 files changed, 16 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 42c8728f6117..4991f9d5def8 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2,10 +2,6 @@
 /*
  *  libata-core.c - helper library for ATA
  *
- *  Maintained by:  Tejun Heo <tj@kernel.org>
- *    		    Please ALWAYS copy linux-ide@vger.kernel.org
- *		    on emails.
- *
  *  Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
  *  Copyright 2003-2004 Jeff Garzik
  *
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 3bfd9da58473..53605c8949d8 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2,10 +2,6 @@
 /*
  *  libata-eh.c - libata error handling
  *
- *  Maintained by:  Tejun Heo <tj@kernel.org>
- *    		    Please ALWAYS copy linux-ide@vger.kernel.org
- *		    on emails.
- *
  *  Copyright 2006 Tejun Heo <htejun@gmail.com>
  *
  *  libata documentation is available via 'make {ps|pdf}docs',
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index eb2eb599e602..11eb25b6e2cd 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2,10 +2,6 @@
 /*
  *  libata-scsi.c - helper library for ATA
  *
- *  Maintained by:  Tejun Heo <tj@kernel.org>
- *    		    Please ALWAYS copy linux-ide@vger.kernel.org
- *		    on emails.
- *
  *  Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
  *  Copyright 2003-2004 Jeff Garzik
  *
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 038db94216a9..ae7189d1a568 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2,10 +2,6 @@
 /*
  *  libata-sff.c - helper library for PCI IDE BMDMA
  *
- *  Maintained by:  Tejun Heo <tj@kernel.org>
- *    		    Please ALWAYS copy linux-ide@vger.kernel.org
- *		    on emails.
- *
  *  Copyright 2003-2006 Red Hat, Inc.  All rights reserved.
  *  Copyright 2003-2006 Jeff Garzik
  *
-- 
2.24.1

