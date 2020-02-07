Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C01EC3B185
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10155217BA
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MCftVho0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbgBGO2f (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:28:35 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59696 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgBGO2E (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:28:04 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142802euoutp01d90581fcc6d32382f60e13fa17f6a0d4~xJQ0Jxo6h2241722417euoutp01O
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:28:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200207142802euoutp01d90581fcc6d32382f60e13fa17f6a0d4~xJQ0Jxo6h2241722417euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085682;
        bh=TiPIWO6MDYi7os92ARDe8b4H4IphgPoYs5BziYZ30yU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MCftVho0MfE7tL4UBUlOf0S6/9Pn2t/wPEhlESG6yuJc7sYe/l2tBohUdhTm3mruf
         2ZLVrJiqv8J6CH1IIli+6Icvsvy4SVUnJSF/AX1pJh3AzUZ7K9/EQ7cXRojZNBZnSW
         BSbCw02yDu6QsIWodZqYY9STXQwuzWkoCqQVTo8M=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200207142801eucas1p158c8c1343ca8a28be8f208f32db07470~xJQzju-0k1078610786eucas1p1z;
        Fri,  7 Feb 2020 14:28:01 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 32.5D.60679.1F37D3E5; Fri,  7
        Feb 2020 14:28:01 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142801eucas1p27ac052c180ec3adab13543d1c0817a05~xJQzOLGHo0410804108eucas1p23;
        Fri,  7 Feb 2020 14:28:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200207142801eusmtrp17b934dc20febd9973bf979ff962e105d~xJQzNlvmE0480004800eusmtrp1U;
        Fri,  7 Feb 2020 14:28:01 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-85-5e3d73f1ca13
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DF.89.08375.0F37D3E5; Fri,  7
        Feb 2020 14:28:01 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142800eusmtip20b9016301baa33458877a48f263780fc~xJQyte_xj3155831558eusmtip2O;
        Fri,  7 Feb 2020 14:28:00 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v2 20/26] ata: move ata_qc_complete_multiple() to
 libata-sata.c
Date:   Fri,  7 Feb 2020 15:27:28 +0100
Message-Id: <20200207142734.8431-21-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207142734.8431-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djP87ofi23jDO71SFmsvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoLpuU1JzMstQifbsErowt520LmvUrlpzYxtrAOEWti5GTQ0LA
        ROLD2x7mLkYuDiGBFYwSS3oes0I4Xxgl/j/6zwThfGaU2Df7LitMy7rfm6ASyxklVs/pRWiZ
        sXIRC0gVm4CVxMT2VYwgtoiAgkTP75VsIEXMAu8ZJVZM2gtWJCwQKHHuYzMziM0ioCoxr3UW
        E4jNK2ArsWDOcWaIdfISW799AlvNCRT/OOUvG0SNoMTJmU/A5jAD1TRvnQ32hYTAMnaJrTMa
        mSCaXSTmXZ/HDmELS7w6vgXKlpE4PbmHBaJhHaPE344XUN3bGSWWT/7HBlFlLXHn3C8gmwNo
        habE+l36EGFHiW9tvYwgYQkBPokbbwUhjuCTmLRtOjNEmFeio00IolpNYsOyDWwwa7t2roT6
        y0NizcU1zBMYFWcheWcWkndmIexdwMi8ilE8tbQ4Nz212CgvtVyvODG3uDQvXS85P3cTIzAV
        nf53/MsOxl1/kg4xCnAwKvHwJjjaxAmxJpYVV+YeYpTgYFYS4e1TtY0T4k1JrKxKLcqPLyrN
        SS0+xCjNwaIkzmu86GWskEB6YklqdmpqQWoRTJaJg1OqgVG5W+XB9a9Vfy7+sO9furDxvkh7
        w4lnq+xPuckfCdVfG1We81CK5ZvOhvf9J9Ywr+c3upu3TWuG6vPqi5lS2/2138+w27VmRo3+
        3ubKJrV2P77wOjlV/Wm/vALNJ5wNmnZH7LjGviWeh5283x/uuTZ5+ulFF6ovtQcbuSs16O8q
        MfWqvqN366MSS3FGoqEWc1FxIgBXezr+QQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xe7ofi23jDD75W6y+289msXHGelaL
        Z7f2MlmsXH2UyeLYjkdMFpd3zWGzWP5kLbPF3Nbp7A4cHjtn3WX3uHy21OPQ4Q5Gj5Ot31g8
        dt9sYPPo27KK0ePzJrkA9ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07
        m5TUnMyy1CJ9uwS9jC3nbQua9SuWnNjG2sA4Ra2LkZNDQsBEYt3vTUxdjFwcQgJLGSXuXNjB
        2sXIAZSQkTi+vgyiRljiz7UuNoiaT4wSl77vZQZJsAlYSUxsX8UIYosIKEj0/F4JVsQs8JVR
        YumkbrAiYQF/ie77+5lAbBYBVYl5rbPAbF4BW4kFc44zQ2yQl9j67RMriM0JFP845S8biC0k
        YCPx/f0kdoh6QYmTM5+wgNjMQPXNW2czT2AUmIUkNQtJagEj0ypGkdTS4tz03GJDveLE3OLS
        vHS95PzcTYzAaNl27OfmHYyXNgYfYhTgYFTi4U1wtIkTYk0sK67MPcQowcGsJMLbp2obJ8Sb
        klhZlVqUH19UmpNafIjRFOiJicxSosn5wEjOK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5Y
        kpqdmlqQWgTTx8TBKdXAmGmTPccy1/3QlxWsEclZC9c3T97gcXlL2hWr2GczBP64uPya6fVs
        abtsNruw5uzGRMUn/bVMukkLFpyPbzgRfbfj7MfP31T1OlmMfT7uZP85b5f6T52DyYa1S2z0
        9qxXsd02L/iuZTjvkgk3pabscG7+pJe886aVT1v8h/V3Urn38z3XEBXSUGIpzkg01GIuKk4E
        AOkjbUysAgAA
X-CMS-MailID: 20200207142801eucas1p27ac052c180ec3adab13543d1c0817a05
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200207142801eucas1p27ac052c180ec3adab13543d1c0817a05
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200207142801eucas1p27ac052c180ec3adab13543d1c0817a05
References: <20200207142734.8431-1-b.zolnierkie@samsung.com>
        <CGME20200207142801eucas1p27ac052c180ec3adab13543d1c0817a05@eucas1p2.samsung.com>
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

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 59 ---------------------------------------
 drivers/ata/libata-sata.c | 59 +++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h    |  2 +-
 3 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index cd0febf26dd5..bf98ae0d3f4e 100644
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
index 0c8c3b6eac9f..01f9d3746bf1 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1162,7 +1162,6 @@ extern void ata_id_c_string(const u16 *id, unsigned char *s,
 extern unsigned int ata_do_dev_read_id(struct ata_device *dev,
 					struct ata_taskfile *tf, u16 *id);
 extern void ata_qc_complete(struct ata_queued_cmd *qc);
-extern int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active);
 extern u64 ata_qc_get_active(struct ata_port *ap);
 extern void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd);
 extern int ata_std_bios_param(struct scsi_device *sdev,
@@ -1234,6 +1233,7 @@ extern int ata_slave_link_init(struct ata_port *ap);
 extern void ata_tf_to_fis(const struct ata_taskfile *tf,
 			  u8 pmp, int is_cmd, u8 *fis);
 extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
+extern int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active);
 extern bool sata_lpm_ignore_phy_events(struct ata_link *link);
 
 extern int ata_cable_40wire(struct ata_port *ap);
-- 
2.24.1

