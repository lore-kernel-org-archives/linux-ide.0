Return-Path: <SRS0=dw68=3R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2E3C2D0DB
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B04F22522
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Axr2+LHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgA1NfI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:35:08 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52353 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgA1NeS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jan 2020 08:34:18 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200128133417euoutp02b0133135299dc284259c575a40571683~uEFB5XpIU2911929119euoutp02l
        for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2020 13:34:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200128133417euoutp02b0133135299dc284259c575a40571683~uEFB5XpIU2911929119euoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580218457;
        bh=WqY0W3HvC6cqWZyiVukr+Lf2qHDg/ANtKN6Xk5rhJFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Axr2+LHA2ox5kozBidrUbv2Bbqy3x55B1zOWHahMRQF5L3NG/8DHhJYuBoZgJhAFE
         hCxI+NJqEoYOGH2QoP4+XHEXAdqDMZ/qbBKkZcjoI/Mz5LXZx4ehWZQbhrr4w83TZi
         KyeEwCd+dPpVDSYS9b7s3UKyU3DN5Leu7kwz1Ypo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200128133416eucas1p1a6f1b5ad3c14c47c1aa5e45b74427b30~uEFBhijGo1376413764eucas1p1E;
        Tue, 28 Jan 2020 13:34:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F4.5A.60679.858303E5; Tue, 28
        Jan 2020 13:34:16 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133416eucas1p240f8fc15b334e0608cce30f2b6f0fbe1~uEFBPO3o51585815858eucas1p2-;
        Tue, 28 Jan 2020 13:34:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200128133416eusmtrp25b03fc764b8bbd875f75d8acd9e1e5e4~uEFBOpFKQ0330003300eusmtrp23;
        Tue, 28 Jan 2020 13:34:16 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-52-5e303858245e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 02.82.07950.858303E5; Tue, 28
        Jan 2020 13:34:16 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133416eusmtip25b550982b5cf5738632031e68c75bf96~uEFA6kN1Y0685506855eusmtip2Y;
        Tue, 28 Jan 2020 13:34:15 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 17/28] ata: move *sata_set_spd*() to libata-core-sata.c
Date:   Tue, 28 Jan 2020 14:33:32 +0100
Message-Id: <20200128133343.29905-18-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128133343.29905-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7djPc7oRFgZxBtsnqFusvtvPZrFxxnpW
        i2e39jJZHNvxiMni8q45bBZzW6ezO7B57Jx1l93j8tlSj0OHOxg9+rasYvT4vEkugDWKyyYl
        NSezLLVI3y6BK2Pb85+MBS9tKraceMbYwDjdsIuRk0NCwETiWtdjRhBbSGAFo8TZVxJdjFxA
        9hdGibWLd7FDOJ8ZJeZu/MII07Fo5mlGiMRyRonnBzuY4VoOrTvLDlLFJmAlMbF9FViHiICC
        RM/vlWwgRcwCaxglVh1uAkpwcAgLuEs8vK0BUsMioCox+eI7JhCbV8BO4uTlZWwQ2+Qltn77
        xApSzgkU79lrDlEiKHFy5hMWEJsZqKR562xmiPJudomNS50gbBeJJ9Nes0PYwhKvjm+BsmUk
        /u+czwRyjoTAOkaJvx0vmCGc7YwSyyf/g1psLXHn3C82kMXMApoS63fpQ4QdJWYvvsAOEpYQ
        4JO48VYQ4gY+iUnbpjNDhHklOtqEIKrVJDYs28AGs7Zr50qoMz0klh49zjaBUXEWkm9mIflm
        FsLeBYzMqxjFU0uLc9NTi43yUsv1ihNzi0vz0vWS83M3MQKTy+l/x7/sYNz1J+kQowAHoxIP
        7wwVgzgh1sSy4srcQ4wSHMxKIrydTEAh3pTEyqrUovz4otKc1OJDjNIcLErivMaLXsYKCaQn
        lqRmp6YWpBbBZJk4OKUaGJmnfSmvn3u//OAuuw8qE3ffD68qmF14XkDb+seeBaavl04oiJc4
        +bzNLeiKgMYtRt7/2VwfrVxb3/BenlthzHlYVvFxfJJknol/SaUWs0JG3JYO1Vzeeyv9bq70
        1nu163IWw519OyKqn+29vfCqcKfO3Hqpu3tTpt5P7touPDdqfXaEzO9VZkosxRmJhlrMRcWJ
        AJNnWX8qAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42I5/e/4Pd0IC4M4g71NIhar7/azWWycsZ7V
        4tmtvUwWx3Y8YrK4vGsOm8Xc1unsDmweO2fdZfe4fLbU49DhDkaPvi2rGD0+b5ILYI3SsynK
        Ly1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy9j2/CdjwUub
        ii0nnjE2ME437GLk5JAQMJFYNPM0YxcjF4eQwFJGiSXvrzJ3MXIAJWQkjq8vg6gRlvhzrYsN
        ouYTo8TB2QuZQRJsAlYSE9tXMYLYIgIKEj2/V4IVMQtsYJR4dfMLC8ggYQF3iYe3NUBqWARU
        JSZffMcEYvMK2EmcvLyMDWKBvMTWb59YQco5geI9e81BwkICthLrzzxlhSgXlDg58wkLiM0M
        VN68dTbzBEaBWUhSs5CkFjAyrWIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiMgm3Hfm7Zwdj1
        LvgQowAHoxIPr4OSQZwQa2JZcWXuIUYJDmYlEd5OJqAQb0piZVVqUX58UWlOavEhRlOgHyYy
        S4km5wMjNK8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA6OMCoPl
        shmhlg83JFWvfcZaHnoj7W/0/4ySrKgZpZ/Oh9+3sI/dstQiLDo/aMLWYNOvsuHGS0MXad/7
        U8F64U+MjZ5hSiHPU9lrdhmhU423Plh3XKbr250LvG4rP59cdmjSCjHGDdOW7Lhut+tq5uNF
        E+oti2LehX7TvSPjvT1Q3bKvWJE1s02JpTgj0VCLuag4EQBUq+1OmAIAAA==
