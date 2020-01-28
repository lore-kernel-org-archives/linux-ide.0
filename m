Return-Path: <SRS0=dw68=3R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4213CC3F68F
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1960D24686
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ft/2pzy0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgA1NfW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:35:22 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58900 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgA1NeR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jan 2020 08:34:17 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200128133415euoutp01f9811f8d7839225aef6204bb9e42de8b~uEFAvYgd20284402844euoutp01Z
        for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2020 13:34:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200128133415euoutp01f9811f8d7839225aef6204bb9e42de8b~uEFAvYgd20284402844euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580218455;
        bh=Ark+fkMgLf1ZNUCc5wzMzdsqKRNjN891oQ1Cqnnqj+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ft/2pzy0E7qOKRZOjsk3Me2pJ2sFjHHzuDiwI5RmuiGaHzr/YjOOk9z9Xzk5xRCDx
         7bjjfYYL345fCfbjt5ezb8rk5oWezkygkQbfPOxrQxXOiiqv6uFgvuImPwe2D7H4dY
         IJ/A0zD3wIgZf6r2xC5UC+wDWAmaoERc8hGJCq2E=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200128133415eucas1p21456bb04fd2cbfdd63f1d9ade02c6b66~uEFAVY3xO1867618676eucas1p2c;
        Tue, 28 Jan 2020 13:34:15 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id BE.CA.61286.758303E5; Tue, 28
        Jan 2020 13:34:15 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133415eucas1p258c0d5c313e2ae42a05508b67eec16ef~uEFABo90w1871818718eucas1p2I;
        Tue, 28 Jan 2020 13:34:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200128133415eusmtrp248656553bccf58a04aa8f5a33d7a6b05~uEFABHKpH0330003300eusmtrp20;
        Tue, 28 Jan 2020 13:34:15 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-80-5e3038571d9a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E0.82.07950.658303E5; Tue, 28
        Jan 2020 13:34:14 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133414eusmtip2ac44a4cec89001bf562317e2180daeb9~uEE-rYOv10657406574eusmtip2f;
        Tue, 28 Jan 2020 13:34:14 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 13/28] ata: move ata_do_link_spd_horkage() to
 libata-core-sata.c
Date:   Tue, 28 Jan 2020 14:33:28 +0100
Message-Id: <20200128133343.29905-14-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128133343.29905-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djPc7rhFgZxBpvniVmsvtvPZrFxxnpW
        i2e39jJZHNvxiMni8q45bBZzW6ezO7B57Jx1l93j8tlSj0OHOxg9+rasYvT4vEkugDWKyyYl
        NSezLLVI3y6BK+P/rSdsBTvlKpb+usnUwHhFoouRk0NCwESif8kv1i5GLg4hgRWMEm07X7FD
        OF8YJdbseMcI4XxmlHjw+DgzTMuMFX3MEInljBLXNlxihmv5v/UfG0gVm4CVxMT2VYwgtoiA
        gkTP75VsIEXMAmsYJVYdbgJLCAsESXyatBHMZhFQlejsessCYvMK2El8eP+eEWKdvMTWb5+A
        LuTg4ASK9+w1hygRlDg58wlYOTNQSfPW2WBHSAi0s0ssWjudFaLXReLT+/0sELawxKvjW9gh
        bBmJ/zvnM0E0rGOU+NvxAqp7O6PE8skQL0gIWEvcOfeLDWQzs4CmxPpd+hBhR4nvG2aDhSUE
        +CRuvBWEOIJPYtK26cwQYV6JjjYhiGo1iQ3LNrDBrO3auRIaih4ST2ZdYpzAqDgLyTuzkLwz
        C2HvAkbmVYziqaXFuempxYZ5qeV6xYm5xaV56XrJ+bmbGIEp5vS/4592MH69lHSIUYCDUYmH
        d4aKQZwQa2JZcWXuIUYJDmYlEd5OJqAQb0piZVVqUX58UWlOavEhRmkOFiVxXuNFL2OFBNIT
        S1KzU1MLUotgskwcnFINjFo+dy61XvplE2QqIfvI+FTMrG9Xms/scfq3/dOl36VsL/mWeUwz
        rVu/q8XNZdMch8WRNQuCNzQZrP59ZeWnR41B8tOu9Tf4fg/9kLXtyoUTRcHageXfzY/w3Jf5
        MMtMNXV9VIJNo/qtabsuWjJfd9bYVHzinuzf7dv47d9tPiPFv939qHgvV5MSS3FGoqEWc1Fx
        IgDGwjdCLQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42I5/e/4Pd0wC4M4g5+Nthar7/azWWycsZ7V
        4tmtvUwWx3Y8YrK4vGsOm8Xc1unsDmweO2fdZfe4fLbU49DhDkaPvi2rGD0+b5ILYI3SsynK
        Ly1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy/h/6wlbwU65
        iqW/bjI1MF6R6GLk5JAQMJGYsaKPuYuRi0NIYCmjRPO6RsYuRg6ghIzE8fVlEDXCEn+udbFB
        1HxilHjStpIJJMEmYCUxsX0VI4gtIqAg0fN7JVgRs8AGRolXN7+wgCSEBQIkzjWfB7NZBFQl
        Orvegtm8AnYSH96/Z4TYIC+x9dsnVpDFnEDxnr3mIGEhAVuJ9WeeskKUC0qcnPkErJUZqLx5
        62zmCYwCs5CkZiFJLWBkWsUoklpanJueW2ykV5yYW1yal66XnJ+7iREYB9uO/dyyg7HrXfAh
        RgEORiUeXgclgzgh1sSy4srcQ4wSHMxKIrydTEAh3pTEyqrUovz4otKc1OJDjKZAP0xklhJN
        zgfGaF5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBkbza/Nb+Xm2
        5RtMXuZz4J31IhW3bTwV/y9Frzkh1596Yp7O6ntx1xdOTurJ+j7RKT730+0DB0/fX90ss7b+
        9+cL116+PW8X6GJxctutqTmMu1cFzrS5s9umtUfzR7Z/aK69rmlF6On051Kx86TS9dJND+pW
        du4pPP1BL3XfwlXlf3p63Q8sLl6rxFKckWioxVxUnAgARIMkgpkCAAA=
