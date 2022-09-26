Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C0BC07E9D
	for <linux-ide@archiver.kernel.org>; Mon, 26 Sep 2022 20:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiIZUxn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 26 Sep 2022 16:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiIZUxV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 26 Sep 2022 16:53:21 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DFAAC3AE
        for <linux-ide@vger.kernel.org>; Mon, 26 Sep 2022 13:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664225600; x=1695761600;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D2tlF2V9kpdDUzPbuo0OvgGM763PPvJVdQJbL/XT7gA=;
  b=PzOoX1eN2fwEYSawzfrq46oGhSGnyoZCjki8NI3fX8Doc06YXeLhkfDF
   mqGZk4R5UquDByrOYGwZ2pzetXSVE9EQ1f95dzYVBeIenya8TBkOhNASG
   nPk5WOpsMLXLjpOKq0bsXB7IuSIIkaDLMD/e/zrXg86U8eDDbCzk9/ozG
   Id9Cg/kK9FghOzkuge/hlRvH0yGuQbr/dguKPQrqV9xVGN/FkitSM7r2I
   LY/DWocIPGRp3+bI20DO+Jl1hVOK6k9hgvS1y1ct2puZyWnkMFzEANy+Q
   AX1wE627Z3NDJuRaLguze0zFBkpZdi7ljZTScXlyruE1UbJO+YzQBhhzn
   g==;
X-IronPort-AV: E=Sophos;i="5.93,347,1654531200"; 
   d="scan'208";a="316601435"
Received: from mail-bn8nam04lp2043.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.43])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2022 04:53:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWGPSRw31RU+jW9WhaiLrKN9MudrO36+/SFC2ouA0vXTPH4pYO3xBueZna8uzq6c07a6peo2P/DL8Pe51ySfVohT5WFdK7dkICrtJA79/F23wZzokzNh3P1wHeAyTV8rP9IiOlc7it6czS0uT91j2+/XVo+jHjEie8J7QAZDxOOgHmfa9/EdFr5sbMM8B6FDjj4fdvHccpDOf75bebjV3sl3RjwGh4szmsoojFSB7SlyWWu8JLVWedGgpMmgsNjvJYdnfpLM55KfCeb3TksESpUg70QXeLJN+10HKUCbZPO4McmejynqAk8yrH6YxF/RK1WXARoYx5UYJLFo87HxiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdfCAwA9ZeHwR1l+q68dZDsCSRmLlPEWtzMEVyVIRsg=;
 b=gxq11YEAdzN/F9mqzHoRKI7g5UX1t8QHjmxsrjHTjnJfY0v+QY0opT5+kN3KOmeo13VNcunApEzZScVTYyljb5h/MWtl1w7fBicRKexHSV2kyUsw57XzUFtk+hLKNxnQ7Adpx6cZ7Nw6iWc3BHrFgQst7phrwk9AB6sUXlcusiOeiPw+Y0+9kj/rbs5lXd6S6HeUXLNGEKqIPCcrlNgYG/sQmLtDOCgGdZHIYZD/dMVi6/QcoGT2n3ygWk/hCDN4sHrUVLkYsWswEwKD/iKgu0mJYU8QCih7Pc+V/pIKRqD9n/hepC/afGXOKgtT8rYKt/cUth0ytxygcPjqEMwb+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdfCAwA9ZeHwR1l+q68dZDsCSRmLlPEWtzMEVyVIRsg=;
 b=YKYUdbztecmDLQ3csuBHUOcDERnOL9A0KHsAhmiR2XBsuDOTHG2boww89I6jJW5BWSqNSlU7V8BeYFhi0RY8/+TYEze3Lw8wpK4yZrmvC4k0vJEhdUAEm7Wig7EB4oPmVEpHb9tmb01SIfEtGfaGxQJQjvXm4Uq4UbQq+nbxm7M=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BY5PR04MB6469.namprd04.prod.outlook.com (2603:10b6:a03:1e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 20:53:06 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::c8bd:645f:364:f7aa]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::c8bd:645f:364:f7aa%5]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 20:53:06 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>
