Return-Path: <SRS0=dw68=3R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A132FC2D0DB
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CEEF22522
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UShVDJAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgA1NeY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:34:24 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58896 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgA1NeW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jan 2020 08:34:22 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200128133420euoutp01df87cd266fe67dce0736976a40cde47d~uEFFS2Q8p0284402844euoutp01i
        for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2020 13:34:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200128133420euoutp01df87cd266fe67dce0736976a40cde47d~uEFFS2Q8p0284402844euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580218460;
        bh=FnAxc8I0haCRwqAAiq/E3v5iEVuaI9WWSWiKifmrAUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UShVDJAWLMGKndZqpHpFOykPwH5tZ+8pJkbPsSxWkFzCp78qVTNzMcuiyCmbcWJH/
         +6SL/7zq8QjZCCaTaJQ83HlNCbXgEKRGS8ZXTUXHMFG25cmjv1otDsP+SAWiVqwf6n
         4UeYbRKd4G/TeKN5cMKNoLtnBZ5okKdpVa3ffJ20=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200128133420eucas1p2c30153238fe597a56437c6470904b2fb~uEFFFqdhM0683706837eucas1p2P;
        Tue, 28 Jan 2020 13:34:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B2.DA.61286.C58303E5; Tue, 28
        Jan 2020 13:34:20 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133420eucas1p294e2d41ec0eb0457ff781c69a5bcc489~uEFEx0XzH2264122641eucas1p2G;
        Tue, 28 Jan 2020 13:34:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200128133420eusmtrp2966682352ca9e0cd8fd27a40d7f6f61e~uEFExP5me0330003300eusmtrp2C;
        Tue, 28 Jan 2020 13:34:20 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-93-5e30385c5008
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F5.82.07950.C58303E5; Tue, 28
        Jan 2020 13:34:20 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133419eusmtip2e8cfbf4715c43f70bc8f8bfa9430b2be~uEFEdeK6X0724907249eusmtip2C;
        Tue, 28 Jan 2020 13:34:19 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 27/28] ata: move ata_eh_analyze_ncq_error() & co. to
 libata-core-sata.c
Date:   Tue, 28 Jan 2020 14:33:42 +0100
Message-Id: <20200128133343.29905-28-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128133343.29905-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djPc7oxFgZxBrN2SVusvtvPZrFxxnpW
        i2e39jJZHNvxiMni8q45bBZzW6ezO7B57Jx1l93j8tlSj0OHOxg9+rasYvT4vEkugDWKyyYl
        NSezLLVI3y6BK+PkJ++Clb4V134eYG9g3GvbxcjJISFgIrH98S+mLkYuDiGBFYwSB3dvZoNw
        vjBKzD79mQXC+cwo0fO6gwWm5czn5VBVyxklVh9fwgTXsnDudDaQKjYBK4mJ7asYQWwRAQWJ
        nt8rwTqYBdYwSqw63ASWEBaIlPh0ayc7iM0ioCpx8uJKsBW8AnYSW8+eYIdYJy+x9dsn1i5G
        Dg5OoHjPXnOIEkGJkzOfgJUzA5U0b53NDDJfQqCZXaJ3yW+oXheJlZ+vsELYwhKvjm+BistI
        /N85nwmiYR2jxN+OF1Dd2xkllk/+xwZRZS1x59wvNpDNzAKaEut36YOYEgKOEiu/eEKYfBI3
        3gpC3MAnMWnbdGaIMK9ER5sQxAw1iQ3LNrDBbO3auZIZwvaQ2DXrG9sERsVZSL6ZheSbWQhr
        FzAyr2IUTy0tzk1PLTbMSy3XK07MLS7NS9dLzs/dxAhML6f/Hf+0g/HrpaRDjAIcjEo8vDNU
        DOKEWBPLiitzDzFKcDArifB2MgGFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xovehkrJJCeWJKa
        nZpakFoEk2Xi4JRqYCyc8ebUpb1PHn7U0m4o3iF/a+UL97w/c5jfzi18tyBC9ME2j/sCe7et
        /ji1MvVAsO/FLAHrnGvHvGMOC+jU9sYG500t9+6tEdDd0GUyaVo1S+np+tPPbA2lpPXXaKwx
        mHdppkqczdJLiTvZWg2S780SFFiQILhlVXDpOTnfQ2+sbI2tJp6VnqbEUpyRaKjFXFScCADX
        BdfWKwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42I5/e/4Pd0YC4M4g1czOSxW3+1ns9g4Yz2r
        xbNbe5ksju14xGRxedccNou5rdPZHdg8ds66y+5x+Wypx6HDHYwefVtWMXp83iQXwBqlZ1OU
        X1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl3Hyk3fBSt+K
        az8PsDcw7rXtYuTkkBAwkTjzeTlbFyMXh5DAUkaJnVt2MnUxcgAlZCSOry+DqBGW+HOtC6rm
        E6PE++ffmUASbAJWEhPbVzGC2CICChI9v1eCFTELbGCUeHXzCwtIQlggXGLL0mNgNouAqsTJ
        iyvBbF4BO4mtZ0+wQ2yQl9j67RMryGJOoHjPXnOQsJCArcT6M09ZIcoFJU7OfALWygxU3rx1
        NvMERoFZSFKzkKQWMDKtYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIyCbcd+btnB2PUu+BCj
        AAejEg+vg5JBnBBrYllxZe4hRgkOZiUR3k4moBBvSmJlVWpRfnxRaU5q8SFGU6AfJjJLiSbn
        AyM0ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QD47k9ch/cnZ8/
        ETdY0+Qt8iDSfEEr46OskOP7ZL0dAthPZO1UeHKh95vGv0sHO2OKbnccWjf1XI1RzaPlAYvs
        llW/N+WtyhIWPaomxLzuY5r0Ck/NRRkaxacfPOp3XapvIX9C3Ub630HtjTqTt4nPyDrgkeWz
        66yX6kSmbffXrEpY3XfPsvK9jBJLcUaioRZzUXEiAJvWUCGYAgAA
