Return-Path: <SRS0=dw68=3R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7E5C33CB3
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4509B22522
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ErSftcT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgA1NfW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:35:22 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58896 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgA1NeR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jan 2020 08:34:17 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200128133416euoutp01baf0c60b41b972d31ee849665c48eb70~uEFBYAo5p0325703257euoutp01L
        for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2020 13:34:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200128133416euoutp01baf0c60b41b972d31ee849665c48eb70~uEFBYAo5p0325703257euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580218456;
        bh=9GC41GZxsu9pE/kEPtcdNoCfP8ZZpAvDx72nJ/t5b5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ErSftcT7fuYEpEulBSvxDYwH1zck4TT9hjY1SMJX2Tn6lX60JQMTwtImEb9INpCYF
         Aevd7X8duTooH/L2EkEhFLkeIuvhIyn0OJeyI5JKuAqOK5kw5qrpzg39IqiRwUDk7F
         t6pU2zV/i6Rbuo/kqAK/PigWBJ5MsJjDLG3o1/cU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200128133416eucas1p170536042e847b1d13cd09fc51ec308ae~uEFBGrF7S1372113721eucas1p1F;
        Tue, 28 Jan 2020 13:34:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F8.DA.60698.858303E5; Tue, 28
        Jan 2020 13:34:16 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200128133415eucas1p12cc620dd5f19e6a26f1deeba083ea82f~uEFAwye7t0714007140eucas1p1j;
        Tue, 28 Jan 2020 13:34:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200128133415eusmtrp2be066cc50ecb226b9de5031f609a3522~uEFAq2Mvj0330103301eusmtrp2z;
        Tue, 28 Jan 2020 13:34:15 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-bc-5e3038589b4c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 71.82.07950.758303E5; Tue, 28
        Jan 2020 13:34:15 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133415eusmtip270e3d36fdc14666da25e0e6e36854a2f~uEFAS4n1z0657106571eusmtip2i;
        Tue, 28 Jan 2020 13:34:15 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 15/28] ata: move sata_print_link_status() to
 libata-core-sata.c
Date:   Tue, 28 Jan 2020 14:33:30 +0100
Message-Id: <20200128133343.29905-16-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128133343.29905-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djP87oRFgZxBuv/cVmsvtvPZrFxxnpW
        i2e39jJZHNvxiMni8q45bBZzW6ezO7B57Jx1l93j8tlSj0OHOxg9+rasYvT4vEkugDWKyyYl
        NSezLLVI3y6BK+PU9DtMBcdlK/Zu72ZqYHwt3sXIySEhYCJxdf5Uxi5GLg4hgRWMEnu+LWKB
        cL4wSlzrmw2V+cwo0f6gnQWmZfXeXcwgtpDAckaJD/uL4Dqm9j0BK2ITsJKY2L6KEcQWEVCQ
        6Pm9kg2kiFlgDaPEqsNNYAlhgUCJ210bmUBsFgFViRfdu8CaeQXsJL6ffgi1TV5i67dPrF2M
        HBycQPGeveYQJYISJ2dC7GIGKmneOpsZorydXeLskWoI20Vi5atGJghbWOLV8S3sELaMxP+d
        85lA7pEQWMco8bfjBTOEs51RYvnkf2wQVdYSd879YgNZzCygKbF+lz5E2FFi5vfT7CBhCQE+
        iRtvBSFu4JOYtG06M0SYV6KjTQiiWk1iw7INbDBru3auhDrTQ+Ll6TbWCYyKs5B8MwvJN7MQ
        9i5gZF7FKJ5aWpybnlpsnJdarlecmFtcmpeul5yfu4kRmF5O/zv+dQfjvj9JhxgFOBiVeHgd
        lAzihFgTy4orcw8xSnAwK4nwdjIBhXhTEiurUovy44tKc1KLDzFKc7AoifMaL3oZKySQnliS
        mp2aWpBaBJNl4uCUamA8/2pZc2n4V68DnTq7/0ipS29r3Dq16qnbvrz1Fy4enfyme780Z+4/
        k3xdyQNB7N2BGTGBUZcskjgufdr/bZnTKzmp1we8u4PiuhZ59z2Smy5fqrh2LdeZYN6kCKk5
        eRImbkntrWJxp37oXIv6XbKkYGa9UNbrWYprTk1/ZXprvdefJsNbtxqVWIozEg21mIuKEwHk
        OXu+KwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42I5/e/4Pd1wC4M4gwWPNSxW3+1ns9g4Yz2r
        xbNbe5ksju14xGRxedccNou5rdPZHdg8ds66y+5x+Wypx6HDHYwefVtWMXp83iQXwBqlZ1OU
        X1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl3Fq+h2mguOy
        FXu3dzM1ML4W72Lk5JAQMJFYvXcXcxcjF4eQwFJGic2rTrB3MXIAJWQkjq8vg6gRlvhzrYsN
        ouYTo8Tk9cuZQRJsAlYSE9tXMYLYIgIKEj2/V4IVMQtsYJR4dfMLC0hCWMBfYv/++2A2i4Cq
        xIvuXWA2r4CdxPfTD1kgNshLbP32iRVkMSdQvGevOUhYSMBWYv2Zp6wQ5YISJ2c+AStnBipv
        3jqbeQKjwCwkqVlIUgsYmVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIExsG2Yz+37GDsehd8
        iFGAg1GJh9dBySBOiDWxrLgy9xCjBAezkghvJxNQiDclsbIqtSg/vqg0J7X4EKMp0A8TmaVE
        k/OBMZpXEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoGxearq3HYG
        jhd2591M1so8UOq++Sr0q9KaoI8HtJ/nyj6Qn+JZuHpX/YxV19m61ctyv81o6PcL9Nugm5Tl
        cj6j+G1r1DIxpbMPX27u36jHLCkctyztgCdn6KtP+jJfPq8XnrnceV2h+px6lUUTV50OCWnq
        ObLQ3O7HguBL+pNcJ3jMEqoOO2ioxFKckWioxVxUnAgAp50g2JkCAAA=
