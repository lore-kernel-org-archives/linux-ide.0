Return-Path: <SRS0=jBxd=5L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79B9C2D0EC
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 15:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8236A20787
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 15:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rKqcJFwY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgCZP7L (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:59:11 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52781 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728619AbgCZP6w (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2020 11:58:52 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200326155849euoutp02cf45314734977577ee397ceb000a6184~-5dyvQx4b0032300323euoutp023
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2020 15:58:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200326155849euoutp02cf45314734977577ee397ceb000a6184~-5dyvQx4b0032300323euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585238329;
        bh=SSDGwAoyMXsmOEZGng33Y0+i+JECUR3GqNgRU6Fn68U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rKqcJFwYVfNIgY702TmSRYUv+GVG1U0WmiRwibxKKpwfnc2Ep2wLqGVRO7+dB4mKy
         ptkCEZVKXvMWADFqwoMm3QVLp1JLULhn4OjrnuBxtZXrOTMDU59UQZCirE6c2lT/d9
         idKnGJFlvt5N4lm2iNuzJoIokRTvtbQjV/aAsZ+Y=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200326155849eucas1p2f072312b45db96c576b828e5413420c4~-5dyQz4_N2647226472eucas1p2U;
        Thu, 26 Mar 2020 15:58:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A8.F7.60698.931DC7E5; Thu, 26
        Mar 2020 15:58:49 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155849eucas1p1b7b96c8913106b0330344af0500aca99~-5dx9aHCV0942809428eucas1p1s;
        Thu, 26 Mar 2020 15:58:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200326155849eusmtrp1dfaba6de9e8ae3548a9dff9c668ff9a4~-5dx81jr-2091520915eusmtrp1b;
        Thu, 26 Mar 2020 15:58:49 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-a5-5e7cd13978bc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 52.DA.07950.831DC7E5; Thu, 26
        Mar 2020 15:58:48 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155848eusmtip146c4253bef9a36bb08f9ca84aecfcacf~-5dxhqUi11330613306eusmtip1U;
        Thu, 26 Mar 2020 15:58:48 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v5 26/27] ata: move ata_eh_analyze_ncq_error() & co. to
 libata-sata.c
Date:   Thu, 26 Mar 2020 16:58:21 +0100
Message-Id: <20200326155822.19400-27-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200326155822.19400-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djPc7qWF2viDBY281usvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoLpuU1JzMstQifbsErozPd18zFtwIqHhyqIOxgXGFQxcjJ4eE
        gInExJ5dzF2MXBxCAisYJZ7f6mKFcL4wSpx4fZsNwvnMKHHpWxcjTMvxnjYWiMRyRokba38x
        wbUs/ruJCaSKTcBKYmL7KrAOEQEFiZ7fK8FGMQu8Z5RYMWkvC0hCWCBcYuOJ+2A2i4CqxJHL
        01lBbF4BO4lTXadYIdbJS2z99gnM5gSKL183nxmiRlDi5MwnYL3MQDXNW2eDfSEhsIxdYsuW
        zcwQzS4Sn2Y9YoKwhSVeHd/CDmHLSJye3MMC0bCOUeJvxwuo7u2MEssn/2ODqLKWuHPuF5DN
        AbRCU2L9Ln2IsKPE+8n72EHCEgJ8EjfeCkIcwScxadt0Zogwr0RHmxBEtZrEhmUb2GDWdu1c
        CXWah8T73W+YJzAqzkLyziwk78xC2LuAkXkVo3hqaXFuemqxcV5quV5xYm5xaV66XnJ+7iZG
        YDI6/e/41x2M+/4kHWIU4GBU4uFtaKuJE2JNLCuuzD3EKMHBrCTC+zQSKMSbklhZlVqUH19U
        mpNafIhRmoNFSZzXeNHLWCGB9MSS1OzU1ILUIpgsEwenVANj0oyHlbzlfSn3zaYwnT/r5Xk9
        4g9vobPN16KDmZeKDx48uXz/yt4Et1zzgNa5d796yi1NPvlSaG39vJXctVvua/CeWHXxjGhy
        nGLGpGiVWw+F5xxPr8l9fGRzwv53bkqG3Wrd6/rOXnKNu/JxucD6Odx1PVE2E66ZBsQVc10X
        KUiUyqgR6jypxFKckWioxVxUnAgA9Phd3UIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xu7oWF2viDA6usbBYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehmf775mLLgRUPHkUAdjA+MKhy5GTg4JAROJ4z1tLF2MXBxCAksZJb7/
        vgnkcAAlZCSOry+DqBGW+HOtiw2i5hOjxNMtS1hAEmwCVhIT21cxgtgiAgoSPb9XghUxC3xl
        lFg6qZsZJCEsECpxd9pRdhCbRUBV4sjl6awgNq+AncSprlOsEBvkJbZ++wRmcwLFl6+bD9Yr
        JGArsfjLByaIekGJkzOfgC1mBqpv3jqbeQKjwCwkqVlIUgsYmVYxiqSWFuem5xYb6RUn5haX
        5qXrJefnbmIERsy2Yz+37GDsehd8iFGAg1GJh1ejpSZOiDWxrLgy9xCjBAezkgjv00igEG9K
        YmVValF+fFFpTmrxIUZToCcmMkuJJucDozmvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJ
        anZqakFqEUwfEwenVAOj9rnl3NuP6+iv5X3wVl7UXGZHtMPL/8/WhvhK3P3Ft/zQhLVL//3o
        u/Cm7lPlrepP/PaPVX7ZvjXr65vfckI4psTB4Epf946wPMUtVRc/3ty+mvXGzQ71FcLTmGW7
        jnta9Jy1nph4N1X1fqfP7MRYeZFvHDlxepFnb4eqPuJP+POZd52QicMCJZbijERDLeai4kQA
        j5bALK4CAAA=
X-CMS-MailID: 20200326155849eucas1p1b7b96c8913106b0330344af0500aca99
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200326155849eucas1p1b7b96c8913106b0330344af0500aca99
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200326155849eucas1p1b7b96c8913106b0330344af0500aca99
References: <20200326155822.19400-1-b.zolnierkie@samsung.com>
        <CGME20200326155849eucas1p1b7b96c8913106b0330344af0500aca99@eucas1p1.samsung.com>
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
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
index 9c7ca659dc94..cffa4714bfa8 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1181,6 +1181,7 @@ extern int sata_link_hardreset(struct ata_link *link,
 			bool *online, int (*check_ready)(struct ata_link *));
 extern int sata_link_resume(struct ata_link *link, const unsigned long *params,
 			    unsigned long deadline);
+extern void ata_eh_analyze_ncq_error(struct ata_link *link);
 #else
 static inline const unsigned long *
 sata_ehc_deb_timing(struct ata_eh_context *ehc)
@@ -1217,6 +1218,7 @@ static inline int sata_link_resume(struct ata_link *link,
 {
 	return -EOPNOTSUPP;
 }
+static inline void ata_eh_analyze_ncq_error(struct ata_link *link) { }
 #endif
 extern int sata_link_debounce(struct ata_link *link,
 			const unsigned long *params, unsigned long deadline);
@@ -1339,7 +1341,6 @@ extern void ata_eh_thaw_port(struct ata_port *ap);
 
 extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
-extern void ata_eh_analyze_ncq_error(struct ata_link *link);
 
 extern void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
 		      ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
-- 
2.24.1

