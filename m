Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57224C6FA8E
	for <linux-ide@archiver.kernel.org>; Mon, 26 Sep 2022 20:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiIZUxV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 26 Sep 2022 16:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiIZUxT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 26 Sep 2022 16:53:19 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA115AC38D
        for <linux-ide@vger.kernel.org>; Mon, 26 Sep 2022 13:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664225598; x=1695761598;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JqpIYf3Izi8KgIMULhAtoyucxD+0UuZfQFqFltsiShA=;
  b=ihGEZOuW2YzH33zZzOeraxvOZgVoz43LBS/RoyDk5cOt2JIJBxSbynlO
   M2vOBPAl7UTZwgBf0toCPmacRfhApvIYVErGR2kCdwiDyPPh9LridAnN5
   z2Vm8cP9O4409mp2+A7ESm7KYDeWFtJSeTpUdzuHghDZuNvobFnsIBfxF
   be7iKUuQYUMzk3eG5tWBK8MstTkvxOkR/HNnXgYEvOr2K0L5vGLz8RdOi
   H4UnwwIdmEIb5AuRGR+X8ItHJRAq6NgtEnU6jL3TqHR207b/9roR+kN7c
   18txw5nKn8MONrMrUu1ALy91K3Y+jiEiEMCiKF9sKFxz7hHSU4GNz2jx6
   A==;
X-IronPort-AV: E=Sophos;i="5.93,347,1654531200"; 
   d="scan'208";a="324421454"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2022 04:53:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqF/fjiKlvoGGW4wwVzrYWRQmhymKoEgOMDJnd0GC9T8jgIRG52oLDDDTPs83O3gkuEC2kz9tasLQx4ntmGoc2qxbdMOnK2ht505hhY3T1H32Ucx4fUrr4loW5EmQN9S4ULj5C9aUiWz0Ys866VYsRrzdX8UxGM1eULc1XBWJkzrKQvD3wEAkhx7QKpqVT2OFU5mYee+5Gc2upWhMEvYNuQj+EN94QgWW7D43vGFj8t+wt0lJrzw7JJIc/mO26JHyOCgFfsLHduIxPAX/IB2dizRlNWnwvLvMxA9FhofFdL+lXIo90qNGfMIVot1eJfqdclJ8zGmvd5gwo2pGG+MPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJ6L0otYBGnT8ar4rvQ8Gx5QpuyIn0kBu8FJ1nancdM=;
 b=b0nwBe5uzyhF7CdlF1aj2buRJJFeoXnkEFmbbrc6GRz5cVVoqu76j7keMQFcGFHBhyvrP5BDfNbwAvtu7SySFSU8mGgq8KqCflGTgQvlih7qZ36rIRcw126laq1MhkEPEbZNWVI0O+XsTGCat2oY5ka6Z0cGh2sH6qVIWiZ3moc4MjUoc/QT+cxSM/5lXe9a+mAqDKtM+DsQJmb6tDrSb6xR7eFiu6StQxxuChazmyaPnYpoLensv81Nu7YsN0aZFnSL26CushIov0VOTpwjWg6orCEjUxFeCi1FZO5JruIzkLOXPOj6sGO7DmNSNB1ouKucrSZmZGcvHikAzKZFDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJ6L0otYBGnT8ar4rvQ8Gx5QpuyIn0kBu8FJ1nancdM=;
 b=oDf+sRNjRd0Vnzx1dk2BkIXzGKObO1anQ885HXyx6b/sp/1vlAG0syr310dUptOrpAAWoMeVp22DlUORNPGlHDzrjWSY0uodorFv/DHive3sqIeNN8VX8WbbY6lZz2Au4IEO6dvHe6c4JDcxbNLk3ts38ZzTAk9rnYRshBAUU7g=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by CY4PR04MB0391.namprd04.prod.outlook.com (2603:10b6:903:bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.22; Mon, 26 Sep
 2022 20:53:08 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::c8bd:645f:364:f7aa]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::c8bd:645f:364:f7aa%5]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 20:53:08 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     Hannes Reinecke <hare@suse.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: [PATCH 5/5] ata: libata: fetch sense data for ATA devices supporting
 sense reporting
