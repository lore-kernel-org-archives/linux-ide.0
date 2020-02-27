Return-Path: <SRS0=ljer=4P=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55286C35DF9
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B85246AF
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aqzmEJ9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbgB0SXW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:23:22 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39762 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730996AbgB0SWv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Feb 2020 13:22:51 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200227182249euoutp01a9a13b01336f7408d7331e4faad06d95~3VXhYgt511216412164euoutp01s
        for <linux-ide@vger.kernel.org>; Thu, 27 Feb 2020 18:22:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200227182249euoutp01a9a13b01336f7408d7331e4faad06d95~3VXhYgt511216412164euoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582827769;
        bh=qZc+1z8aEsuZgC/7xIoQGDGXodgEe24TIW2Biw06J8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aqzmEJ9eTBbKx3EBqR0TJ0d1O6K9tdzkXGm5VHdR3UPkLhCzeb+ffKZ2avYycL7yC
         lc5lX24NaY3rd5lOazwrvf48daUD0Bd4AbvVIIIb4QCKaqMjpKAINkN3GMhKdO1BEi
         njhAq/HDjgWdfmXWa2tl7WP6xx7Kb3QIH4aPJ0mw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200227182249eucas1p146771d9a1692f0aa54c90b45833cc701~3VXhFfr7G1935419354eucas1p1w;
        Thu, 27 Feb 2020 18:22:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 56.5F.61286.9F8085E5; Thu, 27
        Feb 2020 18:22:49 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200227182248eucas1p12ce0e7ce8d0653085591eea64604c656~3VXgI7HER1937419374eucas1p18;
        Thu, 27 Feb 2020 18:22:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200227182248eusmtrp19d3bca1865eb2ce454c89a8893129811~3VXgITw7m0185901859eusmtrp1j;
        Thu, 27 Feb 2020 18:22:48 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-6b-5e5808f9b25d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 86.61.07950.7F8085E5; Thu, 27
        Feb 2020 18:22:47 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182247eusmtip2726c143df8e81863deb90b57d166b8fb~3VXflW8oe0595905959eusmtip2o;
        Thu, 27 Feb 2020 18:22:47 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v3 19/27] ata: move sata_link_{debounce,resume}() to
 libata-sata.c
Date:   Thu, 27 Feb 2020 19:22:18 +0100
Message-Id: <20200227182226.19188-20-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227182226.19188-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djPc7o/OSLiDC4+ZbZYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBm/5pxmLFgfVTHpRlID4073LkZODgkB
        E4nNp3+wgthCAisYJX68jepi5AKyvzBKfNv+lBnC+cwocW9lMxtMx4xln6ASyxkl2q5vZYdo
        B2o5M0EFxGYTsJKY2L6KEcQWEVCQ6Pm9kg2kgVngPaPEikl7WUASwgIhEkdefGACsVkEVCVe
        7/4EFucVsJPYsKGDEWKbvMTWb5/A7uMEit/o284GUSMocXLmE7B6ZqCa5q2zwS6SEFjFLrH7
        /1RWiGYXibbHl1ggbGGJV8e3sEPYMhKnJ/ewQDSsY5T42/ECqns7o8Tyyf+gHrWWuHPuF5DN
        AbRCU2L9Ln2IsKPEpL9d7CBhCQE+iRtvBSGO4JOYtG06M0SYV6KjTQiiWk1iw7INbDBru3au
        ZIawPSQ+3V/ONoFRcRaSd2YheWcWwt4FjMyrGMVTS4tz01OLDfNSy/WKE3OLS/PS9ZLzczcx
        AtPQ6X/HP+1g/Hop6RCjAAejEg/vgh3hcUKsiWXFlbmHGCU4mJVEeDd+DY0T4k1JrKxKLcqP
        LyrNSS0+xCjNwaIkzmu86GWskEB6YklqdmpqQWoRTJaJg1OqgbGw7vzhw1u1fa1jvj/792af
        4hMpRdMbjIKH/x7ak3X7mC37G43nWteDpqb1CzG/jTp+KnmT0I4Zq2/07y20Mdgzqfwxm/bF
        unzhjJXdvS8SYprK5J/LW607vuuP3A0Gu4DjQjM/aCUvStnFcvzWJW5npyu7JlX2OsQvKyle
        vmEb/5TJs/9yet5WYinOSDTUYi4qTgQAP7lEKj8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xe7rfOSLiDKYdtLJYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehm/5pxmLFgfVTHpRlID4073LkZODgkBE4kZyz4xdzFycQgJLGWU+PPk
        I0sXIwdQQkbi+PoyiBphiT/Xutggaj4xSsxeuIAdJMEmYCUxsX0VI4gtIqAg0fN7JVgRs8BX
        Romlk7qZQRLCAkESW/vnMYHYLAKqEq93f2IBsXkF7CQ2bOhghNggL7H12ydWEJsTKH6jbzsb
        iC0kYCvR1fGUEaJeUOLkzCdgvcxA9c1bZzNPYBSYhSQ1C0lqASPTKkaR1NLi3PTcYiO94sTc
        4tK8dL3k/NxNjMB42Xbs55YdjF3vgg8xCnAwKvHwemwLjxNiTSwrrsw9xCjBwawkwrvxa2ic
        EG9KYmVValF+fFFpTmrxIUZToCcmMkuJJucDYzmvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBA
        emJJanZqakFqEUwfEwenVAPj7MV3ZE8t7ltrYZP26R/z3sjzi6ZvzztccUuLS+pe9mGvdu89
        cq/2uIfllXVPv3BPJpzJ/Et3cc6t6rjlK7+IByaVK0Yf5j7y6ZnEWYUJ7ew7o16IyOesOKFp
        9aztROUabfW8mzKTZ7ZElYW1ZydJqdi9exfmXijkUi6yffmvDSfXe6m5l31QYinOSDTUYi4q
        TgQAqUofo60CAAA=
