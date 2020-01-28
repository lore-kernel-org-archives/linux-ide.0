Return-Path: <SRS0=dw68=3R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7C0C35240
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B1324693
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qJfMuVY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgA1NfJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:35:09 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52350 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgA1NeS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jan 2020 08:34:18 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200128133416euoutp026a37de59577069cfa1f71534a5f7361a~uEFBef-7D2862028620euoutp02-
        for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2020 13:34:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200128133416euoutp026a37de59577069cfa1f71534a5f7361a~uEFBef-7D2862028620euoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580218456;
        bh=+nhl2QgmqdoNH5vOKvOoBGGKQG+7lMuwayVmJW3tto0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qJfMuVY9ja+nGsnGXnyt2fAljvNE4D2tdtx6hbw+lM9B/yOZPER/tmjS7SBZLODqX
         peiC7YlvssdiCvOJzz5/fBxLSbtXBlHFQTLaewC4ThXz3WE7E6TaWNwNHOz4HJj/LS
         XlN2m1j7+9TMbWG4+upWgZJsKySnhUH4j60LTPCE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200128133416eucas1p279457a2cb05080fbee9c0a223a21eb07~uEFBRnDd70683706837eucas1p2H;
        Tue, 28 Jan 2020 13:34:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F3.5A.60679.858303E5; Tue, 28
        Jan 2020 13:34:16 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200128133416eucas1p1eb121384be2323aed1fc63a6d1ebe14f~uEFA8EeCh0713407134eucas1p1u;
        Tue, 28 Jan 2020 13:34:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200128133416eusmtrp24985406fc97da71716c231976f5997ad~uEFA7h93J0330003300eusmtrp22;
        Tue, 28 Jan 2020 13:34:16 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-51-5e3038581b88
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 04.92.08375.758303E5; Tue, 28
        Jan 2020 13:34:15 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133415eusmtip26f0b06ff629847adfb1ecdfafdf3de9a~uEFAm5fAM0113601136eusmtip2F;
        Tue, 28 Jan 2020 13:34:15 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 16/28] ata: move sata_down_spd_limit() to libata-core-sata.c
