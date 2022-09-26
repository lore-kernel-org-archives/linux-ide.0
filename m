Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE79C32771
	for <linux-ide@archiver.kernel.org>; Mon, 26 Sep 2022 20:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiIZUxm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 26 Sep 2022 16:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiIZUxV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 26 Sep 2022 16:53:21 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12219AD990
        for <linux-ide@vger.kernel.org>; Mon, 26 Sep 2022 13:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664225601; x=1695761601;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gbaItaRaFMyXHP89ibXuSJoC2eqkOjhpx1y9B1GahNM=;
  b=gYjHCwwHC3EXV856cWpa4zXViIY3qyAS3DUyRV8bCdx66lrm2SFgOvC7
   JPq+DZQx9zkSbtEyAxJbjqezgu0dbfGQC0luAdRcWTIflKA22H2auj2ed
   io2231qdhWbyBF9GqZlSopX3Z1ze4UVixPj3TuKb0hzzc5kO8uKby4fNk
   1AjAyZLsREL4/a5w8MBWReeVdmteLYP3kZZDcSENoTnW2GymceUzNsPT/
   7yhFVJkWIdsRh8OLhDrPqaoQVC4+HDtY4bKwS++B0XiDatpi4ug0rhin0
   23ql5vsskOHCO6pRKuDUxqdxBeEKgNaNCyhPgHECNd9o9ttzkTyafyJQk
   w==;
X-IronPort-AV: E=Sophos;i="5.93,347,1654531200"; 
   d="scan'208";a="316601437"
Received: from mail-bn8nam04lp2043.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.43])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2022 04:53:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQXuYOBSwbH8vC/eXMKttz2xwcVrtqIohD183PSH3+xCouxhPClug/6OurHgBt/4Q8KhMHz1lv0sLCYRiwj4gf+pZnA/0tADNrKNAPclek9d5p1dw434OuwN+J2Ca6OQ/ZWpXst2P+ZQbvx/NQWieUd7OG5uyTi/g2GSTLHgJWjeF58cTx7yYm7PIFevMPpKGw/63i78sWWc1JfPESL85LBkx3UF3d9Pk5adhMxGX9HTaqs7vGe+7p2uoULOfdofzafMqKsmUiomWMSlVZLCsyclw2cE8oP2oe4VqM8+IHJCtzMAYSDuCOnMmGKTXIqfH5Z6lwueVYpZYFk0si+sSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQsqlHDsllkGjVrrW/21ePQAubhlkNwITe69I/XnpLk=;
 b=jt2S4GO/LOxv1gqwWftA+p8ifVDODz5Br1pzoCWpVg3LLEKCN9h6Bcxr0DYK5TAjEKhRgvWQFwqPSHt6/ny8X9HXxVnxO1bhEp1PhgGymgjtiZlcZx88pB1yu19MUs6081ncHZo4Rte6OG+4uoY2QG3sPaiqfcOWFouHcbWSffvxqNmet/vPWRen+e3K9Dr89arWgR3TklNug4eXQIs40ohVqHW1I2TLM4c1Npb9V3U392chwHtEa4d3dK5PMZzRrcrPsqn2lO+e5iY5o36iXa9wt1whhIFHP0nKhs2KANYPD0IYtnHQBgxsK2jkzI9q8k4pyUW+8tzhcxjG/yEcdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQsqlHDsllkGjVrrW/21ePQAubhlkNwITe69I/XnpLk=;
 b=APjwNDLMnDg9i4bPKopIj1McE39sPiwaQa2qfgKOz74ZcLxhiTdjHDcNdQmTL51ZndqIo8Vo2Wu157iXlnwv5jZrKNEETW0BEvm1iYCGL3NIpG2O3D/iCwkRLN1NBWGpr1EVg2WFcZeXCSh3BcLjDOeehZZHNjs7GHnuZIuR/v4=
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
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     Hannes Reinecke <hare@suse.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: [PATCH 3/5] ata: libata: clarify when ata_eh_request_sense() will be
 called
Thread-Topic: [PATCH 3/5] ata: libata: clarify when ata_eh_request_sense()
 will be called
