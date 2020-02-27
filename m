Return-Path: <SRS0=ljer=4P=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E058C35E15
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50468246A8
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vHYd3xWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbgB0SXh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:23:37 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59070 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730992AbgB0SWt (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Feb 2020 13:22:49 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200227182248euoutp02cc8a3b04a823a402b752d4078afa9f97~3VXgMvDEd0821308213euoutp02a
        for <linux-ide@vger.kernel.org>; Thu, 27 Feb 2020 18:22:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200227182248euoutp02cc8a3b04a823a402b752d4078afa9f97~3VXgMvDEd0821308213euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582827768;
        bh=8xuRiV9wBbmT3y/ytbo3ymgr+5UeWNtwn/zbxK7zuzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vHYd3xWc0bx3wlgFTHuhXx1Ldzq+eP3X2zPxKKsxOichKRxQ643HqPQaxpz46VVBs
         fgELGi4V8yg2z4Vlrcz3RXxpcGV7aFdYWEGaFW+4ZkmsYBJ0x4tB2F66mLeROWmh8A
         /T0HzrgyiBaFEV4I+jKcbk99t6slzKoZoN87IgHE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200227182247eucas1p22961663202ea51bdc14d843dddb84f78~3VXf-LBjK3194731947eucas1p2I;
        Thu, 27 Feb 2020 18:22:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 99.05.60698.7F8085E5; Thu, 27
        Feb 2020 18:22:47 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200227182247eucas1p1e9042300d9ad7dd56a1319afb980bdfe~3VXflFboR0494604946eucas1p1J;
        Thu, 27 Feb 2020 18:22:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200227182247eusmtrp15e0a12fa55bec1ddcde5282ac27beae2~3VXfkcuAp0110301103eusmtrp1e;
        Thu, 27 Feb 2020 18:22:47 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-04-5e5808f79908
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 45.61.07950.7F8085E5; Thu, 27
        Feb 2020 18:22:47 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182247eusmtip2e59f4b892303e67c711d3e98ea62a2ae~3VXfJL_4B2149421494eusmtip2K;
        Thu, 27 Feb 2020 18:22:46 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v3 18/27] ata: move *sata_set_spd*() to libata-sata.c
Date:   Thu, 27 Feb 2020 19:22:17 +0100
Message-Id: <20200227182226.19188-19-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227182226.19188-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djP87rfOSLiDK72mlisvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoLpuU1JzMstQifbsEroxvs7axFBywquhsm8LSwDhfv4uRg0NC
        wETiT1tYFyMXh5DACkaJnkkn2SCcL4wSn5e+Y+xi5ARyPjNKXL/vAWKDNNyd1cEIUbScUeLL
        jHXscB1t/3axg1SxCVhJTGxfBdYtIqAg0fN7JdhYZoH3jBIrJu1lAUkIC7hKfJs/hxXEZhFQ
        lVjx5SFYA6+AncSX/k4miHXyElu/fQKr4QSK3+jbzgZRIyhxcuYTsDnMQDXNW2czgyyQEFjG
        LnFm0w42iGYXiU2HHjBC2MISr45vYYewZSROT+5hgWhYxyjxt+MFVPd2Ronlk/9BdVtL3Dn3
        iw0UTMwCmhLrd+lDhB0l7vbeZYSEHp/EjbeCEEfwSUzaNp0ZIswr0dEmBFGtJrFh2QY2mLVd
        O1dClXhInP5WPIFRcRaSb2Yh+WYWwtoFjMyrGMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLzczcx
        AtPQ6X/Hv+5g3Pcn6RCjAAejEg/vgh3hcUKsiWXFlbmHGCU4mJVEeDd+DY0T4k1JrKxKLcqP
        LyrNSS0+xCjNwaIkzmu86GWskEB6YklqdmpqQWoRTJaJg1OqgXF55d2p2TtqajZ2c7P3saYn
        2tfMeXTiW+/bSzcO/zmydJHud4ZwM/bz6YXPZO6/XR1Wtkho5hLZTSERNTbmNSuqLvY9eR2v
        mxIluInpx9Q3vx5pz3X6MPXit8JKuae6TQsKBKZ8Xxq3qu1o9V+nDR+vTj61emt71qaX26bU
        bb8SHBemq1dyoOSsEktxRqKhFnNRcSIAB+cKFz8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xe7rfOSLiDO6/lbJYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehnfZm1jKThgVdHZNoWlgXG+fhcjJ4eEgInE3VkdjF2MXBxCAksZJQ5u
        v8XWxcgBlJCROL6+DKJGWOLPtS42iJpPjBJtnTsYQRJsAlYSE9tXgdkiAgoSPb9XghUxC3xl
        lFg6qZsZJCEs4Crxbf4cVhCbRUBVYsWXh2ANvAJ2El/6O5kgNshLbP32CayGEyh+o287G4gt
        JGAr0dXxFKpeUOLkzCcsIDYzUH3z1tnMExgFZiFJzUKSWsDItIpRJLW0ODc9t9hIrzgxt7g0
        L10vOT93EyMwYrYd+7kF6Il3wYcYBTgYlXh4PbaFxwmxJpYVV+YeYpTgYFYS4d34NTROiDcl
        sbIqtSg/vqg0J7X4EKMp0BMTmaVEk/OB0ZxXEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEk
        NTs1tSC1CKaPiYNTqoFRoOzsLaGiDdbVQh/rc6tFug9XlTSIee+5ue38kglP3XkcuXo2X26+
        nyMm5P59/9Z2Z+fIZbonP66oST9xpsDjQcvlzbzHPgoItP9dc/QB26uay+8epp1d27h4u5lZ
        VJj7W2ajPBtF/SwLn0A+t6hCGc171kUzWu9ntF7ZnHLi5IbI24ULA9KVWIozEg21mIuKEwFB
        Cpn3rgIAAA==