Thread-Topic: [PATCH 5/5] ata: libata: fetch sense data for ATA devices
 supporting sense reporting
Thread-Index: AQHY0en7G1nndT3GEUy7Yn3UZCEKTA==
Date:   Mon, 26 Sep 2022 20:53:08 +0000
Message-ID: <20220926205257.601750-6-Niklas.Cassel@wdc.com>
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
x-ms-office365-filtering-correlation-id: 271a239e-4672-4c2e-bf77-08daa0011e0a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SF8+NTwspMB01ZUWxmvAvBT1BSH0eDbBrKVf2DffbV8Q4zx+DudiDqMjQNHYOmlHUNih3pquwv1ooFJ/dLVEBFUcyCQAgciq6p//jlc/sZSCDtkA0Ej/2xvIgrUZzPnOzIJiusRWk0wWzBT+kzaysMJau+hSbyPC1gLo3Q4ZQhuBQGIojgmNquU2RCKSzcrBTCK1Hj6z110Wa/cxsq+Lf3AuXeQw5Sdsccif0j2NpH6qqrtNoRVxC4qu5G6SABzaNUHKGZNwrH5G5KRk5j7rEdwsw8obZknGOqvipvUe2b8lWT5TLjZ5QS9nO5B7SS8DZCG02JpNoMxhS7deVAXASUC56YO7772Zf8QnoBP4lyNKKQJhZmWbbP1gyx0z90psHY8yf+OFciys+TnGt8SjjKIC2ST1zV/RNN6GUw3EDKr319D3TZYDFTD4YvpH2fKVJInqwiFYhzdUnXTtyJjuPzT9p8htYHrbK3oSvPv8r8o8kdXdDoMzCaoNt1O5+MNfrVUe4HwwlQ4exVzwdCI/L6T/7sprVokb0NIl3j9fMAozBYjRO/PEzDtIUfK6LDIR6E4nakV2IhgWyFvLbkmIRCNu40vISJP8LQXdgz4z1WI0aG0hsfQEAMf55u9NwBcuO5dltOgtpvxOhrrf1KFOSAMs3xFvoZWywl4xqWCseomQEdQ6HrTwn79LGyg2Q8czB+P2l84ovXfkP9EqDLDr5/+hlPgZdrbk51q+4voCX1orclsqlaxrSXkgvBchKXjnsmKTTVIQwKWXx9mSA+vyRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199015)(38070700005)(5660300002)(38100700002)(122000001)(66556008)(6512007)(82960400001)(316002)(66946007)(26005)(64756008)(2906002)(66446008)(91956017)(76116006)(2616005)(66476007)(478600001)(86362001)(71200400001)(6506007)(54906003)(6486002)(36756003)(6862004)(186003)(8936002)(8676002)(1076003)(4326008)(41300700001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?y/R8plRsx0nWv/lo3PpAS5PjTTEpuoXtdt5Kve4ZUFslQxVVdFGpj6oStY?=
 =?iso-8859-1?Q?OjLcvgRM3TO25PK7NkaHln+zQKuzDZsBOTUxGc/3giPoztHAOmaovhjfVR?=
 =?iso-8859-1?Q?00rZ4G3wfa5kGPKYJgaJHm0dkyg4L+kYzv12WxDTgPLTWYYmNXelF8YHfZ?=
 =?iso-8859-1?Q?zqxVsvJJUZdTv0NNNtarNOSReNRw1txx28cBIJAF2+UhBaHS8FGQQ7kyUv?=
 =?iso-8859-1?Q?ETZWyJQtoz9a8kpMJypzdAbaMkoWoI0BOLIR7OcHrIwHkZYE4v+DPexMOx?=
 =?iso-8859-1?Q?zXj+n5bR6TSufTTC8HGT407U7iFXGtW0nlKqybq3IOqxrS8dV01DlAJDwj?=
 =?iso-8859-1?Q?XYNUTSDDkdf8PpB641ZizFTZvB9Kd0xRc16Rwt3G8R4ETkuDh7Fb+jlEUv?=
 =?iso-8859-1?Q?FHt/fEdLmPNjPbsRCkV9fieFnUv8a19QAqOCJyfno7clwnk4qNQlSVeABr?=
 =?iso-8859-1?Q?xMlh81xA4T59aEgCXGzVxl0s0yRQFEmXzOilKekPB13rw31oqbpmQNUVb4?=
 =?iso-8859-1?Q?6twjJ2Wuz6KWhk9mCjGG/JD9glkBGs208wP6W4SiIRSM7XWEffezXGHOfg?=
 =?iso-8859-1?Q?Gl/iVZSMXNmI19xBJLUNWBtOy17m9lLbYaNj7sG0zuAnCc318STElsR8+G?=
 =?iso-8859-1?Q?kAr1WMlLL40dHVQp2PGzNA0Xz2Bo1zH4rNEJTQIZIjnLGvjiNSR3KcwQRT?=
 =?iso-8859-1?Q?f8FkrCUkVxdeTv96Jqu4I/Ngla8FLrOxGqYPoAtLP6I0u3EcqUETdlQbaE?=
 =?iso-8859-1?Q?plhyGQpyjTy/hNNmJNkqmleKNeBSppzHGIHW02isGuoo7HWBktU9wGPMXj?=
 =?iso-8859-1?Q?W1b0m2KEodgybqfjRcM3NH48sIRVGTAhNCVBXXP3KCUD1oA2bN2yejCay9?=
 =?iso-8859-1?Q?j1VEqhqZiGq+QE59k0ivfbjQTupVzRogN7qvPXba1+DrTMotEctFAtRBHi?=
 =?iso-8859-1?Q?jWHe3R+LwOozocKejPbFruxU+0+BFhW3bkuJxr+DhzjEh8J3LnQ8rOSdN4?=
 =?iso-8859-1?Q?NSHPaetP0ge7onw02ear7kBgcc9Usi+FPHgDOcvDQYvgPUhvyZBu1i8As+?=
 =?iso-8859-1?Q?ImRS8A4Bu/5tH1ulEuMTWUJPL/Oelj5aiBv9AU9Wuiu5t7MupFQtF+GGqR?=
 =?iso-8859-1?Q?yJnk4Vxh63CLn9yZ3OVzdgsxM3cSbiCnc2WiVccY310yRCHtECMw8HUT0I?=
 =?iso-8859-1?Q?FY3v3NiKXGpZAIW1XZL5Y47wWgcNeyBkT9J+r8FCFgCpYcb+n51PxlVMQa?=
 =?iso-8859-1?Q?adXprTMWYAhMNT9c4iCyMxMkA12aF0BhLunHXs/K+RlM/lel+vniU8ainX?=
 =?iso-8859-1?Q?sGDtZgeLoDgQX+bIoSTEjK1srj6p/ezVdGIyif9vD2zhpUI1hDiRWi9Ffu?=
 =?iso-8859-1?Q?KTjNrb3MB9t54d54FrkE6oOj1YlxV6Oz0TCXgV/+HmlHRZ+jMtuRGQAaHq?=
 =?iso-8859-1?Q?8IW6WiYrHz3HcUugKpuH+4UC25myhHyIb2VyrOw/Ag1WwpGSXUK8tm1AMm?=
 =?iso-8859-1?Q?2u6DrF5LlWiGwnMDvKiXSlwHphTHWJy4iTx+q6NHTT6a1x31GNi7q/Xezs?=
 =?iso-8859-1?Q?zw/HsfKlFlVv9C4uFAizzRWxxMibB19gGgiro3dKIvqkBG2t/R+T31qbEA?=
 =?iso-8859-1?Q?JEe7rddY1vyFH2UQSS9f9HRsowOO2eKxPOyL4uLeqiIn02O9ekBA297Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271a239e-4672-4c2e-bf77-08daa0011e0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 20:53:08.5622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K1/Io+2/uLn4BAE3BGdDJrs0UGraJRS/encXQmDlQjzaXnNkgnPAp9HCW1qGEoirb5THzh9nJi24uxNoBCNKBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0391
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