X-CMS-MailID: 20200128133415eucas1p258c0d5c313e2ae42a05508b67eec16ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133415eucas1p258c0d5c313e2ae42a05508b67eec16ef
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133415eucas1p258c0d5c313e2ae42a05508b67eec16ef
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133415eucas1p258c0d5c313e2ae42a05508b67eec16ef@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

* move ata_do_link_spd_horkage() to libata-core-sata.c

* add static inline for CONFIG_SATA_HOST=n case

Code size savings on m68k arch using atari_defconfig:

   text    data     bss     dec     hex filename
before:
  36762     572      40   37374    91fe drivers/ata/libata-core.o
after:
  36627     572      40   37239    9177 drivers/ata/libata-core.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core-sata.c | 33 +++++++++++++++++++++++++++++++++
 drivers/ata/libata-core.c      | 33 ---------------------------------
 drivers/ata/libata.h           |  7 +++++++
 3 files changed, 40 insertions(+), 33 deletions(-)

diff --git a/drivers/ata/libata-core-sata.c b/drivers/ata/libata-core-sata.c
index 8b939d2db0a6..fed8009981c0 100644
--- a/drivers/ata/libata-core-sata.c
+++ b/drivers/ata/libata-core-sata.c
@@ -87,6 +87,39 @@ void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf)
 }
 EXPORT_SYMBOL_GPL(ata_tf_from_fis);
 
+int ata_do_link_spd_horkage(struct ata_device *dev)
+{
+	struct ata_link *plink = ata_dev_phys_link(dev);
+	u32 target, target_limit;
+
+	if (!sata_scr_valid(plink))
+		return 0;
+
+	if (dev->horkage & ATA_HORKAGE_1_5_GBPS)
+		target = 1;
+	else
+		return 0;
+
+	target_limit = (1 << target) - 1;
+
+	/* if already on stricter limit, no need to push further */
+	if (plink->sata_spd_limit <= target_limit)
+		return 0;
+
+	plink->sata_spd_limit = target_limit;
+
+	/* Request another EH round by returning -EAGAIN if link is
+	 * going faster than the target speed.  Forward progress is
+	 * guaranteed by setting sata_spd_limit to target_limit above.
+	 */
+	if (plink->sata_spd > target) {
+		ata_dev_info(dev, "applying link speed limit horkage to %s\n",
+			     sata_spd_string(target));
+		return -EAGAIN;
+	}
+	return 0;
+}
+
 /**
  *	sata_link_scr_lpm - manipulate SControl IPM and SPM fields
  *	@link: ATA link to manipulate SControl for
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 24b8ee668e6f..52bd81bad484 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2074,39 +2074,6 @@ static bool ata_identify_page_supported(struct ata_device *dev, u8 page)
 	return false;
 }
 
-static int ata_do_link_spd_horkage(struct ata_device *dev)
-{
-	struct ata_link *plink = ata_dev_phys_link(dev);
-	u32 target, target_limit;
-
-	if (!sata_scr_valid(plink))
-		return 0;
-
-	if (dev->horkage & ATA_HORKAGE_1_5_GBPS)
-		target = 1;
-	else
-		return 0;
-
-	target_limit = (1 << target) - 1;
-
-	/* if already on stricter limit, no need to push further */
-	if (plink->sata_spd_limit <= target_limit)
-		return 0;
-
-	plink->sata_spd_limit = target_limit;
-
-	/* Request another EH round by returning -EAGAIN if link is
-	 * going faster than the target speed.  Forward progress is
-	 * guaranteed by setting sata_spd_limit to target_limit above.
-	 */
-	if (plink->sata_spd > target) {
-		ata_dev_info(dev, "applying link speed limit horkage to %s\n",
-			     sata_spd_string(target));
-		return -EAGAIN;
-	}
-	return 0;
-}
-
 static inline u8 ata_dev_knobble(struct ata_device *dev)
 {
 	struct ata_port *ap = dev->link->ap;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index cd8090ad43e5..9eebe4e0be39 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -87,6 +87,13 @@ extern unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 
 #define to_ata_port(d) container_of(d, struct ata_port, tdev)
 
+/* libata-core-sata.c */
+#ifdef CONFIG_SATA_HOST
+int ata_do_link_spd_horkage(struct ata_device *dev);
+#else
+static inline int ata_do_link_spd_horkage(struct ata_device *dev) { return 0; }
+#endif
+
 /* libata-acpi.c */
 #ifdef CONFIG_ATA_ACPI
 extern unsigned int ata_acpi_gtf_filter;
-- 
2.24.1

