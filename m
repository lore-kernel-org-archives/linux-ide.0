Return-Path: <SRS0=jBxd=5L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05348C2D0E5
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 15:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B8D2073E
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 15:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dC1r49yo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgCZP7N (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:59:13 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58902 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbgCZP6v (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2020 11:58:51 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200326155849euoutp01d60dc41069ad35c3bae86616e7bf3ddc~-5dyYWGeo2919829198euoutp01C
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2020 15:58:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200326155849euoutp01d60dc41069ad35c3bae86616e7bf3ddc~-5dyYWGeo2919829198euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585238329;
        bh=ClzUpKG2VnZyQz5IwFzjQO6Uh0tMYISB0yCrxJPnVFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dC1r49youdBr/QYIULYgn5AI7i0x980bElLa3a4n7bP1JbHz/fyttSV1+p7AAoviw
         kQSrRQTg5Sef6rJpcDyejh9wV4Dcz9yiTIwPOn049fKHv5+Ycau9YshPAjne9qPjrs
         fskYgdjB3vgYjAxWEGxCcHLt0UKRjrKoU/3llk4U=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200326155849eucas1p2e54138f2d5ccc6bb6daaefd4788f8ef8~-5dyDUXqD2255222552eucas1p2T;
        Thu, 26 Mar 2020 15:58:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A3.06.61286.931DC7E5; Thu, 26
        Mar 2020 15:58:49 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155848eucas1p1c9c2ca0451748cdfa4ab6a3420ab2847~-5dxnHQeX2422724227eucas1p18;
        Thu, 26 Mar 2020 15:58:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200326155848eusmtrp179162452eb08329f6e215f85bf92ace0~-5dxmka5v2090020900eusmtrp1z;
        Thu, 26 Mar 2020 15:58:48 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-d7-5e7cd139aba8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E3.6A.08375.831DC7E5; Thu, 26
        Mar 2020 15:58:48 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155848eusmtip179a6e09043f77af95a8bb31428580121~-5dxKEjG91235312353eusmtip12;
        Thu, 26 Mar 2020 15:58:48 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v5 25/27] ata: start separating SATA specific code from
 libata-eh.c
Date:   Thu, 26 Mar 2020 16:58:20 +0100
Message-Id: <20200326155822.19400-26-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200326155822.19400-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djP87qWF2viDP5uZrZYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBlTn71kLHhmXDGl7wVjA+MrjS5GTg4J
        AROJp1d2MHYxcnEICaxglJh/YDMbhPOFUeLrmR4WCOczo8TelZOZYVouvt0CVbWcUWLe15MI
        LTunP2MEqWITsJKY2L4KzBYRUJDo+b0SrIhZ4D2jxIpJe1lAEsICoRL9y54xgdgsAqoSa2/P
        YgOxeQXsJD7N+84GsU5eYuu3T6wgNidQfPm6+cwQNYISJ2c+AZvDDFTTvHU2M8gCCYFl7BLL
        ljYADeUAclwk7m23gpgjLPHq+BZ2CFtG4vRkiN8kBNYxSvzteAHVvJ1RYvnkf1CbrSXunPvF
        BjKIWUBTYv0ufYiwo8ScK/vZIObzSdx4KwhxA5/EpG3TmSHCvBIdbUIQ1WoSG5ZtYINZ27Vz
        JTQUPSRe3X3BPoFRcRaSb2Yh+WYWwt4FjMyrGMVTS4tz01OLDfNSy/WKE3OLS/PS9ZLzczcx
        AlPR6X/HP+1g/Hop6RCjAAejEg+vRktNnBBrYllxZe4hRgkOZiUR3qeRQCHelMTKqtSi/Pii
        0pzU4kOM0hwsSuK8xotexgoJpCeWpGanphakFsFkmTg4pRoYA7dez9aqXNRfWnL04MFDy2LE
        OMo+LtXTiO76x/5tEqfB4Zc/HXmkaiY7+tQ8mRwQ9VXOOkYjdN/dRWFSGWaXjK8uaP4qOjVp
        74ojP/b3iNdtVTslsGNPwA6hPvnPz48W2W24kcIV/nn5q/CbW39mzj7dxH9Bmk/n60FZd5Fb
        mTZfK7MXxDwTUmIpzkg01GIuKk4EAFdAOIxBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xu7oWF2viDBrWKVisvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYypz14yFjwzrpjS94KxgfGVRhcjJ4eEgInExbdb2LoYuTiEBJYyStxt
        b2buYuQASshIHF9fBlEjLPHnWhdUzSdGic7rE5lAEmwCVhIT21cxgtgiAgoSPb9XghUxC3xl
        lFg6qZsZJCEsECzx9fAjFhCbRUBVYu3tWWwgNq+AncSned/ZIDbIS2z99okVxOYEii9fNx+s
        V0jAVmLxlw9MEPWCEidnPgGbwwxU37x1NvMERoFZSFKzkKQWMDKtYhRJLS3OTc8tNtQrTswt
        Ls1L10vOz93ECIyYbcd+bt7BeGlj8CFGAQ5GJR5ejZaaOCHWxLLiytxDjBIczEoivE8jgUK8
        KYmVValF+fFFpTmpxYcYTYGemMgsJZqcD4zmvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJ
        JanZqakFqUUwfUwcnFINjLWl/2d95g2b9uDTCrlTJ5LvzJTkvbLrnUXKuerSu6cFVgWpqUg/
        2HtJ2WFS/ak2M8XFK/fMVG3k61We1NfXyXz65xRVkZ2PlWUUOvq+Wdwr21fVlpryP/eb1pbf
        DZbFR/a8WLOHLevjClbdPu+Kxra83qqDbyyf/ZJkZLapFr5yPbCs4fSmuUosxRmJhlrMRcWJ
        AFSwUiSuAgAA
X-CMS-MailID: 20200326155848eucas1p1c9c2ca0451748cdfa4ab6a3420ab2847
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200326155848eucas1p1c9c2ca0451748cdfa4ab6a3420ab2847
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200326155848eucas1p1c9c2ca0451748cdfa4ab6a3420ab2847
References: <20200326155822.19400-1-b.zolnierkie@samsung.com>
        <CGME20200326155848eucas1p1c9c2ca0451748cdfa4ab6a3420ab2847@eucas1p1.samsung.com>
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
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
index da899f18a3e9..9c7ca659dc94 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1240,6 +1240,7 @@ extern void ata_tf_to_fis(const struct ata_taskfile *tf,
 extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
 extern int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active);
 extern bool sata_lpm_ignore_phy_events(struct ata_link *link);
+extern int sata_async_notification(struct ata_port *ap);
 
 extern int ata_cable_40wire(struct ata_port *ap);
 extern int ata_cable_80wire(struct ata_port *ap);
@@ -1332,7 +1333,6 @@ extern void ata_port_wait_eh(struct ata_port *ap);
 extern int ata_link_abort(struct ata_link *link);
 extern int ata_port_abort(struct ata_port *ap);
 extern int ata_port_freeze(struct ata_port *ap);
-extern int sata_async_notification(struct ata_port *ap);
 
 extern void ata_eh_freeze_port(struct ata_port *ap);
 extern void ata_eh_thaw_port(struct ata_port *ap);
-- 
2.24.1

