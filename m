Return-Path: <SRS0=dw68=3R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC746C2D0DB
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA0B24688
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mB+RnDR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgA1Nee (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:34:34 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52438 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgA1NeV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jan 2020 08:34:21 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200128133419euoutp02c8d00e4a80d95bbd21979df2b67225b5~uEFD76sEn2862028620euoutp02E
        for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2020 13:34:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200128133419euoutp02c8d00e4a80d95bbd21979df2b67225b5~uEFD76sEn2862028620euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580218459;
        bh=NeSh++fdyBE5U7WVo4sr4O4ZCyftf3oHxPCdwGubSgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mB+RnDR+4BDHTof+i7yE6uSYr0JjoLd1cMQqkao4cn3h5oMxoIGkZ47u+l3TH/0P7
         tqjEeWoP+XgWfLOqIH1VgcqgXBYxQ+HAhGn5uoxwkWIcCxmnwtu3wl5IZ0EF/dg1ub
         FnGruMaqcLwHOdvIQcTPQmqjFMF6lAggtN1hGOa8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200128133418eucas1p1d1bb7165a0359e7503fe7a9d4020bc39~uEFDsMmYa1375113751eucas1p1L;
        Tue, 28 Jan 2020 13:34:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D1.DA.61286.A58303E5; Tue, 28
        Jan 2020 13:34:18 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200128133418eucas1p1fd63b12146a2848ab61db768fde77857~uEFDHblmv0089200892eucas1p17;
        Tue, 28 Jan 2020 13:34:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200128133418eusmtrp2e7c93e79848b8a99460c9d26a3e36b24~uEFDG5Bzo0330003300eusmtrp29;
        Tue, 28 Jan 2020 13:34:18 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-8f-5e30385a8a94
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 56.92.08375.A58303E5; Tue, 28
        Jan 2020 13:34:18 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133418eusmtip26b17fdf31352cc842f866af26f81343d~uEFCycQkO0685506855eusmtip2a;
        Tue, 28 Jan 2020 13:34:17 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 23/28] ata: move sata_deb_timing_*() to libata-core-sata.c
Date:   Tue, 28 Jan 2020 14:33:38 +0100
Message-Id: <20200128133343.29905-24-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128133343.29905-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWy7djP87pRFgZxBjemmlmsvtvPZrFxxnpW
        i2e39jJZHNvxiMni8q45bBZzW6ezO7B57Jx1l93j8tlSj0OHOxg9+rasYvT4vEkugDWKyyYl
        NSezLLVI3y6BK2PZSd2Cx8oVq6f/ZW9gfC/bxcjJISFgInH++TYmEFtIYAWjxLRZ0l2MXED2
        F0aJwy9/MUI4nxklJkx/zgTT8fTFEhaIxHJGiZMvX7NCtAO1zF1sAWKzCVhJTGxfxQhiiwgo
        SPT8XskG0sAssIZRYtXhJrCEsICXxKKHN1hAbBYBVYnJx88BxTk4eAXsJC5tqoZYJi+x9dsn
        VpAwJ1C4Z685SJhXQFDi5MwnYJ3MQCXNW2czg4yXEGhnlzh/+DUbRK+LxOmTK6FsYYlXx7ew
        Q9gyEv93zmeCaFjHKPG34wVU93ZGieWT/0F1WEvcOfeLDWQzs4CmxPpd+hBhR4klC8+yg4Ql
        BPgkbrwVhDiCT2LStunMEGFeiY42IYhqNYkNyzawwazt2rmSGcL2kFgz9z/LBEbFWUjemYXk
        nVkIexcwMq9iFE8tLc5NTy02zEst1ytOzC0uzUvXS87P3cQITC2n/x3/tIPx66WkQ4wCHIxK
        PLwzVAzihFgTy4orcw8xSnAwK4nwdjIBhXhTEiurUovy44tKc1KLDzFKc7AoifMaL3oZKySQ
        nliSmp2aWpBaBJNl4uCUamDckbSOdcUad5M7f10410i9Y/aczbr2g12XvtzM8/nde9hni/zl
        62UJN+ObnCzbs/bBG61+aT7l/RXfZ/VIifb4PZ17VaxdMU3p9hf5DQGOT/1Kmn7viJJTrK30
        fXnf+MFWvy83NMRTD6966yLel39zhuJ9MS7xb0+ZQ15bnOPyCp9dEj9jnZwSS3FGoqEWc1Fx
        IgDFcc9MKQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42I5/e/4Pd0oC4M4g71vRSxW3+1ns9g4Yz2r
        xbNbe5ksju14xGRxedccNou5rdPZHdg8ds66y+5x+Wypx6HDHYwefVtWMXp83iQXwBqlZ1OU
        X1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7HspG7BY+WK
        1dP/sjcwvpftYuTkkBAwkXj6YglLFyMXh5DAUkaJyfNnMHUxcgAlZCSOry+DqBGW+HOtiw2i
        5hOjxNO5z5lBEmwCVhIT21cxgtgiAgoSPb9XghUxC2xglHh18wsLSEJYwEti0cMbYDaLgKrE
        5OPnGEEW8ArYSVzaVA2xQF5i67dPrCBhTqBwz15zkLCQgK3E+jNPWUFsXgFBiZMzn4BNYQYq
        b946m3kCo8AsJKlZSFILGJlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBMbAtmM/N+9gvLQx
        +BCjAAejEg/vDBWDOCHWxLLiytxDjBIczEoivJ1MQCHelMTKqtSi/Pii0pzU4kOMpkAvTGSW
        Ek3OB8ZnXkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxrTAmPyn
        vYW8y6JfiBzlePV264erk5wFGKQri3N5NJ4L17HILLN8OrH9ng/DOUXN8GBTk/8/TnY61uds
        3t2kU2mprc9yf67kC3bjorvXD+S4cMjsZJo090T3pM9qrnvPOOkEzpZYsGC2pIzwt1dtGwN1
        psb/Ti0WD5g3hcfWWNOJ79q3pUtslViKMxINtZiLihMBsj4sWZcCAAA=
