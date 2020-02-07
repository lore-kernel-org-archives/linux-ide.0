Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4558C3B186
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912D6214AF
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="A6N4lLpp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgBGO2f (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:28:35 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59623 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgBGO2D (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:28:03 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142802euoutp019fee159c7ffb1dcb5e82d0b95b4bad5a~xJQ0moEs42241722417euoutp01P
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:28:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200207142802euoutp019fee159c7ffb1dcb5e82d0b95b4bad5a~xJQ0moEs42241722417euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085682;
        bh=W56pOxOq1qD6TcSbddIxmUfxLuGM6DOjeWNZsIhkCZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A6N4lLppfo68jBAADhWyevjbOVjfff2AdeqybRfCpc7N+qoYOJlYHU4f40uA4yyGr
         yKrQHsxUdBsSPkQw41vW69ELZEgtJ+YrbPGKobVJEfgTZ33hk1V11aotT1U2ov/MRK
         B0vMf0k4f/yOJPaTpB5WJlNyx+weWeHQ2M74isMQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200207142802eucas1p2f3dd7817c3337d0b88d6c5e17001fa33~xJQ0MwUPL3055030550eucas1p2I;
        Fri,  7 Feb 2020 14:28:02 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 80.25.61286.2F37D3E5; Fri,  7
        Feb 2020 14:28:02 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200207142801eucas1p1b7ef2c914af9abfb409917facae0ceb4~xJQzsA2Da1085510855eucas1p1r;
        Fri,  7 Feb 2020 14:28:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200207142801eusmtrp14b950e2f84b0de892b00b624ee695741~xJQzrZ2IU0480004800eusmtrp1V;
        Fri,  7 Feb 2020 14:28:01 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-2e-5e3d73f21772
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 60.99.08375.1F37D3E5; Fri,  7
        Feb 2020 14:28:01 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142801eusmtip28b51b8b01843c000b6a15cc6cafd7511~xJQzKf0Zw3155831558eusmtip2P;
        Fri,  7 Feb 2020 14:28:01 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v2 21/26] ata: move sata_deb_timing_*() to libata-sata.c
Date:   Fri,  7 Feb 2020 15:27:29 +0100
Message-Id: <20200207142734.8431-22-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207142734.8431-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djP87qfim3jDK5dY7ZYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBknplxhLZitXLH84nuWBsb1sl2MnBwS
        AiYSx461M3UxcnEICaxglDh/p4sZwvnCKHH0/BoWCOczo8SD9QuYYVo+fXnMBpFYzijxakIj
        K1zLpRcnWEGq2ASsJCa2r2IEsUUEFCR6fq8E62AWeM8osWLSXhaQhLCAh8T5Da+ZQGwWAVWJ
        B69Xgdm8ArYS3UsuM0Gsk5fY+u0T2FBOoPjHKX/ZIGoEJU7OfAI2hxmopnnrbLDDJQRWsUsc
        b/3DDtHsIjHx1EEoW1ji1fEtULaMxOnJPSwQDesYJf52vIDq3s4osXzyPzaIKmuJO+d+Adkc
        QCs0Jdbv0ocIO0qs6ZjMDBKWEOCTuPFWEOIIPolJ26ZDhXklOtqEIKrVJDYs28AGs7Zr50po
        MHpI7Hm7gHkCo+IsJO/MQvLOLIS9CxiZVzGKp5YW56anFhvmpZbrFSfmFpfmpesl5+duYgQm
        o9P/jn/awfj1UtIhRgEORiUe3gRHmzgh1sSy4srcQ4wSHMxKIrx9qrZxQrwpiZVVqUX58UWl
        OanFhxilOViUxHmNF72MFRJITyxJzU5NLUgtgskycXBKNTBmOfSVmbUVX7JfueN6xen3nxcE
        irjtrH35KCWLw2c1w6KACztjjvhNNPN67jS90L7ERGOtZjZz4/+5F6/oJPo9ntmy7mFF9ar8
        lIqi8soSoVmcbuscRLfMO9JvrqUdE2bzwyJxy63w5Zm2DQasBUend/t2/xe9yPR669oPT27M
        2SDXb26d9k2JpTgj0VCLuag4EQA+9bnJQgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xe7ofi23jDDbsVLBYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehknplxhLZitXLH84nuWBsb1sl2MnBwSAiYSn748Zuti5OIQEljKKDHh
        xjbmLkYOoISMxPH1ZRA1whJ/rnVB1XxilFi9YzsbSIJNwEpiYvsqRhBbREBBouf3SrAiZoGv
        jBJLJ3UzgySEBTwkzm94zQRiswioSjx4vQrM5hWwlehecpkJYoO8xNZvn1hBbE6g+Mcpf8EW
        CAnYSHx/P4kdol5Q4uTMJywgNjNQffPW2cwTGAVmIUnNQpJawMi0ilEktbQ4Nz232FCvODG3
        uDQvXS85P3cTIzBith37uXkH46WNwYcYBTgYlXh4Exxt4oRYE8uKK3MPMUpwMCuJ8Pap2sYJ
        8aYkVlalFuXHF5XmpBYfYjQFemIis5Rocj4wmvNK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmk
        J5akZqemFqQWwfQxcXBKNTDWu+XJ3ax/sujShy2ZDMulErp3zlov9/SWfUxGuddt1Y7wrz4b
        iua+8FLI+p7/kbF+eiX7ry234s2Wf2i37bFZzel5dclz31+/18uXr4vjOOG9MZL7gEj0EvZV
        cSVOZVPi9Is/1Lku2vlrZeIjs5xjMw8LrbvAJ3n08ht1r225f7f2uh5ncVqjxFKckWioxVxU
        nAgA1xG1k64CAAA=
X-CMS-MailID: 20200207142801eucas1p1b7ef2c914af9abfb409917facae0ceb4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200207142801eucas1p1b7ef2c914af9abfb409917facae0ceb4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200207142801eucas1p1b7ef2c914af9abfb409917facae0ceb4
References: <20200207142734.8431-1-b.zolnierkie@samsung.com>
        <CGME20200207142801eucas1p1b7ef2c914af9abfb409917facae0ceb4@eucas1p1.samsung.com>
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
index bf98ae0d3f4e..1a3218e81703 100644
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
index 849582e0d653..f3ad4aca5d09 100644
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
index 01f9d3746bf1..e55875546236 100644
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

