Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6F4C07E9D
	for <linux-ide@archiver.kernel.org>; Mon, 26 Sep 2022 20:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiIZUxU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 26 Sep 2022 16:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiIZUxS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 26 Sep 2022 16:53:18 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C361AAC39F
        for <linux-ide@vger.kernel.org>; Mon, 26 Sep 2022 13:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664225597; x=1695761597;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=popbEWWE8beRjvLWbjO6htXqgXTCLBhiU4JqgO0BaKA=;
  b=n2gZIrIXt0Wfb2Qz5psi2jfDWL9E0s1+bptYCM9Xct3Nh8TYOBLH6jHh
   xlNJAuL1IMLvhQ/MYvGMQROmgRgKUfC4QJSzx4OMcIgKQI06l1Qg+gdC7
   8TuYdcmq7WzSaXtQasoH7IC1SFDiDldtjr7uOHKBgLpKIn6rxsLNbfN4W
   /rTX8I7zDEmAW2J639z41rD4pGKDcEGtyBSVG8GPe/bmP7SKlJBYQ6oo1
   9/gCddfI+F47DNghwmizfLDrsHzts5VTBs0h0WjPeAhKW9ip1zub/USz+
   n5qJaipHvhnY42CkSeCUk+CgLjKdRMRdkDus/AoUNKcDfoaikcRe5juYB
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,347,1654531200"; 
   d="scan'208";a="324421453"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2022 04:53:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxMOXqCmKwjUR5J6LuYIwD0+sMaCC7j3nn3z7HJW3o/feUd4Ppmlvzsntlz05O0ZsZQRi/9wPnVWEeCbqyhka2wRPjmpeBbM3tKqTFKcrIhDcsdHM65Fztp6EifYy96+bQb8z/r/oiCdWgDkmBrXGlCplr+bjgX64bmYnkSWOARtCA2fE8Y+ydXS77DBnTO0lTT59DWAX2OWq3naSuVnj2UQsZwoAIdUyl78ZVbSOOcm4U20cWoo6/xfxh4+lmgocmbCy4+I+ZpVsC6zEVnkjtJDdUw/hWRsUP+EEpUKyNYjgmHwAT32HkFCumdOnH9b8aWTNTSUDfXSGx6sBN1d0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L66sVjYJgXTdlE23mWhV8TxI10w8jkj94MYl+PRw2a0=;
 b=D4958ImsQOgN+Zt6Yh0K/La6xNuW54R4MxACY9MI6cEOA99EkiGMMYn6Di2oKO1EJOB+ZrzCkh8LnYxj35JLcG4YSvgOs920nhAdpunZpwxWIzaimMpmWtw+B5TzEz9AU/mc+YjrcNM/4fab7x3uYhvhz/6W36Vn/aCvA7aBcvL98WxadhAuE1iez418gT8Q+D0TcWruUn+U/uAeMbr2R+Kc8HOo0fe14tpVUCoQcCJZtpDTW3jomdjXz95VGyrhLzOb4StVRbdoueUi2GzpXGf2gUtSqSc+QsD+D/wu3/+xetiG4wtB5JxobG//gLxhNdUl8TY8rl+VezYNaJOwFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L66sVjYJgXTdlE23mWhV8TxI10w8jkj94MYl+PRw2a0=;
 b=a7dU5rcTlUlhA51lyAVC3jS9qpKTFMIm12pHMMw5c9mpa3Yj4c7G2c5jbi/pcsAAbZeGZ4ANcd1FpADyZLRCmepOMIW7VKJ9l/8Dl6Rem9hB4p/hM5mjvt6mx7QL194PvqpUqwzIMwkacAtsrAjfGGoukSSVCGehlAG9lp5Z0vQ=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by CY4PR04MB0391.namprd04.prod.outlook.com (2603:10b6:903:bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.22; Mon, 26 Sep
 2022 20:53:07 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::c8bd:645f:364:f7aa]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::c8bd:645f:364:f7aa%5]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 20:53:07 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     Hannes Reinecke <hare@suse.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: [PATCH 4/5] ata: libata: only set sense valid flag if sense data is
 valid
Thread-Topic: [PATCH 4/5] ata: libata: only set sense valid flag if sense data
 is valid
