Return-Path: <SRS0=ljer=4P=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D796FC35E1F
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7E5246AE
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KZIm0HVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730981AbgB0SXW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:23:22 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59063 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731000AbgB0SWv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Feb 2020 13:22:51 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200227182249euoutp024b7b0057312b5d84e3c776f900d87f78~3VXhkSlpo0716607166euoutp02q
        for <linux-ide@vger.kernel.org>; Thu, 27 Feb 2020 18:22:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200227182249euoutp024b7b0057312b5d84e3c776f900d87f78~3VXhkSlpo0716607166euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582827769;
        bh=gZO8awiK7kH8eFJRB9zG2w/BhF1oQWwLfwiRBkAy9do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KZIm0HVbptf8WkCl09sZHNIGBPzur7sWNi0kbVDVDT1aXzDwxZJVT9VBsm86JfcLZ
         AJFmvkq2Rwu/QKnLAgd0pm0oMJUNIUKpZHh4JfIS4pVBnU34L7yK/62iY5Mb5HoY0Q
         S5HtDIrmu2GnGMrX1ZYz9KApFQjgakCfN8q1o9Ak=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200227182249eucas1p2a39b2fcf88bce9f91d0a767d2258b560~3VXhSplw53195531955eucas1p2J;
        Thu, 27 Feb 2020 18:22:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 7A.05.60698.9F8085E5; Thu, 27
        Feb 2020 18:22:49 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182248eucas1p296773cdb2ab7ae9f4114f7052ff08414~3VXggZ1gP3196231962eucas1p2J;
        Thu, 27 Feb 2020 18:22:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200227182248eusmtrp27cf5eeb2555186c6f343746e14447a53~3VXgf36eu1813218132eusmtrp2v;
        Thu, 27 Feb 2020 18:22:48 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-08-5e5808f9f085
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 03.C1.08375.8F8085E5; Thu, 27
        Feb 2020 18:22:48 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182247eusmtip2b89f3c4e861b8f74f3e97b7cfeeed142~3VXgCVRtY1203512035eusmtip2R;
        Thu, 27 Feb 2020 18:22:47 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v3 20/27] ata: move sata_link_hardreset() to libata-sata.c
Date:   Thu, 27 Feb 2020 19:22:19 +0100
Message-Id: <20200227182226.19188-21-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227182226.19188-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djP87o/OSLiDCZ857FYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBlb/79hLfgVWtHS+J25gXG7SxcjJ4eE
        gInE3p4rbF2MXBxCAisYJe70v2aBcL4wSnTtP8UE4XxmlDiy+zZQhgOspfeKLER8OaPEqptr
        2OA6zl29xwIyl03ASmJi+ypGEFtEQEGi5/dKsCJmgfeMEism7QUrEhbwkth1eB+YzSKgKtFz
        rQesgVfATmL/wivMEAfKS2z99okVxOYEit/o284GUSMocXLmE7BeZqCa5q2zmUEWSAgsY5d4
        tXkPK0Szi8SHVzsYIWxhiVfHt7BD2DIS/3fOZ4JoWMco8bfjBVT3dkaJ5ZP/sUFUWUvcOfeL
        DeRpZgFNifW79CH+d5TofCgIYfJJ3HgrCHEDn8SkbdOZIcK8Eh1tQhAz1CQ2LNvABrO1a+dK
        qLc8JLoufWefwKg4C8k3s5B8Mwth7QJG5lWM4qmlxbnpqcXGeanlesWJucWleel6yfm5mxiB
        iej0v+NfdzDu+5N0iFGAg1GJh3fBjvA4IdbEsuLK3EOMEhzMSiK8G7+GxgnxpiRWVqUW5ccX
        leakFh9ilOZgURLnNV70MlZIID2xJDU7NbUgtQgmy8TBKdXAeNX1dYrAyt6fMtVyz6RLP2R8
        MEr9tUBN6+hV3dpXyd/nvizjfM7xfuH8Qw5rT5U5c2966dTanListWn961TeihXy3qedQnc+
        2f2m6Mz8SZFNuo/rOrIqN6eKepWIHLrZFSkW5vcq132G+vGe6yf4JmhdcZITrW9rTXvYk82U
        sqi296WT3qZ3SizFGYmGWsxFxYkAHvnqUUADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xe7o/OCLiDD5flrBYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehlb/79hLfgVWtHS+J25gXG7SxcjB4eEgIlE7xXZLkYuDiGBpYwS6/f8
        YIOIy0gcX1/WxcgJZApL/LnWxQZiCwl8YpR4f8UKxGYTsJKY2L6KEcQWEVCQ6Pm9kg1kDrPA
        V0aJpZO6mUESwgJeErsO72MBsVkEVCV6rvWANfAK2EnsX3iFGWKBvMTWb59YQWxOoPiNvu1Q
        y2wlujqeQtULSpyc+QRsDjNQffPW2cwTGAVmIUnNQpJawMi0ilEktbQ4Nz232FCvODG3uDQv
        XS85P3cTIzBath37uXkH46WNwYcYBTgYlXh4F+wIjxNiTSwrrsw9xCjBwawkwrvxa2icEG9K
        YmVValF+fFFpTmrxIUZToCcmMkuJJucDIzmvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJ
        anZqakFqEUwfEwenVANjC+P1G123fSLKbe+Kr+CouRAivYGraObeE3tsWnle6W5Q3cDyOc9W
        SruteM0BeWZRXX7Jkx7MTDaSpyaLfdaZeUnov8xFS+/Ak6cbH6r/9OjuPPu79ubVzLcxfrW1
        nlxWqjJH67dpGX6Y+8R8WWud85Tr4ncXanypNvvJmPb330ITeY3dtjOVWIozEg21mIuKEwFM
        cT3XrAIAAA==