X-CMS-MailID: 20200128133420eucas1p294e2d41ec0eb0457ff781c69a5bcc489
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133420eucas1p294e2d41ec0eb0457ff781c69a5bcc489
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133420eucas1p294e2d41ec0eb0457ff781c69a5bcc489
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133420eucas1p294e2d41ec0eb0457ff781c69a5bcc489@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

* move ata_eh_analyze_ncq_error() and ata_eh_read_log_10h() to
  libata-eh-sata.c

* add static inline for ata_eh_analyze_ncq_error() for
  CONFIG_SATA_HOST=n case (link->sactive is non-zero only if
  NCQ commands are actually queued so empty function body is
  sufficient)

Code size savings on m68k arch using atari_defconfig:

   text    data     bss     dec     hex filename
before:
  16810      18       0   16828    41bc drivers/ata/libata-eh.o
after:
  16092      18       0   16110    3eee drivers/ata/libata-eh.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-eh-sata.c | 131 +++++++++++++++++++++++++++++++++++
 drivers/ata/libata-eh.c      | 131 -----------------------------------
 include/linux/libata.h       |   4 +-
 3 files changed, 134 insertions(+), 132 deletions(-)

diff --git a/drivers/ata/libata-eh-sata.c b/drivers/ata/libata-eh-sata.c
index 4b6dc715629a..4b55d89862fb 100644
--- a/drivers/ata/libata-eh-sata.c
+++ b/drivers/ata/libata-eh-sata.c
@@ -83,3 +83,134 @@ int sata_async_notification(struct ata_port *ap)
 	}
 }
 EXPORT_SYMBOL_GPL(sata_async_notification);