Date:   Tue, 28 Jan 2020 14:33:31 +0100
Message-Id: <20200128133343.29905-17-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128133343.29905-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djPc7oRFgZxBj+2i1usvtvPZrFxxnpW
        i2e39jJZHNvxiMni8q45bBZzW6ezO7B57Jx1l93j8tlSj0OHOxg9+rasYvT4vEkugDWKyyYl
        NSezLLVI3y6BK+Pf0Q/MBT/sKy5cbmZuYFxn1MXIySEhYCIxu2UeSxcjF4eQwApGiVVfdzJC
        OF8YJZ4t7oXKfGaU+LO3hRWmZeOz3ewQieWMEg8mH2eGa5l6fBsbSBWbgJXExPZVjCC2iICC
        RM/vlWwgRcwCa4CWHG4CSwgL+EicnnWPCcRmEVCV6D40DczmFbCTWL31IRvEOnmJrd8+Aa3m
        4OAEivfsNYcoEZQ4OfMJC4jNDFTSvHU22BESAu3sEr9//IA61UXi84kJLBC2sMSr41vYIWwZ
        if875zNBNKxjlPjb8QKqezujxPLJ/6A2W0vcOfeLDWQzs4CmxPpd+iCmhICjxKfbghAmn8SN
        t4IQN/BJTNo2nRkizCvR0SYEMUNNYsOyDWwwW7t2rmSGsD0kJlw4xjqBUXEWkm9mIflmFsLa
        BYzMqxjFU0uLc9NTi43yUsv1ihNzi0vz0vWS83M3MQITzOl/x7/sYNz1J+kQowAHoxIP7wwV
        gzgh1sSy4srcQ4wSHMxKIrydTEAh3pTEyqrUovz4otKc1OJDjNIcLErivMaLXsYKCaQnlqRm
        p6YWpBbBZJk4OKUaGAMvi1QKq/FMvbtO5iKb76ep26a5vo5gts+6n7dIxFj4L8/nu4vuGx7q
        mS2l9u7S0lMXHqr8YPgTJNup+vXrtgWSvuK32id1+V5eXZFUOe02u0WcZjWf5dP8gHVqAQ7h
        hVvYHp0o6Vms/dnXz6WtS9zP6JHeuZAnd38tytn13Vv6xxEPzsqb2UosxRmJhlrMRcWJAC44
        2a0sAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42I5/e/4Pd1wC4M4g/NvbCxW3+1ns9g4Yz2r
        xbNbe5ksju14xGRxedccNou5rdPZHdg8ds66y+5x+Wypx6HDHYwefVtWMXp83iQXwBqlZ1OU
        X1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl/Hv6Afmgh/2
        FRcuNzM3MK4z6mLk5JAQMJHY+Gw3excjF4eQwFJGiemHJjF3MXIAJWQkjq8vg6gRlvhzrYsN
        ouYTo8SMUxNZQRJsAlYSE9tXMYLYIgIKEj2/V4IVMQtsYJR4dfMLC0hCWMBH4vSse0wgNouA
        qkT3oWlgNq+AncTqrQ/ZIDbIS2z99okVZDEnULxnrzlIWEjAVmL9maesEOWCEidnPgEbyQxU
        3rx1NvMERoFZSFKzkKQWMDKtYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIyDbcd+bt7BeGlj
        8CFGAQ5GJR7eGSoGcUKsiWXFlbmHGCU4mJVEeDuZgEK8KYmVValF+fFFpTmpxYcYTYF+mMgs
        JZqcD4zRvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjJWr9/K4
        aYWItWhblL8V///h6teprhcuWucH//dewHlHe6Lfo0YeJp9tT0rXSJi5vuSbp+yTt/Hu3I39
        pVV9C9bxPZ5bGPBPzXzZmqwFdk/exshsmnatVM5qtyXDxuNhoiuXF27qezPHgtF8wl+HDeVW
        4qpfm1sXLrFvPqT3Ur1LVuMXg55RpRJLcUaioRZzUXEiAADOLQyZAgAA
X-CMS-MailID: 20200128133416eucas1p1eb121384be2323aed1fc63a6d1ebe14f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133416eucas1p1eb121384be2323aed1fc63a6d1ebe14f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133416eucas1p1eb121384be2323aed1fc63a6d1ebe14f
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133416eucas1p1eb121384be2323aed1fc63a6d1ebe14f@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

* move ata_sstatus_online() to libata.h and make it inline

* move sata_down_spd_limit() to libata-core-sata.c

* add static inline for CONFIG_SATA_HOST=n case

Code size savings on m68k arch using atari_defconfig:

   text    data     bss     dec     hex filename
before:
  35276     572      40   35888    8c30 drivers/ata/libata-core.o
after:
  34996     572      40   35608    8b18 drivers/ata/libata-core.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core-sata.c | 80 ++++++++++++++++++++++++++++++++
 drivers/ata/libata-core.c      | 85 ----------------------------------
 drivers/ata/libata.h           | 11 ++++-
 3 files changed, 90 insertions(+), 86 deletions(-)

diff --git a/drivers/ata/libata-core-sata.c b/drivers/ata/libata-core-sata.c
index 8ad8f97660df..fb956c8aee9a 100644
--- a/drivers/ata/libata-core-sata.c
+++ b/drivers/ata/libata-core-sata.c
@@ -285,6 +285,86 @@ void sata_print_link_status(struct ata_link *link)
 	}
 }
 
