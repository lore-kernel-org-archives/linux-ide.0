Return-Path: <SRS0=dw68=3R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DB2C33CB2
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A660324688
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VQmvCVGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgA1NeV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:34:21 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52418 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgA1NeT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jan 2020 08:34:19 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200128133418euoutp0244c9b5c998ad1c130975a6bad2121997~uEFC1HLi12858228582euoutp02C
        for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2020 13:34:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200128133418euoutp0244c9b5c998ad1c130975a6bad2121997~uEFC1HLi12858228582euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580218458;
        bh=CEDKPDVx78ARY0rhMGLN2/WrTMo5btTHp+8A5sbfC1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VQmvCVGYEOkEPeJvGkrd3pd0IQxbVSXBhOWo37kS9LU3jCjiE+x2OFSl/rMCPtLtf
         JpHzlkbOU34NfeLPZBpMnTyDMdoliAYPfVVd/Ily1tgpnrFwICbp2DQEeAHBs9avaD
         9nxas4TjXlv2XGK4byZ2u+zAxqVavdVzG9Gl/GuY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200128133417eucas1p132d7a2b0e104d8e0824b4096c93fb000~uEFCqj6s20713407134eucas1p1w;
        Tue, 28 Jan 2020 13:34:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A0.DA.61286.958303E5; Tue, 28
        Jan 2020 13:34:17 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133417eucas1p28b1e3fbb20c686bd75997f5339993071~uEFCKwOc51871818718eucas1p2L;
        Tue, 28 Jan 2020 13:34:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200128133417eusmtrp2e7c771d1b394cb125aefe84d2ce57772~uEFCKQkDi0330003300eusmtrp27;
        Tue, 28 Jan 2020 13:34:17 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-8a-5e3038597d59
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A2.82.07950.958303E5; Tue, 28
        Jan 2020 13:34:17 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133417eusmtip296496a0bc9275258b5d53e4f03cac4aa~uEFB16PmA0113601136eusmtip2H;
        Tue, 28 Jan 2020 13:34:16 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 20/28] ata: move sata_link_init_spd() to libata-core-sata.c
Date:   Tue, 28 Jan 2020 14:33:35 +0100
Message-Id: <20200128133343.29905-21-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128133343.29905-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djPc7qRFgZxBt++mFisvtvPZrFxxnpW
        i2e39jJZHNvxiMni8q45bBZzW6ezO7B57Jx1l93j8tlSj0OHOxg9+rasYvT4vEkugDWKyyYl
        NSezLLVI3y6BK+PE7V2sBWe0K57fP8TSwHhJuYuRk0NCwETiSNs+pi5GLg4hgRWMEp1P26Gc
        L4wSs47/ZIZwPjNKNPxfwNrFyAHWcrVNGyK+nFHiz/xFrHAdkzsOs4HMZROwkpjYvooRxBYR
        UJDo+b2SDaSIWWANo8Sqw01gCWEBb4mFv76wgNgsAqoSDc9ngDXzCthJzHx7mAXiQHmJrd8+
        gW3mBIr37DWHKBGUODnzCVgJM1BJ89bZYJdKCDSzS2w52s4O0esi8bTxMyuELSzx6vgWqLiM
        xP+d85kgGtYxSvzteAHVvZ1RYvnkf2wQVdYSd879YgPZzCygKbF+lz5E2FHi+Lp7LJCg4JO4
        8VYQ4gg+iUnbpjNDhHklOtqEIKrVJDYs28AGs7Zr50qoEg+JmadLJjAqzkLyzSwk38xCWLuA
        kXkVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYHo5/e/4px2MXy8lHWIU4GBU4uGdoWIQ
        J8SaWFZcmXuIUYKDWUmEt5MJKMSbklhZlVqUH19UmpNafIhRmoNFSZzXeNHLWCGB9MSS1OzU
        1ILUIpgsEwenVAOjBFPrpQcqXKX7q022uLuZtAs/9Gow3WnIeuzN3uTZ3iccvWJcRVUM+A6u
        c7d4qhwq+6ReWVJ9w8neHbm1ItG8qxeuz6/ISLvwq7c4csYvtl3vNj/ezyp47tmFiI6VrxSP
        9bpIR1uyTJBJCPZyv2RRcy/5tMtyV6/fcxTj2AVkjqTVz53V2KXEUpyRaKjFXFScCAAvEc2y
        KwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42I5/e/4Pd1IC4M4g08tIhar7/azWWycsZ7V
        4tmtvUwWx3Y8YrK4vGsOm8Xc1unsDmweO2fdZfe4fLbU49DhDkaPvi2rGD0+b5ILYI3SsynK
        Ly1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQyzhxexdrwRnt
        iuf3D7E0MF5S7mLk4JAQMJG42qbdxcjJISSwlFHixm0ziLCMxPH1ZSBhCQFhiT/Xuti6GLmA
        Sj4xSpyc/YIVJMEmYCUxsX0VI4gtIqAg0fN7JVgRs8AGRolXN7+wgCSEBbwlFv6CsFkEVCUa
        ns9gA7F5BewkZr49zAKxQV5i67dPrCCLOYHiPXvNIe6xlVh/5ikrRLmgxMmZT8DKmYHKm7fO
        Zp7AKDALSWoWktQCRqZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgTGw7djPLTsYu94FH2IU
        4GBU4uF1UDKIE2JNLCuuzD3EKMHBrCTC28kEFOJNSaysSi3Kjy8qzUktPsRoCvTDRGYp0eR8
        YHzmlcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpgXHUrWWLxaWWD
        2S+0H6ySsTsx+17ehdhD9m4S+xaEv3vCslpxrxj71WS+m08N03Yd0Iq+uTrfWEbhnDVX72KW
        pTmcIpZttawnmwP+8h5g/pZnV/9KetoVvc7kjS3ah1k4D0+Z1cly5Mq1QJHm4OWX3308UJjT
        d37NxbfTpzD8VJ9udJVxtiarmxJLcUaioRZzUXEiAL4si3+XAgAA