CC:     Hannes Reinecke <hare@suse.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: [PATCH 2/5] ata: libata: fix NCQ autosense logic
Thread-Topic: [PATCH 2/5] ata: libata: fix NCQ autosense logic
Thread-Index: AQHY0en6rNKKvZczkECrEVsvZ9JCxg==
Date:   Mon, 26 Sep 2022 20:53:06 +0000
Message-ID: <20220926205257.601750-3-Niklas.Cassel@wdc.com>
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
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BY5PR04MB6469:EE_
x-ms-office365-filtering-correlation-id: f13f461a-53da-435e-4d0f-08daa0011c8d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DKeXzIXA4/ILQMohe64gT1984ZqUq4ixQcKjMI9KVMqs3wgxGuydY5iPjXoPYuwHdSXSRrEwCgQkURxaJQ/3ita9aD5ibXgIjMX8KZHNLhxNbOzvAs+XEyNoG6G14eWRv1ORCzYva0zNnEtR6OZUAuSv5ZkmLe+IiJKxgB5CKw5l5J64Nd763oIAQilYCIwmeGPD+QyGHQZ0htv5JjdcCe+Q5/QHxb19j4pBbSGFZkMfRxlPAThE6qF0y4y8ZoRcbyFM3ii2VbPzyIdtJRpN8ehZFaJal12UrGpupDfqvDT+fwjFXIQjFnGZPz2R5W41sVUBcZ7uIuQItGXxBo6fcrcNqngGFdL3g+xUevpYDKdH3AFDZ31SIGul+volmwFm6jnBytSwOmb+o4yB61ng046p2YYAqccHQsK3EUblE4vLpJEceagA/v6QIlDDla2PxREN1cQiUDWRT6uUkC/UOqYqXiHDRlwMLNdvojeqGeZdNCaBVzDsnfENBmJyNi49tIbarQQvcNm5eBtUeJ1V2lklDEX8G3MbPrcKxRI3so1+zDt60+d6RQ1E4fOVg2z9cdIZiTcm2YnJCOOVZg6NKDBFXCB9zNEWthXUXOQ1fEDGJ2cNhuqrkaT2m46Yn/2Daiut0JzMS9F7wAordvS+068bykiBCDAVy1VTKF++hLXg82hJlEv7N191YZYJNTte+FM5tu8NcUvC/Pf74o3QMOk8Bp5suMiEbFdWlbCsI6xKwYqtC+x2myX/Zaw1WqIXkckpfqEIlrE3PlCtCOM7Aw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199015)(26005)(6506007)(5660300002)(8936002)(41300700001)(82960400001)(83380400001)(6512007)(122000001)(186003)(2616005)(1076003)(36756003)(38070700005)(2906002)(38100700002)(110136005)(316002)(6486002)(54906003)(71200400001)(4326008)(8676002)(76116006)(66446008)(66476007)(66556008)(91956017)(64756008)(66946007)(86362001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?D2jBtPAEzqxpersxfWDfvizWMIGrA/2/1eC5/Q48I1qmmGJji/Yp1upW5j?=
 =?iso-8859-1?Q?i8hVyCEIKXNbXMEG923MLnrc98MD1jnpSQtYPBeUIip1VGFUb5NJ1KCf2o?=
 =?iso-8859-1?Q?DDNw0qBLrzK2hCsh1QXvVocVVYhX4sbyfAkMwIbH6Q6QpugI8ljqga++6E?=
 =?iso-8859-1?Q?a/SUr3jR84nvyW0PxqC2mqhh7YXKkKwXo3QFC49wW022fFFuSMHRHkjELi?=
 =?iso-8859-1?Q?sd7/javfAKqkfcg0US/TlvOV4UOoWIs/LuOSASDGwKeaZA5l5vOPc9/9co?=
 =?iso-8859-1?Q?dDIiG91S5y08mkJdbGZPhhSI0KF8hAQM94pvGxFfTiym7iUbXtGKhYnUTu?=
 =?iso-8859-1?Q?rb5BSsLkak8tgdc1ngowOabnRJoabe0/Gj3RWF0OeEBiQd6P/WRtwFXIYO?=
 =?iso-8859-1?Q?M4LmYty7I0nZZIK/KxWIuROxx4GRP6ZkeIysZxTU1Xi1XdcUuwXsKVygYi?=
 =?iso-8859-1?Q?Nf/r0A6dnmz/sDq9Gw9c2g6/ThOGGnA699lOYK3u/bqZGCTR2RXTyIkKrX?=
 =?iso-8859-1?Q?5sPQKWVN1LfJ2ZtvVv3LMZWoVsbe3QgSrn0LLpCBGGuOBPIppsjymUoiQE?=
 =?iso-8859-1?Q?IT7gbx+EdAR1pHJc4pp44vKcv2jkaU0VTn7abMITzFHNEztzReRT1A6kcb?=
 =?iso-8859-1?Q?x6d5FI79T0iKczjqTyGvEy+7+LEZOzO89PGD3pWXjgq9MIbr9k8r6iTLAB?=
 =?iso-8859-1?Q?edqGvYRoRkI5V2c8bInLAmo1ot8pNp4WrV/AoXW62KKx5jrGXEmxZ0CLYX?=
 =?iso-8859-1?Q?1SUZ9gi90bRHiw1ioeHjpDGW5sy3ey22cYNkcTfhxPBJ0AbJBXg+ahpuJK?=
 =?iso-8859-1?Q?lN/TujHSS10y2QAu6ikwZ/noAxe0oftoj8MnKnDXkd3Go3sxhwICfyHyJG?=
 =?iso-8859-1?Q?qA3VcgXzrYkLnxnoa9ShydQFpeKOsTc8YIFfN6dra/tiCTDoFrFNwnkS21?=
 =?iso-8859-1?Q?gDgTVbGgPoPfpwzhkUmdOS+S3KmIjknpPErCEUAnmUSODOpMN96wAopqYI?=
 =?iso-8859-1?Q?e7Ufpr79PMzDOlcmzB0182CLtCtQT3IqEFq6OQKmNBD+w1ZWv2QrTlevio?=
 =?iso-8859-1?Q?ZUzSKoV2zzdK6sU/goKkxb5ECrElY59Kz5ZDIgeLeLyoIpj3W84vx/SDEw?=
 =?iso-8859-1?Q?qVTEj/ZKV6rtufBpocsbgwx3XjTJQ1MsU703iZoPT/eYOaRUipDg0ntMKe?=
 =?iso-8859-1?Q?1qHUWiT6SaQf4jzUzU/Fnce0POB+YbgzWj1amZYbiIiqu7+KBqn9Ph0Kb6?=
 =?iso-8859-1?Q?hSIhS1bQ7u4QSSM1bdnMMff/mPn4frjDVJP6dO71YNvVirUZux70CShJvz?=
 =?iso-8859-1?Q?+y4b9p4pPTeb2odHurxlrZlLn/PfxMjpuVqdMFBF9VvedboAm02dj1Aq9O?=
 =?iso-8859-1?Q?I/lSZFL9HrbhuQVPWHEQyLP3A1RTsfEmSHPdN764er3fM79qkonetzXVK2?=
 =?iso-8859-1?Q?6yrHJTYkT58PRXDsB/qeWPsLJkZKWQjANeAPWh+8qdDczMAaM2f2SCFCas?=
 =?iso-8859-1?Q?81m6kxp+8ohc6pdc8XsewGa6XkEvm5i4g/r+M7iwRTtUNl9H87GC3VI7UF?=
 =?iso-8859-1?Q?nNYkh0kdbScKFs/YerZkn4alORX+cCthUlGHkj3TKjLI3QAXy2ogF+Gys5?=
 =?iso-8859-1?Q?89r2lu9iYB1K14UdkTMW4tgnZlzjlx24ZdSwTtRhrocxkmGwmlQztPsA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f13f461a-53da-435e-4d0f-08daa0011c8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 20:53:06.0624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m0gMHMI5lLp6cPCALNqQINgCUONiWRKMuyKEkpKLs4UVyEeaURPM87jIQD+QIwK6zAnxgy7/RbFBz5EwUl9xqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6469
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

Currently, the logic if we should call ata_scsi_set_sense()
(and set flag ATA_QCFLAG_SENSE_VALID to indicate that we have
successfully added sense data to the struct ata_queued_cmd)
looks like this:

if (dev->class =3D=3D ATA_DEV_ZAC &&
    ((qc->result_tf.status & ATA_SENSE) || qc->result_tf.auxiliary))

The problem with this is that a drive can support the NCQ command
error log without supporting NCQ autosense.

On such a drive, if the failing command has sense data, the status
field in the NCQ command error log will have the ATA_SENSE bit set.

It is just that this sense data is not included in the NCQ command
error log when NCQ autosense is not supported. Instead the sense
data has to be fetched using the REQUEST SENSE DATA EXT command.

Therefore, we should only add the sense data if the drive supports
NCQ autosense AND the ATA_SENSE bit is set in the status field.

Fix this, and at the same time, remove the duplicated ATA_DEV_ZAC
check. The struct ata_taskfile supplied to ata_eh_read_log_10h()
is memset:ed before calling the function, so simply checking if
qc->result_tf.auxiliary is set is sufficient to tell us that the
log actually contained sense data.

Fixes: d238ffd59d3c ("libata: do not attempt to retrieve sense code twice")
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libata-sata.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index eef57d101ed1..dfbc660651e7 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1392,7 +1392,8 @@ static int ata_eh_read_log_10h(struct ata_device *dev=
,
 	tf->hob_lbah =3D buf[10];
 	tf->nsect =3D buf[12];
 	tf->hob_nsect =3D buf[13];
-	if (dev->class =3D=3D ATA_DEV_ZAC && ata_id_has_ncq_autosense(dev->id))
+	if (dev->class =3D=3D ATA_DEV_ZAC && ata_id_has_ncq_autosense(dev->id) &&
+	    (tf->status & ATA_SENSE))
 		tf->auxiliary =3D buf[14] << 16 | buf[15] << 8 | buf[16];
=20
 	return 0;
@@ -1456,8 +1457,12 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
 	memcpy(&qc->result_tf, &tf, sizeof(tf));
 	qc->result_tf.flags =3D ATA_TFLAG_ISADDR | ATA_TFLAG_LBA | ATA_TFLAG_LBA4=
8;
 	qc->err_mask |=3D AC_ERR_DEV | AC_ERR_NCQ;
-	if (dev->class =3D=3D ATA_DEV_ZAC &&
-	    ((qc->result_tf.status & ATA_SENSE) || qc->result_tf.auxiliary)) {
+
+	/*
+	 * If the device supports NCQ autosense, ata_eh_read_log_10h() will have
+	 * stored the sense data in qc->result_tf.auxiliary.
+	 */
+	if (qc->result_tf.auxiliary) {
 		char sense_key, asc, ascq;
=20
 		sense_key =3D (qc->result_tf.auxiliary >> 16) & 0xff;
--=20
2.37.3
