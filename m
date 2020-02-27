Return-Path: <SRS0=ljer=4P=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46165C35E17
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6BB246AF
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZFhk5GNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbgB0SWz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:22:55 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39835 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731051AbgB0SWy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Feb 2020 13:22:54 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200227182252euoutp01d59b2bdcba973b43dfe4af480f995719~3VXkdfAwd1217012170euoutp01t
        for <linux-ide@vger.kernel.org>; Thu, 27 Feb 2020 18:22:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200227182252euoutp01d59b2bdcba973b43dfe4af480f995719~3VXkdfAwd1217012170euoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582827772;
        bh=E8DbQhEWqANYBUoUVWSJBOeuj9bLCaGemkD8/OJkZq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZFhk5GNCQCrK5XbESkMlCubURJ+iI78ITJDgZa/gV/YnljqiSjjVacpOKAvAxZ9Hf
         Y8mqSFNfaCuEV43U2fhTLr/WNDOcF2JiGYlHdHK9oRpIctllj+EF9r24I0/Msn4rb2
         SvdFtRvBXQsVU2+B652ko4UPm9Z6PGx0a7RzphlQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200227182252eucas1p2e4fa5671150be8ad4c1017d3e0c02fb2~3VXjzmlMf3196231962eucas1p2K;
        Thu, 27 Feb 2020 18:22:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 9B.05.60698.BF8085E5; Thu, 27
        Feb 2020 18:22:51 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200227182251eucas1p1857e44a8f0860829e821748464bb936d~3VXjNVNUA1392413924eucas1p1_;
        Thu, 27 Feb 2020 18:22:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200227182251eusmtrp2eb38af03aebbf4bd2249d8daab792b25~3VXjMygeS1813218132eusmtrp2y;
        Thu, 27 Feb 2020 18:22:51 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-0c-5e5808fb2f18
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B4.C1.08375.BF8085E5; Thu, 27
        Feb 2020 18:22:51 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182250eusmtip267e9647421fb0d4312e6514c041ec0d4~3VXituIO71203512035eusmtip2S;
        Thu, 27 Feb 2020 18:22:50 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v3 26/27] ata: move ata_eh_analyze_ncq_error() & co. to
 libata-sata.c
Date:   Thu, 27 Feb 2020 19:22:25 +0100
Message-Id: <20200227182226.19188-27-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227182226.19188-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djPc7q/OSLiDBbesrJYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBnnfigUrA6o+Px6OlMDY4NDFyMnh4SA
        icS+bxPYuxi5OIQEVjBKrL03mwnC+cIo8f7BXEYI5zOjxN25fWwwLRef/mWDSCxnlGjc1skG
        1/L6zFsmkCo2ASuJie2rGEFsEQEFiZ7fK8GKmAXeM0qsmLSXBSQhLBAu8XPeWXYQm0VAVaLt
        /HNWEJtXwE7i7ewjjBDr5CW2fvsEFucEit/o284GUSMocXLmE7A5zEA1zVtnM4MskBBYxi7x
        ddEGoCs4gBwXiVWzmCDmCEu8Or6FHcKWkfi/cz4TRP06Rom/HS+gmrczSiyf/A/qUWuJO+d+
        sYEMYhbQlFi/Sx8i7ChxYekhRoj5fBI33gpC3MAnMWnbdGaIMK9ER5sQRLWaxIZlG9hg1nbt
        XMkMYXtIbL/fzjaBUXEWkm9mIflmFsLeBYzMqxjFU0uLc9NTi43zUsv1ihNzi0vz0vWS83M3
        MQIT0el/x7/uYNz3J+kQowAHoxIP74Id4XFCrIllxZW5hxglOJiVRHg3fg2NE+JNSaysSi3K
        jy8qzUktPsQozcGiJM5rvOhlrJBAemJJanZqakFqEUyWiYNTqoFx9Z79izMXeczp+G5SYjwl
        5tKWtOTdkZcFnkWIXuPsd5t1M/pPcaGg7L1JKRFTC55WzON15Jt60ITpyAeJ7Dy+6lkPI63K
        vfbZHdwd+GBpyvzn7tcXNRUtD/ykdkbELKz9iVCq5pc1/z5eP7upa17Y/g0Sy/aJnd3ZVfTs
        /bJHbbHiv/gqSvbPU2Ipzkg01GIuKk4EAKITYNxAAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xe7q/OSLiDBY/E7BYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehnnfigUrA6o+Px6OlMDY4NDFyMnh4SAicTFp3/Zuhi5OIQEljJKbN+7
        hb2LkQMoISNxfH0ZRI2wxJ9rXVA1nxgl1rbfYwdJsAlYSUxsX8UIYosIKEj0/F4JVsQs8JVR
        YumkbmaQhLBAqMTTJ3/AGlgEVCXazj9nBbF5Bewk3s4+wgixQV5i67dPYHFOoPiNvu1sILaQ
        gK1EV8dTRoh6QYmTM5+wgNjMQPXNW2czT2AUmIUkNQtJagEj0ypGkdTS4tz03GJDveLE3OLS
        vHS95PzcTYzAeNl27OfmHYyXNgYfYhTgYFTi4V2wIzxOiDWxrLgy9xCjBAezkgjvxq+hcUK8
        KYmVValF+fFFpTmpxYcYTYGemMgsJZqcD4zlvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJ
        JanZqakFqUUwfUwcnFINjLN+N5yMT738cX7i8b5H1q8EvKRfP2UUUXLRE355tfpN8exZLt+m
        vRLvTXsVdOpc0CV3r/2SHOaZGRo/TWzjdXJlvziqnXmvndyyOG2FXwf3mzlP4xRVTlc/6cj2
        795qfHKHKc9137jvZ6xclheVzdBL0GXaekrNObSjWeLhptRsF4/EPJbnSizFGYmGWsxFxYkA
        gjOjJ60CAAA=