X-CMS-MailID: 20200128133417eucas1p28b1e3fbb20c686bd75997f5339993071
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133417eucas1p28b1e3fbb20c686bd75997f5339993071
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133417eucas1p28b1e3fbb20c686bd75997f5339993071
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133417eucas1p28b1e3fbb20c686bd75997f5339993071@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

* move sata_link_init_spd() to libata-core-sata.c

* add static inline for CONFIG_SATA_HOST=n case

* cover ata_force_link_limits() with CONFIG_SATA_HOST ifdef (it
  depends on code from libata-core.c while its only user is in
  libata-core-sata.c)

Code size savings on m68k arch using atari_defconfig:

   text    data     bss     dec     hex filename
before:
  33574     572      40   34186    858a drivers/ata/libata-core.o
after:
  33212     572      40   33824    8420 drivers/ata/libata-core.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core-sata.c | 33 ++++++++++++++++++++++++++++++
 drivers/ata/libata-core.c      | 37 +++-------------------------------
 drivers/ata/libata.h           |  7 ++++++-
 3 files changed, 42 insertions(+), 35 deletions(-)

diff --git a/drivers/ata/libata-core-sata.c b/drivers/ata/libata-core-sata.c
index b43207396829..8c6ed82dc166 100644
--- a/drivers/ata/libata-core-sata.c
+++ b/drivers/ata/libata-core-sata.c
@@ -772,6 +772,39 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
 }
 EXPORT_SYMBOL_GPL(sata_link_hardreset);
 
