Return-Path: <SRS0=dw68=3R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494FBC33CB3
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BCB24688
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gN8jXqnR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgA1Nee (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:34:34 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58897 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgA1NeV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jan 2020 08:34:21 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200128133420euoutp01ef780dc49c6a7277d3351466be2d64e1~uEFExvVmj0325703257euoutp01R
        for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2020 13:34:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200128133420euoutp01ef780dc49c6a7277d3351466be2d64e1~uEFExvVmj0325703257euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580218460;
        bh=pKCHxmLFgloCufJUhTXfQk8jti0gj8T4/UNwwnqUITk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gN8jXqnRa6fzxsZEBX/iQaa3vFFiYkrgqTN+eJA+ywGDy44Yx4w97yr+yZbD49OnB
         wY5sscUaipnV6Z4rPa81b7lih28bryR88blY5ywgFDa/DDNofOfm7lMK1nkamr3C2d
         upFRJ67LE2UZKd8KMWktxKyk2nwEctQR7BnKOvvQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200128133419eucas1p16e9f753f60812e80b51c2e968d6ed319~uEFEnhNF40714007140eucas1p1o;
        Tue, 28 Jan 2020 13:34:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 68.5A.60679.B58303E5; Tue, 28
        Jan 2020 13:34:19 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133419eucas1p293e7f2e62e74c9208a30fd83650e8615~uEFEUJBW-0474204742eucas1p2Y;
        Tue, 28 Jan 2020 13:34:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200128133419eusmtrp2fe02c5a35e93f939d087ea1b00cc047a~uEFETbAcc0330103301eusmtrp2_;
        Tue, 28 Jan 2020 13:34:19 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-61-5e30385bfc93
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 15.82.07950.B58303E5; Tue, 28
        Jan 2020 13:34:19 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133419eusmtip29a86a1b37f149255148f57a28935142c~uEFD1s7iJ0724907249eusmtip2B;
        Tue, 28 Jan 2020 13:34:19 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 26/28] ata: start separating SATA specific code from
 libata-eh.c
Date:   Tue, 28 Jan 2020 14:33:41 +0100
Message-Id: <20200128133343.29905-27-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128133343.29905-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7djP87rRFgZxBm23rC1W3+1ns9g4Yz2r
        xbNbe5ksju14xGRxedccNou5rdPZHdg8ds66y+5x+Wypx6HDHYwefVtWMXp83iQXwBrFZZOS
        mpNZllqkb5fAlXF8/0TWgrWWFbN3WDcwHtbtYuTkkBAwkTi24hhLFyMXh5DACkaJqY2z2CGc
        L4wSbR0ToDKfGSXOdexkgmm5eeghI0RiOaPErxvbWeFapr6bDVbFJmAlMbF9FSOILSKgINHz
        eyUbSBGzwBpGiVWHm8ASwgJBEtunPwSzWQRUJT5tPcMKYvMK2EmsXjGRHWKdvMTWb5+A4hwc
        nEDxnr3mECWCEidnPmEBsZmBSpq3zmYGmS8h0M4u8ePcD2aIXheJM4e2QJ0tLPHq+BaomTIS
        /3fOZ4JoWMco8bfjBVT3dkaJ5ZP/sUFUWUvcOfeLDWQzs4CmxPpd+iCmhICjxJ/p4RAmn8SN
        t4IQN/BJTNo2nRkizCvR0SYEMUNNYsOyDWwwW7t2roQq8ZDYeJhtAqPiLCTPzELyzCyErQsY
        mVcxiqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIEJpfT/45/2cG460/SIUYBDkYlHt4ZKgZx
        QqyJZcWVuYcYJTiYlUR4O5mAQrwpiZVVqUX58UWlOanFhxilOViUxHmNF72MFRJITyxJzU5N
        LUgtgskycXBKNTBu2fLTN1HU33Dz+u3XDZqj9Pj3Nf2c33XBmEvo/KmcszVmnCdiLflyJjhP
        ebva0bQ9Sifk3aN81WCxy26P6lNvOs+9GHlml2P55ideO9ZocBvOMp8xd+ufpKQTFcmGzIHS
        aZ6Jv3muz7gwPT1/+4yFD16uaOpl+lj6Kc5uz+pEzbqSmBmqaeeVWIozEg21mIuKEwGxf1hn
        KgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42I5/e/4Pd1oC4M4g+MblSxW3+1ns9g4Yz2r
        xbNbe5ksju14xGRxedccNou5rdPZHdg8ds66y+5x+Wypx6HDHYwefVtWMXp83iQXwBqlZ1OU
        X1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl3F8/0TWgrWW
        FbN3WDcwHtbtYuTkkBAwkbh56CFjFyMXh5DAUkaJd1+PM3UxcgAlZCSOry+DqBGW+HOtiw2i
        5hOjxN3LN5hBEmwCVhIT21cxgtgiAgoSPb9XghUxC2xglHh18wsLSEJYIEDiV9tjNhCbRUBV
        4tPWM6wgNq+AncTqFRPZITbIS2z99okVZDEnULxnrzlIWEjAVmL9madQ5YISJ2c+ARvJDFTe
        vHU28wRGgVlIUrOQpBYwMq1iFEktLc5Nzy020itOzC0uzUvXS87P3cQIjIJtx35u2cHY9S74
        EKMAB6MSD6+DkkGcEGtiWXFl7iFGCQ5mJRHeTiagEG9KYmVValF+fFFpTmrxIUZToB8mMkuJ
        JucDIzSvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVAOj2BdvMXNh
        VpsOw68PfyvMan2iqby8nOOjP4vqfhPG8s3vnhaWfExb/O958n69ZC43hpUl93Qq5XxXKTQL
        F2rVnX66YZaEiKqgYtyLx9M/lG7q9k4+5VNnH8ZXebQo58TcjKTvXdcYmJR5Ih/ty3Wcl8Bm
        PePfl1PlFytTFpwTN21m0NW+HqHEUpyRaKjFXFScCABvDXkWmAIAAA==
