Return-Path: <SRS0=AjNr=5C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6327C2BB1D
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86D020735
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fcPg+Gn+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgCQOoD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:44:03 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40521 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbgCQOn4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Mar 2020 10:43:56 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200317144354euoutp024424b7659e1dd48a58ff6c9babe8248a~9HozZ378L1539915399euoutp02h
        for <linux-ide@vger.kernel.org>; Tue, 17 Mar 2020 14:43:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200317144354euoutp024424b7659e1dd48a58ff6c9babe8248a~9HozZ378L1539915399euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584456234;
        bh=U2kX3IO/lZayHMzeMAkQmYVh3yaslasgfl9Yy1BChc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fcPg+Gn+TZDNEi6q+luiXS/iveEc4n7YwjycOMSkwuWFgurG5n1P5YhWlq5g5v6rM
         TXq2bQSP6aApqMLcshchxzhvYgKljliw5p4VLjQXrWWVS8y0xdJcEIgYqyVFIujbzv
         dfzg6f17oCudk6SeJquDup4Za+TG4z7vS/Hrt5YQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200317144353eucas1p16c1095f3a3ae4a33a6b65e5496f9ffe5~9HozIeUbQ1085210852eucas1p1I;
        Tue, 17 Mar 2020 14:43:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A6.E3.61286.922E07E5; Tue, 17
        Mar 2020 14:43:53 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200317144353eucas1p22a8a5d4a9c920db90387720159a26c90~9Hoy0V1XU0560005600eucas1p2V;
        Tue, 17 Mar 2020 14:43:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200317144353eusmtrp11a629ddfb8a8d9fecfcb9bd0534d99da~9Hoyx8VER0867908679eusmtrp1y;
        Tue, 17 Mar 2020 14:43:53 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-45-5e70e2292fd9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D4.E4.08375.922E07E5; Tue, 17
        Mar 2020 14:43:53 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144352eusmtip1d8028fdecd32e30ed8278fb1a6031103~9HoyReMyM1027610276eusmtip1E;
        Tue, 17 Mar 2020 14:43:52 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v4 25/27] ata: start separating SATA specific code from
 libata-eh.c