Thread-Index: AQHY0en6NTfrUlF+Lka6NwKeEQzlVQ==
Date:   Mon, 26 Sep 2022 20:53:06 +0000
Message-ID: <20220926205257.601750-4-Niklas.Cassel@wdc.com>
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
x-ms-office365-filtering-correlation-id: 8d11fe56-0f70-4948-bc2a-08daa0011cff
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hz4GnxsZd0Ke2GfOJ+HpfEoMjZ7GcdNwc5NjkSQq9zJMM3mtpvzKlTOQllRf9n8f/jAnXerMUL52Y/ozZ1wO3Ko+lXnr1Ndi4WOqgjzvoApz8feemdzSGGOKKenfto8SQHpDWU7J3YRjgo7NjyvmFwH2evZ2mZ2IGidT3krv+OzTP63ioIU0CGituSjl4qciksbmeTzeQoWurvMFKhmzp4oic7KuRE9dAIQ3ateTc/PsE6ydB+c+8Iu2Jk5kkOa21309yRZuWYHoc4/7L2+nePJgrbpcknJsbKVE1J6y7yjT9SUGj41nYdp1Ho+NtZnUM4JETuQOz5af/m0OdEpfIFp+GQcNcC6tBPInBusCjj1MOJs9q9l+EH3xRZJJ/+komxru1QEOZLAwZf/tsSWxKLK/cQSXLx0YzLELrp+etSQ5GZa174Wz7QdlhvV2ZNDLznw3YtlM755/FOK5f1fD87kn92D/oXRrLASgKP5ej6tP0DnZtvtikmuKj7tOUIllzb7wyIZurHuY4wpKcMRjQfbkGXTbVkTPZotI6ZJXb1YddP6mes2kO1I2xZEnCkWHKcozqOCAvypiaeQXALnqKly3yMRPx0hOsOIkhg1I4bM+FqkkPB3YkC3cuJZxdRNQVHsufLzoRMQn0ZE3Y6Bcw0luyovnn4ATw3hQ0OrwZi2sHeUdlLglM23dKZ+jjTUpO5OpAoyArCTIXpDx0oceovXGB4r/br/lgGX8mi2dRAtAL1qCnPilMagI858WuvU1QafKB5VvzwBhGDehlfgBGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199015)(26005)(6506007)(5660300002)(8936002)(6862004)(41300700001)(82960400001)(83380400001)(6512007)(122000001)(186003)(2616005)(1076003)(36756003)(38070700005)(2906002)(38100700002)(316002)(6486002)(54906003)(71200400001)(4326008)(8676002)(76116006)(66446008)(66476007)(66556008)(91956017)(64756008)(66946007)(86362001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7q7NOhdkAwaVMOPUBP9g5n1i/uK2tUET8mseFOJeI+MNAM+unrOv1OItqL?=
 =?iso-8859-1?Q?5X01890cJaQTxUtzGHVi0z0V+zmOncc/HUs3to4AH3nfSuQ/wBrWYT2xat?=
 =?iso-8859-1?Q?X2LMJpcYtq2Inrw3L5EIUULu9CJZD63pPGquaTMeVevvTYz20Ep2BWlTDA?=
 =?iso-8859-1?Q?PmudvEPvMubSNWtiHNWzxH1xwaP1Tu2np1Hv7W4fFbv5LMmYHaDO75Nfpu?=
 =?iso-8859-1?Q?VTEnWbiyuNafUPKwrdwEaY89KcDPrH7HYkDWASCFT4AosHec0OKl0/mQNO?=
 =?iso-8859-1?Q?0Hg7vpCbFsHLWiyGyNuHK4Z7qccZeprYKC/wPocERl6OoXAMuT0mznPuxC?=
 =?iso-8859-1?Q?iiVlSx1Bu3grZd2GYeWifnOD/A6k0RplBuHmLtW5IV0yaHKheIYaxNW929?=
 =?iso-8859-1?Q?qGwH09iHwJIsVMwpIQaOsB3bcErFw758Gv9MF63m9Zs0sZETbOIkWf4VG4?=
 =?iso-8859-1?Q?KDV2HKfTmCm7m8kNkkiGK7wrf083xgbS6EBEfhgQLU6UVXH12IZjvH5Dpz?=
 =?iso-8859-1?Q?uNtv6BNJZQcNo19aNZKGvlnIrSrwexqFRpgqwyfaBFoMM6EdTK0Y6SlUgb?=
 =?iso-8859-1?Q?Dg6ygCmpc+fP0qoikhVWY8la39p4BNf2INvlGj/d7Cqymn51kSwrG9JtV2?=
 =?iso-8859-1?Q?0S7sKVn8IKX+kX8tfDJYBERdGGyRDk2x4Rp3HKnGRlK3gb2U78trIl7YDU?=
 =?iso-8859-1?Q?wPO54F4o9H/RkucDHRR1DQv3sLZ7yJpJ65enghEe9q248OfPlkdYrWr1QJ?=
 =?iso-8859-1?Q?3y3c/A8XuPHmDF8OgATuRFFJCUmKjvsBQLYGXkvE5t9ZVMLCu527PLR9C8?=
 =?iso-8859-1?Q?Yl5B7z75C8GVD/NFz+XHNMfQJuCAKYlig4JyBXi7Dwfv9SDOiul6CATqhB?=
 =?iso-8859-1?Q?P5+NysMDxtxy1pruf2KQ0MJO3pRY+zWmcNW3jMAninXxk0Brqkh3Oo8TgL?=
 =?iso-8859-1?Q?eA99hpEemcU9WxEQyBZnWBhZlRhlmSkuMEWSIcet0HDV0iWWCkEw9xFl3g?=
 =?iso-8859-1?Q?6CnesA5GiIx3+b30JRj9U3IuRHcb6C9RFAAl4M3BfuqYb7q8R/+CWqdS9L?=
 =?iso-8859-1?Q?Ts2dMC3dvwyiTDI0ekstVnV7FNn9+C+R20mqdFM/10DdKfoFH64p9UyL/z?=
 =?iso-8859-1?Q?+HqdYvxJgE6J3quhRZ7+zG5vL4Vq5tJKCz+zgEWgP0Y0lGwG1yXKBtABem?=
 =?iso-8859-1?Q?uBY9OlwvLyeHrxE06KVaU7PB2fcucPbdBhLD9UGCXjf3Lu3aDvUsqRDCqb?=
 =?iso-8859-1?Q?/Pxd0K3av5Qjel3pDKEm6hQeSzhAvbSgD9qQe8zEHbWIGdDGS9cGsEb/A4?=
 =?iso-8859-1?Q?PQ2sENmRi2Pg/FnsRl7ELfUxPyiflX1TC8S6uOfx8yruZh1nKG4S2Med09?=
 =?iso-8859-1?Q?ZYEYDPRGCCsfghFbUYq5/srPv+y87vHN1GVd19TEiwOVwtCEY3aP7DoiIx?=
 =?iso-8859-1?Q?OfLTiucR42N7QR520BXh9auLk7DgPJsv5lcJDRovH35rLRAhvffxC/pnkU?=
 =?iso-8859-1?Q?mJwHUlGxzjWVCcNjxtpjGUaOCVh1WIhvdsq+m25abSzt3oZkwFSAxG3P89?=
 =?iso-8859-1?Q?j8AW+Db33s5y+ZVmzq2wyTIS7dDWYyCnXdajef89io1EL1cS1U2Sfbkbz5?=
 =?iso-8859-1?Q?KafcF1k+fChVe6/b1pflRr8ROdR7ay3dD16r325zZB2ZBDi0BvKypukA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d11fe56-0f70-4948-bc2a-08daa0011cff
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 20:53:06.7654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a/Dg1piTjxf3M2TBetYvXj4utfOx3Xc9LWj8pvjKf2MTSOUDMbdOxE+OgGvWMw75lhDe0UFhOxKVUnuA5xgpSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6469
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

ata_eh_request_sense() returns early when flag ATA_QCFLAG_SENSE_VALID is
set. However, since the call to ata_eh_request_sense() is guarded by a
ATA_SENSE bit conditional, the logical conclusion for the reader is that
all checks are performed at the call site.

Highlight the fact that the sense data will not be fetched if flag
ATA_QCFLAG_SENSE_VALID is already set by adding an additional check to
the existing guarding conditional. No functional change.

Additionally, add a comment explaining that ata_eh_analyze_tf() will
only fetch the sense data if:
-It was a non-NCQ command that failed, or
-It was a NCQ command that failed, but the sense data was not included
 in the NCQ command error log (i.e. NCQ autosense is not supported).

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libata-eh.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 89ddc15235b7..c6964fd2bc42 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1578,7 +1578,14 @@ static unsigned int ata_eh_analyze_tf(struct ata_que=
ued_cmd *qc)
=20
 	switch (qc->dev->class) {
 	case ATA_DEV_ZAC:
-		if (stat & ATA_SENSE)
+		/*
+		 * Fetch the sense data explicitly if:
+		 * -It was a non-NCQ command that failed, or
+		 * -It was a NCQ command that failed, but the sense data
+		 *  was not included in the NCQ command error log
+		 *  (i.e. NCQ autosense is not supported by the device).
+		 */
+		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID) && (stat & ATA_SENSE))
 			ata_eh_request_sense(qc);
 		fallthrough;
 	case ATA_DEV_ATA:
--=20
2.37.3
