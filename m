Return-Path: <SRS0=jBxd=5L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E64BC2D0EC
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 15:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5625021556
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 15:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kVrimrdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgCZP7V (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:59:21 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52738 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbgCZP6t (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2020 11:58:49 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200326155847euoutp02b13fbc7d24221392880700d9617782c5~-5dwy0u9c0089000890euoutp02P
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2020 15:58:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200326155847euoutp02b13fbc7d24221392880700d9617782c5~-5dwy0u9c0089000890euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585238327;
        bh=xZoAjDFKbQEkPMfR4GHVF12ElcDkcbEr9DJcepvgQAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kVrimrdkY0VxXPOLEMQiva13noopiiqVe11Q+rWzzvxIFuPRK6IRPvLT/HMO9B7GT
         1dYyAuKfb4QuxquY4zKV9X9aU3hwpsLjsKSEjarXtQGrPqkQokxG273aRedo/b3zsA
         ZXaj5xafXzmNwJY94AH0ls4dI5fZTxjJ+TwEI/3k=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200326155847eucas1p252ea72411c36cede1b0f55ed219f454e~-5dwjeB7f2646526465eucas1p2G;
        Thu, 26 Mar 2020 15:58:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 50.06.61286.731DC7E5; Thu, 26
        Mar 2020 15:58:47 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155847eucas1p1ed7286be9fa1a0616efc2d148bffe50d~-5dwGHdzL2422724227eucas1p17;
        Thu, 26 Mar 2020 15:58:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200326155847eusmtrp165f9793094394f284793917cba35ca26~-5dwFjpNF2091520915eusmtrp1X;
        Thu, 26 Mar 2020 15:58:47 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-d1-5e7cd137b48e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BF.CA.07950.631DC7E5; Thu, 26
        Mar 2020 15:58:46 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155846eusmtip176e9e804f7fa6b3cae42c60d2c994f1d~-5dvqVbYi0490504905eusmtip1S;
        Thu, 26 Mar 2020 15:58:46 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v5 21/27] ata: move ata_qc_complete_multiple() to
 libata-sata.c
Date:   Thu, 26 Mar 2020 16:58:16 +0100
Message-Id: <20200326155822.19400-22-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200326155822.19400-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djPc7rmF2viDB40SlisvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoLpuU1JzMstQifbsErozD+y+yFGzQrzg51aSBcY9aFyMnh4SA
        icTJbQ2sXYxcHEICKxglFhxcyAThfGGUePL4NjuE85lR4vSLb6wwLf82bIBqWc4oMaPxHwtc
        y653f9hAqtgErCQmtq9iBLFFBBQken6vZAMpYhZ4zyixYtJeFpCEsECgRHfXJaAdHBwsAqoS
        rU2ZIGFeATuJG4vfsEBsk5fY+u0T2GZOoPjydfOZIWoEJU7OfAJWwwxU07x1NjPIfAmBZewS
        91f3M0E0u0h8a7wHdbawxKvjW9ghbBmJ05N7WCAa1jFK/O14AdW9nVFi+eR/bBBV1hJ3zv1i
        A7mOWUBTYv0ufYiwo8TtE5uZQMISAnwSN94KQhzBJzFp23RmiDCvREebEES1msSGZRvYYNZ2
        7VzJDGF7SLQ2LmGcwKg4C8k7s5C8Mwth7wJG5lWM4qmlxbnpqcWGeanlesWJucWleel6yfm5
        mxiBiej0v+OfdjB+vZR0iFGAg1GJh1ejpSZOiDWxrLgy9xCjBAezkgjv00igEG9KYmVValF+
        fFFpTmrxIUZpDhYlcV7jRS9jhQTSE0tSs1NTC1KLYLJMHJxSDYzznvhNZs/xP9lz5bkoczb/
        0U312qsXAHmrd9fv49SvO1Gu6si3RPL55/6Dql6LUzMUAv5r1KTOvyPIya0wSUQvmb1cZr/N
        nPev54TWWJq5bpN55Xc2/mDGLPnihoWvu/7xR5W8PHksulTuVNQ0fdWHvBXfFQzeL66dEK3+
        JdFh+vfgRK+5SizFGYmGWsxFxYkAyzj05kADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t/xu7pmF2viDJ42W1qsvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYzD+y+yFGzQrzg51aSBcY9aFyMnh4SAicS/DRtYuxi5OIQEljJKNKzY
        ztzFyAGUkJE4vr4MokZY4s+1LjYQW0jgE6PE13+FIDabgJXExPZVjCC2iICCRM/vlWwgc5gF
        vjJKLJ3UzQySEBbwl+h4O5MdZCaLgKpEa1MmSJhXwE7ixuI3LBDz5SW2fvvECmJzAsWXr5vP
        DLHLVmLxlw9MEPWCEidnPgGrZwaqb946m3kCo8AsJKlZSFILGJlWMYqklhbnpucWG+kVJ+YW
        l+al6yXn525iBMbKtmM/t+xg7HoXfIhRgINRiYdXo6UmTog1say4MvcQowQHs5II79NIoBBv
        SmJlVWpRfnxRaU5q8SFGU6AfJjJLiSbnA+M4ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpi
        SWp2ampBahFMHxMHp1QD4/TiWlcFK/f7xyS0jPTLnmxgOPn5sxo/m43GJAvFd0d/1cUv6drN
        sWjho7fvYv+FNTmGS3ssrfm7/s/jg0t8esQvHvLR8BDcJrP1RcRxt/7pE3rmG724PDsyoODs
        36SOFpuohsoJdyXcFB8YPDA5zrmTfcWyRDNHv6/X/7oX8OjUtcSI3L4srsRSnJFoqMVcVJwI
        ADwH5COrAgAA
X-CMS-MailID: 20200326155847eucas1p1ed7286be9fa1a0616efc2d148bffe50d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200326155847eucas1p1ed7286be9fa1a0616efc2d148bffe50d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200326155847eucas1p1ed7286be9fa1a0616efc2d148bffe50d
References: <20200326155822.19400-1-b.zolnierkie@samsung.com>
        <CGME20200326155847eucas1p1ed7286be9fa1a0616efc2d148bffe50d@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

* move ata_qc_complete_multiple() to libata-sata.c

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  32559     572      40   33171    8193 drivers/ata/libata-core.o
after:
  32162     572      40   32774    8006 drivers/ata/libata-core.o

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 59 ---------------------------------------
 drivers/ata/libata-sata.c | 59 +++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h    |  2 +-
 3 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 19624d056d92..2ef0960b2154 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4749,65 +4749,6 @@ u64 ata_qc_get_active(struct ata_port *ap)
 }
 EXPORT_SYMBOL_GPL(ata_qc_get_active);
 