+
+/**
+ *	ata_eh_read_log_10h - Read log page 10h for NCQ error details
+ *	@dev: Device to read log page 10h from
+ *	@tag: Resulting tag of the failed command
+ *	@tf: Resulting taskfile registers of the failed command
+ *
+ *	Read log page 10h to obtain NCQ error details and clear error
+ *	condition.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+static int ata_eh_read_log_10h(struct ata_device *dev,
+			       int *tag, struct ata_taskfile *tf)
+{
+	u8 *buf = dev->link->ap->sector_buf;
+	unsigned int err_mask;
+	u8 csum;
+	int i;
+
+	err_mask = ata_read_log_page(dev, ATA_LOG_SATA_NCQ, 0, buf, 1);
+	if (err_mask)
+		return -EIO;
+
+	csum = 0;
+	for (i = 0; i < ATA_SECT_SIZE; i++)
+		csum += buf[i];
+	if (csum)
+		ata_dev_warn(dev, "invalid checksum 0x%x on log page 10h\n",
+			     csum);
+
+	if (buf[0] & 0x80)
+		return -ENOENT;
+
+	*tag = buf[0] & 0x1f;
+
+	tf->command = buf[2];
+	tf->feature = buf[3];
+	tf->lbal = buf[4];
+	tf->lbam = buf[5];
+	tf->lbah = buf[6];
+	tf->device = buf[7];
+	tf->hob_lbal = buf[8];
+	tf->hob_lbam = buf[9];
+	tf->hob_lbah = buf[10];
+	tf->nsect = buf[12];
+	tf->hob_nsect = buf[13];
+	if (dev->class == ATA_DEV_ZAC && ata_id_has_ncq_autosense(dev->id))
+		tf->auxiliary = buf[14] << 16 | buf[15] << 8 | buf[16];
+
+	return 0;
+}
+
+/**
+ *	ata_eh_analyze_ncq_error - analyze NCQ error
+ *	@link: ATA link to analyze NCQ error for
+ *
+ *	Read log page 10h, determine the offending qc and acquire
+ *	error status TF.  For NCQ device errors, all LLDDs have to do
+ *	is setting AC_ERR_DEV in ehi->err_mask.  This function takes
+ *	care of the rest.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ */
+void ata_eh_analyze_ncq_error(struct ata_link *link)
+{
+	struct ata_port *ap = link->ap;
+	struct ata_eh_context *ehc = &link->eh_context;
+	struct ata_device *dev = link->device;
+	struct ata_queued_cmd *qc;
+	struct ata_taskfile tf;
+	int tag, rc;
+
+	/* if frozen, we can't do much */
+	if (ap->pflags & ATA_PFLAG_FROZEN)
+		return;
+
+	/* is it NCQ device error? */
+	if (!link->sactive || !(ehc->i.err_mask & AC_ERR_DEV))
+		return;
+
+	/* has LLDD analyzed already? */
+	ata_qc_for_each_raw(ap, qc, tag) {
+		if (!(qc->flags & ATA_QCFLAG_FAILED))
+			continue;
+
+		if (qc->err_mask)
+			return;
+	}
+
+	/* okay, this error is ours */
+	memset(&tf, 0, sizeof(tf));
+	rc = ata_eh_read_log_10h(dev, &tag, &tf);
+	if (rc) {
+		ata_link_err(link, "failed to read log page 10h (errno=%d)\n",
+			     rc);
+		return;
+	}
+
+	if (!(link->sactive & (1 << tag))) {
+		ata_link_err(link, "log page 10h reported inactive tag %d\n",
+			     tag);
+		return;
+	}
+
+	/* we've got the perpetrator, condemn it */
+	qc = __ata_qc_from_tag(ap, tag);
+	memcpy(&qc->result_tf, &tf, sizeof(tf));
+	qc->result_tf.flags = ATA_TFLAG_ISADDR | ATA_TFLAG_LBA | ATA_TFLAG_LBA48;
+	qc->err_mask |= AC_ERR_DEV | AC_ERR_NCQ;
+	if (dev->class == ATA_DEV_ZAC &&
+	    ((qc->result_tf.command & ATA_SENSE) || qc->result_tf.auxiliary)) {
+		char sense_key, asc, ascq;
+
+		sense_key = (qc->result_tf.auxiliary >> 16) & 0xff;
+		asc = (qc->result_tf.auxiliary >> 8) & 0xff;
+		ascq = qc->result_tf.auxiliary & 0xff;
+		ata_scsi_set_sense(dev, qc->scsicmd, sense_key, asc, ascq);
+		ata_scsi_set_sense_information(dev, qc->scsicmd,
+					       &qc->result_tf);
+		qc->flags |= ATA_QCFLAG_SENSE_VALID;
+	}
+
+	ehc->i.err_mask &= ~AC_ERR_DEV;
+}
+EXPORT_SYMBOL_GPL(ata_eh_analyze_ncq_error);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 201165955b90..b37e93c5013d 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1351,62 +1351,6 @@ static const char *ata_err_string(unsigned int err_mask)
 	return "unknown error";
 }
 