Thread-Index: AQHY0en7pPsTP8d7Kk6fjaAZPX9+6g==
Date:   Mon, 26 Sep 2022 20:53:07 +0000
Message-ID: <20220926205257.601750-5-Niklas.Cassel@wdc.com>
References: <20220926205257.601750-1-Niklas.Cassel@wdc.com>
In-Reply-To: <20220926205257.601750-1-Niklas.Cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.37.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|CY4PR04MB0391:EE_
x-ms-office365-filtering-correlation-id: 9767cb82-e50c-4717-c719-08daa0011d8e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fUFG8PZfvnqo6VfV5NcNs5yGQW0NLfgSMs5ObpmsalnnLO9xEjfq5NNfjTdzF1hWWawVpCvcC8iM6b395ORWjOKfS/RdNs2VoxQZgr92JMl0PqpV1aqmp4LIVE/rDuu5G/Qqy7nn9AO5J1VoUc+Nim5W1abFxQHDKh1R6EpkldlMAsARQQN+bQquJP9Nii4e8xqvrUOYVkjMvi9eoZWkmdjapO4IHJjegbhDHFUIlnqU5RX+p1hx0cFCQveDKWhjRdZPXEQVfPmsUI0mN0LXl8uRfYyROO3Xk/bstEusSSmv7mGzNFoxXQJZqAJRFehtm6O2vK3YkHY+r406xO+tlsEz2GgHr1BPGcykbPfqRHX2rCy+I5jmhHEct9cwoG7ncuEEa0nKDxhA7FlXiGVAhTNdw9+ALuL7Jy9PI6JXtVvF9mE1qQrxykspLfN7H12UhVBYOvo5gpCuIHq6B061BkxAUCXa9I2Gpi0PbFXjP4iM9HUi3DksX0cd626+txGtdiEUd+0a4G0TXtbdq1bVDnEqarpuWZI37uOJQh2DbX+F2qfibMDOTMPWMt4YsUH4vIXdKljiHQo8hE341EReNGpCltOT5BfkKR6yaMyZbxWleXFn+9DNBc+qMaJrVgAYbaSG+gNn769aDR8p1L1PtbsoeypPjt/A1+ykb3dgT0JrGAXg/7iG3tslpcv1mWCThd82Q+stXmDGLgzKlTiXlJU1wM6K7BDxJ0fe8qrJTbNjQPkCy7XUpoyNc0Cs2lOqNGXJ/YyQ//GO15CM8QWkaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199015)(38070700005)(5660300002)(38100700002)(122000001)(66556008)(6512007)(82960400001)(316002)(66946007)(26005)(64756008)(2906002)(66446008)(91956017)(76116006)(2616005)(66476007)(478600001)(86362001)(71200400001)(6506007)(54906003)(6486002)(36756003)(6862004)(186003)(8936002)(8676002)(1076003)(4326008)(41300700001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?R2xI5hL2pkOzfhC5tJGyRR6NA/U11OGIff8svrHczLaP8JD77E3sQmxeXC?=
 =?iso-8859-1?Q?vbWDWNeA+mka1dg4yEjK2RYXkhYQvHAaO8qrDeGDrUQI6cSKgPq+X+qJDR?=
 =?iso-8859-1?Q?/bDXSGB4R22QBPsLf0BzoJ2aMm1dkhAxSke6TqnCr71pYF304BTPlBgY4d?=
 =?iso-8859-1?Q?7aLQLQvIGi/TYU22SexEVu2VyA1xKS2D5fLKlsdxfexiPtGVQiFXayOw2l?=
 =?iso-8859-1?Q?7FE51zhmCERMqGzvnxKOx35wAQiAXVHY14Sjo6P5R4+P9r7+lvLROMozfg?=
 =?iso-8859-1?Q?r5uAAeryXQ8jiacumB5vPsVIhkZKGM9mnHSSYVsNdfojLlKhqHq9iQf/fm?=
 =?iso-8859-1?Q?i07fmH2HeFBnbtsBTvSc2lmIsYWD8pSxmUMYRijJ3AkKVwCg+m4ndUuslW?=
 =?iso-8859-1?Q?RAJIkFeUYrS2G4SMqXviJk8VrJJkO+lIF9Ogv1qPr+0ZjLGVtWD7Fsv6i/?=
 =?iso-8859-1?Q?xfQAaAr3Mv+TbBFeMVJCrGIkRWKupdHnjXOhGnssrXcodsArtFv5f2OQ6V?=
 =?iso-8859-1?Q?JgOe4sqXlV92dXgjxsVwCknpg6e6hDMZ7H9IeJigV/6hyBjvM9rYpfxw3B?=
 =?iso-8859-1?Q?/320vG5F3+IZSRx/txX32HTLQU1LZes9Z0bKPPPshZMewJjA+JyF8ivY8x?=
 =?iso-8859-1?Q?oqFm9Tct0C01hI6eKc8Qtf3DzPtwSD7LPuttnPpl7RO4tI/ZOqef1qCPZy?=
 =?iso-8859-1?Q?Cv7IgB72PqMp2d9IVh/attSuR8Y5xu3QdTnsN4ULJIfG9yWGN2WKSV6FUW?=
 =?iso-8859-1?Q?cG8aUBfTaL+ib9zA5+wcjapjL+hrbSqGsFLgjZO1g/FPYxS85ck3mYgO3O?=
 =?iso-8859-1?Q?RNi4mvx7si8lqocUeMRK4YkbIC7uAWMDzF5ybUyUGr8W6YyM1OLlvDYTx1?=
 =?iso-8859-1?Q?weWPqsGGeFHVnhxKOEq9xXKorIcaam2rYITGkqpWR30r2JuNSVkEX6FGAE?=
 =?iso-8859-1?Q?MZS11PkD5nyJhQ75KR0aQoaUWUpKmHrmlLbdgGxuV4tHEZrYQgX/qmnYWX?=
 =?iso-8859-1?Q?WiRwl++s5UNjS/nG8Jayfs272FD73RJsDwNVQ8AEer3ASHxmZTr6/hTZIw?=
 =?iso-8859-1?Q?CIUwq4oXBH/vORXggs89SAB8Ux7vxZoy6gtV3YBS5MN8N8vMlGfHLo4O3/?=
 =?iso-8859-1?Q?zm5q8WanQfM+iOMejsI9zwxU40J2caVZOkW/WLAE1GLEgMveyZLe/gjQbp?=
 =?iso-8859-1?Q?4T9OQbOjR+oQYsxABbhdRBrFevrxxOCi6dltJEnR7GWaPDQfW0kuy7H+IE?=
 =?iso-8859-1?Q?291j1OSrQZzxlL+PC2OSCSBiI+Nu8NmESs9wEgNFPJvkLIlq6Pf81EYYus?=
 =?iso-8859-1?Q?01F7LMmWf0/5G8HCmDh3e3v3D3htBNiKESvfHJ8iZHyccAkxKPENe9zF8W?=
 =?iso-8859-1?Q?LzllOEdw1nNH4zmygYjopXzpJU6j3iFWKnslO6at6gU1jdlryL22lLBp22?=
 =?iso-8859-1?Q?A6htWO8MNFGbR3Gb3SZ/r1ANGBSfx2HC90aNm3xBks0AyBW/Z9029T7Gfz?=
 =?iso-8859-1?Q?1jfv4MMMr7KBudis6VEuwmf2Uz/8gVe2fU1XpVARr4K8/c3eLNlmLAxC6f?=
 =?iso-8859-1?Q?ZN5+B5Fle8EPlm5TPqoIG2UpSq/vRgqeedl6fqdSilaghMs0Wa0DSBvGLS?=
 =?iso-8859-1?Q?rd5+LXbn9WZnii8zxuefSJ7tSSuc/0TlAnOPSH3MI8ckkJferYNAaflA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9767cb82-e50c-4717-c719-08daa0011d8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 20:53:07.7498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EusHSMLHjbAgWn3dL6OF2XfjJWluURfrt0qWT4L2R/aqXwUVFTSDLn0eUZRJ3io8gw7R+wxnd1BvvvyP0bpdvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0391
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