X-CMS-MailID: 20200128133415eucas1p12cc620dd5f19e6a26f1deeba083ea82f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133415eucas1p12cc620dd5f19e6a26f1deeba083ea82f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133415eucas1p12cc620dd5f19e6a26f1deeba083ea82f
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133415eucas1p12cc620dd5f19e6a26f1deeba083ea82f@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

* move sata_print_link_status() to libata-core-sata.c

* add static inline for CONFIG_SATA_HOST=n case

Code size savings on m68k arch using atari_defconfig:

   text    data     bss     dec     hex filename
before:
  35499     572      40   36111    8d0f drivers/ata/libata-core.o
after:
  35276     572      40   35888    8c30 drivers/ata/libata-core.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core-sata.c | 27 +++++++++++++++++++++++++++
 drivers/ata/libata-core.c      | 27 ---------------------------
 drivers/ata/libata.h           |  2 ++
 3 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/ata/libata-core-sata.c b/drivers/ata/libata-core-sata.c
index f2629e069a55..8ad8f97660df 100644
--- a/drivers/ata/libata-core-sata.c
+++ b/drivers/ata/libata-core-sata.c
@@ -258,6 +258,33 @@ int ata_dev_config_ncq(struct ata_device *dev, char *desc, size_t desc_sz)
 	return 0;
 }
 
+/**
+ *	sata_print_link_status - Print SATA link status
+ *	@link: SATA link to printk link status about
+ *
+ *	This function prints link speed and status of a SATA link.
+ *
+ *	LOCKING:
+ *	None.
+ */
+void sata_print_link_status(struct ata_link *link)
+{
+	u32 sstatus, scontrol, tmp;
+
+	if (sata_scr_read(link, SCR_STATUS, &sstatus))
+		return;
+	sata_scr_read(link, SCR_CONTROL, &scontrol);
+
+	if (ata_phys_link_online(link)) {
+		tmp = (sstatus >> 4) & 0xf;
+		ata_link_info(link, "SATA link up %s (SStatus %X SControl %X)\n",
+			      sata_spd_string(tmp), sstatus, scontrol);
+	} else {
+		ata_link_info(link, "SATA link down (SStatus %X SControl %X)\n",
+			      sstatus, scontrol);
+	}
+}
+
 /**
  *	sata_link_scr_lpm - manipulate SControl IPM and SPM fields
  *	@link: ATA link to manipulate SControl for
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0a90e0e65f0b..73f732a32261 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2742,33 +2742,6 @@ int ata_bus_probe(struct ata_port *ap)
 	goto retry;
 }
 
-/**
- *	sata_print_link_status - Print SATA link status
- *	@link: SATA link to printk link status about
- *
- *	This function prints link speed and status of a SATA link.
- *
- *	LOCKING:
- *	None.
- */
-static void sata_print_link_status(struct ata_link *link)
-{
-	u32 sstatus, scontrol, tmp;
-
-	if (sata_scr_read(link, SCR_STATUS, &sstatus))
-		return;
-	sata_scr_read(link, SCR_CONTROL, &scontrol);
-
-	if (ata_phys_link_online(link)) {
-		tmp = (sstatus >> 4) & 0xf;
-		ata_link_info(link, "SATA link up %s (SStatus %X SControl %X)\n",
-			      sata_spd_string(tmp), sstatus, scontrol);
-	} else {
-		ata_link_info(link, "SATA link down (SStatus %X SControl %X)\n",
-			      sstatus, scontrol);
-	}
-}
-
 /**
  *	ata_dev_pair		-	return other device on cable
  *	@adev: device
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 24b08efd79a3..909c2cae52a0 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -102,6 +102,7 @@ static inline bool ata_log_supported(struct ata_device *dev, u8 log)
 #ifdef CONFIG_SATA_HOST
 int ata_do_link_spd_horkage(struct ata_device *dev);
 int ata_dev_config_ncq(struct ata_device *dev, char *desc, size_t desc_sz);
+void sata_print_link_status(struct ata_link *link);
 #else
 static inline int ata_do_link_spd_horkage(struct ata_device *dev) { return 0; }
 static inline int ata_dev_config_ncq(struct ata_device *dev, char *desc,
@@ -110,6 +111,7 @@ static inline int ata_dev_config_ncq(struct ata_device *dev, char *desc,
 	desc[0] = '\0';
 	return 0;
 }
+static inline void sata_print_link_status(struct ata_link *link) { }
 #endif
 
 /* libata-acpi.c */
-- 
2.24.1