Currently, the sense data reporting feature set is enabled for all ATA
devices which supports the feature set (ata_id_has_sense_reporting()),
see ata_dev_config_sense_reporting().

However, even if sense data reporting is enabled, and the device
indicates that sense data is available, the sense data is only fetched
for ATA ZAC devices. For regular ATA devices, the available sense data
is never fetched, it is simply ignored. Instead, libata will use the
ERROR + STATUS fields and map them to a very generic and reduced set
of sense data, see ata_gen_ata_sense() and ata_to_sense_error().

When sense data reporting was first implemented, regular ATA devices
did fetch the sense data from the device. However, this was restricted
to only ATA ZAC devices in commit ca156e006add ("libata: don't request
sense data on !ZAC ATA devices").

With recent changes related to sense data and NCQ autosense, we want
to, once again, fetch the sense data for all ATA devices supporting
sense reporting.
ata_gen_ata_sense() should only be used for devices that don't support
the sense data reporting feature set.
hopefully the features will be more robust this time around.

It is not just ZAC, many new ATA features, e.g. Command Duration
Limits, relies on working NCQ autosense and sense data. Therefore,
it is not really an option to avoid fetching the sense data forever.

If we encounter a device that is misbehaving because the sense data is
actually fetched, then that device should be quirked such that it
never enables the sense data reporting feature set in the first place,
since such a device is obviously not compliant with the specification.

The order in which we will try to add sense data to a scsi_cmnd:
1) NCQ autosense (if supported) - ata_eh_analyze_ncq_error()
2) REQUEST SENSE DATA EXT (if supported) - ata_eh_request_sense()
3) error + status field translation - ata_gen_ata_sense(), called
   by ata_scsi_qc_complete() if neither 1) or 2) is supported.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libata-eh.c   | 3 +--
 drivers/ata/libata-sata.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 922e6c37ea9b..8610756d7d0a 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1579,6 +1579,7 @@ static unsigned int ata_eh_analyze_tf(struct ata_queu=
ed_cmd *qc)
 	}
