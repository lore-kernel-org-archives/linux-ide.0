Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A8DC433F5
	for <linux-ide@archiver.kernel.org>; Mon, 25 Apr 2022 01:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240159AbiDYBhw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 24 Apr 2022 21:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240163AbiDYBhZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 24 Apr 2022 21:37:25 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0D2EE4ED
        for <linux-ide@vger.kernel.org>; Sun, 24 Apr 2022 18:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650850462; x=1682386462;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0qK5trTMohR+usRjrhJxE3Vg0PVM3LOFaxYvJKwRmHE=;
  b=GG/Im3330RgpeUGrtd6bRiTaku76TP3oJcYUNm8VZo9WqPtolyyYoThn
   OyXw1ej8z2hun+lobZ/dgQdXmTQrYwl92cX3FCgFM7Ey61r6mokYGYRva
   UvNJtFU5t5VYF9DWsO7+kYSQ1vWopPYm3Fn3XHGcu2XmBFDksvQfQD92m
   N7m1LA1YhPdbWCRL/fuZZ8MGUILfhbpofAiJrH1pjOktT+IFri0M9F6xQ
   poxFbEutNsVwKmepTgP0H993HRYik0kQdW7dFLLvxqw3uw0Gprro/nf3J
   BMmUgsICnGMmB5Zx+uyxMlEmBM49Tit1PwuUa52f5nleDH/uarhKzijB+
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,287,1643644800"; 
   d="scan'208";a="197558810"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2022 09:34:22 +0800
IronPort-SDR: VGlWjbznWxxHW7LqUcFV8NqDGzKNtNWxjcMjSDCUajPyurkUecEMgP4hn1Kau3/5X3Cwmvw7sC
 GS7lGG8ZNcfxEKsgHsz68avSlGjU6D3TS4fUN9dTOW/z+I6K7hFhTPWmI6e3gaiHsrv2Om8mnQ
 4HB/MhE5Z0PVem3IomNiaP6HWFaLd4UYIJjJ7HeP1yMktgqwfduJe3XjLLSdht4qmrFsGdrz2p
 E8PRgfl4Y7U0Cvi3vUlMR887vD4+myt/WVcgCk7MyLMu8J9n399MGmA7FxTa1I3olAxvjnhVcl
 bkXlH5Thk4sw77gH6oSCEZCk
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2022 18:04:35 -0700
IronPort-SDR: 2MzJsCvRuLE2dqVcdPjOaNd2hQpcBetf+UXg24eSJLe+5Mnae0GoYbzITSbfWvm2y3PkLgHpEa
 nT6syJGgNelCTqJRPMe8mDNnZkQAxOzby4JzjdGU8Yw8k3Lj3FtQm493ALolr0S+y3QMz1zAgk
 /C5YJ6xpszEcTqgD8d5eb7zTbugIupnRGIcpObFR0I67RLqzYczJ9BEzSPjEW+9AHpRa0yT5n+
 DiLG5HllGzF1hJ0oNGgpyz36Tfodv2pCeQvIqHovaNwBckY3aiWEbgyQ+hYMyfYCF3HgyocGRL
 3zc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2022 18:34:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KmncF71FRz1SVny
        for <linux-ide@vger.kernel.org>; Sun, 24 Apr 2022 18:34:21 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1650850461; x=1653442462; bh=0qK5trTMohR+usRjrh
        JxE3Vg0PVM3LOFaxYvJKwRmHE=; b=ahhQIz9sjXFje0I9UG7vqzxN9kkGTOTOPU
        h2yE9i7DBvDm+cKVIfIFqV7Afja1NW1gjSJiXQs2MfoPwcb5z0cZH+TBkZvqUM71
        Ybr9swVWqv24bDkfN3Oev5rXRwovKlbrwEdC1cpHdUlgD9cUijz+p2YnXOGGncY9
        yp6LX0iP24J2Xf2/XGUqhXpx8j0ZEl0rokOUaI/d/tbDbT8f1BjDlNWhf1PANktR
        LFU12p25TFmBd4b/jk0snVZ3zfIVFYV+O+1g3k1F+7FoMnsW8rQXAb/DzuvbqEzW
        NDxpeHH8ig7grUg3hl8McE8LRWKaTACRnvzG65mQmt22tuYTc91g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OFCmXj1DFsZs for <linux-ide@vger.kernel.org>;
        Sun, 24 Apr 2022 18:34:21 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KmncD2x1kz1Rwrw;
        Sun, 24 Apr 2022 18:34:20 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2 1/5] ata: libata-core: cleanup ata_device_blacklist