X-CMS-MailID: 20200227182248eucas1p12ce0e7ce8d0653085591eea64604c656
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200227182248eucas1p12ce0e7ce8d0653085591eea64604c656
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200227182248eucas1p12ce0e7ce8d0653085591eea64604c656
References: <20200227182226.19188-1-b.zolnierkie@samsung.com>
        <CGME20200227182248eucas1p12ce0e7ce8d0653085591eea64604c656@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

* move sata_link_{debounce,resume}() to libata-sata.c

* add static inline for CONFIG_SATA_HOST=n case (only one,
  for sata_link_resume() is needed)

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  32816     572      40   33428    8294 drivers/ata/libata-core.o
after:
  32724     572      40   33336    8238 drivers/ata/libata-core.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 138 --------------------------------------
 drivers/ata/libata-sata.c | 138 ++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h    |  14 ++--
 3 files changed, 148 insertions(+), 142 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 13214ebd0e5c..4ca81ef7c8bd 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3485,144 +3485,6 @@ int ata_wait_after_reset(struct ata_link *link, unsigned long deadline,
 }
 EXPORT_SYMBOL_GPL(ata_wait_after_reset);
 
-/**
- *	sata_link_debounce - debounce SATA phy status
- *	@link: ATA link to debounce SATA phy status for
- *	@params: timing parameters { interval, duration, timeout } in msec
- *	@deadline: deadline jiffies for the operation
- *
- *	Make sure SStatus of @link reaches stable state, determined by
- *	holding the same value where DET is not 1 for @duration polled
- *	every @interval, before @timeout.  Timeout constraints the
- *	beginning of the stable state.  Because DET gets stuck at 1 on
- *	some controllers after hot unplugging, this functions waits
- *	until timeout then returns 0 if DET is stable at 1.
- *
- *	@timeout is further limited by @deadline.  The sooner of the
- *	two is used.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep)
- *
- *	RETURNS:
- *	0 on success, -errno on failure.
- */
-int sata_link_debounce(struct ata_link *link, const unsigned long *params,
-		       unsigned long deadline)
-{
-	unsigned long interval = params[0];
-	unsigned long duration = params[1];
-	unsigned long last_jiffies, t;
-	u32 last, cur;
-	int rc;
-
-	t = ata_deadline(jiffies, params[2]);
-	if (time_before(t, deadline))
-		deadline = t;
-
-	if ((rc = sata_scr_read(link, SCR_STATUS, &cur)))
-		return rc;
-	cur &= 0xf;
-
-	last = cur;
-	last_jiffies = jiffies;
-
-	while (1) {
-		ata_msleep(link->ap, interval);
-		if ((rc = sata_scr_read(link, SCR_STATUS, &cur)))
-			return rc;
-		cur &= 0xf;
-
-		/* DET stable? */
-		if (cur == last) {
-			if (cur == 1 && time_before(jiffies, deadline))
-				continue;
-			if (time_after(jiffies,
-				       ata_deadline(last_jiffies, duration)))
-				return 0;
-			continue;
-		}
-
-		/* unstable, start over */
-		last = cur;
-		last_jiffies = jiffies;
-
-		/* Check deadline.  If debouncing failed, return
-		 * -EPIPE to tell upper layer to lower link speed.
-		 */
-		if (time_after(jiffies, deadline))
-			return -EPIPE;
-	}
-}
-EXPORT_SYMBOL_GPL(sata_link_debounce);
-
-/**
- *	sata_link_resume - resume SATA link
- *	@link: ATA link to resume SATA
- *	@params: timing parameters { interval, duration, timeout } in msec
- *	@deadline: deadline jiffies for the operation
- *
- *	Resume SATA phy @link and debounce it.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep)
- *
- *	RETURNS:
- *	0 on success, -errno on failure.
- */
-int sata_link_resume(struct ata_link *link, const unsigned long *params,
-		     unsigned long deadline)
-{
-	int tries = ATA_LINK_RESUME_TRIES;
-	u32 scontrol, serror;
-	int rc;
-
-	if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
-		return rc;
-
-	/*
-	 * Writes to SControl sometimes get ignored under certain
-	 * controllers (ata_piix SIDPR).  Make sure DET actually is
-	 * cleared.
-	 */
-	do {
-		scontrol = (scontrol & 0x0f0) | 0x300;
-		if ((rc = sata_scr_write(link, SCR_CONTROL, scontrol)))
-			return rc;
-		/*
-		 * Some PHYs react badly if SStatus is pounded
-		 * immediately after resuming.  Delay 200ms before
-		 * debouncing.
-		 */
-		if (!(link->flags & ATA_LFLAG_NO_DB_DELAY))
-			ata_msleep(link->ap, 200);
-
-		/* is SControl restored correctly? */
-		if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
-			return rc;
-	} while ((scontrol & 0xf0f) != 0x300 && --tries);
-
-	if ((scontrol & 0xf0f) != 0x300) {
-		ata_link_warn(link, "failed to resume link (SControl %X)\n",
-			     scontrol);
-		return 0;
-	}
-
-	if (tries < ATA_LINK_RESUME_TRIES)
-		ata_link_warn(link, "link resume succeeded after %d retries\n",
-			      ATA_LINK_RESUME_TRIES - tries);
-
-	if ((rc = sata_link_debounce(link, params, deadline)))
-		return rc;
-
-	/* clear SError, some PHYs require this even for SRST to work */
-	if (!(rc = sata_scr_read(link, SCR_ERROR, &serror)))
-		rc = sata_scr_write(link, SCR_ERROR, serror);
-
-	return rc != -EINVAL ? rc : 0;
-}
-EXPORT_SYMBOL_GPL(sata_link_resume);
-
 /**
  *	ata_std_prereset - prepare for reset
  *	@link: ATA link to be reset
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index d66afdc33d54..34852fced999 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -196,6 +196,144 @@ void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf)
 }
 EXPORT_SYMBOL_GPL(ata_tf_from_fis);
 
+/**
+ *	sata_link_debounce - debounce SATA phy status
+ *	@link: ATA link to debounce SATA phy status for
+ *	@params: timing parameters { interval, duration, timeout } in msec
+ *	@deadline: deadline jiffies for the operation
+ *
+ *	Make sure SStatus of @link reaches stable state, determined by
+ *	holding the same value where DET is not 1 for @duration polled
+ *	every @interval, before @timeout.  Timeout constraints the
+ *	beginning of the stable state.  Because DET gets stuck at 1 on
+ *	some controllers after hot unplugging, this functions waits
+ *	until timeout then returns 0 if DET is stable at 1.
+ *
+ *	@timeout is further limited by @deadline.  The sooner of the
+ *	two is used.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno on failure.
+ */
+int sata_link_debounce(struct ata_link *link, const unsigned long *params,
+		       unsigned long deadline)
+{
+	unsigned long interval = params[0];
+	unsigned long duration = params[1];
+	unsigned long last_jiffies, t;
+	u32 last, cur;
+	int rc;
+
+	t = ata_deadline(jiffies, params[2]);
+	if (time_before(t, deadline))
+		deadline = t;
+
+	if ((rc = sata_scr_read(link, SCR_STATUS, &cur)))
+		return rc;
+	cur &= 0xf;
+
+	last = cur;
+	last_jiffies = jiffies;
+
+	while (1) {
+		ata_msleep(link->ap, interval);
+		if ((rc = sata_scr_read(link, SCR_STATUS, &cur)))
+			return rc;
+		cur &= 0xf;
+
+		/* DET stable? */
+		if (cur == last) {
+			if (cur == 1 && time_before(jiffies, deadline))
+				continue;
+			if (time_after(jiffies,
+				       ata_deadline(last_jiffies, duration)))
+				return 0;
+			continue;
+		}
+
+		/* unstable, start over */
+		last = cur;
+		last_jiffies = jiffies;
+
+		/* Check deadline.  If debouncing failed, return
+		 * -EPIPE to tell upper layer to lower link speed.
+		 */
+		if (time_after(jiffies, deadline))
+			return -EPIPE;
+	}
+}
+EXPORT_SYMBOL_GPL(sata_link_debounce);
+
+/**
+ *	sata_link_resume - resume SATA link
+ *	@link: ATA link to resume SATA
+ *	@params: timing parameters { interval, duration, timeout } in msec
+ *	@deadline: deadline jiffies for the operation
+ *
+ *	Resume SATA phy @link and debounce it.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno on failure.
+ */
+int sata_link_resume(struct ata_link *link, const unsigned long *params,
+		     unsigned long deadline)
+{
+	int tries = ATA_LINK_RESUME_TRIES;
+	u32 scontrol, serror;
+	int rc;
+
+	if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
+		return rc;
+
+	/*
+	 * Writes to SControl sometimes get ignored under certain
+	 * controllers (ata_piix SIDPR).  Make sure DET actually is
+	 * cleared.
+	 */
+	do {
+		scontrol = (scontrol & 0x0f0) | 0x300;
+		if ((rc = sata_scr_write(link, SCR_CONTROL, scontrol)))
+			return rc;
+		/*
+		 * Some PHYs react badly if SStatus is pounded
+		 * immediately after resuming.  Delay 200ms before
+		 * debouncing.
+		 */
+		if (!(link->flags & ATA_LFLAG_NO_DB_DELAY))
+			ata_msleep(link->ap, 200);
+
+		/* is SControl restored correctly? */
+		if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
+			return rc;
+	} while ((scontrol & 0xf0f) != 0x300 && --tries);
+
+	if ((scontrol & 0xf0f) != 0x300) {
+		ata_link_warn(link, "failed to resume link (SControl %X)\n",
+			     scontrol);
+		return 0;
+	}
+
+	if (tries < ATA_LINK_RESUME_TRIES)
+		ata_link_warn(link, "link resume succeeded after %d retries\n",
+			      ATA_LINK_RESUME_TRIES - tries);
+
+	if ((rc = sata_link_debounce(link, params, deadline)))
+		return rc;
+
+	/* clear SError, some PHYs require this even for SRST to work */
+	if (!(rc = sata_scr_read(link, SCR_ERROR, &serror)))
+		rc = sata_scr_write(link, SCR_ERROR, serror);
+
+	return rc != -EINVAL ? rc : 0;
+}
+EXPORT_SYMBOL_GPL(sata_link_resume);
+
 /**
  *	sata_link_scr_lpm - manipulate SControl IPM and SPM fields
  *	@link: ATA link to manipulate SControl for
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3f0bdc2c30d3..3981e413f582 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1079,10 +1079,6 @@ static inline int ata_port_is_dummy(struct ata_port *ap)
 extern int ata_std_prereset(struct ata_link *link, unsigned long deadline);
 extern int ata_wait_after_reset(struct ata_link *link, unsigned long deadline,
 				int (*check_ready)(struct ata_link *link));
-extern int sata_link_debounce(struct ata_link *link,
-			const unsigned long *params, unsigned long deadline);
-extern int sata_link_resume(struct ata_link *link, const unsigned long *params,
-			    unsigned long deadline);
 extern int sata_link_hardreset(struct ata_link *link,
 			const unsigned long *timing, unsigned long deadline,
 			bool *online, int (*check_ready)(struct ata_link *));
@@ -1196,6 +1192,8 @@ extern int sata_scr_read(struct ata_link *link, int reg, u32 *val);
 extern int sata_scr_write(struct ata_link *link, int reg, u32 val);
 extern int sata_scr_write_flush(struct ata_link *link, int reg, u32 val);
 extern int sata_set_spd(struct ata_link *link);
+extern int sata_link_resume(struct ata_link *link, const unsigned long *params,
+			    unsigned long deadline);
 #else
 static inline int sata_scr_valid(struct ata_link *link) { return 0; }
 static inline int sata_scr_read(struct ata_link *link, int reg, u32 *val)
@@ -1211,7 +1209,15 @@ static inline int sata_scr_write_flush(struct ata_link *link, int reg, u32 val)
 	return -EOPNOTSUPP;
 }
 static inline int sata_set_spd(struct ata_link *link) { return -EOPNOTSUPP; }
+static inline int sata_link_resume(struct ata_link *link,
+				   const unsigned long *params,
+				   unsigned long deadline)
+{
+	return -EOPNOTSUPP;
+}
 #endif
+extern int sata_link_debounce(struct ata_link *link,
+			const unsigned long *params, unsigned long deadline);
 extern int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 			     bool spm_wakeup);
 extern int ata_slave_link_init(struct ata_port *ap);
-- 
2.24.1