X-CMS-MailID: 20200227182248eucas1p296773cdb2ab7ae9f4114f7052ff08414
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200227182248eucas1p296773cdb2ab7ae9f4114f7052ff08414
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200227182248eucas1p296773cdb2ab7ae9f4114f7052ff08414
References: <20200227182226.19188-1-b.zolnierkie@samsung.com>
        <CGME20200227182248eucas1p296773cdb2ab7ae9f4114f7052ff08414@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

* move sata_link_hardreset() to libata-sata.c

* add static inline for CONFIG_SATA_HOST=n case

* make sata_set_spd_needed() static

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  32724     572      40   33336    8238 drivers/ata/libata-core.o
after:
  32559     572      40   33171    8193 drivers/ata/libata-core.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 113 -------------------------------------
 drivers/ata/libata-sata.c | 115 +++++++++++++++++++++++++++++++++++++-
 drivers/ata/libata.h      |   7 ---
 include/linux/libata.h    |  16 +++++-
 4 files changed, 127 insertions(+), 124 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4ca81ef7c8bd..19624d056d92 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3531,119 +3531,6 @@ int ata_std_prereset(struct ata_link *link, unsigned long deadline)
 }
 EXPORT_SYMBOL_GPL(ata_std_prereset);
 
-/**
- *	sata_link_hardreset - reset link via SATA phy reset
- *	@link: link to reset
- *	@timing: timing parameters { interval, duration, timeout } in msec
- *	@deadline: deadline jiffies for the operation
- *	@online: optional out parameter indicating link onlineness
- *	@check_ready: optional callback to check link readiness
- *
- *	SATA phy-reset @link using DET bits of SControl register.
- *	After hardreset, link readiness is waited upon using
- *	ata_wait_ready() if @check_ready is specified.  LLDs are
- *	allowed to not specify @check_ready and wait itself after this
- *	function returns.  Device classification is LLD's
- *	responsibility.
- *
- *	*@online is set to one iff reset succeeded and @link is online
- *	after reset.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep)
- *
- *	RETURNS:
- *	0 on success, -errno otherwise.
- */
-int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
-			unsigned long deadline,
-			bool *online, int (*check_ready)(struct ata_link *))
-{
-	u32 scontrol;
-	int rc;
-
-	DPRINTK("ENTER\n");
-
-	if (online)
-		*online = false;
-
-	if (sata_set_spd_needed(link)) {
-		/* SATA spec says nothing about how to reconfigure
-		 * spd.  To be on the safe side, turn off phy during
-		 * reconfiguration.  This works for at least ICH7 AHCI
-		 * and Sil3124.
-		 */
-		if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
-			goto out;
-
-		scontrol = (scontrol & 0x0f0) | 0x304;
-
-		if ((rc = sata_scr_write(link, SCR_CONTROL, scontrol)))
-			goto out;
-
-		sata_set_spd(link);
-	}
-
-	/* issue phy wake/reset */
-	if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
-		goto out;
-
-	scontrol = (scontrol & 0x0f0) | 0x301;
-
-	if ((rc = sata_scr_write_flush(link, SCR_CONTROL, scontrol)))
-		goto out;
-
-	/* Couldn't find anything in SATA I/II specs, but AHCI-1.1
-	 * 10.4.2 says at least 1 ms.
-	 */
-	ata_msleep(link->ap, 1);
-
-	/* bring link back */
-	rc = sata_link_resume(link, timing, deadline);
-	if (rc)
-		goto out;
-	/* if link is offline nothing more to do */
-	if (ata_phys_link_offline(link))
-		goto out;
-
-	/* Link is online.  From this point, -ENODEV too is an error. */
-	if (online)
-		*online = true;
-
-	if (sata_pmp_supported(link->ap) && ata_is_host_link(link)) {
-		/* If PMP is supported, we have to do follow-up SRST.
-		 * Some PMPs don't send D2H Reg FIS after hardreset if
-		 * the first port is empty.  Wait only for
-		 * ATA_TMOUT_PMP_SRST_WAIT.
-		 */
-		if (check_ready) {
-			unsigned long pmp_deadline;
-
-			pmp_deadline = ata_deadline(jiffies,
-						    ATA_TMOUT_PMP_SRST_WAIT);
-			if (time_after(pmp_deadline, deadline))
-				pmp_deadline = deadline;
-			ata_wait_ready(link, pmp_deadline, check_ready);
-		}
-		rc = -EAGAIN;
-		goto out;
-	}
-
-	rc = 0;
-	if (check_ready)
-		rc = ata_wait_ready(link, deadline, check_ready);
- out:
-	if (rc && rc != -EAGAIN) {
-		/* online is set iff link is online && reset succeeded */
-		if (online)
-			*online = false;
-		ata_link_err(link, "COMRESET failed (errno=%d)\n", rc);
-	}
-	DPRINTK("EXIT, rc=%d\n", rc);
-	return rc;
-}
-EXPORT_SYMBOL_GPL(sata_link_hardreset);
-
 /**
  *	sata_std_hardreset - COMRESET w/o waiting or classification
  *	@link: link to reset
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 34852fced999..05a1872ba329 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -449,7 +449,7 @@ static int __sata_set_spd_needed(struct ata_link *link, u32 *scontrol)
  *	RETURNS:
  *	1 if SATA spd configuration is needed, 0 otherwise.
  */
