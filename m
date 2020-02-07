Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D045C3F68F
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F3F218AC
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PDbgAzph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgBGO2G (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:28:06 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49685 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgBGO2F (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:28:05 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142803euoutp0228fba9a896d27060907cade100b335a5~xJQ1yfNi02598725987euoutp02Q
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:28:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200207142803euoutp0228fba9a896d27060907cade100b335a5~xJQ1yfNi02598725987euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085683;
        bh=Gm7GS6/l8ZQE666ZiHRPCjTBX17aKesxrF1xG+DUNEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PDbgAzphqpjcxHyylvtatMLNZJubNZucnpaOrhPsJl2K5gxWsQMRTsVJUaTgNYyIB
         l/K3n1gT+CHkAc4QsIWMxXaebwoGjkI7zeSECHT4zU6JiJvq3ZHD7D+R3Po6hvZXWq
         EdRr755+GszjVjqIpw+wAXaJ7BnGJjR6KL8XF9W8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200207142803eucas1p2e5871ed74b2b6d0368e70223de5cad03~xJQ1ZXu_M2432324323eucas1p2e;
        Fri,  7 Feb 2020 14:28:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 55.D8.60698.3F37D3E5; Fri,  7
        Feb 2020 14:28:03 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142803eucas1p2625a00402342b1279344ec2ab6d4db5b~xJQ1IUr7h3192231922eucas1p23;
        Fri,  7 Feb 2020 14:28:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200207142803eusmtrp2024e1a793dc95c8e1cf11e9f5783d920~xJQ1Hpylo1102911029eusmtrp2M;
        Fri,  7 Feb 2020 14:28:03 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-d5-5e3d73f3dd4d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 62.99.08375.3F37D3E5; Fri,  7
        Feb 2020 14:28:03 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142802eusmtip284545e053b4a6c6a414ab2a19a43c4a2~xJQ0r-ys53158331583eusmtip2C;
        Fri,  7 Feb 2020 14:28:02 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v2 24/26] ata: start separating SATA specific code from
 libata-eh.c
Date:   Fri,  7 Feb 2020 15:27:32 +0100
Message-Id: <20200207142734.8431-25-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207142734.8431-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djPc7qfi23jDLY/lLBYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBmXHh1mL9hpXNGzopm1gfGQRhcjB4eE
        gInE2oeZXYxcHEICKxgl3t5tZ4VwvjBKLNqxng3C+cwo8XD/LpYuRk6wjt0dj5ghEssZJXq3
        3GCHa9nb+ZQdpIpNwEpiYvsqRhBbREBBouf3SrBRzALvGSVWTNoLNkpYIFTi3v6jbCA2i4Cq
        xOuWz2BxXgFbid4HnUwQ6+Qltn77xApicwLFP075ywZRIyhxcuYTsHpmoJrmrbPBTpIQWMUu
        sWvvTqhbXST+LJ/LDGELS7w6voUdwpaR+L9zPhNEwzpGib8dL6C6tzNKLJ/8jw2iylrizrlf
        bKBwYhbQlFi/Sx8i7CjR3bWTCRJ8fBI33gpCHMEnMWnbdGaIMK9ER5sQRLWaxIZlG9hg1nbt
        XAlV4iHx73j6BEbFWUi+mYXkm1kIaxcwMq9iFE8tLc5NTy02zkst1ytOzC0uzUvXS87P3cQI
        TESn/x3/uoNx35+kQ4wCHIxKPLwJjjZxQqyJZcWVuYcYJTiYlUR4+1Rt44R4UxIrq1KL8uOL
        SnNSiw8xSnOwKInzGi96GSskkJ5YkpqdmlqQWgSTZeLglGpgnGbyMsKJM9WvqE2hdGK8++vO
        1aFLC48f5LaPE+d0r92cK7Vfe2uEcsCSqpaXd/bNsJhh+qB2w+PA6jiBtLuCqbe3HJyodHWS
        QnxhdlWB2ax193637IqR4ipmnHe1nGPF6TX/Tv7a3KSxKvY0w5I/DX6Pti6JuRuXfXxOdd4U
        S4PPQo1dc/+EKrEUZyQaajEXFScCAAdr63dAAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xe7qfi23jDD7P57BYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehmXHh1mL9hpXNGzopm1gfGQRhcjJ4eEgInE7o5HzF2MXBxCAksZJV7O
        OMHYxcgBlJCROL6+DKJGWOLPtS42iJpPjBLbHmxjBUmwCVhJTGxfxQhiiwgoSPT8XglWxCzw
        lVFi6aRuZpBBwgLBErN2SILUsAioSrxu+cwCYvMK2Er0PuhkglggL7H12yewmZxA8Y9T/rKB
        2EICNhLf309ih6gXlDg58wlYLzNQffPW2cwTGAVmIUnNQpJawMi0ilEktbQ4Nz232FCvODG3
        uDQvXS85P3cTIzBeth37uXkH46WNwYcYBTgYlXh4Exxt4oRYE8uKK3MPMUpwMCuJ8Pap2sYJ
        8aYkVlalFuXHF5XmpBYfYjQFemIis5Rocj4wlvNK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmk
        J5akZqemFqQWwfQxcXBKNTCquffpZtwveNKsO5Wby/7WzeyI+7WPdNZ61WkcTTZxyX22MLxt
        +v25gj+7/595qmwV4BPyeM1SI5auycbH3CqZtR6XVbEsZj815XhlITvvo6AFjOI3X02ve9x5
        mOFn64r+iU/WVy9ibpDWObKIPafGrqhP7bVsj/2jxe7+h57yBZzcstjqk6USS3FGoqEWc1Fx
        IgABuzCcrQIAAA==
X-CMS-MailID: 20200207142803eucas1p2625a00402342b1279344ec2ab6d4db5b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200207142803eucas1p2625a00402342b1279344ec2ab6d4db5b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200207142803eucas1p2625a00402342b1279344ec2ab6d4db5b
References: <20200207142734.8431-1-b.zolnierkie@samsung.com>
        <CGME20200207142803eucas1p2625a00402342b1279344ec2ab6d4db5b@eucas1p2.samsung.com>
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
index 33225cb2c6cc..24de4b66ce36 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1242,6 +1242,7 @@ extern void ata_tf_to_fis(const struct ata_taskfile *tf,
 extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
 extern int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active);
 extern bool sata_lpm_ignore_phy_events(struct ata_link *link);
+extern int sata_async_notification(struct ata_port *ap);
 
 extern int ata_cable_40wire(struct ata_port *ap);
 extern int ata_cable_80wire(struct ata_port *ap);
@@ -1333,7 +1334,6 @@ extern void ata_port_wait_eh(struct ata_port *ap);
 extern int ata_link_abort(struct ata_link *link);
 extern int ata_port_abort(struct ata_port *ap);
 extern int ata_port_freeze(struct ata_port *ap);
-extern int sata_async_notification(struct ata_port *ap);
 
 extern void ata_eh_freeze_port(struct ata_port *ap);
 extern void ata_eh_thaw_port(struct ata_port *ap);
-- 
2.24.1

