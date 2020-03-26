Return-Path: <SRS0=jBxd=5L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF74AC2D0EC
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 15:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8405420787
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 15:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="otEvvWHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgCZP6k (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:58:40 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52606 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbgCZP6k (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2020 11:58:40 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200326155839euoutp0230694e357e06658e27228f1f75cae7e3~-5do_ZV8U0032300323euoutp02c
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2020 15:58:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200326155839euoutp0230694e357e06658e27228f1f75cae7e3~-5do_ZV8U0032300323euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585238319;
        bh=z3zEha6y7ylhzS/ya0/3rXTA3ZnK5+xg+F2LYnSmLTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=otEvvWHrvuWcgnOEn342Mso5ELd6+QKkr4vhQ0wFtLCjiW3iUpMun5q2lyh699BGO
         FpCeGSqXLuUFzfFszaebr7uP5sUJOYyAoe2DGUrqR6EIlOcBaBs1E14ulkAbkN7qbl
         SE/T7TGgU5SscfDQVzWr+8z4A6ZrnN3a6RWWmr/s=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200326155839eucas1p1288b777e6cc50f119cc8a63bdc8d053f~-5dovLCD-0942809428eucas1p1d;
        Thu, 26 Mar 2020 15:58:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B9.F5.61286.F21DC7E5; Thu, 26
        Mar 2020 15:58:39 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155838eucas1p1931e5db55f9efd231696c210c0690733~-5doYf9mL2821828218eucas1p1p;
        Thu, 26 Mar 2020 15:58:38 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200326155838eusmtrp151e644913a92cd7af76e4f6823dc1874~-5doX5KNa2090020900eusmtrp1Q;
        Thu, 26 Mar 2020 15:58:38 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-b4-5e7cd12f2951
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 66.5A.08375.E21DC7E5; Thu, 26
        Mar 2020 15:58:38 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155838eusmtip1fcc73d64e70894c86bdef808dd99a8f0~-5dn6dSYc1233412334eusmtip1t;
        Thu, 26 Mar 2020 15:58:38 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH v5 01/27] ata: remove stale maintainership information from
 core code
Date:   Thu, 26 Mar 2020 16:57:56 +0100
Message-Id: <20200326155822.19400-2-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200326155822.19400-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjmO+fs7DhaHqfhl9rFUaFBLqkfByuzlDhGkVCRSlkrDyq6aTtq
        GRbC1GxYacNLU8sbrW2mS51OTaOFmoiGSqKiP2bmDYPQ0rKU3I6W/573fZ/L98BHoCITz42I
        kScyCrk0TowLsIaOX70HJH2pEQfbljDKMPYYp14X1vCoyZFWhNIZ2hGqwzyOUAPNxTilnXiF
        UiUZBXxqWdsOAhzoJs0Ynx7oSaJr9Q9w2vI+C9BdGYsY3TKchtOP6vWAXqjdGUKEC45GMnEx
        yYxC4n9NEF2nTkhQO9/OtX7ipYFnjipAEJA8DB8uB6mAgBCRLwGsyOzBueE7gHX5Iwg3LAA4
        qmzlq4CDXZFZaEBtWERqARw3BfxT5Cm1uO2Ak34w974e2LALuRtm/9bZbVEyG4Fq86Bd7Uxe
        gu+aNHaMkXuhtcuA2LCQPAYHFuZ4XNouaFqct2MH0h9qq5+jHMcJdj2dwGwYXeMoTUWoLQCS
        DXzYa5ric+WCoG7wPOfjDGc769cbeMBudTbG8asBXMmaXhc3AqhVr+Ic6wgc7V3GbUYo6Q1r
        miXc+gT8WaPFOf+tcOirE/eGrfBJQwHKrYUwK1PEsfdB4wsjvhGratKhHKbhaKUFyQGemk1t
        NJvaaP7nlgJUD1yZJFYWxbC+cuaWDyuVsUnyKJ8b8bJasPaZulc7583gR/91CyAJIN4i9EpP
        jRDxpMlsiswCIIGKXYRfwtZWwkhpyh1GEX9VkRTHsBbgTmBiV+Gh8pkrIjJKmsjEMkwCo9i4
        IoSDWxpotnZ/czQK+ZbJvrPpbyzugeUhd0s/K2ZS/d5+XPqgxOar9oQCz1MVsqkF77AykDNk
        HP3j1RbcKaoMVxeH8s4EzhXlbzMFXlw03zwe65F/rm/ocolquwKZG5xuvFBmvCexIrOBkolg
        /UldzY6QloKmsOHTVbwVwWJef/RUibFbjLHRUt/9qIKV/gV6aGx/SAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xu7p6F2viDA7dULNYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09ktfi0/yujA6bFz1l12j8tnSz02repk
        8zh0uIPR42TrNxaP3Tcb2Dz6tqxi9Pi8SS6AI0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jE
        Us/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY/PkgoLJwhUTH15lbWCcx9/FyMkhIWAi0TZjNXMX
        IxeHkMBSRom5nXuYuhg5gBIyEsfXl0HUCEv8udbFBlHziVGi/eQ2RpAEm4CVxMT2VWC2iICC
        RM/vlWBFzAKTmCRW321kB0kIC4RKvDp/lBXEZhFQlXh4cjUTiM0rYCtx+fMbVogN8hJbv30C
        szkF7CSWr5vPDGILAdUs/vIBql5Q4uTMJywgNjNQffPW2cwTGAVmIUnNQpJawMi0ilEktbQ4
        Nz232FCvODG3uDQvXS85P3cTIzCGth37uXkH46WNwYcYBTgYlXh4NVpq4oRYE8uKK3MPMUpw
        MCuJ8D6NBArxpiRWVqUW5ccXleakFh9iNAV6YiKzlGhyPjC+80riDU0NzS0sDc2NzY3NLJTE
        eTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MBpfCtBztDk0m/v93R/eIhtc1M8dTP743D40m+VU
        0Z77Nsa6OwqOX7LVXv949ry6jLy18jdl6rw87yo+f201N/341Yde+z8Y617bZLXeuoC9QqVm
        fclUh6zcQx6O5q3yd+z5Pl4PlCteKL71c9ypdr9nH6+uWON4UFYjaMObSUqVB87tftiQqa7E
        UpyRaKjFXFScCABeibMMtwIAAA==
X-CMS-MailID: 20200326155838eucas1p1931e5db55f9efd231696c210c0690733
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200326155838eucas1p1931e5db55f9efd231696c210c0690733
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200326155838eucas1p1931e5db55f9efd231696c210c0690733
References: <20200326155822.19400-1-b.zolnierkie@samsung.com>
        <CGME20200326155838eucas1p1931e5db55f9efd231696c210c0690733@eucas1p1.samsung.com>
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
index 75bd7792df02..ebc3de7c363a 100644
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

