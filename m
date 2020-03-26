Return-Path: <SRS0=jBxd=5L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE5BC2D0EF
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 15:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B8420737
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 15:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jsc6jESY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgCZP72 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:59:28 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58970 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbgCZP6t (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2020 11:58:49 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200326155847euoutp013af0a91723014d6169ca1a33818ad234~-5dwczwvD3032230322euoutp01C
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2020 15:58:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200326155847euoutp013af0a91723014d6169ca1a33818ad234~-5dwczwvD3032230322euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585238327;
        bh=FXlvVo2ucia17qGwJ/iW56q2pvAF9VZdpWgkBcPtlAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jsc6jESYqyYx09XSx2hTO5mRbbUORoYMuLu0UuLIFIxoKF0V5SYbovwrlssrk2ME7
         j6RmYGpEPPUfTX91Ev5C82BJ1ZGxHHvdeOEf66XR4Hla5uDI4pmEOwFIkzn03OVhmB
         ax094OfE7EPhtVVNMLfGM6gMPjkPrKMIZH193gNA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200326155846eucas1p223ff0dbc5c9e3ff373d70a0cb30ad70b~-5dvpy2G62254722547eucas1p2M;
        Thu, 26 Mar 2020 15:58:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 96.F7.60698.631DC7E5; Thu, 26
        Mar 2020 15:58:46 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200326155846eucas1p2c1a68a558be3f6df1308cd665ca60e32~-5dvVpKIW2254022540eucas1p2I;
        Thu, 26 Mar 2020 15:58:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200326155846eusmtrp1955108fec5eadb36db1113a55997f249~-5dvU_Bha2091520915eusmtrp1T;
        Thu, 26 Mar 2020 15:58:46 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-9d-5e7cd136155b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5F.5A.08375.631DC7E5; Thu, 26
        Mar 2020 15:58:46 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155845eusmtip13fb8178c1af746fa30792a63cf1e2da1~-5du7ZOY70452404524eusmtip1O;
        Thu, 26 Mar 2020 15:58:45 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v5 19/27] ata: move sata_link_{debounce,resume}() to
 libata-sata.c
Date:   Thu, 26 Mar 2020 16:58:14 +0100
Message-Id: <20200326155822.19400-20-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200326155822.19400-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djP87pmF2viDBb9l7RYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBk/mmayFdyJqnj2egdrA+ND9y5GTg4J
        AROJ1/unMXUxcnEICaxglHj7+x0LhPOFUeLEyyPMIFVCAp8ZJXoPc8B09F9vZ4QoWs4ose3U
        VoSO33vPMIJUsQlYSUxsXwVmiwgoSPT8XskGUsQs8J5RYsWkvSwgCWGBEIlDC5+A2SwCqhLt
        Vy6xdjFycPAK2Elc/uwFsU1eYuu3T6wgNidQePm6+WAX8QoISpycCdHKDFTTvHU2M8h8CYF1
        7BL/2q+yQjS7SMy/+IodwhaWeHV8C5QtI3F6cg8LVAOjxN+OF1Dd2xkllk/+xwZRZS1x59wv
        NpCLmAU0Jdbv0ocIO0r8O7uDHSQsIcAnceOtIMQRfBKTtk1nhgjzSnS0CUFUq0lsWLaBDWZt
        186VzBC2h8SsKVdZJjAqzkLyziwk78xC2LuAkXkVo3hqaXFuemqxcV5quV5xYm5xaV66XnJ+
        7iZGYCI6/e/41x2M+/4kHWIU4GBU4uFtaKuJE2JNLCuuzD3EKMHBrCTC+zQSKMSbklhZlVqU
        H19UmpNafIhRmoNFSZzXeNHLWCGB9MSS1OzU1ILUIpgsEwenVAOjjeNOrXlKdhwW/+JXTnlq
        fvbLUjf56c1dTZyNy0W258vcF5v80e7chZqmp1MWHklT/MK1w4Ql76iOUf0N6Y1ltxs1p/5t
        y1eUO9opvt3Ws23Tek4/I805uqfMN/hmlu4yj3i0OZ/958R1DgUyl/0yT32KVorySJJKqJMX
        E4o8najnuS4q10GJpTgj0VCLuag4EQAc1eDwQAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xu7pmF2viDDbd57JYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehk/mmayFdyJqnj2egdrA+ND9y5GTg4JAROJ/uvtjF2MXBxCAksZJSYd
        +MHcxcgBlJCROL6+DKJGWOLPtS42EFtI4BOjxMmWbBCbTcBKYmL7KkYQW0RAQaLn90o2kDnM
        Al8ZJZZO6mYGSQgLBEmcWfABzGYRUJVov3KJFWQ+r4CdxOXPXhDz5SW2fvvECmJzAoWXr5vP
        DLHLVmLxlw9MIDavgKDEyZlPWEBsZqD65q2zmScwCsxCkpqFJLWAkWkVo0hqaXFuem6xoV5x
        Ym5xaV66XnJ+7iZGYLRsO/Zz8w7GSxuDDzEKcDAq8fBqtNTECbEmlhVX5h5ilOBgVhLhfRoJ
        FOJNSaysSi3Kjy8qzUktPsRoCvTDRGYp0eR8YCTnlcQbmhqaW1gamhubG5tZKInzdggcjBES
        SE8sSc1OTS1ILYLpY+LglGpgbI1iqjx03PDbpq0TinlSkvd1Tf4i+OF6g/hFqfVnArJTjzoy
        ff/85tQjnh1PPc8t5NhRu/Hezkfrtk8U0vjFIVsZee6lXbruA82ZLMa+q968WOq+40Dnmw9W
        6ee+udfYpK1+zPxT1MIv++fOLTPEz3H7LNPY66Ys8Z9hjoSMXdyb604hr3p+eSmxFGckGmox
        FxUnAgCFu4nHrAIAAA==
X-CMS-MailID: 20200326155846eucas1p2c1a68a558be3f6df1308cd665ca60e32
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200326155846eucas1p2c1a68a558be3f6df1308cd665ca60e32
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200326155846eucas1p2c1a68a558be3f6df1308cd665ca60e32
References: <20200326155822.19400-1-b.zolnierkie@samsung.com>
        <CGME20200326155846eucas1p2c1a68a558be3f6df1308cd665ca60e32@eucas1p2.samsung.com>
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
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
index f0817a8f1e3f..b05538d06919 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1077,10 +1077,6 @@ static inline int ata_port_is_dummy(struct ata_port *ap)
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
@@ -1194,6 +1190,8 @@ extern int sata_scr_read(struct ata_link *link, int reg, u32 *val);
 extern int sata_scr_write(struct ata_link *link, int reg, u32 val);
 extern int sata_scr_write_flush(struct ata_link *link, int reg, u32 val);
 extern int sata_set_spd(struct ata_link *link);
+extern int sata_link_resume(struct ata_link *link, const unsigned long *params,
+			    unsigned long deadline);
 #else
 static inline int sata_scr_valid(struct ata_link *link) { return 0; }
 static inline int sata_scr_read(struct ata_link *link, int reg, u32 *val)
@@ -1209,7 +1207,15 @@ static inline int sata_scr_write_flush(struct ata_link *link, int reg, u32 val)
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