+/**
+ *	sata_link_init_spd - Initialize link->sata_spd_limit
+ *	@link: Link to configure sata_spd_limit for
+ *
+ *	Initialize @link->[hw_]sata_spd_limit to the currently
+ *	configured value.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno on failure.
+ */
+int sata_link_init_spd(struct ata_link *link)
+{
+	u8 spd;
+	int rc;
+
+	rc = sata_scr_read(link, SCR_CONTROL, &link->saved_scontrol);
+	if (rc)
+		return rc;
+
+	spd = (link->saved_scontrol >> 4) & 0xf;
+	if (spd)
+		link->hw_sata_spd_limit &= (1 << spd) - 1;
+
+	ata_force_link_limits(link);
+
+	link->sata_spd_limit = link->hw_sata_spd_limit;
+
+	return 0;
+}
+
 /**
  *	ata_slave_link_init - initialize slave link
  *	@ap: port to initialize slave link for
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index bd82cab2996e..17f1d98eab71 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -338,6 +338,7 @@ void ata_force_cbl(struct ata_port *ap)
 	}
 }
 
+#ifdef CONFIG_SATA_HOST
 /**
  *	ata_force_link_limits - force link limits according to libata.force
  *	@link: ATA link of interest
@@ -354,7 +355,7 @@ void ata_force_cbl(struct ata_port *ap)
  *	LOCKING:
  *	EH context.
  */
-static void ata_force_link_limits(struct ata_link *link)
+void ata_force_link_limits(struct ata_link *link)
 {
 	bool did_spd = false;
 	int linkno = link->pmp;
@@ -389,6 +390,7 @@ static void ata_force_link_limits(struct ata_link *link)
 		}
 	}
 }
+#endif
 
 /**
  *	ata_force_xfermask - force xfermask according to libata.force
@@ -5078,39 +5080,6 @@ void ata_link_init(struct ata_port *ap, struct ata_link *link, int pmp)
 	}
 }
 
-/**
- *	sata_link_init_spd - Initialize link->sata_spd_limit
- *	@link: Link to configure sata_spd_limit for
- *
- *	Initialize @link->[hw_]sata_spd_limit to the currently
- *	configured value.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep).
- *
- *	RETURNS:
- *	0 on success, -errno on failure.
- */
-int sata_link_init_spd(struct ata_link *link)
-{
-	u8 spd;
-	int rc;
-
-	rc = sata_scr_read(link, SCR_CONTROL, &link->saved_scontrol);
-	if (rc)
-		return rc;
-
-	spd = (link->saved_scontrol >> 4) & 0xf;
-	if (spd)
-		link->hw_sata_spd_limit &= (1 << spd) - 1;
-
-	ata_force_link_limits(link);
-
-	link->sata_spd_limit = link->hw_sata_spd_limit;
-
-	return 0;
-}
-
 /**
  *	ata_port_alloc - allocate and initialize basic ATA port resources
  *	@host: ATA host this allocated port belongs to
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 518a8e08a26d..8f5da7be88fe 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -76,7 +76,6 @@ extern bool ata_phys_link_online(struct ata_link *link);
 extern bool ata_phys_link_offline(struct ata_link *link);
 extern void ata_dev_init(struct ata_device *dev);
 extern void ata_link_init(struct ata_port *ap, struct ata_link *link, int pmp);
-extern int sata_link_init_spd(struct ata_link *link);
 extern int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg);
 extern int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg);
 extern struct ata_port *ata_port_alloc(struct ata_host *host);
@@ -85,6 +84,7 @@ extern int ata_port_probe(struct ata_port *ap);
 extern void __ata_port_probe(struct ata_port *ap);
 extern unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 				      u8 page, void *buf, unsigned int sectors);
+extern void ata_force_link_limits(struct ata_link *link);
 
 static inline bool ata_sstatus_online(u32 sstatus)
 {
@@ -108,6 +108,7 @@ int ata_do_link_spd_horkage(struct ata_device *dev);
 int ata_dev_config_ncq(struct ata_device *dev, char *desc, size_t desc_sz);
 void sata_print_link_status(struct ata_link *link);
 int sata_down_spd_limit(struct ata_link *link, u32 spd_limit);
+int sata_link_init_spd(struct ata_link *link);
 #else
 static inline int ata_do_link_spd_horkage(struct ata_device *dev) { return 0; }
 static inline int ata_dev_config_ncq(struct ata_device *dev, char *desc,
@@ -121,6 +122,10 @@ static inline int sata_down_spd_limit(struct ata_link *link, u32 spd_limit)
 {
 	return -EOPNOTSUPP;
 }
+static inline int sata_link_init_spd(struct ata_link *link)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 /* libata-acpi.c */
-- 
2.24.1