X-CMS-MailID: 20200227182247eucas1p1e9042300d9ad7dd56a1319afb980bdfe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200227182247eucas1p1e9042300d9ad7dd56a1319afb980bdfe
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200227182247eucas1p1e9042300d9ad7dd56a1319afb980bdfe
References: <20200227182226.19188-1-b.zolnierkie@samsung.com>
        <CGME20200227182247eucas1p1e9042300d9ad7dd56a1319afb980bdfe@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

* move *sata_set_spd*() to libata-sata.c

* add static inlines for CONFIG_SATA_HOST=n case

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  32842     572      40   33458    82ae drivers/ata/libata-core.o
after:
  32812     572      40   33428    8290 drivers/ata/libata-core.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 81 ---------------------------------------
 drivers/ata/libata-sata.c | 81 +++++++++++++++++++++++++++++++++++++++
 drivers/ata/libata.h      |  7 ++++
 include/linux/libata.h    |  3 +-
 4 files changed, 90 insertions(+), 82 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ba1e5c4d3c09..13214ebd0e5c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3050,87 +3050,6 @@ int sata_down_spd_limit(struct ata_link *link, u32 spd_limit)
 	return 0;
 }
 
-static int __sata_set_spd_needed(struct ata_link *link, u32 *scontrol)
-{
-	struct ata_link *host_link = &link->ap->link;
-	u32 limit, target, spd;
-
-	limit = link->sata_spd_limit;
-
-	/* Don't configure downstream link faster than upstream link.
-	 * It doesn't speed up anything and some PMPs choke on such
-	 * configuration.
-	 */
-	if (!ata_is_host_link(link) && host_link->sata_spd)
-		limit &= (1 << host_link->sata_spd) - 1;
-
-	if (limit == UINT_MAX)
-		target = 0;
-	else
-		target = fls(limit);
-
-	spd = (*scontrol >> 4) & 0xf;
-	*scontrol = (*scontrol & ~0xf0) | ((target & 0xf) << 4);
-
-	return spd != target;
-}
-
-/**
- *	sata_set_spd_needed - is SATA spd configuration needed
- *	@link: Link in question
- *
- *	Test whether the spd limit in SControl matches
- *	@link->sata_spd_limit.  This function is used to determine
- *	whether hardreset is necessary to apply SATA spd
- *	configuration.
- *
- *	LOCKING:
- *	Inherited from caller.
- *
- *	RETURNS:
- *	1 if SATA spd configuration is needed, 0 otherwise.
- */
-static int sata_set_spd_needed(struct ata_link *link)
-{
-	u32 scontrol;
-
-	if (sata_scr_read(link, SCR_CONTROL, &scontrol))
-		return 1;
-
-	return __sata_set_spd_needed(link, &scontrol);
-}
-
-/**
- *	sata_set_spd - set SATA spd according to spd limit
- *	@link: Link to set SATA spd for
- *
- *	Set SATA spd of @link according to sata_spd_limit.
- *
- *	LOCKING:
- *	Inherited from caller.
- *
- *	RETURNS:
- *	0 if spd doesn't need to be changed, 1 if spd has been
- *	changed.  Negative errno if SCR registers are inaccessible.
- */
-int sata_set_spd(struct ata_link *link)
-{
-	u32 scontrol;
-	int rc;
-
-	if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
-		return rc;
-
-	if (!__sata_set_spd_needed(link, &scontrol))
-		return 0;
-
-	if ((rc = sata_scr_write(link, SCR_CONTROL, scontrol)))
-		return rc;
-
-	return 1;
-}
-EXPORT_SYMBOL_GPL(sata_set_spd);
-
 #ifdef CONFIG_ATA_ACPI
 /**
  *	ata_timing_cycle2mode - find xfer mode for the specified cycle duration
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 1ef4c19864ac..d66afdc33d54 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -271,6 +271,87 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 }
 EXPORT_SYMBOL_GPL(sata_link_scr_lpm);
 
+static int __sata_set_spd_needed(struct ata_link *link, u32 *scontrol)
+{
+	struct ata_link *host_link = &link->ap->link;
+	u32 limit, target, spd;
+
+	limit = link->sata_spd_limit;
+
+	/* Don't configure downstream link faster than upstream link.
+	 * It doesn't speed up anything and some PMPs choke on such
+	 * configuration.
+	 */
+	if (!ata_is_host_link(link) && host_link->sata_spd)
+		limit &= (1 << host_link->sata_spd) - 1;
+
+	if (limit == UINT_MAX)
+		target = 0;
+	else
+		target = fls(limit);
+
+	spd = (*scontrol >> 4) & 0xf;
+	*scontrol = (*scontrol & ~0xf0) | ((target & 0xf) << 4);
+
+	return spd != target;
+}
+
+/**
+ *	sata_set_spd_needed - is SATA spd configuration needed
+ *	@link: Link in question
+ *
+ *	Test whether the spd limit in SControl matches
+ *	@link->sata_spd_limit.  This function is used to determine
+ *	whether hardreset is necessary to apply SATA spd
+ *	configuration.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ *
+ *	RETURNS:
+ *	1 if SATA spd configuration is needed, 0 otherwise.
+ */
+int sata_set_spd_needed(struct ata_link *link)
+{
+	u32 scontrol;
+
+	if (sata_scr_read(link, SCR_CONTROL, &scontrol))
+		return 1;
+
+	return __sata_set_spd_needed(link, &scontrol);
+}
+
+/**
+ *	sata_set_spd - set SATA spd according to spd limit
+ *	@link: Link to set SATA spd for
+ *
+ *	Set SATA spd of @link according to sata_spd_limit.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ *
+ *	RETURNS:
+ *	0 if spd doesn't need to be changed, 1 if spd has been
+ *	changed.  Negative errno if SCR registers are inaccessible.
+ */
+int sata_set_spd(struct ata_link *link)
+{
+	u32 scontrol;
+	int rc;
+
+	if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
+		return rc;
+
+	if (!__sata_set_spd_needed(link, &scontrol))
+		return 0;
+
+	if ((rc = sata_scr_write(link, SCR_CONTROL, scontrol)))
+		return rc;
+
+	return 1;
+}
+EXPORT_SYMBOL_GPL(sata_set_spd);
+
 /**
  *	ata_slave_link_init - initialize slave link
  *	@ap: port to initialize slave link for
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index cd8090ad43e5..53b45ebe3d55 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -87,6 +87,13 @@ extern unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 
 #define to_ata_port(d) container_of(d, struct ata_port, tdev)
 
+/* libata-sata.c */
+#ifdef CONFIG_SATA_HOST
+int sata_set_spd_needed(struct ata_link *link);
+#else
+static inline int sata_set_spd_needed(struct ata_link *link) { return 1; }
+#endif
+
 /* libata-acpi.c */
 #ifdef CONFIG_ATA_ACPI
 extern unsigned int ata_acpi_gtf_filter;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 372070a9d92e..3f0bdc2c30d3 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1076,7 +1076,6 @@ static inline int ata_port_is_dummy(struct ata_port *ap)
 	return ap->ops == &ata_dummy_port_ops;
 }
 
-extern int sata_set_spd(struct ata_link *link);
 extern int ata_std_prereset(struct ata_link *link, unsigned long deadline);
 extern int ata_wait_after_reset(struct ata_link *link, unsigned long deadline,
 				int (*check_ready)(struct ata_link *link));
@@ -1196,6 +1195,7 @@ extern int sata_scr_valid(struct ata_link *link);
 extern int sata_scr_read(struct ata_link *link, int reg, u32 *val);
 extern int sata_scr_write(struct ata_link *link, int reg, u32 val);
 extern int sata_scr_write_flush(struct ata_link *link, int reg, u32 val);
+extern int sata_set_spd(struct ata_link *link);
 #else
 static inline int sata_scr_valid(struct ata_link *link) { return 0; }
 static inline int sata_scr_read(struct ata_link *link, int reg, u32 *val)
@@ -1210,6 +1210,7 @@ static inline int sata_scr_write_flush(struct ata_link *link, int reg, u32 val)
 {
 	return -EOPNOTSUPP;
 }
+static inline int sata_set_spd(struct ata_link *link) { return -EOPNOTSUPP; }
 #endif
 extern int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 			     bool spm_wakeup);
-- 
2.24.1