X-CMS-MailID: 20200227182251eucas1p1857e44a8f0860829e821748464bb936d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200227182251eucas1p1857e44a8f0860829e821748464bb936d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200227182251eucas1p1857e44a8f0860829e821748464bb936d
References: <20200227182226.19188-1-b.zolnierkie@samsung.com>
        <CGME20200227182251eucas1p1857e44a8f0860829e821748464bb936d@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

* move ata_eh_analyze_ncq_error() and ata_eh_read_log_10h() to
  libata-sata.c

* add static inline for ata_eh_analyze_ncq_error() for
  CONFIG_SATA_HOST=n case (link->sactive is non-zero only if
  NCQ commands are actually queued so empty function body is
  sufficient)

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  16164      18       0   16182    3f36 drivers/ata/libata-eh.o
after:
  15446      18       0   15464    3c68 drivers/ata/libata-eh.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-eh.c   | 131 --------------------------------------
 drivers/ata/libata-sata.c | 131 ++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h    |   3 +-
 3 files changed, 133 insertions(+), 132 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index ef4d606cd8c6..474c6c34fe02 100644
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
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 008468e516cd..c16423e44525 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1350,3 +1350,134 @@ int sata_async_notification(struct ata_port *ap)
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
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6d6fb25cc650..23277eddb54e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1183,6 +1183,7 @@ extern int sata_link_hardreset(struct ata_link *link,
 			bool *online, int (*check_ready)(struct ata_link *));
 extern int sata_link_resume(struct ata_link *link, const unsigned long *params,
 			    unsigned long deadline);
+extern void ata_eh_analyze_ncq_error(struct ata_link *link);
 #else
 static inline const unsigned long *
 sata_ehc_deb_timing(struct ata_eh_context *ehc)
@@ -1219,6 +1220,7 @@ static inline int sata_link_resume(struct ata_link *link,
 {
 	return -EOPNOTSUPP;
 }
+static inline void ata_eh_analyze_ncq_error(struct ata_link *link) { }
 #endif
 extern int sata_link_debounce(struct ata_link *link,
 			const unsigned long *params, unsigned long deadline);
@@ -1341,7 +1343,6 @@ extern void ata_eh_thaw_port(struct ata_port *ap);
 
 extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
-extern void ata_eh_analyze_ncq_error(struct ata_link *link);
 
 extern void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
 		      ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
-- 
2.24.1