While this shouldn't be needed if all devices that claim that they
support NCQ autosense (ata_id_has_ncq_autosense()) and/or the sense
data reporting feature (ata_id_has_sense_reporting()), actually
supported those features.

However, there might be some old ATA devices that either have these
bits set, even when they don't support those features, or they simply
return malformed data when using those features.

These devices should be quirked, but in order to try to minimize the
impact for the users of these such devices, it was suggested by Damien
Le Moal that it might be a good idea to sanity check the sense data
received from the device. If the sense data looks bogus, then the
sense data is never added to the scsi_cmnd command.

Introduce a new function, ata_scsi_sense_is_valid(), and use it in all
places where sense data is received from the device.

Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libata-eh.c   |  6 ++++--
 drivers/ata/libata-sata.c | 11 +++++++----
 drivers/ata/libata-scsi.c | 16 ++++++++++++++++
 drivers/ata/libata.h      |  1 +
 4 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index c6964fd2bc42..922e6c37ea9b 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1431,8 +1431,10 @@ static void ata_eh_request_sense(struct ata_queued_c=
md *qc)
 	err_mask =3D ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
 	/* Ignore err_mask; ATA_ERR might be set */
 	if (tf.status & ATA_SENSE) {
-		ata_scsi_set_sense(dev, cmd, tf.lbah, tf.lbam, tf.lbal);
-		qc->flags |=3D ATA_QCFLAG_SENSE_VALID;
+		if (ata_scsi_sense_is_valid(tf.lbah, tf.lbam, tf.lbal)) {
+			ata_scsi_set_sense(dev, cmd, tf.lbah, tf.lbam, tf.lbal);
+			qc->flags |=3D ATA_QCFLAG_SENSE_VALID;
+		}
 	} else {
 		ata_dev_warn(dev, "request sense failed stat %02x emask %x\n",
 			     tf.status, err_mask);
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index dfbc660651e7..5d75e62f27b5 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1468,10 +1468,13 @@ void ata_eh_analyze_ncq_error(struct ata_link *link=
)
 		sense_key =3D (qc->result_tf.auxiliary >> 16) & 0xff;
 		asc =3D (qc->result_tf.auxiliary >> 8) & 0xff;
 		ascq =3D qc->result_tf.auxiliary & 0xff;
-		ata_scsi_set_sense(dev, qc->scsicmd, sense_key, asc, ascq);
-		ata_scsi_set_sense_information(dev, qc->scsicmd,
-					       &qc->result_tf);
-		qc->flags |=3D ATA_QCFLAG_SENSE_VALID;
+		if (ata_scsi_sense_is_valid(sense_key, asc, ascq)) {
+			ata_scsi_set_sense(dev, qc->scsicmd, sense_key, asc,
+					   ascq);
+			ata_scsi_set_sense_information(dev, qc->scsicmd,
+						       &qc->result_tf);
+			qc->flags |=3D ATA_QCFLAG_SENSE_VALID;
+		}
 	}
