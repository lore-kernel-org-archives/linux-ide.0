Return-Path: <SRS0=ljer=4P=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F05FC35E1D
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF546246AD
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uyT0quz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbgB0SWt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:22:49 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39756 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730981AbgB0SWt (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Feb 2020 13:22:49 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200227182247euoutp018de3a73c8a4505a63445abf121443add~3VXf-DsE81369013690euoutp01W
        for <linux-ide@vger.kernel.org>; Thu, 27 Feb 2020 18:22:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200227182247euoutp018de3a73c8a4505a63445abf121443add~3VXf-DsE81369013690euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582827767;
        bh=iDPgCJs2pauSPsc9cvKpKoeuURBB34Y4rspF4Y7Movo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uyT0quz+vULgeikyY359oHMDH2smAHz5+zfkBDLIXT0TDZF9LxH2cdl3glHiHctEQ
         PkZlJcGj1/qp1oHEfFgjzemA7DqlykRGvYIDABJfV1WQjo/DvFUf5Dodjae3r/xtuO
         3WIWO8WYsScc/45nsAnGzKngBEK0S+Y85xFjhAhA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200227182247eucas1p1805d859fd5e556c96d132e97e89ee180~3VXffiYfI0931609316eucas1p1E;
        Thu, 27 Feb 2020 18:22:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C5.5F.61286.7F8085E5; Thu, 27
        Feb 2020 18:22:47 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182247eucas1p2d83a212c200832402cc17817fab4f650~3VXfM_XHb1553915539eucas1p2y;
        Thu, 27 Feb 2020 18:22:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200227182247eusmtrp230701f3e830f11a9400b514e3d867f29~3VXfMdryf1813218132eusmtrp2t;
        Thu, 27 Feb 2020 18:22:47 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-68-5e5808f748ba
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 22.C1.08375.6F8085E5; Thu, 27
        Feb 2020 18:22:46 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182246eusmtip25acbaf31b074e3bba3446026cba3511f~3VXetCDl81203512035eusmtip2Q;
        Thu, 27 Feb 2020 18:22:46 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v3 17/27] ata: move sata_scr_*() to libata-sata.c
Date:   Thu, 27 Feb 2020 19:22:16 +0100
Message-Id: <20200227182226.19188-18-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227182226.19188-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djP87rfOSLiDP53CVusvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoLpuU1JzMstQifbsErowfU3cyFsz0rFi9rImtgfG0VRcjJ4eE
        gInEwjkt7F2MXBxCAisYJfouXmAESQgJfGGUONsdDZH4zChx+s0pZpiOq5MnM0MkljNK7Pt/
        ixHCAeo4ffsFO0gVm4CVxMT2VWCjRAQUJHp+r2QDKWIWeM8osWLSXhaQhLCAo8Tbg+fBxrII
        qEo0/5gGVMTBwStgJ/H2NAfENnmJrd8+sYLYnEDhG33b2UBsXgFBiZMzn4CNYQaqad46G+wi
        CYFV7BKdX1uhTnWR2HHgO5QtLPHq+BZ2CFtG4v/O+UwQDesYJf52vIDq3s4osXzyPzaIKmuJ
        O+d+gV3ELKApsX6XPkTYUWJi/0qwsIQAn8SNt4IQR/BJTNo2nRkizCvR0SYEUa0msWHZBjaY
        tV07V0Kd4yFx+8wn5gmMirOQvDMLyTuzEPYuYGRexSieWlqcm55abJiXWq5XnJhbXJqXrpec
        n7uJEZiITv87/mkH49dLSYcYBTgYlXh4F+wIjxNiTSwrrsw9xCjBwawkwrvxa2icEG9KYmVV
        alF+fFFpTmrxIUZpDhYlcV7jRS9jhQTSE0tSs1NTC1KLYLJMHJxSDYwTZ/5grvmyQHjF0pta
        l87+O/BisvKRyytVJzcJSkVea1Jw9ApjlBA4om/xwdX73+PMmUsXbGfSNw/fxSkicflmcear
        qlNKbfmC2lwH5Z98flNS8Djyyt4DNry7e+Jvfm8x0mt+6izevsOb57DalJXh/CFempWvWBya
        ld13X+P3f3aXa044m4cSS3FGoqEWc1FxIgBobha2QAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xe7rfOCLiDBo/WVmsvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYwfU3cyFsz0rFi9rImtgfG0VRcjJ4eEgInE1cmTmbsYuTiEBJYySrRu
        PQvkcAAlZCSOry+DqBGW+HOtiw2i5hOjxMUfvYwgCTYBK4mJ7avAbBEBBYme3yvBipgFvjJK
        LJ3UzQySEBZwlHh78DyYzSKgKtH8YxobyAJeATuJt6c5IBbIS2z99okVxOYECt/o284GYgsJ
        2Ep0dTwFm88rIChxcuYTFhCbGai+eets5gmMArOQpGYhSS1gZFrFKJJaWpybnltsqFecmFtc
        mpeul5yfu4kRGC/bjv3cvIPx0sbgQ4wCHIxKPLwLdoTHCbEmlhVX5h5ilOBgVhLh3fg1NE6I
        NyWxsiq1KD++qDQntfgQoynQDxOZpUST84GxnFcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9
        sSQ1OzW1ILUIpo+Jg1OqgXEKW05Qy4N9pyJ75Ms2qLPsfP7x8vnuPVNd715bIbX/gc65Q/Gl
        gWV9oYHFn6x/r3z0Zt2pDX8L3ecXb/v6s7SPe+UP3Q/zXR+sqXo8M/XuzAli+x4e3vXtuJ5Y
        9FLLjXGGR1+evGD8+EtpT/sHTefVLNuYHubo52vL7WWPuDbhk5HRnL3nOl66K7EUZyQaajEX
        FScCAGOnTiGtAgAA