X-CMS-MailID: 20200128133419eucas1p293e7f2e62e74c9208a30fd83650e8615
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133419eucas1p293e7f2e62e74c9208a30fd83650e8615
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133419eucas1p293e7f2e62e74c9208a30fd83650e8615
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133419eucas1p293e7f2e62e74c9208a30fd83650e8615@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Start separating SATA specific code from libata-eh.c:

* move sata_async_notification() to libata-eh-sata.c:

* cover sata_async_notification() with CONFIG_SATA_HOST ifdef
  in <linux/libata.h>

* include libata-eh-sata.c in the build when CONFIG_SATA_HOST=y

Code size savings on m68k arch using atari_defconfig:

   text    data     bss     dec     hex filename
before:
  16889      18       0   16907    420b drivers/ata/libata-eh.o
after:
  16810      18       0   16828    41bc drivers/ata/libata-eh.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/Makefile         |  3 +-
 drivers/ata/libata-eh-sata.c | 85 ++++++++++++++++++++++++++++++++++++
 drivers/ata/libata-eh.c      | 74 -------------------------------
 include/linux/libata.h       |  8 +++-
 4 files changed, 94 insertions(+), 76 deletions(-)
 create mode 100644 drivers/ata/libata-eh-sata.c

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index d6fb3d4a2ac5..6bdbbcce8fef 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -123,7 +123,8 @@ obj-$(CONFIG_PATA_LEGACY)	+= pata_legacy.o
 
 libata-y	:= libata-core.o libata-scsi.o libata-eh.o \
 	libata-transport.o libata-trace.o
-libata-$(CONFIG_SATA_HOST)	+= libata-core-sata.o libata-scsi-sata.o
+libata-$(CONFIG_SATA_HOST)	+= libata-core-sata.o libata-scsi-sata.o \
+	libata-eh-sata.o
 libata-$(CONFIG_ATA_SFF)	+= libata-sff.o
 libata-$(CONFIG_SATA_PMP)	+= libata-pmp.o
 libata-$(CONFIG_ATA_ACPI)	+= libata-acpi.o
diff --git a/drivers/ata/libata-eh-sata.c b/drivers/ata/libata-eh-sata.c
new file mode 100644
index 000000000000..4b6dc715629a
--- /dev/null
+++ b/drivers/ata/libata-eh-sata.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  libata-eh.c - SATA specific part of libata error handling
+ *
+ *  Copyright 2006 Tejun Heo <htejun@gmail.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/libata.h>
+
+#include "libata.h"
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
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 04275f4c8d36..201165955b90 100644
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
diff --git a/include/linux/libata.h b/include/linux/libata.h
index eb2797c27547..d09997e2290b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1335,7 +1335,6 @@ extern void ata_port_wait_eh(struct ata_port *ap);
 extern int ata_link_abort(struct ata_link *link);
 extern int ata_port_abort(struct ata_port *ap);
 extern int ata_port_freeze(struct ata_port *ap);
-extern int sata_async_notification(struct ata_port *ap);
 
 extern void ata_eh_freeze_port(struct ata_port *ap);
 extern void ata_eh_thaw_port(struct ata_port *ap);
@@ -1352,6 +1351,13 @@ extern void ata_std_sched_eh(struct ata_port *ap);
 extern void ata_std_end_eh(struct ata_port *ap);
 extern int ata_link_nr_enabled(struct ata_link *link);
 
+/*
+ * SATA specific part of EH - drivers/ata/libata-eh-sata.c
+ */
+#ifdef CONFIG_SATA_HOST
+extern int sata_async_notification(struct ata_port *ap);
+#endif
+
 /*
  * Base operations to inherit from and initializers for sht
  *
-- 
2.24.1

