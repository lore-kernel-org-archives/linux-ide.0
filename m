Return-Path: <SRS0=AjNr=5C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C648BC10F29
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9335620738
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JK1gVJDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgCQOoS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:44:18 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40416 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbgCQOny (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Mar 2020 10:43:54 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200317144352euoutp02be8a36f8efaece142b59f2c0577641e1~9Hox6JxC61539415394euoutp02j
        for <linux-ide@vger.kernel.org>; Tue, 17 Mar 2020 14:43:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200317144352euoutp02be8a36f8efaece142b59f2c0577641e1~9Hox6JxC61539415394euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584456232;
        bh=7yXkCWBeAT00jf5oi+/5FfMHgxjLEvrh+ZeX915KI6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JK1gVJDLJnEK+ByHnXJbydwcciMrXXmRgOl01JSWf9Hex1cFAxMWss8nQ0po/HHde
         SC/VnAH9mfq2iSlKcwriOaFWnpyGNvO1W2lUdgqHB3um1SewNNpK9veWbgGe7CgBq3
         T/5ZDtgIH5iqRYBgrKfUUJsX7VdiukdRDpsEZ1sM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200317144352eucas1p2eee83843401b8fc1cf4353d83c405be9~9HoxmwCCo2984629846eucas1p27;
        Tue, 17 Mar 2020 14:43:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 45.E3.61286.822E07E5; Tue, 17
        Mar 2020 14:43:52 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200317144351eucas1p2020714aa775f0ab3aaea870d25f7fb92~9HoxUh_HH0133301333eucas1p2r;
        Tue, 17 Mar 2020 14:43:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200317144351eusmtrp22d972e80aa64364e3a342d584e458f23~9HoxT8krY0146401464eusmtrp2V;
        Tue, 17 Mar 2020 14:43:51 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-3d-5e70e22888fe
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EF.23.07950.722E07E5; Tue, 17
        Mar 2020 14:43:51 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144351eusmtip1ba871c63b03a33fe96b5ca2cb31082bf~9HowzH7vl0538205382eusmtip1N;
        Tue, 17 Mar 2020 14:43:51 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v4 22/27] ata: move sata_deb_timing_*() to libata-sata.c
Date:   Tue, 17 Mar 2020 15:43:28 +0100
Message-Id: <20200317144333.2904-23-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317144333.2904-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djP87oajwriDB5N5LdYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBkz+pezFXQqV/z7HdfAuEC2i5GTQ0LA
        RGLe1yPsXYxcHEICKxglZj1+zAbhfGGU+PPyAJTzmVFi2f3jrF2MHGAtXzdJgHQLCSxnlPj8
        gBOu4X/zH0aQBJuAlcTE9lVgtoiAgkTP75Vgg5gF3jNKrJi0lwUkISzgITGtYQMriM0ioCrx
        +OQcJhCbV8BWYue1BkaI++Qltn77BFbDCRS/dvgfG0SNoMTJmU/A5jAD1TRvnc0MskBCYBm7
        RMe8XawQzS4Sv5tWQtnCEq+Ob2GHsGUk/u+czwTRsI5R4m/HC6ju7YwSyydDrJAQsJa4c+4X
        G8jPzAKaEut36UOEHSW2POpjggQFn8SNt4IQR/BJTNo2nRkizCvR0SYEUa0msWHZBjaYtV07
        VzJD2B4Sc+4/Yp3AqDgLyTuzkLwzC2HvAkbmVYziqaXFuempxYZ5qeV6xYm5xaV56XrJ+bmb
        GIFp6PS/4592MH69lHSIUYCDUYmHl2NDQZwQa2JZcWXuIUYJDmYlEd7FhflxQrwpiZVVqUX5
        8UWlOanFhxilOViUxHmNF72MFRJITyxJzU5NLUgtgskycXBKNTBa3eAU/uQ+c225nyxvZLz2
        DLuulrdbc158m50goKtcKfF92mV1cY0la5bITS/3VhX31N4RcvzLx9s51Qf0F73ZMGW90O6r
        lbXXbq+0aVno8U4hcp3xxYe9Aows7aoJexPnNJ32n/hpxqt53BlNimqca6U3C8vYrNv2dMcx
        tyOX/uwuspyu76SmxFKckWioxVxUnAgATPhg0z8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t/xu7rqjwriDOavt7BYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehkz+pezFXQqV/z7HdfAuEC2i5GDQ0LAROLrJokuRi4OIYGljBK7Pt5j
        h4jLSBxfX9bFyAlkCkv8udbFBmILCXxilNi02x3EZhOwkpjYvooRxBYRUJDo+b2SDWQOs8BX
        Romlk7qZQRLCAh4S0xo2sILYLAKqEo9PzmECsXkFbCV2XmtghFggL7H12yewGk6g+LXD/6CW
        2Ui8ePMfql5Q4uTMJywgNjNQffPW2cwTGAVmIUnNQpJawMi0ilEktbQ4Nz232EivODG3uDQv
        XS85P3cTIzBWth37uWUHY9e74EOMAhyMSjy8HBsK4oRYE8uKK3MPMUpwMCuJ8C4uzI8T4k1J
        rKxKLcqPLyrNSS0+xGgK9MREZinR5HxgHOeVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJ
        zU5NLUgtgulj4uCUamDseS0QFWRg4CJ+b8Imtfzrwtzh57fFXZzxcpGsXFJhYKeh2hReUR37
        25xTTWsF/pZ4xW/0DWLaUfjgVntbd+qJj7u+Jagd85J5/b6V7cq61WVz5yov+R3w9cOlQNHb
        tcx9Z+Wnrp+c4llf5z9TNPvAecvTXqenf2oteXXP+69A2pqyr/d23DuoxFKckWioxVxUnAgA
        8HNd2asCAAA=
