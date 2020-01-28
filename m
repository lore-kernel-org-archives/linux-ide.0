Return-Path: <SRS0=dw68=3R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065F8C33CB3
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B1624688
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="S53LH3CY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgA1NeU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:34:20 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52410 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgA1NeT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jan 2020 08:34:19 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200128133417euoutp0207a44b100f212c2be2694556bebfdc4a~uEFCkkK2V2911929119euoutp02m
        for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2020 13:34:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200128133417euoutp0207a44b100f212c2be2694556bebfdc4a~uEFCkkK2V2911929119euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580218457;
        bh=vpGdIB9thEp072F1DkjIZyy1yEPEEdtmljPGrQ3v0/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S53LH3CYTAb93U8SDooN3S06D7AuyyWDH8bzoGxHNG0xwnqqLrWQXDdUc/g2LiplE
         +/132IkLfi8tpwbVf5yL6RVzt2n2ckSMN3w9pvXJ5BniWFIVbuxyclAI0btjRdROPV
         1dVmO9E6h+83BTT8729QkULRkgBfaPAaxtHjLx94=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200128133417eucas1p25849b4194b3ede9c7762b2c7686331ea~uEFCGuGc70683706837eucas1p2J;
        Tue, 28 Jan 2020 13:34:17 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 10.DA.61286.958303E5; Tue, 28
        Jan 2020 13:34:17 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200128133416eucas1p172512260c12e8cce9516dd194c467134~uEFBmNGPa0087500875eucas1p1A;
        Tue, 28 Jan 2020 13:34:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200128133416eusmtrp2339a18ac37f8501cf503c33aee3676cc~uEFBlot_n0330003300eusmtrp24;
        Tue, 28 Jan 2020 13:34:16 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-87-5e303859c635
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A4.92.08375.858303E5; Tue, 28
        Jan 2020 13:34:16 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133416eusmtip2574692252d5dbb85ca8f271ed835bf0f~uEFBOR4sP0113601136eusmtip2G;
        Tue, 28 Jan 2020 13:34:16 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 18/28] ata: move sata_link_{debounce,resume}() to
 libata-core-sata.c
Date:   Tue, 28 Jan 2020 14:33:33 +0100
Message-Id: <20200128133343.29905-19-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128133343.29905-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djP87qRFgZxBrNvcVusvtvPZrFxxnpW
        i2e39jJZHNvxiMni8q45bBZzW6ezO7B57Jx1l93j8tlSj0OHOxg9+rasYvT4vEkugDWKyyYl
        NSezLLVI3y6BK2PGm3fMBS2RFSdWnmVtYFzh1sXIySEhYCLx5tFZ9i5GLg4hgRWMEht2L4Ry
        vjBKTFn7CMr5zCjR3bSZHabl1bxeqMRyRoltiycjtPSd7WACqWITsJKY2L6KEcQWEVCQ6Pm9
        kg2kiFlgDaPEqsNNYAlhgTCJ7h89rCA2i4CqRM+8iWDNvAJ2EtNXPGSEWCcvsfXbJ6AaDg5O
        oHjPXnOIEkGJkzOfsIDYzEAlzVtnM4PMlxBoZ5dYtvEA1KkuEt0/1zJD2MISr45vgYrLSPzf
        OZ8JomEdo8TfjhdQ3dsZJZZP/scGUWUtcefcLzaQzcwCmhLrd+lDhB0l5rbNZgIJSwjwSdx4
        KwhxBJ/EpG3TmSHCvBIdbUIQ1WoSG5ZtYINZ27VzJVSJh8TujYwTGBVnIflmFpJvZiGsXcDI
        vIpRPLW0ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMwwZz+d/zTDsavl5IOMQpwMCrx8M5QMYgT
        Yk0sK67MPcQowcGsJMLbyQQU4k1JrKxKLcqPLyrNSS0+xCjNwaIkzmu86GWskEB6Yklqdmpq
        QWoRTJaJg1OqgVHTRTfA89c7ltLgZQdXm+vYLWJ4etz674yu5d96bLZ+yRSp/GCyfLlbk6dv
        qk1Cgl/gku7Hajb/Mm2FLe6vqHxkXb5DdB+nbnjQjeJf2Ws/9k4s041XjnG8Vuh3pbyL8xCL
        xX29y7sYzV2TJ7ovr2arqZwou+SFVgnzi9UlRlPMa1+bep0OVWIpzkg01GIuKk4EAPLgdAgs
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42I5/e/4Pd0IC4M4g6Z7Whar7/azWWycsZ7V
        4tmtvUwWx3Y8YrK4vGsOm8Xc1unsDmweO2fdZfe4fLbU49DhDkaPvi2rGD0+b5ILYI3SsynK
        Ly1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy5jx5h1zQUtk
        xYmVZ1kbGFe4dTFyckgImEi8mtfL3sXIxSEksJRRYtLrG8xdjBxACRmJ4+vLIGqEJf5c62KD
        qPnEKPHs81JGkASbgJXExPZVYLaIgIJEz++VYEXMAhsYJV7d/MICkhAWCJF493kVG4jNIqAq
        0TNvIhOIzStgJzF9xUNGiA3yElu/fWIFWcwJFO/Zaw4SFhKwlVh/5ikrRLmgxMmZT8BGMgOV
        N2+dzTyBUWAWktQsJKkFjEyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAuNg27Gfm3cwXtoY
        fIhRgINRiYd3hopBnBBrYllxZe4hRgkOZiUR3k4moBBvSmJlVWpRfnxRaU5q8SFGU6AfJjJL
        iSbnA2M0ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDY74Zs/w8
        3UXWyxWTjPWmB2U3zOL9ZJtfpecWe6P6XHG80GMmw2d6ktOENFw2TfUr3vz3v5bhgsDqAsfl
        R/ilTKy8RL0FqzL1NN1n7Av9UHvR8LzsXBvus6KVJQcrL91mKOoPXJr88k3JabGP+55tWDfV
        JvBGVU9qtfJnVaPH15Y8Fv7Bcei3EktxRqKhFnNRcSIArXFuK5kCAAA=
