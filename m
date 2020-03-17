Return-Path: <SRS0=AjNr=5C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7320C2BB1D
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDD120735
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="scjJRQx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgCQOoB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:44:01 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40527 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbgCQOn5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Mar 2020 10:43:57 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200317144354euoutp02ef1274a5814f82ca3c5a236a7cd1b785~9Hozsrsf91582715827euoutp02M
        for <linux-ide@vger.kernel.org>; Tue, 17 Mar 2020 14:43:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200317144354euoutp02ef1274a5814f82ca3c5a236a7cd1b785~9Hozsrsf91582715827euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584456234;
        bh=3foSod+V4F/iyX2KJpQw1vSqGZHJb/zFM+r7EAosMp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=scjJRQx0qzoHbB0Ws7rfjHHP7MupRKjnjE6uxvUBOb7yVfFoypBnz7KONw2lDoVff
         0tS7klTOwlNLEla5O34sbAmhsixP1t5yEbXKiHoDAW+TDw2CX2uX7KIX8qSLbpHlx8
         dlD6y2gyvBH+xDFNlUQfxLG/DgssTMAitknS0sus=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200317144354eucas1p21eb622061454dcfebe01737ffc77a1b1~9Hozdl2cT0133401334eucas1p2o;
        Tue, 17 Mar 2020 14:43:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 08.E9.60698.A22E07E5; Tue, 17
        Mar 2020 14:43:54 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144353eucas1p120a8f1a0fa5c293ada61b8d06f7aa9ec~9HozL4Fyo1083310833eucas1p1p;
        Tue, 17 Mar 2020 14:43:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200317144353eusmtrp28b0099b882d13a0c15444eff36a3b09f~9HozLM9uj0146401464eusmtrp2Y;
        Tue, 17 Mar 2020 14:43:53 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-fc-5e70e22a83c9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 02.33.07950.922E07E5; Tue, 17
        Mar 2020 14:43:53 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144353eusmtip1a6e34a80cbaaa93c941a3e0bdedce300~9HoyuhmZl0973009730eusmtip1a;
        Tue, 17 Mar 2020 14:43:53 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v4 26/27] ata: move ata_eh_analyze_ncq_error() & co. to
 libata-sata.c