=20
 	switch (qc->dev->class) {
+	case ATA_DEV_ATA:
 	case ATA_DEV_ZAC:
 		/*
 		 * Fetch the sense data explicitly if:
@@ -1589,8 +1590,6 @@ static unsigned int ata_eh_analyze_tf(struct ata_queu=
ed_cmd *qc)
 		 */
 		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID) && (stat & ATA_SENSE))
 			ata_eh_request_sense(qc);
-		fallthrough;
-	case ATA_DEV_ATA:
 		if (err & ATA_ICRC)
 			qc->err_mask |=3D AC_ERR_ATA_BUS;
 		if (err & (ATA_UNC | ATA_AMNF))
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 5d75e62f27b5..464e85d5cd83 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1392,8 +1392,7 @@ static int ata_eh_read_log_10h(struct ata_device *dev=
,
 	tf->hob_lbah =3D buf[10];
 	tf->nsect =3D buf[12];
 	tf->hob_nsect =3D buf[13];
-	if (dev->class =3D=3D ATA_DEV_ZAC && ata_id_has_ncq_autosense(dev->id) &&
-	    (tf->status & ATA_SENSE))
+	if (ata_id_has_ncq_autosense(dev->id) && (tf->status & ATA_SENSE))
 		tf->auxiliary =3D buf[14] << 16 | buf[15] << 8 | buf[16];
=20
 	return 0;
--=20
2.37.3
