Return-Path: <SRS0=ljer=4P=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC34C11D3D
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54EC1246AE
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QAUfD7qY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbgB0SXR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:23:17 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39715 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731032AbgB0SWw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Feb 2020 13:22:52 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200227182251euoutp01726018a4ff634a958afc2230d46d4970~3VXja4pX81216412164euoutp01w
        for <linux-ide@vger.kernel.org>; Thu, 27 Feb 2020 18:22:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200227182251euoutp01726018a4ff634a958afc2230d46d4970~3VXja4pX81216412164euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582827771;
        bh=C1QhB8NTuZP6sDzL87SmQE/aWN4sqoccQ81vuaPwNQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QAUfD7qYn7eubg0gDEI/pAQqlg/GYCd0JC8bJAb4aPQcSC55jJMXGkakJJ6hFj4zt
         DIZatwc2Jxc+SJfE3RoC6K8d7JWLzENUTCMrK0rBe8vnvFCcp05LvqVSQnhN2KGmvG
         o6SWpvmTwEC7SIeoTxB2/Bz1GLcMLV+D+tD178fE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200227182251eucas1p2c1ce243d5113362c799f59a08f855bff~3VXjCE7zJ2058320583eucas1p2f;
        Thu, 27 Feb 2020 18:22:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 77.5F.61286.BF8085E5; Thu, 27
        Feb 2020 18:22:51 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182250eucas1p2140d4ae6f3f65f2b712027dab63de3bd~3VXiv1xyL1998119981eucas1p2k;
        Thu, 27 Feb 2020 18:22:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200227182250eusmtrp1c90af0009b093627d3d2a87114c7483f~3VXivNXbg0110301103eusmtrp1h;
        Thu, 27 Feb 2020 18:22:50 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-6f-5e5808fb7ed0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 38.61.07950.AF8085E5; Thu, 27
        Feb 2020 18:22:50 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182250eusmtip2730c8a9044163edf489bed11d38fd4a7~3VXiRpAxp3109031090eusmtip2w;
        Thu, 27 Feb 2020 18:22:50 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v3 25/27] ata: start separating SATA specific code from
 libata-eh.c
Date:   Thu, 27 Feb 2020 19:22:24 +0100
Message-Id: <20200227182226.19188-26-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227182226.19188-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djP87q/OSLiDHp7WCxW3+1ns9g4Yz2r
        xbNbe5ksVq4+ymRxbMcjJovLu+awWSx/spbZYm7rdHYHDo+ds+6ye1w+W+px6HAHo8fJ1m8s
        HrtvNrB59G1ZxejxeZNcAHsUl01Kak5mWWqRvl0CV8bEJ22sBTuNKz7Oa2NpYDyk0cXIySEh
        YCLxe/F3xi5GLg4hgRWMEoc/9TKCJIQEvjBKfOgUg0h8ZpTYvv4eE0zH86fHoTqWM0qcXP2L
        GcIB6pj+fAc7SBWbgJXExPZVYKNEBBQken6vZAMpYhZ4zyixYtJeFpCEsECoxP79IA0cHCwC
        qhKPr8uChHkF7CQuXHzJCLFNXmLrt0+sIDYnUPxG33Y2iBpBiZMzn4CNYQaqad46G+wICYFV
        7BKrLp1jBJkpIeAi8fG3DMQcYYlXx7ewQ9gyEqcn97BA1K9jlPjb8QKqeTujxPLJ/9ggqqwl
        7pz7xQYyiFlAU2L9Ln2IsKPE4y/P2SHm80nceCsIcQOfxKRt05khwrwSHW1CENVqEhuWbWCD
        Wdu1cyVUiYfE96saExgVZyF5ZhaSZ2YhrF3AyLyKUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/
        dxMjMAmd/nf80w7Gr5eSDjEKcDAq8fAu2BEeJ8SaWFZcmXuIUYKDWUmEd+PX0Dgh3pTEyqrU
        ovz4otKc1OJDjNIcLErivMaLXsYKCaQnlqRmp6YWpBbBZJk4OKUaGGv/5CQnzLoi8Td+O6/1
        Ipu5D5QUhOZqb5nv4yw4X6ckNy3d5lqgZEHmtpI/qyRZT5UtYDBqXPp6jcbdSB6BBee+L/pU
        u73VQPWz7CU+5qNXQx40fMkS2v/30lIWpQRDhm1nbF9ziQVOWft3otuVqSoKvyV0uC+maJyw
        Ub8iei9S88ucuKeXWpVYijMSDbWYi4oTAYr4kK8+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xe7q/OCLiDNq+G1isvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYyJT9pYC3YaV3yc18bSwHhIo4uRk0NCwETi+dPjjF2MXBxCAksZJX42
        TGDrYuQASshIHF9fBlEjLPHnWhcbRM0nRol/Nz4ygiTYBKwkJravArNFBBQken6vBCtiFvjK
        KLF0UjczyCBhgWCJljfcICaLgKrE4+uyIOW8AnYSFy6+ZISYLy+x9dsnVhCbEyh+o287G4gt
        JGAr0dXxlBGiXlDi5MwnLCA2M1B989bZzBMYBWYhSc1CklrAyLSKUSS1tDg3PbfYSK84Mbe4
        NC9dLzk/dxMjMFq2Hfu5ZQdj17vgQ4wCHIxKPLwe28LjhFgTy4orcw8xSnAwK4nwbvwaGifE
        m5JYWZValB9fVJqTWnyI0RToh4nMUqLJ+cBIziuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCe
        WJKanZpakFoE08fEwSnVwMh/9l2+hvzVvkJpg7udl2RWHFv3NamMS2LqP/nIRczn9l1g2fhs
        Ppfl+oOfBNa+cLbVelHFPPur1xXnO4bNGzK+Giyc1l28VcKP74uC3PMksQelitM5PD+mBPVF
        JVxgPGO+kOdt/+cbHovmfuP+nl/32u+CgvE3ofDAUu4lK4N2cpzaJXsqyVKJpTgj0VCLuag4
        EQDhVCK2rAIAAA==