+/**
+ *	sata_down_spd_limit - adjust SATA spd limit downward
+ *	@link: Link to adjust SATA spd limit for
+ *	@spd_limit: Additional limit
+ *
+ *	Adjust SATA spd limit of @link downward.  Note that this
+ *	function only adjusts the limit.  The change must be applied
+ *	using sata_set_spd().
+ *
+ *	If @spd_limit is non-zero, the speed is limited to equal to or
+ *	lower than @spd_limit if such speed is supported.  If
+ *	@spd_limit is slower than any supported speed, only the lowest
+ *	supported speed is allowed.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ *
+ *	RETURNS:
+ *	0 on success, negative errno on failure
+ */
+int sata_down_spd_limit(struct ata_link *link, u32 spd_limit)
+{
+	u32 sstatus, spd, mask;
+	int rc, bit;
+
+	if (!sata_scr_valid(link))
+		return -EOPNOTSUPP;
+
+	/* If SCR can be read, use it to determine the current SPD.
+	 * If not, use cached value in link->sata_spd.
+	 */
+	rc = sata_scr_read(link, SCR_STATUS, &sstatus);
+	if (rc == 0 && ata_sstatus_online(sstatus))
+		spd = (sstatus >> 4) & 0xf;
+	else
+		spd = link->sata_spd;
+
+	mask = link->sata_spd_limit;
+	if (mask <= 1)
+		return -EINVAL;
+
+	/* unconditionally mask off the highest bit */
+	bit = fls(mask) - 1;
+	mask &= ~(1 << bit);
+
+	/*
+	 * Mask off all speeds higher than or equal to the current one.  At
+	 * this point, if current SPD is not available and we previously
+	 * recorded the link speed from SStatus, the driver has already
+	 * masked off the highest bit so mask should already be 1 or 0.
+	 * Otherwise, we should not force 1.5Gbps on a link where we have
+	 * not previously recorded speed from SStatus.  Just return in this
+	 * case.
+	 */
+	if (spd > 1)
+		mask &= (1 << (spd - 1)) - 1;
+	else
+		return -EINVAL;
+
+	/* were we already at the bottom? */
+	if (!mask)
+		return -EINVAL;
+
+	if (spd_limit) {
+		if (mask & ((1 << spd_limit) - 1))
+			mask &= (1 << spd_limit) - 1;
+		else {
+			bit = ffs(mask) - 1;
+			mask = 1 << bit;
+		}
+	}
+
+	link->sata_spd_limit = mask;
+
+	ata_link_warn(link, "limiting SATA link speed to %s\n",
+		      sata_spd_string(fls(mask)));
+
+	return 0;
+}
+
 /**
  *	sata_link_scr_lpm - manipulate SControl IPM and SPM fields
  *	@link: ATA link to manipulate SControl for
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 73f732a32261..1d0744f18754 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -167,11 +167,6 @@ MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
 
-static bool ata_sstatus_online(u32 sstatus)
-{
-	return (sstatus & 0xf) == 0x3;
-}
-
 /**
  *	ata_link_next - link iteration helper
  *	@link: the previous link, NULL to start
@@ -2760,86 +2755,6 @@ struct ata_device *ata_dev_pair(struct ata_device *adev)
 }
 EXPORT_SYMBOL_GPL(ata_dev_pair);
 
-/**
- *	sata_down_spd_limit - adjust SATA spd limit downward
- *	@link: Link to adjust SATA spd limit for
- *	@spd_limit: Additional limit
- *
- *	Adjust SATA spd limit of @link downward.  Note that this
- *	function only adjusts the limit.  The change must be applied
- *	using sata_set_spd().
- *
- *	If @spd_limit is non-zero, the speed is limited to equal to or
- *	lower than @spd_limit if such speed is supported.  If
- *	@spd_limit is slower than any supported speed, only the lowest
- *	supported speed is allowed.
- *
- *	LOCKING:
- *	Inherited from caller.
- *
- *	RETURNS:
- *	0 on success, negative errno on failure
- */
-int sata_down_spd_limit(struct ata_link *link, u32 spd_limit)
-{
-	u32 sstatus, spd, mask;
-	int rc, bit;
-
-	if (!sata_scr_valid(link))
-		return -EOPNOTSUPP;
-
-	/* If SCR can be read, use it to determine the current SPD.
-	 * If not, use cached value in link->sata_spd.
-	 */
-	rc = sata_scr_read(link, SCR_STATUS, &sstatus);
-	if (rc == 0 && ata_sstatus_online(sstatus))
-		spd = (sstatus >> 4) & 0xf;
-	else
-		spd = link->sata_spd;
-
-	mask = link->sata_spd_limit;
-	if (mask <= 1)
-		return -EINVAL;
-
-	/* unconditionally mask off the highest bit */
-	bit = fls(mask) - 1;
-	mask &= ~(1 << bit);
-
-	/*
-	 * Mask off all speeds higher than or equal to the current one.  At
-	 * this point, if current SPD is not available and we previously
-	 * recorded the link speed from SStatus, the driver has already
-	 * masked off the highest bit so mask should already be 1 or 0.
-	 * Otherwise, we should not force 1.5Gbps on a link where we have
-	 * not previously recorded speed from SStatus.  Just return in this
-	 * case.
-	 */
-	if (spd > 1)
-		mask &= (1 << (spd - 1)) - 1;
-	else
-		return -EINVAL;
-
-	/* were we already at the bottom? */
-	if (!mask)
-		return -EINVAL;
-
-	if (spd_limit) {
-		if (mask & ((1 << spd_limit) - 1))
-			mask &= (1 << spd_limit) - 1;
-		else {
-			bit = ffs(mask) - 1;
-			mask = 1 << bit;
-		}
-	}
-
-	link->sata_spd_limit = mask;
-
-	ata_link_warn(link, "limiting SATA link speed to %s\n",
-		      sata_spd_string(fls(mask)));
-
-	return 0;
-}
-
 static int __sata_set_spd_needed(struct ata_link *link, u32 *scontrol)
 {
 	struct ata_link *host_link = &link->ap->link;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 909c2cae52a0..518a8e08a26d 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -64,7 +64,6 @@ extern int ata_dev_reread_id(struct ata_device *dev, unsigned int readid_flags);
 extern int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
 			      unsigned int readid_flags);
 extern int ata_dev_configure(struct ata_device *dev);