X-CMS-MailID: 20200128133418eucas1p1fd63b12146a2848ab61db768fde77857
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133418eucas1p1fd63b12146a2848ab61db768fde77857
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133418eucas1p1fd63b12146a2848ab61db768fde77857
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133418eucas1p1fd63b12146a2848ab61db768fde77857@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

* move sata_deb_timing_*() to libata-core-sata.c

* add static inline for sata_ehc_deb_timing() for
  CONFIG_SATA_HOST=n case

Code size savings on m68k arch using atari_defconfig:

   text    data     bss     dec     hex filename
before:
  32146     572      40   32758    7ff6 drivers/ata/libata-core.o
after:
  32003     572      40   32615    7f67 drivers/ata/libata-core.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core-sata.c |  8 ++++++++
 drivers/ata/libata-core.c      |  8 --------
 include/linux/libata.h         | 31 ++++++++++++++++++-------------
 3 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/libata-core-sata.c b/drivers/ata/libata-core-sata.c
index a3709b356fd2..2bfbb67450f2 100644
--- a/drivers/ata/libata-core-sata.c
+++ b/drivers/ata/libata-core-sata.c
@@ -12,6 +12,14 @@
 
 #include "libata.h"
 
+/* debounce timing parameters in msecs { interval, duration, timeout } */
+const unsigned long sata_deb_timing_normal[]		= {   5,  100, 2000 };
+EXPORT_SYMBOL_GPL(sata_deb_timing_normal);
+const unsigned long sata_deb_timing_hotplug[]		= {  25,  500, 2000 };
+EXPORT_SYMBOL_GPL(sata_deb_timing_hotplug);
+const unsigned long sata_deb_timing_long[]		= { 100, 2000, 5000 };
+EXPORT_SYMBOL_GPL(sata_deb_timing_long);
+
 /**
  *	ata_tf_to_fis - Convert ATA taskfile to SATA FIS structure
  *	@tf: Taskfile to convert
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f7124aede419..c7583f7e9bf0 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -65,14 +65,6 @@
 #include "libata.h"
 #include "libata-transport.h"
 
-/* debounce timing parameters in msecs { interval, duration, timeout } */
-const unsigned long sata_deb_timing_normal[]		= {   5,  100, 2000 };
-EXPORT_SYMBOL_GPL(sata_deb_timing_normal);
-const unsigned long sata_deb_timing_hotplug[]		= {  25,  500, 2000 };
-EXPORT_SYMBOL_GPL(sata_deb_timing_hotplug);
-const unsigned long sata_deb_timing_long[]		= { 100, 2000, 5000 };
-EXPORT_SYMBOL_GPL(sata_deb_timing_long);
-
 const struct ata_port_operations ata_base_port_ops = {
 	.prereset		= ata_std_prereset,
 	.postreset		= ata_std_postreset,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3f5d714caa43..3124cad39d50 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1021,10 +1021,6 @@ struct ata_timing {
 /*
  * Core layer - drivers/ata/libata-core.c
  */
-extern const unsigned long sata_deb_timing_normal[];
-extern const unsigned long sata_deb_timing_hotplug[];
-extern const unsigned long sata_deb_timing_long[];
-
 extern struct ata_port_operations ata_dummy_port_ops;
 extern const struct ata_port_info ata_dummy_port_info;
 
@@ -1062,15 +1058,6 @@ static inline int is_multi_taskfile(struct ata_taskfile *tf)
 	       (tf->command == ATA_CMD_WRITE_MULTI_FUA_EXT);
 }
 
-static inline const unsigned long *
-sata_ehc_deb_timing(struct ata_eh_context *ehc)
-{
-	if (ehc->i.flags & ATA_EHI_HOTPLUGGED)
-		return sata_deb_timing_hotplug;
-	else
-		return sata_deb_timing_normal;
-}
-
 static inline int ata_port_is_dummy(struct ata_port *ap)
 {
 	return ap->ops == &ata_dummy_port_ops;
@@ -1183,6 +1170,19 @@ extern void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *
  * Core layer (SATA specific part) - drivers/ata/libata-core-sata.c
  */
 #ifdef CONFIG_SATA_HOST
+extern const unsigned long sata_deb_timing_normal[];
+extern const unsigned long sata_deb_timing_hotplug[];
+extern const unsigned long sata_deb_timing_long[];
+
+static inline const unsigned long *
+sata_ehc_deb_timing(struct ata_eh_context *ehc)
+{
+	if (ehc->i.flags & ATA_EHI_HOTPLUGGED)
+		return sata_deb_timing_hotplug;
+	else
+		return sata_deb_timing_normal;
+}
+
 extern int sata_set_spd(struct ata_link *link);
 extern int sata_link_debounce(struct ata_link *link,
 			const unsigned long *params, unsigned long deadline);
@@ -1204,6 +1204,11 @@ extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
 extern int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active);
 extern bool sata_lpm_ignore_phy_events(struct ata_link *link);
 #else
+static inline const unsigned long *
+sata_ehc_deb_timing(struct ata_eh_context *ehc)
+{
+	return NULL;
+}
 static inline int sata_set_spd(struct ata_link *link) { return -EOPNOTSUPP; }
 static inline int sata_link_resume(struct ata_link *link,
 				   const unsigned long *params,
-- 
2.24.1