X-CMS-MailID: 20200227182250eucas1p2140d4ae6f3f65f2b712027dab63de3bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200227182250eucas1p2140d4ae6f3f65f2b712027dab63de3bd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200227182250eucas1p2140d4ae6f3f65f2b712027dab63de3bd
References: <20200227182226.19188-1-b.zolnierkie@samsung.com>
        <CGME20200227182250eucas1p2140d4ae6f3f65f2b712027dab63de3bd@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Start separating SATA specific code from libata-eh.c:

* move sata_async_notification() to libata-sata.c:

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  16243      18       0   16261    3f85 drivers/ata/libata-eh.o
after:
  16164      18       0   16182    3f36 drivers/ata/libata-eh.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-eh.c   | 74 --------------------------------------
 drivers/ata/libata-sata.c | 75 +++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h    |  2 +-
 3 files changed, 76 insertions(+), 75 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 8dc33b6832f0..ef4d606cd8c6 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1092,80 +1092,6 @@ int ata_port_freeze(struct ata_port *ap)
 }
 EXPORT_SYMBOL_GPL(ata_port_freeze);
 
-/**
- *	sata_async_notification - SATA async notification handler
- *	@ap: ATA port where async notification is received
- *
- *	Handler to be called when async notification via SDB FIS is
- *	received.  This function schedules EH if necessary.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- *
- *	RETURNS:
- *	1 if EH is scheduled, 0 otherwise.
- */
-int sata_async_notification(struct ata_port *ap)
-{
-	u32 sntf;
-	int rc;
-
-	if (!(ap->flags & ATA_FLAG_AN))
-		return 0;
-
-	rc = sata_scr_read(&ap->link, SCR_NOTIFICATION, &sntf);
-	if (rc == 0)
-		sata_scr_write(&ap->link, SCR_NOTIFICATION, sntf);
-
-	if (!sata_pmp_attached(ap) || rc) {
-		/* PMP is not attached or SNTF is not available */
-		if (!sata_pmp_attached(ap)) {
-			/* PMP is not attached.  Check whether ATAPI
-			 * AN is configured.  If so, notify media
-			 * change.
-			 */
-			struct ata_device *dev = ap->link.device;
-
-			if ((dev->class == ATA_DEV_ATAPI) &&
-			    (dev->flags & ATA_DFLAG_AN))
-				ata_scsi_media_change_notify(dev);
-			return 0;
-		} else {
-			/* PMP is attached but SNTF is not available.
-			 * ATAPI async media change notification is
-			 * not used.  The PMP must be reporting PHY
-			 * status change, schedule EH.
-			 */
-			ata_port_schedule_eh(ap);
-			return 1;
-		}
-	} else {
-		/* PMP is attached and SNTF is available */
-		struct ata_link *link;
-
-		/* check and notify ATAPI AN */
-		ata_for_each_link(link, ap, EDGE) {
-			if (!(sntf & (1 << link->pmp)))
-				continue;
-
-			if ((link->device->class == ATA_DEV_ATAPI) &&
-			    (link->device->flags & ATA_DFLAG_AN))
-				ata_scsi_media_change_notify(link->device);
-		}
-
-		/* If PMP is reporting that PHY status of some
-		 * downstream ports has changed, schedule EH.
-		 */
-		if (sntf & (1 << SATA_PMP_CTRL_PORT)) {
-			ata_port_schedule_eh(ap);
-			return 1;
-		}
-
-		return 0;
-	}
-}
-EXPORT_SYMBOL_GPL(sata_async_notification);
-
 /**
  *	ata_eh_freeze_port - EH helper to freeze port
  *	@ap: ATA port to freeze
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 2d934ccfc930..008468e516cd 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -4,6 +4,7 @@
  *
  *  Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
  *  Copyright 2003-2004 Jeff Garzik
+ *  Copyright 2006 Tejun Heo <htejun@gmail.com>
  */
 
 #include <linux/kernel.h>
