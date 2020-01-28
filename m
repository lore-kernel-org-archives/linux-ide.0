Return-Path: <SRS0=dw68=3R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAE0C33CB2
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C542E24686
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GSayUzQB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgA1NeN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:34:13 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58859 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgA1NeN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jan 2020 08:34:13 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200128133411euoutp01b646dd3cfadfff49e682305079e553ab~uEE87Suvc0325703257euoutp01D
        for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2020 13:34:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200128133411euoutp01b646dd3cfadfff49e682305079e553ab~uEE87Suvc0325703257euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580218451;
        bh=ePuNIRXCdAVaLAW228VBbPf1mEA8XYlrGDlSfA/cZkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GSayUzQBP1C0zxnlJ3SX3NwzV5f3ISnlg45oEADUawBXPjNWP1+E5iXkxy9zZaYFw
         hqh/4Zh4eokuNV8DKkQMzfIcJT7MLtLTa8lRahosFi0fEamJ6lMPFLdh5mE1ol+qe7
         Gul4/xjwf4sl9EYhPXevA++wndDqQWMWtDrAXtmM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200128133411eucas1p1bb9a82bb6cdf0ebd0c91513fbfd7059a~uEE8YR5GE1375113751eucas1p1C;
        Tue, 28 Jan 2020 13:34:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9A.CA.61286.358303E5; Tue, 28
        Jan 2020 13:34:11 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133410eucas1p271284329b9b63c2c48167308809c569c~uEE8IRj-b3228632286eucas1p2h;
        Tue, 28 Jan 2020 13:34:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200128133410eusmtrp228251aa3a90197833460bd842d5bc520~uEE8HruUL0330103301eusmtrp2k;
        Tue, 28 Jan 2020 13:34:10 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-71-5e3038536605
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BE.82.08375.258303E5; Tue, 28
        Jan 2020 13:34:10 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133410eusmtip204ae489d1d3ea0abb6e0edba27d637f4~uEE7yFf410685506855eusmtip2S;
        Tue, 28 Jan 2020 13:34:10 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/28] ata: remove stale maintainership information from
 core code