X-CMS-MailID: 20200227182247eucas1p2d83a212c200832402cc17817fab4f650
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200227182247eucas1p2d83a212c200832402cc17817fab4f650
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200227182247eucas1p2d83a212c200832402cc17817fab4f650
References: <20200227182226.19188-1-b.zolnierkie@samsung.com>
        <CGME20200227182247eucas1p2d83a212c200832402cc17817fab4f650@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

* move sata_scr_*() to libata-sata.c

* add static inlines for CONFIG_SATA_HOST=n case

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  35642     572      40   36254    8d9e drivers/ata/libata-core.o
  16607      18       0   16625    40f1 drivers/ata/libata-eh.o
after:
  32846     572      40   33458    82b2 drivers/ata/libata-core.o
  16243      18       0   16261    3f85 drivers/ata/libata-eh.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 109 --------------------------------------
 drivers/ata/libata-sata.c | 109 ++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h    |  24 +++++++--
 3 files changed, 129 insertions(+), 113 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b4a952dce7ab..ba1e5c4d3c09 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5215,115 +5215,6 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 	ata_qc_complete(qc);
 }
 
-/**
- *	sata_scr_valid - test whether SCRs are accessible
- *	@link: ATA link to test SCR accessibility for
- *
- *	Test whether SCRs are accessible for @link.
- *
- *	LOCKING:
- *	None.
- *
- *	RETURNS:
- *	1 if SCRs are accessible, 0 otherwise.
- */
-int sata_scr_valid(struct ata_link *link)
-{
-	struct ata_port *ap = link->ap;
-
-	return (ap->flags & ATA_FLAG_SATA) && ap->ops->scr_read;
-}
-EXPORT_SYMBOL_GPL(sata_scr_valid);
-
-/**
- *	sata_scr_read - read SCR register of the specified port
- *	@link: ATA link to read SCR for
- *	@reg: SCR to read
- *	@val: Place to store read value
- *
- *	Read SCR register @reg of @link into *@val.  This function is
- *	guaranteed to succeed if @link is ap->link, the cable type of
- *	the port is SATA and the port implements ->scr_read.
- *
- *	LOCKING:
- *	None if @link is ap->link.  Kernel thread context otherwise.
- *
- *	RETURNS:
- *	0 on success, negative errno on failure.
- */
-int sata_scr_read(struct ata_link *link, int reg, u32 *val)
-{
-	if (ata_is_host_link(link)) {
-		if (sata_scr_valid(link))
-			return link->ap->ops->scr_read(link, reg, val);
-		return -EOPNOTSUPP;
-	}
-
-	return sata_pmp_scr_read(link, reg, val);
-}
-EXPORT_SYMBOL_GPL(sata_scr_read);
-
-/**
- *	sata_scr_write - write SCR register of the specified port
- *	@link: ATA link to write SCR for
- *	@reg: SCR to write
- *	@val: value to write
- *
- *	Write @val to SCR register @reg of @link.  This function is
- *	guaranteed to succeed if @link is ap->link, the cable type of
- *	the port is SATA and the port implements ->scr_read.
- *
- *	LOCKING:
- *	None if @link is ap->link.  Kernel thread context otherwise.
- *
- *	RETURNS:
- *	0 on success, negative errno on failure.
- */
-int sata_scr_write(struct ata_link *link, int reg, u32 val)
-{
-	if (ata_is_host_link(link)) {
-		if (sata_scr_valid(link))
-			return link->ap->ops->scr_write(link, reg, val);
-		return -EOPNOTSUPP;
-	}
-
-	return sata_pmp_scr_write(link, reg, val);
-}
-EXPORT_SYMBOL_GPL(sata_scr_write);
-
-/**
- *	sata_scr_write_flush - write SCR register of the specified port and flush
- *	@link: ATA link to write SCR for
- *	@reg: SCR to write
- *	@val: value to write
- *
- *	This function is identical to sata_scr_write() except that this
- *	function performs flush after writing to the register.
- *
- *	LOCKING:
- *	None if @link is ap->link.  Kernel thread context otherwise.
- *
- *	RETURNS:
- *	0 on success, negative errno on failure.
- */
-int sata_scr_write_flush(struct ata_link *link, int reg, u32 val)
-{
-	if (ata_is_host_link(link)) {
-		int rc;
-
-		if (sata_scr_valid(link)) {
-			rc = link->ap->ops->scr_write(link, reg, val);
-			if (rc == 0)
-				rc = link->ap->ops->scr_read(link, reg, &val);
-			return rc;
-		}
-		return -EOPNOTSUPP;
-	}
-
-	return sata_pmp_scr_write(link, reg, val);
-}
-EXPORT_SYMBOL_GPL(sata_scr_write_flush);
-
 /**
  *	ata_phys_link_online - test whether the given link is online
  *	@link: ATA link to test
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 04f1ecaf414c..1ef4c19864ac 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -12,6 +12,115 @@
 
 #include "libata.h"
 
+/**
+ *	sata_scr_valid - test whether SCRs are accessible
+ *	@link: ATA link to test SCR accessibility for
+ *
+ *	Test whether SCRs are accessible for @link.
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	1 if SCRs are accessible, 0 otherwise.
+ */
+int sata_scr_valid(struct ata_link *link)
+{
+	struct ata_port *ap = link->ap;
+
+	return (ap->flags & ATA_FLAG_SATA) && ap->ops->scr_read;
+}
+EXPORT_SYMBOL_GPL(sata_scr_valid);
+
+/**
+ *	sata_scr_read - read SCR register of the specified port
+ *	@link: ATA link to read SCR for
+ *	@reg: SCR to read
+ *	@val: Place to store read value
+ *
+ *	Read SCR register @reg of @link into *@val.  This function is
+ *	guaranteed to succeed if @link is ap->link, the cable type of
+ *	the port is SATA and the port implements ->scr_read.
+ *
+ *	LOCKING:
+ *	None if @link is ap->link.  Kernel thread context otherwise.
+ *
+ *	RETURNS:
+ *	0 on success, negative errno on failure.
+ */
+int sata_scr_read(struct ata_link *link, int reg, u32 *val)
+{
+	if (ata_is_host_link(link)) {
+		if (sata_scr_valid(link))
+			return link->ap->ops->scr_read(link, reg, val);
+		return -EOPNOTSUPP;
+	}
+
+	return sata_pmp_scr_read(link, reg, val);
+}
+EXPORT_SYMBOL_GPL(sata_scr_read);
+
+/**
+ *	sata_scr_write - write SCR register of the specified port
+ *	@link: ATA link to write SCR for
+ *	@reg: SCR to write
+ *	@val: value to write
+ *
+ *	Write @val to SCR register @reg of @link.  This function is
+ *	guaranteed to succeed if @link is ap->link, the cable type of
+ *	the port is SATA and the port implements ->scr_read.
+ *
+ *	LOCKING:
+ *	None if @link is ap->link.  Kernel thread context otherwise.
+ *
+ *	RETURNS:
+ *	0 on success, negative errno on failure.
+ */
+int sata_scr_write(struct ata_link *link, int reg, u32 val)
+{
+	if (ata_is_host_link(link)) {
+		if (sata_scr_valid(link))
+			return link->ap->ops->scr_write(link, reg, val);
+		return -EOPNOTSUPP;
+	}
+
+	return sata_pmp_scr_write(link, reg, val);
+}
+EXPORT_SYMBOL_GPL(sata_scr_write);
+
+/**
+ *	sata_scr_write_flush - write SCR register of the specified port and flush
+ *	@link: ATA link to write SCR for
+ *	@reg: SCR to write
+ *	@val: value to write
+ *
+ *	This function is identical to sata_scr_write() except that this
+ *	function performs flush after writing to the register.
+ *
+ *	LOCKING:
+ *	None if @link is ap->link.  Kernel thread context otherwise.
+ *
+ *	RETURNS:
+ *	0 on success, negative errno on failure.
+ */
+int sata_scr_write_flush(struct ata_link *link, int reg, u32 val)
+{
+	if (ata_is_host_link(link)) {
+		int rc;
+
+		if (sata_scr_valid(link)) {
+			rc = link->ap->ops->scr_write(link, reg, val);
+			if (rc == 0)
+				rc = link->ap->ops->scr_read(link, reg, &val);
+			return rc;
+		}
+		return -EOPNOTSUPP;
+	}
+
+	return sata_pmp_scr_write(link, reg, val);
+}
+EXPORT_SYMBOL_GPL(sata_scr_write_flush);
+
 /**
  *	ata_tf_to_fis - Convert ATA taskfile to SATA FIS structure
  *	@tf: Taskfile to convert
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5d76eab000e9..372070a9d92e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1127,10 +1127,6 @@ extern void ata_sas_tport_delete(struct ata_port *ap);
 extern void ata_sas_port_stop(struct ata_port *ap);
 extern int ata_sas_slave_configure(struct scsi_device *, struct ata_port *);
 extern int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap);
-extern int sata_scr_valid(struct ata_link *link);
-extern int sata_scr_read(struct ata_link *link, int reg, u32 *val);
-extern int sata_scr_write(struct ata_link *link, int reg, u32 val);
-extern int sata_scr_write_flush(struct ata_link *link, int reg, u32 val);
 extern bool ata_link_online(struct ata_link *link);
 extern bool ata_link_offline(struct ata_link *link);
 #ifdef CONFIG_PM
@@ -1195,6 +1191,26 @@ extern void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *
 /*
  * SATA specific code - drivers/ata/libata-sata.c
  */
+#ifdef CONFIG_SATA_HOST
+extern int sata_scr_valid(struct ata_link *link);
+extern int sata_scr_read(struct ata_link *link, int reg, u32 *val);
+extern int sata_scr_write(struct ata_link *link, int reg, u32 val);
+extern int sata_scr_write_flush(struct ata_link *link, int reg, u32 val);
+#else
+static inline int sata_scr_valid(struct ata_link *link) { return 0; }
+static inline int sata_scr_read(struct ata_link *link, int reg, u32 *val)
+{
+	return -EOPNOTSUPP;
+}
+static inline int sata_scr_write(struct ata_link *link, int reg, u32 val)
+{
+	return -EOPNOTSUPP;
+}
+static inline int sata_scr_write_flush(struct ata_link *link, int reg, u32 val)
+{
+	return -EOPNOTSUPP;
+}
+#endif
 extern int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 			     bool spm_wakeup);
 extern int ata_slave_link_init(struct ata_port *ap);
-- 
2.24.1