@@ -1275,3 +1276,77 @@ void ata_sas_free_tag(unsigned int tag, struct ata_port *ap)
 {
 	clear_bit(tag, &ap->sas_tag_allocated);
 }
+
+/**
+ *	sata_async_notification - SATA async notification handler
+ *	@ap: ATA port where async notification is received
+ *
+ *	Handler to be called when async notification via SDB FIS is
+ *	received.  This function schedules EH if necessary.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ *
+ *	RETURNS:
+ *	1 if EH is scheduled, 0 otherwise.
+ */
+int sata_async_notification(struct ata_port *ap)
+{
+	u32 sntf;
+	int rc;
+
+	if (!(ap->flags & ATA_FLAG_AN))
+		return 0;
+
+	rc = sata_scr_read(&ap->link, SCR_NOTIFICATION, &sntf);
+	if (rc == 0)
+		sata_scr_write(&ap->link, SCR_NOTIFICATION, sntf);
+
+	if (!sata_pmp_attached(ap) || rc) {
+		/* PMP is not attached or SNTF is not available */
+		if (!sata_pmp_attached(ap)) {
+			/* PMP is not attached.  Check whether ATAPI
+			 * AN is configured.  If so, notify media
+			 * change.
+			 */
+			struct ata_device *dev = ap->link.device;
+
+			if ((dev->class == ATA_DEV_ATAPI) &&
+			    (dev->flags & ATA_DFLAG_AN))
+				ata_scsi_media_change_notify(dev);
+			return 0;
+		} else {
+			/* PMP is attached but SNTF is not available.
+			 * ATAPI async media change notification is
+			 * not used.  The PMP must be reporting PHY
+			 * status change, schedule EH.
+			 */
+			ata_port_schedule_eh(ap);
+			return 1;
+		}
+	} else {
+		/* PMP is attached and SNTF is available */
+		struct ata_link *link;
+
+		/* check and notify ATAPI AN */
+		ata_for_each_link(link, ap, EDGE) {
+			if (!(sntf & (1 << link->pmp)))
+				continue;
+
+			if ((link->device->class == ATA_DEV_ATAPI) &&
+			    (link->device->flags & ATA_DFLAG_AN))
+				ata_scsi_media_change_notify(link->device);
+		}
+
+		/* If PMP is reporting that PHY status of some
+		 * downstream ports has changed, schedule EH.
+		 */
+		if (sntf & (1 << SATA_PMP_CTRL_PORT)) {
+			ata_port_schedule_eh(ap);
+			return 1;
+		}
+
+		return 0;
+	}
+}
+EXPORT_SYMBOL_GPL(sata_async_notification);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 550adfa05cc1..6d6fb25cc650 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1242,6 +1242,7 @@ extern void ata_tf_to_fis(const struct ata_taskfile *tf,
 extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
 extern int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active);
 extern bool sata_lpm_ignore_phy_events(struct ata_link *link);
+extern int sata_async_notification(struct ata_port *ap);
 
 extern int ata_cable_40wire(struct ata_port *ap);
 extern int ata_cable_80wire(struct ata_port *ap);
@@ -1334,7 +1335,6 @@ extern void ata_port_wait_eh(struct ata_port *ap);
 extern int ata_link_abort(struct ata_link *link);
 extern int ata_port_abort(struct ata_port *ap);
 extern int ata_port_freeze(struct ata_port *ap);
-extern int sata_async_notification(struct ata_port *ap);
 
 extern void ata_eh_freeze_port(struct ata_port *ap);
 extern void ata_eh_thaw_port(struct ata_port *ap);
-- 
2.24.1