-int sata_set_spd_needed(struct ata_link *link)
+static int sata_set_spd_needed(struct ata_link *link)
 {
 	u32 scontrol;
 
@@ -490,6 +490,119 @@ int sata_set_spd(struct ata_link *link)
 }
 EXPORT_SYMBOL_GPL(sata_set_spd);
 
+/**
+ *	sata_link_hardreset - reset link via SATA phy reset
+ *	@link: link to reset
+ *	@timing: timing parameters { interval, duration, timeout } in msec
+ *	@deadline: deadline jiffies for the operation
+ *	@online: optional out parameter indicating link onlineness
+ *	@check_ready: optional callback to check link readiness
+ *
+ *	SATA phy-reset @link using DET bits of SControl register.
+ *	After hardreset, link readiness is waited upon using
+ *	ata_wait_ready() if @check_ready is specified.  LLDs are
+ *	allowed to not specify @check_ready and wait itself after this
+ *	function returns.  Device classification is LLD's
+ *	responsibility.
+ *
+ *	*@online is set to one iff reset succeeded and @link is online
+ *	after reset.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
+			unsigned long deadline,
+			bool *online, int (*check_ready)(struct ata_link *))
+{
+	u32 scontrol;
+	int rc;
+
+	DPRINTK("ENTER\n");
+
+	if (online)
+		*online = false;
+
+	if (sata_set_spd_needed(link)) {
+		/* SATA spec says nothing about how to reconfigure
+		 * spd.  To be on the safe side, turn off phy during
+		 * reconfiguration.  This works for at least ICH7 AHCI
+		 * and Sil3124.
+		 */
+		if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
+			goto out;
+
+		scontrol = (scontrol & 0x0f0) | 0x304;
+
+		if ((rc = sata_scr_write(link, SCR_CONTROL, scontrol)))
+			goto out;
+
+		sata_set_spd(link);
+	}
+
+	/* issue phy wake/reset */
+	if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
+		goto out;
+
+	scontrol = (scontrol & 0x0f0) | 0x301;
+
+	if ((rc = sata_scr_write_flush(link, SCR_CONTROL, scontrol)))
+		goto out;
+
+	/* Couldn't find anything in SATA I/II specs, but AHCI-1.1
+	 * 10.4.2 says at least 1 ms.
+	 */
+	ata_msleep(link->ap, 1);
+
+	/* bring link back */
+	rc = sata_link_resume(link, timing, deadline);
+	if (rc)
+		goto out;
+	/* if link is offline nothing more to do */
+	if (ata_phys_link_offline(link))
+		goto out;
+
+	/* Link is online.  From this point, -ENODEV too is an error. */
+	if (online)
+		*online = true;
+
+	if (sata_pmp_supported(link->ap) && ata_is_host_link(link)) {
+		/* If PMP is supported, we have to do follow-up SRST.
+		 * Some PMPs don't send D2H Reg FIS after hardreset if
+		 * the first port is empty.  Wait only for
+		 * ATA_TMOUT_PMP_SRST_WAIT.
+		 */
+		if (check_ready) {
+			unsigned long pmp_deadline;
+
+			pmp_deadline = ata_deadline(jiffies,
+						    ATA_TMOUT_PMP_SRST_WAIT);
+			if (time_after(pmp_deadline, deadline))
+				pmp_deadline = deadline;
+			ata_wait_ready(link, pmp_deadline, check_ready);
+		}
+		rc = -EAGAIN;
+		goto out;
+	}
+
+	rc = 0;
+	if (check_ready)
+		rc = ata_wait_ready(link, deadline, check_ready);
+ out:
+	if (rc && rc != -EAGAIN) {
+		/* online is set iff link is online && reset succeeded */
+		if (online)
+			*online = false;
+		ata_link_err(link, "COMRESET failed (errno=%d)\n", rc);
+	}
+	DPRINTK("EXIT, rc=%d\n", rc);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(sata_link_hardreset);
+
 /**
  *	ata_slave_link_init - initialize slave link
  *	@ap: port to initialize slave link for
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 53b45ebe3d55..cd8090ad43e5 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -87,13 +87,6 @@ extern unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 
 #define to_ata_port(d) container_of(d, struct ata_port, tdev)
 
-/* libata-sata.c */
-#ifdef CONFIG_SATA_HOST
-int sata_set_spd_needed(struct ata_link *link);
-#else
-static inline int sata_set_spd_needed(struct ata_link *link) { return 1; }
-#endif
-
 /* libata-acpi.c */
 #ifdef CONFIG_ATA_ACPI
 extern unsigned int ata_acpi_gtf_filter;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3981e413f582..bf13af0c47ae 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1079,9 +1079,6 @@ static inline int ata_port_is_dummy(struct ata_port *ap)
 extern int ata_std_prereset(struct ata_link *link, unsigned long deadline);
 extern int ata_wait_after_reset(struct ata_link *link, unsigned long deadline,
 				int (*check_ready)(struct ata_link *link));