X-CMS-MailID: 20200128133416eucas1p240f8fc15b334e0608cce30f2b6f0fbe1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133416eucas1p240f8fc15b334e0608cce30f2b6f0fbe1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133416eucas1p240f8fc15b334e0608cce30f2b6f0fbe1
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133416eucas1p240f8fc15b334e0608cce30f2b6f0fbe1@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

* move *sata_set_spd*() to libata-core-sata.c

* add static inlines for CONFIG_SATA_HOST=n case

Code size savings on m68k arch using atari_defconfig:

   text    data     bss     dec     hex filename
before:
  34996     572      40   35608    8b18 drivers/ata/libata-core.o
after:
  34766     572      40   35378    8a32 drivers/ata/libata-core.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core-sata.c | 81 ++++++++++++++++++++++++++++++++++
 drivers/ata/libata-core.c      | 81 ----------------------------------
 drivers/ata/libata.h           |  2 +
 include/linux/libata.h         |  4 +-
 4 files changed, 86 insertions(+), 82 deletions(-)

diff --git a/drivers/ata/libata-core-sata.c b/drivers/ata/libata-core-sata.c
index fb956c8aee9a..4aa938c1df8d 100644
--- a/drivers/ata/libata-core-sata.c
+++ b/drivers/ata/libata-core-sata.c
@@ -365,6 +365,87 @@ int sata_down_spd_limit(struct ata_link *link, u32 spd_limit)
 	return 0;
 }
 
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
  *	sata_link_scr_lpm - manipulate SControl IPM and SPM fields
  *	@link: ATA link to manipulate SControl for
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1d0744f18754..ff44d16b718e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2755,87 +2755,6 @@ struct ata_device *ata_dev_pair(struct ata_device *adev)
 }
 EXPORT_SYMBOL_GPL(ata_dev_pair);
 
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
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 518a8e08a26d..ea614ac10c76 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -108,6 +108,7 @@ int ata_do_link_spd_horkage(struct ata_device *dev);
 int ata_dev_config_ncq(struct ata_device *dev, char *desc, size_t desc_sz);
 void sata_print_link_status(struct ata_link *link);
 int sata_down_spd_limit(struct ata_link *link, u32 spd_limit);
+int sata_set_spd_needed(struct ata_link *link);
 #else
 static inline int ata_do_link_spd_horkage(struct ata_device *dev) { return 0; }
 static inline int ata_dev_config_ncq(struct ata_device *dev, char *desc,
@@ -121,6 +122,7 @@ static inline int sata_down_spd_limit(struct ata_link *link, u32 spd_limit)
 {
 	return -EOPNOTSUPP;
 }
+static inline int sata_set_spd_needed(struct ata_link *link) { return 1; }
 #endif
 
 /* libata-acpi.c */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6bb0bd644f17..e466dbe56158 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1076,7 +1076,6 @@ static inline int ata_port_is_dummy(struct ata_port *ap)
 	return ap->ops == &ata_dummy_port_ops;
 }
 
-extern int sata_set_spd(struct ata_link *link);
 extern int ata_std_prereset(struct ata_link *link, unsigned long deadline);
 extern int ata_wait_after_reset(struct ata_link *link, unsigned long deadline,
 				int (*check_ready)(struct ata_link *link));
@@ -1196,6 +1195,7 @@ extern void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *
  * Core layer (SATA specific part) - drivers/ata/libata-core-sata.c
  */
 #ifdef CONFIG_SATA_HOST
+extern int sata_set_spd(struct ata_link *link);
 extern int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 			     bool spm_wakeup);
 extern int ata_slave_link_init(struct ata_port *ap);
@@ -1203,6 +1203,8 @@ extern void ata_tf_to_fis(const struct ata_taskfile *tf,
 			  u8 pmp, int is_cmd, u8 *fis);
 extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
 extern bool sata_lpm_ignore_phy_events(struct ata_link *link);
+#else
+static inline int sata_set_spd(struct ata_link *link) { return -EOPNOTSUPP; }
 #endif
 
 extern int ata_cable_40wire(struct ata_port *ap);
-- 
2.24.1