Date:   Mon, 25 Apr 2022 10:34:13 +0900
Message-Id: <20220425013417.3947791-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425013417.3947791-1-damien.lemoal@opensource.wdc.com>
References: <20220425013417.3947791-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Remove the unneeded comma after the last field of the array entries.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/ata/libata-core.c | 96 +++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index cceedde51126..bc59c77b99b6 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3898,7 +3898,7 @@ static const struct ata_blacklist_entry ata_device_=
blacklist [] =3D {
 	/* Devices where NCQ should be avoided */
 	/* NCQ is slow */
 	{ "WDC WD740ADFD-00",	NULL,		ATA_HORKAGE_NONCQ },
-	{ "WDC WD740ADFD-00NLR1", NULL,		ATA_HORKAGE_NONCQ, },
+	{ "WDC WD740ADFD-00NLR1", NULL,		ATA_HORKAGE_NONCQ },
 	/* http://thread.gmane.org/gmane.linux.ide/14907 */
 	{ "FUJITSU MHT2060BH",	NULL,		ATA_HORKAGE_NONCQ },
 	/* NCQ is broken */
@@ -3924,23 +3924,23 @@ static const struct ata_blacklist_entry ata_devic=
e_blacklist [] =3D {
 	/* drives which fail FPDMA_AA activation (some may freeze afterwards)
 	   the ST disks also have LPM issues */
 	{ "ST1000LM024 HN-M101MBB", NULL,	ATA_HORKAGE_BROKEN_FPDMA_AA |
-						ATA_HORKAGE_NOLPM, },
+						ATA_HORKAGE_NOLPM },
 	{ "VB0250EAVER",	"HPG7",		ATA_HORKAGE_BROKEN_FPDMA_AA },
=20
 	/* Blacklist entries taken from Silicon Image 3124/3132
 	   Windows driver .inf file - also several Linux problem reports */
-	{ "HTS541060G9SA00",    "MB3OC60D",     ATA_HORKAGE_NONCQ, },
-	{ "HTS541080G9SA00",    "MB4OC60D",     ATA_HORKAGE_NONCQ, },
-	{ "HTS541010G9SA00",    "MBZOC60D",     ATA_HORKAGE_NONCQ, },
+	{ "HTS541060G9SA00",    "MB3OC60D",     ATA_HORKAGE_NONCQ },
+	{ "HTS541080G9SA00",    "MB4OC60D",     ATA_HORKAGE_NONCQ },
+	{ "HTS541010G9SA00",    "MBZOC60D",     ATA_HORKAGE_NONCQ },
=20
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=3D15573 */
-	{ "C300-CTFDDAC128MAG",	"0001",		ATA_HORKAGE_NONCQ, },
+	{ "C300-CTFDDAC128MAG",	"0001",		ATA_HORKAGE_NONCQ },
=20
 	/* Sandisk SD7/8/9s lock up hard on large trims */
-	{ "SanDisk SD[789]*",	NULL,		ATA_HORKAGE_MAX_TRIM_128M, },
+	{ "SanDisk SD[789]*",	NULL,		ATA_HORKAGE_MAX_TRIM_128M },
=20
 	/* devices which puke on READ_NATIVE_MAX */
-	{ "HDS724040KLSA80",	"KFAOA20N",	ATA_HORKAGE_BROKEN_HPA, },
+	{ "HDS724040KLSA80",	"KFAOA20N",	ATA_HORKAGE_BROKEN_HPA },
 	{ "WDC WD3200JD-00KLB0", "WD-WCAMR1130137", ATA_HORKAGE_BROKEN_HPA },
 	{ "WDC WD2500JD-00HBB0", "WD-WMAL71490727", ATA_HORKAGE_BROKEN_HPA },
 	{ "MAXTOR 6L080L4",	"A93.0500",	ATA_HORKAGE_BROKEN_HPA },
@@ -3949,22 +3949,22 @@ static const struct ata_blacklist_entry ata_devic=
e_blacklist [] =3D {
 	{ "OCZ-VERTEX",		    "1.30",	ATA_HORKAGE_BROKEN_HPA },
=20
 	/* Devices which report 1 sector over size HPA */
-	{ "ST340823A",		NULL,		ATA_HORKAGE_HPA_SIZE, },
-	{ "ST320413A",		NULL,		ATA_HORKAGE_HPA_SIZE, },
-	{ "ST310211A",		NULL,		ATA_HORKAGE_HPA_SIZE, },
+	{ "ST340823A",		NULL,		ATA_HORKAGE_HPA_SIZE },
+	{ "ST320413A",		NULL,		ATA_HORKAGE_HPA_SIZE },
+	{ "ST310211A",		NULL,		ATA_HORKAGE_HPA_SIZE },
=20
 	/* Devices which get the IVB wrong */
-	{ "QUANTUM FIREBALLlct10 05", "A03.0900", ATA_HORKAGE_IVB, },
+	{ "QUANTUM FIREBALLlct10 05", "A03.0900", ATA_HORKAGE_IVB },
 	/* Maybe we should just blacklist TSSTcorp... */
-	{ "TSSTcorp CDDVDW SH-S202[HJN]", "SB0[01]",  ATA_HORKAGE_IVB, },
+	{ "TSSTcorp CDDVDW SH-S202[HJN]", "SB0[01]",  ATA_HORKAGE_IVB },
=20
 	/* Devices that do not need bridging limits applied */
-	{ "MTRON MSP-SATA*",		NULL,	ATA_HORKAGE_BRIDGE_OK, },
-	{ "BUFFALO HD-QSU2/R5",		NULL,	ATA_HORKAGE_BRIDGE_OK, },
+	{ "MTRON MSP-SATA*",		NULL,	ATA_HORKAGE_BRIDGE_OK },
+	{ "BUFFALO HD-QSU2/R5",		NULL,	ATA_HORKAGE_BRIDGE_OK },
=20
 	/* Devices which aren't very happy with higher link speeds */
-	{ "WD My Book",			NULL,	ATA_HORKAGE_1_5_GBPS, },
-	{ "Seagate FreeAgent GoFlex",	NULL,	ATA_HORKAGE_1_5_GBPS, },
+	{ "WD My Book",			NULL,	ATA_HORKAGE_1_5_GBPS },
+	{ "Seagate FreeAgent GoFlex",	NULL,	ATA_HORKAGE_1_5_GBPS },
=20
 	/*
 	 * Devices which choke on SETXFER.  Applies only if both the
@@ -3982,54 +3982,54 @@ static const struct ata_blacklist_entry ata_devic=
e_blacklist [] =3D {
 	/* 512GB MX100 with MU01 firmware has both queued TRIM and LPM issues *=
/
 	{ "Crucial_CT512MX100*",	"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
-						ATA_HORKAGE_NOLPM, },
+						ATA_HORKAGE_NOLPM },
 	/* 512GB MX100 with newer firmware has only LPM issues */
 	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM |
-						ATA_HORKAGE_NOLPM, },
+						ATA_HORKAGE_NOLPM },
=20
 	/* 480GB+ M500 SSDs have both queued TRIM and LPM issues */
 	{ "Crucial_CT480M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
-						ATA_HORKAGE_NOLPM, },
+						ATA_HORKAGE_NOLPM },
 	{ "Crucial_CT960M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
-						ATA_HORKAGE_NOLPM, },
+						ATA_HORKAGE_NOLPM },
=20
 	/* These specific Samsung models/firmware-revs do not handle LPM well *=
/
-	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM, },
-	{ "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM, },
-	{ "SAMSUNG MZ7TD256HAFV-000L9", NULL,       ATA_HORKAGE_NOLPM, },
-	{ "SAMSUNG MZ7TE512HMHP-000L1", "EXT06L0Q", ATA_HORKAGE_NOLPM, },
+	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM },
+	{ "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM },
+	{ "SAMSUNG MZ7TD256HAFV-000L9", NULL,       ATA_HORKAGE_NOLPM },
+	{ "SAMSUNG MZ7TE512HMHP-000L1", "EXT06L0Q", ATA_HORKAGE_NOLPM },
=20
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+						ATA_HORKAGE_ZERO_AFTER_TRIM },
 	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+						ATA_HORKAGE_ZERO_AFTER_TRIM },
 	{ "Crucial_CT*M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+						ATA_HORKAGE_ZERO_AFTER_TRIM },
 	{ "Micron_M5[15]0_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+						ATA_HORKAGE_ZERO_AFTER_TRIM },
 	{ "Crucial_CT*M550*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+						ATA_HORKAGE_ZERO_AFTER_TRIM },
 	{ "Crucial_CT*MX100*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+						ATA_HORKAGE_ZERO_AFTER_TRIM },
 	{ "Samsung SSD 840*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+						ATA_HORKAGE_ZERO_AFTER_TRIM },
 	{ "Samsung SSD 850*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+						ATA_HORKAGE_ZERO_AFTER_TRIM },
 	{ "Samsung SSD 860*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
-						ATA_HORKAGE_NO_NCQ_ON_ATI, },
+						ATA_HORKAGE_NO_NCQ_ON_ATI },
 	{ "Samsung SSD 870*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
-						ATA_HORKAGE_NO_NCQ_ON_ATI, },
+						ATA_HORKAGE_NO_NCQ_ON_ATI },
 	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+						ATA_HORKAGE_ZERO_AFTER_TRIM },
=20
 	/* devices that don't properly handle TRIM commands */