=20
 	ehc->i.err_mask &=3D ~AC_ERR_DEV;
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index f3c64e796423..1222aaa62aff 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -188,6 +188,22 @@ DEVICE_ATTR(unload_heads, S_IRUGO | S_IWUSR,
 	    ata_scsi_park_show, ata_scsi_park_store);
 EXPORT_SYMBOL_GPL(dev_attr_unload_heads);
=20
+bool ata_scsi_sense_is_valid(u8 sk, u8 asc, u8 ascq)
+{
+	/*
+	 * If sk =3D=3D NO_SENSE, and asc + ascq =3D=3D NO ADDITIONAL SENSE INFOR=
MATION,
+	 * then there is no sense data to add.
+	 */
+	if (sk =3D=3D 0 && asc =3D=3D 0 && ascq =3D=3D 0)
+		return false;
+
+	/* If sk > COMPLETED, sense data is bogus. */
+	if (sk > COMPLETED)
+		return false;
+
+	return true;
+}
+
 void ata_scsi_set_sense(struct ata_device *dev, struct scsi_cmnd *cmd,
 			u8 sk, u8 asc, u8 ascq)
 {
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 2c5c8273af01..2cd6124a01e8 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -114,6 +114,7 @@ extern int ata_scsi_add_hosts(struct ata_host *host,
 			      struct scsi_host_template *sht);
 extern void ata_scsi_scan_host(struct ata_port *ap, int sync);
 extern int ata_scsi_offline_dev(struct ata_device *dev);
+extern bool ata_scsi_sense_is_valid(u8 sk, u8 asc, u8 ascq);
 extern void ata_scsi_set_sense(struct ata_device *dev,
 			       struct scsi_cmnd *cmd, u8 sk, u8 asc, u8 ascq);
 extern void ata_scsi_set_sense_information(struct ata_device *dev,
--=20
2.37.3
