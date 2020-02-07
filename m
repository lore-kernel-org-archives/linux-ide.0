Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D53DC04EB5
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93039214AF
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RtWyKFS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgBGO2E (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:28:04 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59630 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgBGO2B (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:28:01 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142800euoutp0161670f9f5068791c85150f2f0e48172d~xJQyYDXrs2241722417euoutp01L
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:28:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200207142800euoutp0161670f9f5068791c85150f2f0e48172d~xJQyYDXrs2241722417euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085680;
        bh=N8XFkaMzTtxAPVIy6DQuXc9O6m05ykPcZ9s0OEIyZ1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RtWyKFS/ubyPtLPHUk9/PCSW/Y/+5pGQdb26WvktjevTbZFvB1WfLvenCrYQRMUmn
         yvVUBVbuxQ/LV0k4mhh6wMn9IIxtIM0yNuwttrkCmOsmM6KMqQkT7b+EEu/EkfTOeY
         vUuPRtp4ILv2PmIUvv+X34Iudso3a/5mldY3URek=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200207142759eucas1p1169d8f7b0ef3e3e761d2f02bb765a1db~xJQyDlsQu2844428444eucas1p1o;
        Fri,  7 Feb 2020 14:27:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3F.15.61286.FE37D3E5; Fri,  7
        Feb 2020 14:27:59 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200207142759eucas1p1121be90ddd41b97b9112b8cd599d0243~xJQxz-cmx1078610786eucas1p1y;
        Fri,  7 Feb 2020 14:27:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200207142759eusmtrp10e743037cb8b50bfcb1ff530042beb30~xJQxzZwKO0480004800eusmtrp1Q;
        Fri,  7 Feb 2020 14:27:59 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-27-5e3d73efa1ea
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CE.89.08375.FE37D3E5; Fri,  7
        Feb 2020 14:27:59 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142759eusmtip2164baeee8b2b4e9f89ef24cce69019b3~xJQxV_u1S2944029440eusmtip2h;
        Fri,  7 Feb 2020 14:27:59 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v2 17/26] ata: move *sata_set_spd*() to libata-sata.c
Date:   Fri,  7 Feb 2020 15:27:25 +0100
Message-Id: <20200207142734.8431-18-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207142734.8431-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djPc7rvi23jDKa/MbRYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBk7l19kKzhgVbGj8RpzA+N8/S5GTg4J
        AROJW/OPsHYxcnEICaxglNg0YToLhPOFUWLvzvNQzmdGiQcPlzLBtLzdtREqsZxRYuflxwgt
        21Z8YwSpYhOwkpjYvgrMFhFQkOj5vZINpIhZ4D2jxIpJe1lAEsICrhLtqxeDjWURUJV4uOsL
        WAOvgK3Ehh/X2SDWyUts/faJFcTmBIp/nPKXDaJGUOLkzCdgc5iBapq3zmYGWSAhsIpdYvmF
        q+wQzS4S018uZIWwhSVeHd8CFZeROD25hwWiYR2jxN+OF1Dd2xkllk/+B7XaWuLOuV9ANgfQ
        Ck2J9bugYeYosfPGLUaQsIQAn8SNt4IQR/BJTNo2nRkizCvR0SYEUa0msWHZBjaYtV07VzJD
        2B4SO+adY5rAqDgLyTuzkLwzC2HvAkbmVYziqaXFuempxYZ5qeV6xYm5xaV56XrJ+bmbGIHJ
        6PS/4592MH69lHSIUYCDUYmHN8HRJk6INbGsuDL3EKMEB7OSCG+fqm2cEG9KYmVValF+fFFp
        TmrxIUZpDhYlcV7jRS9jhQTSE0tSs1NTC1KLYLJMHJxSDYwSAXMSw8Nd2HY6u4oYhnlP35vE
        frPQe2FLum3EZ92DO9vddz3/8OrjyXkHNzWHqAWfNpcSfPC/ZjcHV2HG1fWJq020J27aIemR
        3ZP15bfEjC9LhExYTPJZ3c7cClzEIWW/YaNC651s57/GYrezLjbqNr7I10n3bBaetP+4vJdf
        nM+r5fND7imxFGckGmoxFxUnAgAzVFxoQgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xe7rvi23jDHZ2KFmsvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYydyy+yFRywqtjReI25gXG+fhcjJ4eEgInE210bWboYuTiEBJYySmx8
        tJ61i5EDKCEjcXx9GUSNsMSfa11sEDWfGCWm3G9nAUmwCVhJTGxfxQhiiwgoSPT8XglWxCzw
        lVFi6aRuZpCEsICrRPvqxUwgNouAqsTDXV/AGngFbCU2/LjOBrFBXmLrt0+sIDYnUPzjlL9g
        cSEBG4nv7yexQ9QLSpyc+QRsMTNQffPW2cwTGAVmIUnNQpJawMi0ilEktbQ4Nz232FCvODG3
        uDQvXS85P3cTIzBith37uXkH46WNwYcYBTgYlXh4Exxt4oRYE8uKK3MPMUpwMCuJ8Pap2sYJ
        8aYkVlalFuXHF5XmpBYfYjQFemIis5Rocj4wmvNK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmk
        J5akZqemFqQWwfQxcXBKNTC6Vfzw9XvmujoqwT7nPc9z5vMd8zf+jGD4/X5V/NeMe+JObwJj
        VRd33veYufOtZ9E/tatLYxZXV8cziTNVWLr7B/+xefXu8fyyfg+xa66yVkeS5FX5n0jbzY5V
        2rjsOW8ow3m7Lvben9vS5y728U7ambm8NKnIWvSf++Gu1t86lxxll26MP6XEUpyRaKjFXFSc
        CADgwaBfrgIAAA==
X-CMS-MailID: 20200207142759eucas1p1121be90ddd41b97b9112b8cd599d0243
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200207142759eucas1p1121be90ddd41b97b9112b8cd599d0243
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200207142759eucas1p1121be90ddd41b97b9112b8cd599d0243
References: <20200207142734.8431-1-b.zolnierkie@samsung.com>
        <CGME20200207142759eucas1p1121be90ddd41b97b9112b8cd599d0243@eucas1p1.samsung.com>
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
index f2882d1c731b..e932d11a061f 100644
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
index 57c5081eb601..efc87613f9c1 100644
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