-	{ "SuperSSpeed S238*",		NULL,	ATA_HORKAGE_NOTRIM, },
-	{ "M88V29*",			NULL,	ATA_HORKAGE_NOTRIM, },
+	{ "SuperSSpeed S238*",		NULL,	ATA_HORKAGE_NOTRIM },
+	{ "M88V29*",			NULL,	ATA_HORKAGE_NOTRIM },
=20
 	/*
 	 * As defined, the DRAT (Deterministic Read After Trim) and RZAT
@@ -4047,16 +4047,16 @@ static const struct ata_blacklist_entry ata_devic=
e_blacklist [] =3D {
 	 * The intel 510 drive has buggy DRAT/RZAT. Explicitly exclude
 	 * that model before whitelisting all other intel SSDs.
 	 */
-	{ "INTEL*SSDSC2MH*",		NULL,	0, },
-
-	{ "Micron*",			NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
-	{ "Crucial*",			NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
-	{ "INTEL*SSD*", 		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
-	{ "SSD*INTEL*",			NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
-	{ "Samsung*SSD*",		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
-	{ "SAMSUNG*SSD*",		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
-	{ "SAMSUNG*MZ7KM*",		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
-	{ "ST[1248][0248]0[FH]*",	NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "INTEL*SSDSC2MH*",		NULL,	0 },
+
+	{ "Micron*",			NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM },
+	{ "Crucial*",			NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM },
+	{ "INTEL*SSD*", 		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM },
+	{ "SSD*INTEL*",			NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM },
+	{ "Samsung*SSD*",		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM },
+	{ "SAMSUNG*SSD*",		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM },
+	{ "SAMSUNG*MZ7KM*",		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM },
+	{ "ST[1248][0248]0[FH]*",	NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM },
=20
 	/*
 	 * Some WD SATA-I drives spin up and down erratically when the link
--=20
2.35.1