-/**
- *	ata_qc_complete_multiple - Complete multiple qcs successfully
- *	@ap: port in question
- *	@qc_active: new qc_active mask
- *
- *	Complete in-flight commands.  This functions is meant to be
- *	called from low-level driver's interrupt routine to complete
- *	requests normally.  ap->qc_active and @qc_active is compared
- *	and commands are completed accordingly.
- *
- *	Always use this function when completing multiple NCQ commands
- *	from IRQ handlers instead of calling ata_qc_complete()
- *	multiple times to keep IRQ expect status properly in sync.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- *
- *	RETURNS:
- *	Number of completed commands on success, -errno otherwise.
- */
-int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active)
-{
-	u64 done_mask, ap_qc_active = ap->qc_active;
-	int nr_done = 0;
-
-	/*
-	 * If the internal tag is set on ap->qc_active, then we care about
-	 * bit0 on the passed in qc_active mask. Move that bit up to match
-	 * the internal tag.
-	 */
-	if (ap_qc_active & (1ULL << ATA_TAG_INTERNAL)) {
-		qc_active |= (qc_active & 0x01) << ATA_TAG_INTERNAL;
-		qc_active ^= qc_active & 0x01;
-	}
-
-	done_mask = ap_qc_active ^ qc_active;
-
-	if (unlikely(done_mask & qc_active)) {
-		ata_port_err(ap, "illegal qc_active transition (%08llx->%08llx)\n",
-			     ap->qc_active, qc_active);
-		return -EINVAL;
-	}
-
-	while (done_mask) {
-		struct ata_queued_cmd *qc;
-		unsigned int tag = __ffs64(done_mask);
-
-		qc = ata_qc_from_tag(ap, tag);
-		if (qc) {
-			ata_qc_complete(qc);
-			nr_done++;
-		}
-		done_mask &= ~(1ULL << tag);
-	}
-
-	return nr_done;
-}
-EXPORT_SYMBOL_GPL(ata_qc_complete_multiple);
-
 /**
  *	ata_qc_issue - issue taskfile to device
  *	@qc: command to issue to device
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 05a1872ba329..849582e0d653 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -603,6 +603,65 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
 }
 EXPORT_SYMBOL_GPL(sata_link_hardreset);
 
+/**
+ *	ata_qc_complete_multiple - Complete multiple qcs successfully
+ *	@ap: port in question
+ *	@qc_active: new qc_active mask
+ *
+ *	Complete in-flight commands.  This functions is meant to be
+ *	called from low-level driver's interrupt routine to complete
+ *	requests normally.  ap->qc_active and @qc_active is compared
+ *	and commands are completed accordingly.
+ *
+ *	Always use this function when completing multiple NCQ commands
+ *	from IRQ handlers instead of calling ata_qc_complete()
+ *	multiple times to keep IRQ expect status properly in sync.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ *
+ *	RETURNS:
+ *	Number of completed commands on success, -errno otherwise.
+ */
+int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active)
+{
+	u64 done_mask, ap_qc_active = ap->qc_active;
+	int nr_done = 0;
+
+	/*
+	 * If the internal tag is set on ap->qc_active, then we care about
+	 * bit0 on the passed in qc_active mask. Move that bit up to match
+	 * the internal tag.
+	 */
+	if (ap_qc_active & (1ULL << ATA_TAG_INTERNAL)) {
+		qc_active |= (qc_active & 0x01) << ATA_TAG_INTERNAL;
+		qc_active ^= qc_active & 0x01;
+	}
+
+	done_mask = ap_qc_active ^ qc_active;
+
+	if (unlikely(done_mask & qc_active)) {
+		ata_port_err(ap, "illegal qc_active transition (%08llx->%08llx)\n",
+			     ap->qc_active, qc_active);
+		return -EINVAL;
+	}
+
+	while (done_mask) {
+		struct ata_queued_cmd *qc;
+		unsigned int tag = __ffs64(done_mask);
+
+		qc = ata_qc_from_tag(ap, tag);
+		if (qc) {
+			ata_qc_complete(qc);
+			nr_done++;
+		}
+		done_mask &= ~(1ULL << tag);
+	}
+
+	return nr_done;
+}
+EXPORT_SYMBOL_GPL(ata_qc_complete_multiple);
+
 /**
  *	ata_slave_link_init - initialize slave link
  *	@ap: port to initialize slave link for
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 981f73c02509..08fec96a6a1e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1160,7 +1160,6 @@ extern void ata_id_c_string(const u16 *id, unsigned char *s,
 extern unsigned int ata_do_dev_read_id(struct ata_device *dev,
 					struct ata_taskfile *tf, u16 *id);
 extern void ata_qc_complete(struct ata_queued_cmd *qc);
-extern int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active);
 extern u64 ata_qc_get_active(struct ata_port *ap);
 extern void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd);
 extern int ata_std_bios_param(struct scsi_device *sdev,
@@ -1232,6 +1231,7 @@ extern int ata_slave_link_init(struct ata_port *ap);
 extern void ata_tf_to_fis(const struct ata_taskfile *tf,
 			  u8 pmp, int is_cmd, u8 *fis);
 extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
+extern int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active);
 extern bool sata_lpm_ignore_phy_events(struct ata_link *link);
 
 extern int ata_cable_40wire(struct ata_port *ap);
-- 
2.24.1