X-CMS-MailID: 20200317144351eucas1p2020714aa775f0ab3aaea870d25f7fb92
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200317144351eucas1p2020714aa775f0ab3aaea870d25f7fb92
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200317144351eucas1p2020714aa775f0ab3aaea870d25f7fb92
References: <20200317144333.2904-1-b.zolnierkie@samsung.com>
        <CGME20200317144351eucas1p2020714aa775f0ab3aaea870d25f7fb92@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

* move sata_deb_timing_*() to libata-sata.c

* add static inline for sata_ehc_deb_timing() for
  CONFIG_SATA_HOST=n case

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  32158     572      40   32770    8002 drivers/ata/libata-core.o
after:
  32015     572      40   32627    7f73 drivers/ata/libata-core.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c |  8 --------
 drivers/ata/libata-sata.c |  8 ++++++++
 include/linux/libata.h    | 31 ++++++++++++++++++-------------
 3 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d246bc1e08c9..53d1d017c752 100644
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
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 57344f87b4e0..0cf30782452a 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
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
  *	sata_scr_valid - test whether SCRs are accessible
  *	@link: ATA link to test SCR accessibility for
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d9cb7768fb64..0fa34370eefa 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1011,10 +1011,6 @@ struct ata_timing {
 /*
  * Core layer - drivers/ata/libata-core.c
  */
-extern const unsigned long sata_deb_timing_normal[];
-extern const unsigned long sata_deb_timing_hotplug[];
-extern const unsigned long sata_deb_timing_long[];
-
 extern struct ata_port_operations ata_dummy_port_ops;
 extern const struct ata_port_info ata_dummy_port_info;
 
@@ -1052,15 +1048,6 @@ static inline int is_multi_taskfile(struct ata_taskfile *tf)
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
@@ -1183,6 +1170,19 @@ extern void ata_scsi_cmd_error_handler(struct Scsi_Host *host,
  * SATA specific code - drivers/ata/libata-sata.c
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
 extern int sata_scr_valid(struct ata_link *link);
 extern int sata_scr_read(struct ata_link *link, int reg, u32 *val);
 extern int sata_scr_write(struct ata_link *link, int reg, u32 val);
@@ -1194,6 +1194,11 @@ extern int sata_link_hardreset(struct ata_link *link,
 extern int sata_link_resume(struct ata_link *link, const unsigned long *params,
 			    unsigned long deadline);
 #else
+static inline const unsigned long *
+sata_ehc_deb_timing(struct ata_eh_context *ehc)
+{
+	return NULL;
+}
 static inline int sata_scr_valid(struct ata_link *link) { return 0; }
 static inline int sata_scr_read(struct ata_link *link, int reg, u32 *val)
 {
-- 
2.24.1