Date:   Tue, 17 Mar 2020 15:43:31 +0100
Message-Id: <20200317144333.2904-26-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317144333.2904-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djPc7qajwriDL7vMbNYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBlLzvayF+w0rlixo5GlgfGQRhcjJ4eE
        gInE6pmnmLsYuTiEBFYwSkx/twTK+cIo8a7jHCNIlZDAZ0aJCdudYTp23zrMBlG0nFFi2bE5
        CB3fv89lBqliE7CSmNi+CqxbREBBouf3SrAOZoH3jBIrJu1lAUkIC4RKLJrwHsxmEVCV2Lf5
        B1gzr4CtxKe9fSwQ6+Qltn77xApicwLFrx3+xwZRIyhxcuYTsBpmoJrmrbPBrpAQWMYuMWnH
        S6hmF4kbzxYyQ9jCEq+Ob2GHsGUkTk/uYYFoWMco8bfjBVT3dkaJ5ZMhVkgIWEvcOfcLyOYA
        WqEpsX6XPkTYUeL0+RnMIGEJAT6JG28FIY7gk5i0bTpUmFeio00IolpNYsOyDWwwa7t2roQ6
        x0Niz+Tp7BMYFWcheWcWkndmIexdwMi8ilE8tbQ4Nz212DAvtVyvODG3uDQvXS85P3cTIzAV
        nf53/NMOxq+Xkg4xCnAwKvHwcmwoiBNiTSwrrsw9xCjBwawkwru4MD9OiDclsbIqtSg/vqg0
        J7X4EKM0B4uSOK/xopexQgLpiSWp2ampBalFMFkmDk6pBkZZv9KujhsvbzfNm9qtGfmMO0l2
        yrXUD/cKD6fEu91sSZ0kcODbnXNPAq4fusl0deaxtw0fnhz9r7TUY9L7qaG7hb4dKjlcFlX3
        8rN+g8tN9m/vjv+xLMu0Np0YPKX2/EQZ3vWaP9PNYk2m3Gr1entjl2v8ApZqWbUul4BP26eF
        Hua5IL6u6VWXEktxRqKhFnNRcSIAUlhvm0EDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xu7qajwriDE7uk7JYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehlLzvayF+w0rlixo5GlgfGQRhcjJ4eEgInE7luH2boYuTiEBJYySlzs
        ecHUxcgBlJCROL6+DKJGWOLPtS6omk+MEo+OPmIESbAJWElMbF8FZosIKEj0/F4JVsQs8JVR
        YumkbmaQhLBAsMSKlZdYQWwWAVWJfZt/gMV5BWwlPu3tY4HYIC+x9dsnsBpOoPi1w//YQGwh
        ARuJF2/+M0HUC0qcnPkErJ4ZqL5562zmCYwCs5CkZiFJLWBkWsUoklpanJueW2yoV5yYW1ya
        l66XnJ+7iREYMduO/dy8g/HSxuBDjAIcjEo8vBwbCuKEWBPLiitzDzFKcDArifAuLsyPE+JN
        SaysSi3Kjy8qzUktPsRoCvTERGYp0eR8YDTnlcQbmhqaW1gamhubG5tZKInzdggcjBESSE8s
        Sc1OTS1ILYLpY+LglGpglGZvlG39uLz0/Grp1b/O+u32EPhZ3Jj5+bQkx7nyibb2Nn/WWKxm
        beb94OPQW9Gm/j79x5kLr94sj4gtuvJha4sQyz2FNX29/70u3mdRmC13/bPjV7Xp7ZcbJ2RO
        ++kvsHNzuNPi6K5v6q9WvhZ6qMU/aaNyyM7skw4rbgvrXHNdzxrr6StxUomlOCPRUIu5qDgR
        AMCxJ2iuAgAA
X-CMS-MailID: 20200317144353eucas1p22a8a5d4a9c920db90387720159a26c90
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200317144353eucas1p22a8a5d4a9c920db90387720159a26c90
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200317144353eucas1p22a8a5d4a9c920db90387720159a26c90
References: <20200317144333.2904-1-b.zolnierkie@samsung.com>
        <CGME20200317144353eucas1p22a8a5d4a9c920db90387720159a26c90@eucas1p2.samsung.com>
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
index 452c30024f81..9ca777a24117 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1089,80 +1089,6 @@ int ata_port_freeze(struct ata_port *ap)
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
index ad11a77a307c..eff744727dc0 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -4,6 +4,7 @@
  *
  *  Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
  *  Copyright 2003-2004 Jeff Garzik
+ *  Copyright 2006 Tejun Heo <htejun@gmail.com>
  */
 
 #include <linux/kernel.h>
@@ -1272,3 +1273,77 @@ void ata_sas_free_tag(unsigned int tag, struct ata_port *ap)
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
index 2d81ea2ccf12..556fc5d367aa 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1242,6 +1242,7 @@ extern void ata_tf_to_fis(const struct ata_taskfile *tf,
 extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
 extern int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active);
 extern bool sata_lpm_ignore_phy_events(struct ata_link *link);
+extern int sata_async_notification(struct ata_port *ap);
 
 extern int ata_cable_40wire(struct ata_port *ap);
 extern int ata_cable_80wire(struct ata_port *ap);
@@ -1335,7 +1336,6 @@ extern void ata_port_wait_eh(struct ata_port *ap);
 extern int ata_link_abort(struct ata_link *link);
 extern int ata_port_abort(struct ata_port *ap);
 extern int ata_port_freeze(struct ata_port *ap);
-extern int sata_async_notification(struct ata_port *ap);
 
 extern void ata_eh_freeze_port(struct ata_port *ap);
 extern void ata_eh_thaw_port(struct ata_port *ap);
-- 
2.24.1

