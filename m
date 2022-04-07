Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F4DC4332F
	for <linux-ide@archiver.kernel.org>; Thu,  7 Apr 2022 12:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243439AbiDGMjy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 7 Apr 2022 08:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbiDGMjx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 7 Apr 2022 08:39:53 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3EC258444
        for <linux-ide@vger.kernel.org>; Thu,  7 Apr 2022 05:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649335073; x=1680871073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nTUKmO5OrMvbzz6gsATkhqB69hv+JkMkY/iUmHtGT0o=;
  b=rVtdz2UkuPFw0ppmnJTckw+H8qXCwZFjNWqnsjXht37wlpvTF5UXlCB1
   Y3I+beUFwa7/IsqO3trKCVowpM4jrDLj/X7VoyikwTX4r6KAaCF8Hyi3O
   D16o79xRHUQwCr9pmhj8C/OmOU3TG+Aoo3KFy1FCqaEuYSr6NpsWtJok2
   ZiWXLx6PATvmoIuemfpqmq0pKivW8pFsBwA/P/Goc+ZbU80UJOXU5bgUO
   CBDmMkLnXjvgQ5LiJceydkTbAawv2WZgQTSn2XlBIJu+/psuOh/EhQCg/
   Wv+wvNvvRfgMR4ENx5CvtCDCavRKNbL4ULQKyEgOou6r09zQIGcaFgpJc
   A==;
X-IronPort-AV: E=Sophos;i="5.90,242,1643644800"; 
   d="scan'208";a="196215435"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2022 20:37:53 +0800
IronPort-SDR: fqSRnqt0Zz5mkNcWXxs7BEfZDTu7gdok8J4t4px/DPm8ZUD2d8XkZOyFW1xfgYHpZpfYht2bmQ
 Ndr3ayflDqsQIOsLN9N5jOZJf3z4qMqNRp+dllb3qMPH16FYLI4fW5hxYPPSsKh5Xr/cczPNuI
 ep7XjscxicNLFUCEMXFMaiTbLD+4DH0dQnzorbK4a8h+/Tzxh6YutfMzHOwUWyM9hq4QZrSGay
 t4fbT7WkWuPd/Ja6DrfCRfhIRGK0vCwYNVW5RTdTjoZKATzMhrSsRCH7RJjC+pFtaa7jUnjOPE
 2cbzVwXa4vtQlCaEFKEWWhAW
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2022 05:08:33 -0700
IronPort-SDR: A2oNrwlKemUJ0sU1i+R3NXboebiKZ9QJYmeIrMDgbp+gCnlpL/yePKvGApPJi9eY6JdT4StDgI
 2YNoVYVHO85eEnWqiIT8NqpAbysbkTotXYcC8qHlbiCwRsiZjg3VL6cQGW4N8z1x4IFbyMFMRz
 dVzXpWgkfiDtdF6bV+OverrNr5Qb5r0jPdHuJlIU6bFDsSvPWL0fDCMlBWgoc+gO+KVDgwbtXG
 ShukA/qocYN3KyAsAsVt9ayQWOG62+9Xim4n6/MFh7mAjjsH3BdP5/FZAZOQLxvXT6Ai2UNDhB
 FxA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2022 05:37:53 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KZ1B86F5Tz1SVnx
        for <linux-ide@vger.kernel.org>; Thu,  7 Apr 2022 05:37:52 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1649335072; x=1651927073; bh=nTUKmO5OrMvbzz6gsA
        TkhqB69hv+JkMkY/iUmHtGT0o=; b=a2Qz2uoyxJom87m5OZUffErevVGOTac3uo
        aJqLEJcTNipL+z6ywWLM/Ss0ExI6SwvwTRWyq9iGhixjhTJyY/zxQBadYcJwUTwQ
        5W4G/meYHzQT/GEL7yELBG9OYWCeEhyWahjvDmFR1K+Rz7GAO5bd8vfvO8Wfg3r+
        j2ZmqR1QKwpabCZYZL6uYZx/duAfaxbz4y9WKS1kiR47FxZhwuUZxlm0HR6vkudJ
        z1ZDVHCoxqEY9La/WEYm39UHk+kXbUE8QLGye21qrirkSdBj3em7FvdIpETWpAR3
        BkOrU2pTS/feiWJVDPO9upAB+deNa9LWxVU6HV9AxKLSoWCdgfXw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id N4kqpO8qicf4 for <linux-ide@vger.kernel.org>;
        Thu,  7 Apr 2022 05:37:52 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KZ1B72584z1Rwrw;
        Thu,  7 Apr 2022 05:37:51 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 1/5] ata: libata-core: cleanup ata_device_blacklist
Date:   Thu,  7 Apr 2022 21:37:44 +0900
Message-Id: <20220407123748.1170212-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407123748.1170212-1-damien.lemoal@opensource.wdc.com>
References: <20220407123748.1170212-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Remove the unneeded comma after the last field of the array entries.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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