X-CMS-MailID: 20200128133416eucas1p172512260c12e8cce9516dd194c467134
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133416eucas1p172512260c12e8cce9516dd194c467134
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133416eucas1p172512260c12e8cce9516dd194c467134
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133416eucas1p172512260c12e8cce9516dd194c467134@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

* move sata_link_{debounce,resume}() to libata-core-sata.c

* add static inline for CONFIG_SATA_HOST=n case (only one,
  for sata_link_resume() is needed)

Code size savings on m68k arch using atari_defconfig:

   text    data     bss     dec     hex filename
before:
  34766     572      40   35378    8a32 drivers/ata/libata-core.o
after:
  33909     572      40   34521    86d9 drivers/ata/libata-core.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core-sata.c | 138 +++++++++++++++++++++++++++++++++
 drivers/ata/libata-core.c      | 138 ---------------------------------
 include/linux/libata.h         |  14 +++-
 3 files changed, 148 insertions(+), 142 deletions(-)

diff --git a/drivers/ata/libata-core-sata.c b/drivers/ata/libata-core-sata.c
index 4aa938c1df8d..73f8be386a44 100644
--- a/drivers/ata/libata-core-sata.c
+++ b/drivers/ata/libata-core-sata.c
@@ -446,6 +446,144 @@ int sata_set_spd(struct ata_link *link)
 }
 EXPORT_SYMBOL_GPL(sata_set_spd);
 
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
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ff44d16b718e..d3587fb1e78c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3190,144 +3190,6 @@ int ata_wait_after_reset(struct ata_link *link, unsigned long deadline,
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
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e466dbe56158..8a11ae3a019f 100644
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
@@ -1196,6 +1192,10 @@ extern void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *
  */
 #ifdef CONFIG_SATA_HOST
 extern int sata_set_spd(struct ata_link *link);
+extern int sata_link_debounce(struct ata_link *link,
+			const unsigned long *params, unsigned long deadline);
+extern int sata_link_resume(struct ata_link *link, const unsigned long *params,
+			    unsigned long deadline);
 extern int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 			     bool spm_wakeup);
 extern int ata_slave_link_init(struct ata_port *ap);
@@ -1205,6 +1205,12 @@ extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
 extern bool sata_lpm_ignore_phy_events(struct ata_link *link);
 #else
 static inline int sata_set_spd(struct ata_link *link) { return -EOPNOTSUPP; }
+static inline int sata_link_resume(struct ata_link *link,
+				   const unsigned long *params,
+				   unsigned long deadline)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 extern int ata_cable_40wire(struct ata_port *ap);
-- 
2.24.1