-extern int sata_link_hardreset(struct ata_link *link,
-			const unsigned long *timing, unsigned long deadline,
-			bool *online, int (*check_ready)(struct ata_link *));
 extern int sata_std_hardreset(struct ata_link *link, unsigned int *class,
 			      unsigned long deadline);
 extern void ata_std_postreset(struct ata_link *link, unsigned int *classes);
@@ -1192,6 +1189,9 @@ extern int sata_scr_read(struct ata_link *link, int reg, u32 *val);
 extern int sata_scr_write(struct ata_link *link, int reg, u32 val);
 extern int sata_scr_write_flush(struct ata_link *link, int reg, u32 val);
 extern int sata_set_spd(struct ata_link *link);
+extern int sata_link_hardreset(struct ata_link *link,
+			const unsigned long *timing, unsigned long deadline,
+			bool *online, int (*check_ready)(struct ata_link *));
 extern int sata_link_resume(struct ata_link *link, const unsigned long *params,
 			    unsigned long deadline);
 #else
@@ -1209,6 +1209,16 @@ static inline int sata_scr_write_flush(struct ata_link *link, int reg, u32 val)
 	return -EOPNOTSUPP;
 }
 static inline int sata_set_spd(struct ata_link *link) { return -EOPNOTSUPP; }
+static inline int sata_link_hardreset(struct ata_link *link,
+				      const unsigned long *timing,
+				      unsigned long deadline,
+				      bool *online,
+				      int (*check_ready)(struct ata_link *))
+{
+	if (online)
+		*online = false;
+	return -EOPNOTSUPP;
+}
 static inline int sata_link_resume(struct ata_link *link,
 				   const unsigned long *params,
 				   unsigned long deadline)
-- 
2.24.1

