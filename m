Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C0CC35242
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB58821775
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WlTNmbt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgBGO3w (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:29:52 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49540 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbgBGO1y (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:27:54 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142752euoutp0281f01738357574e16465b3740c620829~xJQrBclL12598725987euoutp029
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:27:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200207142752euoutp0281f01738357574e16465b3740c620829~xJQrBclL12598725987euoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085672;
        bh=BsYjVRXttgUazvg1RR2gwWVRvBVWOQgw/we4kL4qGGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WlTNmbt7+fzlAWkIxd57eVifpGuuHYFPW63xNhP1mJ7fLIPsgCiGvf2qiVCvvp7H1
         C+PmvDE8/U7PjOhdzwROdmSwop9EUmj2r+ABv3VNH6KfBZjFxeyzLxsN0teE9Ycd7a
         u/qEpI1fMS11/+z9et8xJe5ncumEEO0HY25imdMk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200207142751eucas1p2c4de0ce729a72843ae1df78e62b9c528~xJQqrmKok0410804108eucas1p2v;
        Fri,  7 Feb 2020 14:27:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6D.C8.60698.7E37D3E5; Fri,  7
        Feb 2020 14:27:51 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200207142751eucas1p19960870c4d79815b9e81747399ef77a2~xJQqYWpfH2611726117eucas1p1Z;
        Fri,  7 Feb 2020 14:27:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200207142751eusmtrp13cb4297069fda7e68704b7fd7600e121~xJQqXsMd10480004800eusmtrp15;
        Fri,  7 Feb 2020 14:27:51 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-b2-5e3d73e72af0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 66.89.08375.7E37D3E5; Fri,  7
        Feb 2020 14:27:51 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142751eusmtip2dfd07ce3ce68e5be6e689a48947f9e99~xJQp4kUNf2997829978eusmtip2F;
        Fri,  7 Feb 2020 14:27:51 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 01/26] ata: remove stale maintainership information from
 core code
Date:   Fri,  7 Feb 2020 15:27:09 +0100
Message-Id: <20200207142734.8431-2-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207142734.8431-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djP87rPi23jDO4dN7VYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09ktfi0/yujA6bFz1l12j8tnSz02repk
        8zh0uIPR42TrNxaP3Tcb2Dz6tqxi9Pi8SS6AI4rLJiU1J7MstUjfLoEro3XpaZaCycIVC2bq
        NzDO4+9i5OSQEDCReLvnOksXIxeHkMAKRomZKz6xgySEBL4wSnSsZINIfGaU+DF7K2sXIwdY
        x7U5ZhDx5YwSvfcXQhUBNaw+s4MNpJtNwEpiYvsqRhBbREBBouc3xCRmgR4mick7rjGDJIQF
        wiVebt7HAmKzCKhKfHm/lxXE5hWwkdg6o5kd4j55ia3fPoHFOQVsJT5O+csGUSMocXLmE7Be
        ZqCa5q2zmUEWSAhsYpf4MLGVBaLZRaLz/GFmCFtY4tXxLVBDZSROT+5hgWhYxyjxt+MFVPd2
        Ronlk/+xQVRZS9w594sN5GlmAU2J9bv0If53lFj50RnC5JO48VYQ4gY+iUnbpjNDhHklOtqE
        IGaoSWxYtoENZmvXzpVQ13hIPFt1hX0Co+IsJN/MQvLNLIS1CxiZVzGKp5YW56anFhvnpZbr
        FSfmFpfmpesl5+duYgQmptP/jn/dwbjvT9IhRgEORiUe3gRHmzgh1sSy4srcQ4wSHMxKIrx9
        qrZxQrwpiZVVqUX58UWlOanFhxilOViUxHmNF72MFRJITyxJzU5NLUgtgskycXBKNTCmhbi/
        0NMve2lxW0PjxynGwJ8rlT0mMrP/s5r4+vB7lS9Z88NV/S/U8XL6XFhjO1G39laR3pf2PxLu
        LRuf2u7nKpIPPW0t0HS0a7ob+9mOBk+Nikm+T27XNn9a4LB2ykynNd+eznmkqV4QXPj95KHE
        oBiWmktcSa9Xe6ptzvx19ESil6O1wGolluKMREMt5qLiRAA9y/4aSAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xe7rPi23jDK51K1usvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewWv5YfZXTg9Ng56y67x+WzpR6bVnWy
        eRw63MHocbL1G4vH7psNbB59W1YxenzeJBfAEaVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2Ri
        qWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX0br0NEvBZOGKBTP1Gxjn8XcxcnBICJhIXJtj1sXI
        xSEksJRRYtqfT2wQcRmJ4+vLuhg5gUxhiT/Xutggaj4xSpw6tpYVJMEmYCUxsX0VI4gtIqAg
        0fN7JVgRs8AkJonVdxvZQRLCAqES3+afYQOxWQRUJb683wvWzCtgI7F1RjM7xAZ5ia3fPoHF
        OQVsJT5O+QtWLwRU8/39JHaIekGJkzOfsIDYzED1zVtnM09gFJiFJDULSWoBI9MqRpHU0uLc
        9NxiQ73ixNzi0rx0veT83E2MwAjaduzn5h2MlzYGH2IU4GBU4uFNcLSJE2JNLCuuzD3EKMHB
        rCTC26dqGyfEm5JYWZValB9fVJqTWnyI0RToiYnMUqLJ+cDoziuJNzQ1NLewNDQ3Njc2s1AS
        5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwGgQsH6Nnr1bgmX74/Nbv/6zrdEzsWwwjd0ulXRR
        Ttll3z6J75FW/ds9Hk0I5t0zVzC1NqjWK/NItuYdnk8eG6wWzzC9enUJ++mKLxqf48rD4j2X
        zbjKaXZI5V7M5FuW9/rjUt1KOrZHumnyvjxt8l4yRnQKo6l+wp/odeWTJJTzg7MZWA8FKbEU
        ZyQaajEXFScCAGvT1tm2AgAA
X-CMS-MailID: 20200207142751eucas1p19960870c4d79815b9e81747399ef77a2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200207142751eucas1p19960870c4d79815b9e81747399ef77a2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200207142751eucas1p19960870c4d79815b9e81747399ef77a2
References: <20200207142734.8431-1-b.zolnierkie@samsung.com>
        <CGME20200207142751eucas1p19960870c4d79815b9e81747399ef77a2@eucas1p1.samsung.com>
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
index 6f4ab5c5b52d..fa36e3248039 100644
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