-extern int sata_down_spd_limit(struct ata_link *link, u32 spd_limit);
 extern int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel);
 extern unsigned int ata_dev_set_feature(struct ata_device *dev,
 					u8 enable, u8 feature);
@@ -87,6 +86,11 @@ extern void __ata_port_probe(struct ata_port *ap);
 extern unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 				      u8 page, void *buf, unsigned int sectors);
 
+static inline bool ata_sstatus_online(u32 sstatus)
+{
+	return (sstatus & 0xf) == 0x3;
+}
+
 static inline bool ata_log_supported(struct ata_device *dev, u8 log)
 {
 	struct ata_port *ap = dev->link->ap;
@@ -103,6 +107,7 @@ static inline bool ata_log_supported(struct ata_device *dev, u8 log)
 int ata_do_link_spd_horkage(struct ata_device *dev);
 int ata_dev_config_ncq(struct ata_device *dev, char *desc, size_t desc_sz);
 void sata_print_link_status(struct ata_link *link);
+int sata_down_spd_limit(struct ata_link *link, u32 spd_limit);
 #else
 static inline int ata_do_link_spd_horkage(struct ata_device *dev) { return 0; }
 static inline int ata_dev_config_ncq(struct ata_device *dev, char *desc,
@@ -112,6 +117,10 @@ static inline int ata_dev_config_ncq(struct ata_device *dev, char *desc,
 	return 0;
 }
 static inline void sata_print_link_status(struct ata_link *link) { }
+static inline int sata_down_spd_limit(struct ata_link *link, u32 spd_limit)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 /* libata-acpi.c */
-- 
2.24.1

