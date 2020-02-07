Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F1FC3B184
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0B4214AF
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JzqjqUOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgBGO2E (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:28:04 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49577 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgBGO2B (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:28:01 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142800euoutp027b39ab1d2e445bfc9c1c2162cfc1be57~xJQy5TnB52687226872euoutp02N
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:28:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200207142800euoutp027b39ab1d2e445bfc9c1c2162cfc1be57~xJQy5TnB52687226872euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085680;
        bh=Vlh1qJ37oHJJtTpN3kGf0OWpySQ/pn6VrmHHkpzu6Ds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JzqjqUOlbjK1o4Gw/zE/MN5U9aiVV7i8lMm/EEoYpzLUV7NHvUbGq0x+4xTFkn9Tm
         a6kcdO9Xg2gi8MlXtTiXw8mNLIE1IigRZX8/ctwGUYawSWeHadiy938jDEyGL++3RS
         bnrXlAukSIG9x43Vp/oFw7A6WXFI9fbGCquuwDFU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200207142800eucas1p11aca3592cc4d2fd53ef33dad342a63f5~xJQymidxo2844428444eucas1p1q;
        Fri,  7 Feb 2020 14:28:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 33.D8.60698.0F37D3E5; Fri,  7
        Feb 2020 14:28:00 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142800eucas1p2714a5e9b2ff1a6f7f714f153846d8b51~xJQySFZkG3055030550eucas1p2H;
        Fri,  7 Feb 2020 14:28:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200207142800eusmtrp22a36c6b52a35f3c420a57d980f2cf420~xJQyRgHKJ1102911029eusmtrp2H;
        Fri,  7 Feb 2020 14:28:00 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-ca-5e3d73f04b8b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 42.D5.07950.FE37D3E5; Fri,  7
        Feb 2020 14:28:00 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142759eusmtip2dad46f5d84e812a4845297292ab57d61~xJQxzKIZb2944029440eusmtip2i;
        Fri,  7 Feb 2020 14:27:59 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v2 18/26] ata: move sata_link_{debounce,resume}() to
 libata-sata.c
Date:   Fri,  7 Feb 2020 15:27:26 +0100
Message-Id: <20200207142734.8431-19-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207142734.8431-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djP87ofim3jDE4ckLBYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBkTHu9nKVgfVXFtTR9LA+NO9y5GTg4J
        AROJ3quHGbsYuTiEBFYwSixctZsNwvnCKPHxUxM7hPOZUeL06XYWmJati2ZAVS1nlNjS/oEF
        rqXv0gqwKjYBK4mJ7asYQWwRAQWJnt8rwTqYBd4zSqyYtBesSFggROLD8w2sIDaLgKrE6qP3
        geIcHLwCthIHF4dAbJOX2PrtE1gJJ1D445S/bCA2r4CgxMmZT8DGMAPVNG+dzQwyX0JgGbvE
        nOYF7BDNLhJLj65hgrCFJV4d3wIVl5H4v3M+E0TDOkaJvx0voLq3M0osn/yPDaLKWuLOuV9s
        IBcxC2hKrN+lDxF2lJi+8ScrSFhCgE/ixltBiCP4JCZtm84MEeaV6GgTgqhWk9iwbAMbzNqu
        nSuZIWwPiYPHVzBPYFScheSdWUjemYWwdwEj8ypG8dTS4tz01GLjvNRyveLE3OLSvHS95Pzc
        TYzAVHT63/GvOxj3/Uk6xCjAwajEw5vgaBMnxJpYVlyZe4hRgoNZSYS3T9U2Tog3JbGyKrUo
        P76oNCe1+BCjNAeLkjiv8aKXsUIC6YklqdmpqQWpRTBZJg5OqQbGNd7nvlg57HMSiH69rth/
        Sq8Ti4IA25SDXEEbr60R2+D7Zeb7X02T1Gp2fghcIi0gGte58vYG81+LvYK5lKYFpv5K2m3b
        nlI37aWCd8O/3Y9u9/gtP5fZmxAQn7EtMfJv4K2cg+ISbzzV89bc/9PoHuP4vNdgUoRwVlNW
        xqKHAmd0z/3Q22mhxFKckWioxVxUnAgAw0V/MUEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t/xe7ofim3jDCaeZLJYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehkTHu9nKVgfVXFtTR9LA+NO9y5GTg4JAROJrYtmsIHYQgJLGSVe3nXt
        YuQAistIHF9fBlEiLPHnWhdUySdGicubIkFsNgEriYntqxhBbBEBBYme3yuBarg4mAW+Mkos
        ndTNDJIQFgiSuLBsEzuIzSKgKrH66H0WkPm8ArYSBxeHQMyXl9j67RMriM0JFP445S/ULhuJ
        7+8ngbXyCghKnJz5hAXEZgaqb946m3kCo8AsJKlZSFILGJlWMYqklhbnpucWG+kVJ+YWl+al
        6yXn525iBMbKtmM/t+xg7HoXfIhRgINRiYc3wdEmTog1say4MvcQowQHs5IIb5+qbZwQb0pi
        ZVVqUX58UWlOavEhRlOgHyYyS4km5wPjOK8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6Yklq
        dmpqQWoRTB8TB6dUA2OPyRXnP7flzRetWxnM0tL6WmDNtJX+n3tKDV9+/BayQSmrte7z/xRj
        7qtNWS7L5u21eXA3wo3diMN2s7UJi+H/Y8utcn3ysx0jbKJuM0Q/n20eufuVaMQLh6fp72W8
        8jtNthmtbrKMY7LryFH/eZqf2fn4zG3ab1+lP/T5cFviU87beQ+2cSuxFGckGmoxFxUnAgBj
        own8qwIAAA==
X-CMS-MailID: 20200207142800eucas1p2714a5e9b2ff1a6f7f714f153846d8b51
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200207142800eucas1p2714a5e9b2ff1a6f7f714f153846d8b51
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200207142800eucas1p2714a5e9b2ff1a6f7f714f153846d8b51
References: <20200207142734.8431-1-b.zolnierkie@samsung.com>
        <CGME20200207142800eucas1p2714a5e9b2ff1a6f7f714f153846d8b51@eucas1p2.samsung.com>
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
index e932d11a061f..f3391e66b694 100644
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
index efc87613f9c1..bd0ac8007911 100644
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