Date:   Tue, 17 Mar 2020 15:43:32 +0100
Message-Id: <20200317144333.2904-27-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317144333.2904-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djPc7pajwriDBZs4LNYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBm/9nxiLlgdULHl/2X2BsYGhy5GDg4J
        AROJmRM5uxi5OIQEVjBKPJr/lRHC+cIo0Th9BxuE85lRYt3i+0AOJ1jHm23boKqWM0ocmrWR
        Da7lwPznYFVsAlYSE9tXMYLYIgIKEj2/V4IVMQu8Z5RYMWkvC0hCWCBc4ueTDWANLAKqElMP
        /WAHsXkFbCXu3ehmhlgnL7H12ydWEJsTKH7t8D82iBpBiZMzn4DNYQaqad46G6p+FbvEjqMZ
        ELaLxOtN65ggbGGJV8e3sEPYMhL/d85nAjlIQmAdo8TfjhfMEM52Ronlk/9BPWotcefcLzZQ
        MDELaEqs36UPEXaUmDTzCDMk9PgkbrwVhLiBT2LStulQYV6JjjYhiGo1iQ3LNrDBrO3auRLq
        TA+JBx8bWScwKs5C8s0sJN/MQti7gJF5FaN4amlxbnpqsXFearlecWJucWleul5yfu4mRmAi
        Ov3v+NcdjPv+JB1iFOBgVOLhTdhUECfEmlhWXJl7iFGCg1lJhHdxYX6cEG9KYmVValF+fFFp
        TmrxIUZpDhYlcV7jRS9jhQTSE0tSs1NTC1KLYLJMHJxSDYwb2tebM/unPAsq3NDK6ebbptnZ
        mLhpptq/BRI/5dXiVa/xpU1XNDt9ZeLS/edPe9oFFnxI1Mvu22Y6L+Sc/MrdXy1un+D8f3O9
        4Eo2/k9iesxhcRLMWZfXXNAWPfDw8w/dMtdsu0iRnNOTbiSJX71e5Z28ynvKriW3pDjUk9cs
        8Fn0TUFm7jolluKMREMt5qLiRADl6BQ9QAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xu7qajwriDJ48MbdYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehm/9nxiLlgdULHl/2X2BsYGhy5GTg4JAROJN9u2MXYxcnEICSxllNjc
        vI+5i5EDKCEjcXx9GUSNsMSfa11sEDWfGCUmT3rDBJJgE7CSmNi+ihHEFhFQkOj5vRKsiFng
        K6PE0kndYIOEBUIlehcHg9SwCKhKTD30gx3E5hWwlbh3A6QEZIG8xNZvn1hBbE6g+LXD/9hA
        bCEBG4kXb/4zQdQLSpyc+YQFxGYGqm/eOpt5AqPALCSpWUhSCxiZVjGKpJYW56bnFhvpFSfm
        Fpfmpesl5+duYgTGy7ZjP7fsYOx6F3yIUYCDUYmHl2NDQZwQa2JZcWXuIUYJDmYlEd7Fhflx
        QrwpiZVVqUX58UWlOanFhxhNgZ6YyCwlmpwPjOW8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC
        6YklqdmpqQWpRTB9TBycUg2Mk9VVDnhLsjIbRnwrP7t7mpYI06KfD0LC3+6bGnK78AZzRamr
        1bISj3lzNjXdXb49tufQvvQ2/W8JVaqz/IuvJDLmiJwL41qsdC3EwTpHPSm1+GrQ/Q7RmX5c
        E3bOTEoMvWIct/R5+56fZYlWLOFF0X/3ntD41Jfp+S0g4PtntmcX23wCC34psRRnJBpqMRcV
        JwIAl/xTUK0CAAA=
X-CMS-MailID: 20200317144353eucas1p120a8f1a0fa5c293ada61b8d06f7aa9ec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200317144353eucas1p120a8f1a0fa5c293ada61b8d06f7aa9ec
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200317144353eucas1p120a8f1a0fa5c293ada61b8d06f7aa9ec
References: <20200317144333.2904-1-b.zolnierkie@samsung.com>
        <CGME20200317144353eucas1p120a8f1a0fa5c293ada61b8d06f7aa9ec@eucas1p1.samsung.com>
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
index 9ca777a24117..702f4aa4d509 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1352,62 +1352,6 @@ static const char *ata_err_string(unsigned int err_mask)
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
@@ -1587,81 +1531,6 @@ static void ata_eh_analyze_serror(struct ata_link *link)
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
index eff744727dc0..13c105912167 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1347,3 +1347,134 @@ int sata_async_notification(struct ata_port *ap)
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
index 556fc5d367aa..422bb71f3bf5 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1182,6 +1182,7 @@ extern int sata_link_hardreset(struct ata_link *link,
 			bool *online, int (*check_ready)(struct ata_link *));
 extern int sata_link_resume(struct ata_link *link, const unsigned long *params,
 			    unsigned long deadline);
+extern void ata_eh_analyze_ncq_error(struct ata_link *link);
 #else
 static inline const unsigned long *
 sata_ehc_deb_timing(struct ata_eh_context *ehc)
@@ -1218,6 +1219,7 @@ static inline int sata_link_resume(struct ata_link *link,
 {
 	return -EOPNOTSUPP;
 }
+static inline void ata_eh_analyze_ncq_error(struct ata_link *link) { }
 #endif
 extern int sata_link_debounce(struct ata_link *link,
 			const unsigned long *params, unsigned long deadline);
@@ -1342,7 +1344,6 @@ extern void ata_eh_thaw_port(struct ata_port *ap);
 
 extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
-extern void ata_eh_analyze_ncq_error(struct ata_link *link);
 
 extern void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
 		      ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
-- 
2.24.1

