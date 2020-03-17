Return-Path: <SRS0=AjNr=5C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA84C18E5B
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59C4206EC
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aI5Mnf6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgCQOoj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:44:39 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40368 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgCQOnw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Mar 2020 10:43:52 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200317144351euoutp02bb6922bae2052b09c8fe3b8cf91d8620~9HowyCOdM1539915399euoutp02a
        for <linux-ide@vger.kernel.org>; Tue, 17 Mar 2020 14:43:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200317144351euoutp02bb6922bae2052b09c8fe3b8cf91d8620~9HowyCOdM1539915399euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584456231;
        bh=oux3YS2rvMRLSqyIEM+M5a2jwa/KLKbK0wzQjLFE3FY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aI5Mnf6o9yWHiSVwFzAWAnch1SZEQ82GFTlUyJ79EHTm1fIyZs50PUq59CsX8OHdt
         5UodZXbC3IJU0U05O3VTsHYeijvhfl0GB35UUXjUA2RYuOCwpXDDV56sFlPef/yb8+
         e3AQAOqDxBubXpH1ZqfjF0nAFu8GkiEqUiQDB/fs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200317144351eucas1p13d7922665ea64fd5ab9346e51bccb299~9HowhSgXM1085710857eucas1p1J;
        Tue, 17 Mar 2020 14:43:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 91.E3.61286.722E07E5; Tue, 17
        Mar 2020 14:43:51 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200317144350eucas1p2270ca7a1757769b238be42c2811172a1~9HowAP-tU0560005600eucas1p2R;
        Tue, 17 Mar 2020 14:43:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200317144350eusmtrp27acb730284fe6ee462815fbc60a518b5~9Hov-rR-h0146401464eusmtrp2T;
        Tue, 17 Mar 2020 14:43:50 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-37-5e70e227a90b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6E.23.07950.622E07E5; Tue, 17
        Mar 2020 14:43:50 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144349eusmtip1a3f30f4ad8bca0460bc3efd9e4145d00~9HovdxASg1029210292eusmtip1F;
        Tue, 17 Mar 2020 14:43:49 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v4 19/27] ata: move sata_link_{debounce,resume}() to
 libata-sata.c
Date:   Tue, 17 Mar 2020 15:43:25 +0100
Message-Id: <20200317144333.2904-20-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317144333.2904-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djPc7rqjwriDBZvZLZYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBmTrh9gLDgcVXHp0w62Bsad7l2MnBwS
        AiYSP67fY+pi5OIQEljBKNF+6DM7hPOFUeLX0iZGCOczo8S5qRMYYVp61+0Hs4UEljNKrLpY
        Cdex7OhbFpAEm4CVxMT2VWBFIgIKEj2/V7KBFDELvGeUWDFpL1iRsECIxMXb51lBbBYBVYn5
        P9axgdi8ArYSV+5/ZoXYJi+x9dsnMJsTKH7t8D+oGkGJkzOfgM1hBqpp3jqbGWSBhMAqdokf
        e1vYIZpdJHZNXMUCYQtLvDq+BSouI/F/53wmiIZ1jBJ/O15AdW9nlFg+GWKFhIC1xJ1zv4Bs
        DqAVmhLrd+lDhB0lNuw7wAISlhDgk7jxVhDiCD6JSdumM0OEeSU62oQgqtUkNizbwAaztmvn
        SmYI20Pi6+ZDbBMYFWcheWcWkndmIexdwMi8ilE8tbQ4Nz212DAvtVyvODG3uDQvXS85P3cT
        IzAVnf53/NMOxq+Xkg4xCnAwKvHwcmwoiBNiTSwrrsw9xCjBwawkwru4MD9OiDclsbIqtSg/
        vqg0J7X4EKM0B4uSOK/xopexQgLpiSWp2ampBalFMFkmDk6pBkbFJovgabe2BXdvi/z6TjYj
        9JnSH9X/XduKYvaGeSWccPGtTPU6cOt93JoQ7ed5C8V9U104F/qxJtwpZZmZFbdfY5d5Zbk7
        v+bSj/cXC8n82lf512L1po0pmkfmiz7hyW7waWm4emnnqViJrzNOHMs582fPZgnDFu4zk28e
        Sy1ZzPZM5dSjQnclluKMREMt5qLiRACZ1u80QQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xu7pqjwriDE6+l7ZYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehmTrh9gLDgcVXHp0w62Bsad7l2MnBwSAiYSvev2M3YxcnEICSxllNj9
        6j5bFyMHUEJG4vj6MogaYYk/17rYIGo+MUrMWtvDCpJgE7CSmNi+ihHEFhFQkOj5vRKsiFng
        K6PE0kndzCAJYYEgiQVHn7GD2CwCqhLzf6xjA7F5BWwlrtz/zAqxQV5i67dPYDYnUPza4X9g
        NUICNhIv3vxngqgXlDg58wkLiM0MVN+8dTbzBEaBWUhSs5CkFjAyrWIUSS0tzk3PLTbSK07M
        LS7NS9dLzs/dxAiMmG3Hfm7Zwdj1LvgQowAHoxIPL8eGgjgh1sSy4srcQ4wSHMxKIryLC/Pj
        hHhTEiurUovy44tKc1KLDzGaAj0xkVlKNDkfGM15JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE
        0hNLUrNTUwtSi2D6mDg4pRoYm5zXhdbsF9j+rEeC9dXd39/vhxXttGJslngQKHX+U8GyxTHJ
        TW9vrS/ntxVu6Ai+wHnGI3Z9Sf9ZkwNii3/PyN8nwqEQr7zAxiRdc5nXR5HHP86vyAvZKs0w
        23tK4lKWG7Nd58x4F6Ao5v0qkrMnvJ7nfcN8/vnrTzJ11V8qtN3/Y3anQ3q8EktxRqKhFnNR
        cSIA+q/n7a4CAAA=
X-CMS-MailID: 20200317144350eucas1p2270ca7a1757769b238be42c2811172a1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200317144350eucas1p2270ca7a1757769b238be42c2811172a1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200317144350eucas1p2270ca7a1757769b238be42c2811172a1
References: <20200317144333.2904-1-b.zolnierkie@samsung.com>
        <CGME20200317144350eucas1p2270ca7a1757769b238be42c2811172a1@eucas1p2.samsung.com>
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
index 37de14e6224f..9c4c7f6d90fc 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3497,144 +3497,6 @@ int ata_wait_after_reset(struct ata_link *link, unsigned long deadline,
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
index 246696cafc4c..f67a7bbb3c35 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1069,10 +1069,6 @@ static inline int ata_port_is_dummy(struct ata_port *ap)
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

