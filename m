Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7748C35242
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7651E217BA
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qsCDK7Ig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgBGO2c (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:28:32 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59726 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgBGO2F (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:28:05 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142804euoutp01548ef572491b6ca5904bdacd9a1c125b~xJQ2VHg-y2241722417euoutp01S
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:28:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200207142804euoutp01548ef572491b6ca5904bdacd9a1c125b~xJQ2VHg-y2241722417euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085684;
        bh=ftzeUmV9iG/vfvKr0kHipFl/DckhDGVDJGjJjv3SiJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qsCDK7IgwO8zXMu03h9GBWbf2pg9NZ/+OdJTgapjsyUNxyllm4PqpQUZZ8GrRqQtC
         V9UgmXu5t+pNStKUVay7qQkky7zjgp3Fz06oXrg6J9z+BcfoXIhr2Ybv+CgqaI6ybW
         y/dY08eiMzam+kJ7+uUs6qiGl3l9H1/iMHKSZwfU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200207142804eucas1p24d99b885c9d8de6852c9087da297d988~xJQ2Ere1N2432324323eucas1p2g;
        Fri,  7 Feb 2020 14:28:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 64.5D.60679.4F37D3E5; Fri,  7
        Feb 2020 14:28:04 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200207142803eucas1p1a2ee17261878ae26f9b388f693d6e56a~xJQ1oC6Fa2611726117eucas1p1u;
        Fri,  7 Feb 2020 14:28:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200207142803eusmtrp24363cd662afb04e9bc66563e73d322d1~xJQ1nYOsn1102911029eusmtrp2O;
        Fri,  7 Feb 2020 14:28:03 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-90-5e3d73f4e41e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E5.D5.07950.3F37D3E5; Fri,  7
        Feb 2020 14:28:03 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142803eusmtip20df3c6efba228a67ef3fb6c2cbbc480a~xJQ1I8GZn3158631586eusmtip2D;
        Fri,  7 Feb 2020 14:28:03 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v2 25/26] ata: move ata_eh_analyze_ncq_error() & co. to
 libata-sata.c
Date:   Fri,  7 Feb 2020 15:27:33 +0100
Message-Id: <20200207142734.8431-26-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207142734.8431-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djP87pfim3jDP5NZbFYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBk3Pl1mK1gdUDGhZy9zA2ODQxcjJ4eE
        gInEh1erGLsYuTiEBFYwSnz+dJcFwvnCKNH86BUzhPOZUeLtwTMsMC2nHj9kgkgsZ5R4dWwj
        O1xLS8tbVpAqNgEriYntIIM5OUQEFCR6fq9kAyliFnjPKLFi0l6wUcIC4RKbLj9gBrFZBFQl
        dr07zARi8wrYSnw7dIsRYp28xNZvn8CGcgLFP075ywZRIyhxcuYTsDnMQDXNW2eD3SohsIpd
        YtnuJ8wQzS4SzdsWsUHYwhKvjm9hh7BlJP7vnM8E0bCOUeJvxwuo7u2MEssn/4PqsJa4c+4X
        kM0BtEJTYv0ufYiwo8Sri3dYQMISAnwSN94KQhzBJzFp23RmiDCvREebEES1msSGZRvYYNZ2
        7VwJdZqHxIzLLxgnMCrOQvLOLCTvzELYu4CReRWjeGppcW56arFRXmq5XnFibnFpXrpecn7u
        JkZgMjr97/iXHYy7/iQdYhTgYFTi4U1wtIkTYk0sK67MPcQowcGsJMLbp2obJ8SbklhZlVqU
        H19UmpNafIhRmoNFSZzXeNHLWCGB9MSS1OzU1ILUIpgsEwenVANjr8Acf4tZG1TPiZ376PHl
        6P7L6oYCPy8yBrB/9Jr1bWrLGefCDzmT9kiua358ZOa0T0HtrH6Rllf2v5zftb/VTPOS16/T
        j5WyFgROytgW9jDj4SxTxch9S6I8D15Q75GeYv/ad/P0Ndsjbi7y0Gp+scHX+8vOn1FKP0wV
        Jjxb/WdLu01Xgrj+CyWW4oxEQy3mouJEAPUmcMlCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xe7qfi23jDA6/ULdYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehk3Pl1mK1gdUDGhZy9zA2ODQxcjJ4eEgInEqccPmboYuTiEBJYySvye
        P4Oxi5EDKCEjcXx9GUSNsMSfa11sEDWfGCWurFvNBJJgE7CSmNi+ihHEFhFQkOj5vRKsiFng
        K6PE0kndzCAJYYFQiUVnH4E1sAioSux6dxjM5hWwlfh26BYjxAZ5ia3fPrGC2JxA8Y9T/rKB
        2EICNhLf309ih6gXlDg58wkLiM0MVN+8dTbzBEaBWUhSs5CkFjAyrWIUSS0tzk3PLTbSK07M
        LS7NS9dLzs/dxAiMmG3Hfm7Zwdj1LvgQowAHoxIPb4KjTZwQa2JZcWXuIUYJDmYlEd4+Vds4
        Id6UxMqq1KL8+KLSnNTiQ4ymQE9MZJYSTc4HRnNeSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB
        9MSS1OzU1ILUIpg+Jg5OqQZGLnmblxP5uRdY3p6b2bH0Z9emXc5Pm16y6q0M9/p+5uLnb9dj
        Nqp/YP7Hku34PCP86b3InV6WZcqfJ4hYz+UPTmlxeac+y/Xz1zcW9tU8LHeY83m8NKf0Pln/
        6+vM7G3aKQGHbE7yS666Lro3ZNP/1k06H7afncjJdf9M65ebHNwSQSU9HgUOSizFGYmGWsxF
        xYkAss/6ya4CAAA=
X-CMS-MailID: 20200207142803eucas1p1a2ee17261878ae26f9b388f693d6e56a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200207142803eucas1p1a2ee17261878ae26f9b388f693d6e56a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200207142803eucas1p1a2ee17261878ae26f9b388f693d6e56a
References: <20200207142734.8431-1-b.zolnierkie@samsung.com>
        <CGME20200207142803eucas1p1a2ee17261878ae26f9b388f693d6e56a@eucas1p1.samsung.com>
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
index 24de4b66ce36..4feeb12f58ea 100644
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
@@ -1340,7 +1342,6 @@ extern void ata_eh_thaw_port(struct ata_port *ap);
 
 extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
-extern void ata_eh_analyze_ncq_error(struct ata_link *link);
 
 extern void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
 		      ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
-- 
2.24.1

