Return-Path: <SRS0=AjNr=5C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FF9C4CECE
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500C4205ED
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GyCRCy2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgCQOoi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:44:38 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40406 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgCQOnw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Mar 2020 10:43:52 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200317144350euoutp02b9951ab79472b79ccf45cb62d3098013~9HowImBYa1642416424euoutp02s
        for <linux-ide@vger.kernel.org>; Tue, 17 Mar 2020 14:43:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200317144350euoutp02b9951ab79472b79ccf45cb62d3098013~9HowImBYa1642416424euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584456230;
        bh=z98hw4z19yrPgf7hDfNSSmWlSrMz8GnsMAP0uiTC7AI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GyCRCy2JYBFu7tJEVIXD0nIo4YEccF41/T3ONGMJeL16vf/nvUBo/OBqaHdfTn+7M
         Wtt4z6uJR60Axephvrc/UTN4vgI57icRvcHco+ycrXRmuQAF7S8/C5DiUbCPkCVLJ2
         FUfqswULggIJ6wGwD3di2hWUHu2sOUYK1JY59xOU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200317144350eucas1p2cbf6dd8d7f826258a60c9ab9e537749d~9Hov4lFfi2986029860eucas1p2r;
        Tue, 17 Mar 2020 14:43:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F2.F1.60679.622E07E5; Tue, 17
        Mar 2020 14:43:50 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200317144350eucas1p2caf23e8366434ef2c9954cd4d52f30f1~9Hovh9-Sd0512605126eucas1p2T;
        Tue, 17 Mar 2020 14:43:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200317144350eusmtrp19d3047f0da5308b19c0155ec1b81c73f~9HovhQ9uc0867908679eusmtrp1r;
        Tue, 17 Mar 2020 14:43:50 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-51-5e70e226ef65
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CF.D4.08375.522E07E5; Tue, 17
        Mar 2020 14:43:49 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144349eusmtip190be159326015a19e0f2839f0c6f9711~9HovBxKYk0453304533eusmtip1i;
        Tue, 17 Mar 2020 14:43:49 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v4 18/27] ata: move *sata_set_spd*() to libata-sata.c
Date:   Tue, 17 Mar 2020 15:43:24 +0100
Message-Id: <20200317144333.2904-19-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317144333.2904-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djPc7pqjwriDL6cE7NYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBkfNpxiK7hiVXF753SWBsb5+l2MnBwS
        AiYS/3aeYO1i5OIQEljBKPHi6Qw2kISQwBdGic/LMyASnxklVkw5zwjT8eBECyNEYjmjROOr
        Pka4jt4HNSA2m4CVxMT2VWBxEQEFiZ7fK9lAGpgF3gNNmrSXBSQhLOAqsXbyNaYuRg4OFgFV
        ib2PgkDCvAK2EuuWP2eFWCYvsfXbJzCbEyh+7fA/NogaQYmTM5+AjWEGqmneOpsZZL6EwCp2
        idsd85lBZkoIuEhsnc4GMUdY4tXxLewQtozE6ck9LBD16xgl/na8gGreziixfPI/qA5riTvn
        frGBDGIW0JRYvwsaXo4Sx95MZIKYzydx460gxA18EpO2TYdayyvR0SYEUa0msWHZBjaYtV07
        VzJD2B4Se36vYZvAqDgLyTezkHwzC2HvAkbmVYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmb
        GIFJ6PS/4192MO76k3SIUYCDUYmHl2NDQZwQa2JZcWXuIUYJDmYlEd7FhflxQrwpiZVVqUX5
        8UWlOanFhxilOViUxHmNF72MFRJITyxJzU5NLUgtgskycXBKNTBOaq0wEY9/x2D+ov6x1EYm
        1bnzijdt4jZuv//unP5eKZ3Cd3u7nEuKSoy1OULvJtuHtJYEMX09HvlgyQzRi08XRbqbbDk1
        v+zh/Uus15Zv/2zX+uDxc5+WWkvTRydZ584wMJ0XPD/XPdKQRWpl26yIKQdlLbgcpz9UY9/a
        92Nh9wvpgJqTlgJKLMUZiYZazEXFiQALZ9GWPgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xu7qqjwriDE5ttrRYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehkfNpxiK7hiVXF753SWBsb5+l2MnBwSAiYSD060MHYxcnEICSxllPh4
        fTZ7FyMHUEJG4vj6MogaYYk/17rYIGo+MUrcuPmfCSTBJmAlMbF9FSOILSKgINHzeyVYEbPA
        V0aJpZO6mUESwgKuEmsnX2MCGcoioCqx91EQSJhXwFZi3fLnrBAL5CW2fvsEZnMCxa8d/scG
        YgsJ2Ei8eAOxi1dAUOLkzCcsIDYzUH3z1tnMExgFZiFJzUKSWsDItIpRJLW0ODc9t9hQrzgx
        t7g0L10vOT93EyMwXrYd+7l5B+OljcGHGAU4GJV4eDk2FMQJsSaWFVfmHmKU4GBWEuFdXJgf
        J8SbklhZlVqUH19UmpNafIjRFOiHicxSosn5wFjOK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMk
        kJ5YkpqdmlqQWgTTx8TBKdXAmLp2baRP8etDzG8cTs1jyt/r4Z4gvZj3xHlvkUdeQv0uyVMy
        mTXLj3d/r2jex7yGNcH6Ez9fdW5Bo2tc0meR3spDgrN1JrbPuLPlcczKh7uv+M8INJx3JXba
        i9n1yScv3SipOPy5y1G9fU7qWceEqAoZ/eWiN//vfXLH5qKqLtNz28dvkhfNU2Ipzkg01GIu
        Kk4EANzJ2xWtAgAA
X-CMS-MailID: 20200317144350eucas1p2caf23e8366434ef2c9954cd4d52f30f1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200317144350eucas1p2caf23e8366434ef2c9954cd4d52f30f1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200317144350eucas1p2caf23e8366434ef2c9954cd4d52f30f1
References: <20200317144333.2904-1-b.zolnierkie@samsung.com>
        <CGME20200317144350eucas1p2caf23e8366434ef2c9954cd4d52f30f1@eucas1p2.samsung.com>
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
index 099d776289d7..37de14e6224f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3062,87 +3062,6 @@ int sata_down_spd_limit(struct ata_link *link, u32 spd_limit)
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
index 6848e2403d4f..246696cafc4c 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1066,7 +1066,6 @@ static inline int ata_port_is_dummy(struct ata_port *ap)
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