Date:   Tue, 28 Jan 2020 14:33:16 +0100
Message-Id: <20200128133343.29905-2-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128133343.29905-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djP87rBFgZxBo8WsVmsvtvPZrFxxnpW
        i2e39jJZHNvxiMni8q45bBZzW6ezW/xafpTRgd1j56y77B6Xz5Z6bFrVyeZx6HAHo0ffllWM
        Hp83yQWwRXHZpKTmZJalFunbJXBlPDi0lLXgsmTFop+TWRoYr4t0MXJwSAiYSMyfFdvFyMkh
        JLCCUeLla9suRi4g+wujxNUF25ggnM+MEs9vdLOBVIE0rHh5nxUisZxR4syuM2xwLWdX/mIE
        qWITsJKY2L4KzBYRUJDo+b0SrIhZ4CSjxNzWd6wgCWGBEImP33rAbBYBVYk9X3+yg9i8ArYS
        k5b+YIFYJy+x9dsnVpBbOQXsJHr2mkOUCEqcnPkErIQZqKR562xmkPkSAtPZJa51bmaG6HWR
        aJ72nB3CFpZ4dXwLlC0j8X/nfCaIhnWMEn87XkB1b2eUWD75H9Sj1hJ3zv1iA9nMLKApsX6X
        PkTYUeL/47tMkMDjk7jxVhDiCD6JSdumM0OEeSU62oQgqtUkNizbwAaztmvnSqjTPCQaf3xh
        n8CoOAvJO7OQvDMLYe8CRuZVjOKppcW56anFhnmp5XrFibnFpXnpesn5uZsYgSnn9L/jn3Yw
        fr2UdIhRgINRiYd3hopBnBBrYllxZe4hRgkOZiUR3k4moBBvSmJlVWpRfnxRaU5q8SFGaQ4W
        JXFe40UvY4UE0hNLUrNTUwtSi2CyTBycUg2MDGJ/05sucXjby0utfmb7eO0uYRatBslVpiyz
        pni4beXbech41fX8WXUR7+QTVi99UXNn0y1BcXexGoG9h9arxWz2+x62en8Vd/7x1QffntW7
        FSo6beFmvl3H7j3lTrru/WV39/k3HHlBlvVLb9ay3zy4sXL1xWOZczJ+evFe9i0oCf91Y+7c
        S0osxRmJhlrMRcWJALEK0IY1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsVy+t/xe7pBFgZxBi2/jS1W3+1ns9g4Yz2r
        xbNbe5ksju14xGRxedccNou5rdPZLX4tP8rowO6xc9Zddo/LZ0s9Nq3qZPM4dLiD0aNvyypG
        j8+b5ALYovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/Tt
        EvQyHhxaylpwWbJi0c/JLA2M10W6GDk5JARMJFa8vM/axcjFISSwlFHi7Jf9jF2MHEAJGYnj
        68sgaoQl/lzrYoOo+cQosW7LclaQBJuAlcTE9lWMILaIgIJEz++VYEXMAmcZJeZuawJLCAsE
        SXQ92ccOYrMIqErs+foTzOYVsJWYtPQHC8QGeYmt3z6xgizmFLCT6NlrDhIWAipZf+YpK0S5
        oMTJmU/AypmBypu3zmaewCgwC0lqFpLUAkamVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIGx
        se3Yz807GC9tDD7EKMDBqMTDO0PFIE6INbGsuDL3EKMEB7OSCG8nE1CINyWxsiq1KD++qDQn
        tfgQoynQDxOZpUST84Fxm1cSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+J
        g1OqgTH3mIP47Q6Dgv6KMqW/pq06Dyv8D0d0PTFPVbV32ZLY4HJ6XWR94ufmeR1qDoXKrlVv
        GpT3RJeeuxzG8yP1bW/Z+w8Fd3ftj2y9MXELK4fyNeYP6+/NeX2p27yKX+LntEaba7vqFTYl
        /jWuUbqucL3v+qU9q/+oaZ4xvlizd+LEuN2L/6fkhyixFGckGmoxFxUnAgCdf35QowIAAA==
X-CMS-MailID: 20200128133410eucas1p271284329b9b63c2c48167308809c569c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133410eucas1p271284329b9b63c2c48167308809c569c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133410eucas1p271284329b9b63c2c48167308809c569c
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133410eucas1p271284329b9b63c2c48167308809c569c@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

In commit 7634ccd2da97 ("libata: maintainership update") from 2018
Jens has officially taken over libata maintainership from Tejun so
remove stale information from core libata code.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
I've not touched host drivers which also list Tejun as Maintainer:

drivers/ata/acard-ahci.c: *  Maintained by:  Tejun Heo <tj@kernel.org>
drivers/ata/ahci.c: *  Maintained by:  Tejun Heo <tj@kernel.org>
drivers/ata/ahci.h: *  Maintained by:  Tejun Heo <tj@kernel.org>
drivers/ata/ata_piix.c: *    Maintained by:  Tejun Heo <tj@kernel.org>
drivers/ata/libahci.c: *  Maintained by:  Tejun Heo <tj@kernel.org>
drivers/ata/pdc_adma.c: *  Maintained by:  Tejun Heo <tj@kernel.org>
drivers/ata/sata_promise.c: *  Maintained by:  Tejun Heo <tj@kernel.org>
drivers/ata/sata_sil.c: *  Maintained by:  Tejun Heo <tj@kernel.org>
drivers/ata/sata_sx4.c: *  Maintained by:  Tejun Heo <tj@kernel.org>
drivers/ata/sata_via.c: *  Maintained by:  Tejun Heo <tj@kernel.org>

Tejun, please let me know if you want me to update any of them.

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