-/**
- *	ata_eh_read_log_10h - Read log page 10h for NCQ error details
- *	@dev: Device to read log page 10h from
- *	@tag: Resulting tag of the failed command
- *	@tf: Resulting taskfile registers of the failed command
- *
- *	Read log page 10h to obtain NCQ error details and clear error
- *	condition.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep).
- *
- *	RETURNS:
- *	0 on success, -errno otherwise.
- */
-static int ata_eh_read_log_10h(struct ata_device *dev,
-			       int *tag, struct ata_taskfile *tf)
-{
-	u8 *buf = dev->link->ap->sector_buf;
-	unsigned int err_mask;
-	u8 csum;
-	int i;
-
-	err_mask = ata_read_log_page(dev, ATA_LOG_SATA_NCQ, 0, buf, 1);
-	if (err_mask)
-		return -EIO;
-
-	csum = 0;
-	for (i = 0; i < ATA_SECT_SIZE; i++)
-		csum += buf[i];
-	if (csum)
-		ata_dev_warn(dev, "invalid checksum 0x%x on log page 10h\n",
-			     csum);
-
-	if (buf[0] & 0x80)
-		return -ENOENT;
-
-	*tag = buf[0] & 0x1f;
-
-	tf->command = buf[2];
-	tf->feature = buf[3];
-	tf->lbal = buf[4];
-	tf->lbam = buf[5];
-	tf->lbah = buf[6];
-	tf->device = buf[7];
-	tf->hob_lbal = buf[8];
-	tf->hob_lbam = buf[9];
-	tf->hob_lbah = buf[10];
-	tf->nsect = buf[12];
-	tf->hob_nsect = buf[13];
-	if (dev->class == ATA_DEV_ZAC && ata_id_has_ncq_autosense(dev->id))
-		tf->auxiliary = buf[14] << 16 | buf[15] << 8 | buf[16];
-
-	return 0;
-}
-
 /**
  *	atapi_eh_tur - perform ATAPI TEST_UNIT_READY
  *	@dev: target ATAPI device
@@ -1590,81 +1534,6 @@ static void ata_eh_analyze_serror(struct ata_link *link)
 	ehc->i.action |= action;
 }
 
-/**
- *	ata_eh_analyze_ncq_error - analyze NCQ error
- *	@link: ATA link to analyze NCQ error for
- *
- *	Read log page 10h, determine the offending qc and acquire
- *	error status TF.  For NCQ device errors, all LLDDs have to do
- *	is setting AC_ERR_DEV in ehi->err_mask.  This function takes
- *	care of the rest.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep).
- */
-void ata_eh_analyze_ncq_error(struct ata_link *link)
-{
-	struct ata_port *ap = link->ap;
-	struct ata_eh_context *ehc = &link->eh_context;
-	struct ata_device *dev = link->device;
-	struct ata_queued_cmd *qc;
-	struct ata_taskfile tf;
-	int tag, rc;
-
-	/* if frozen, we can't do much */
-	if (ap->pflags & ATA_PFLAG_FROZEN)
-		return;
-
-	/* is it NCQ device error? */
-	if (!link->sactive || !(ehc->i.err_mask & AC_ERR_DEV))
-		return;
-
-	/* has LLDD analyzed already? */
-	ata_qc_for_each_raw(ap, qc, tag) {
-		if (!(qc->flags & ATA_QCFLAG_FAILED))
-			continue;
-
-		if (qc->err_mask)
-			return;
-	}
-
-	/* okay, this error is ours */
-	memset(&tf, 0, sizeof(tf));
-	rc = ata_eh_read_log_10h(dev, &tag, &tf);
-	if (rc) {
-		ata_link_err(link, "failed to read log page 10h (errno=%d)\n",
-			     rc);
-		return;
-	}
-
-	if (!(link->sactive & (1 << tag))) {
-		ata_link_err(link, "log page 10h reported inactive tag %d\n",
-			     tag);
-		return;
-	}
-
-	/* we've got the perpetrator, condemn it */
-	qc = __ata_qc_from_tag(ap, tag);
-	memcpy(&qc->result_tf, &tf, sizeof(tf));
-	qc->result_tf.flags = ATA_TFLAG_ISADDR | ATA_TFLAG_LBA | ATA_TFLAG_LBA48;
-	qc->err_mask |= AC_ERR_DEV | AC_ERR_NCQ;
-	if (dev->class == ATA_DEV_ZAC &&
-	    ((qc->result_tf.command & ATA_SENSE) || qc->result_tf.auxiliary)) {
-		char sense_key, asc, ascq;
-
-		sense_key = (qc->result_tf.auxiliary >> 16) & 0xff;
-		asc = (qc->result_tf.auxiliary >> 8) & 0xff;
-		ascq = qc->result_tf.auxiliary & 0xff;
-		ata_scsi_set_sense(dev, qc->scsicmd, sense_key, asc, ascq);
-		ata_scsi_set_sense_information(dev, qc->scsicmd,
-					       &qc->result_tf);
-		qc->flags |= ATA_QCFLAG_SENSE_VALID;
-	}
-
-	ehc->i.err_mask &= ~AC_ERR_DEV;
-}
-EXPORT_SYMBOL_GPL(ata_eh_analyze_ncq_error);
-
 /**
  *	ata_eh_analyze_tf - analyze taskfile of a failed qc
  *	@qc: qc to analyze
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d09997e2290b..aba4bebb25f1 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1341,7 +1341,6 @@ extern void ata_eh_thaw_port(struct ata_port *ap);
 
 extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
-extern void ata_eh_analyze_ncq_error(struct ata_link *link);
 
 extern void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
 		      ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
@@ -1356,6 +1355,9 @@ extern int ata_link_nr_enabled(struct ata_link *link);
  */
 #ifdef CONFIG_SATA_HOST
 extern int sata_async_notification(struct ata_port *ap);
+extern void ata_eh_analyze_ncq_error(struct ata_link *link);
+#else
+static inline void ata_eh_analyze_ncq_error(struct ata_link *link) { }
 #endif
 
 /*
-- 
2.24.1

