Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955FBCD37B0
	for <linux-ide@archiver.kernel.org>; Mon, 18 Sep 2023 20:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjIRUb4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 18 Sep 2023 16:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIRUbz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 18 Sep 2023 16:31:55 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A48B6
        for <linux-ide@vger.kernel.org>; Mon, 18 Sep 2023 13:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695069109; x=1726605109;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V7nzWeKPjCwMBdCsA9GX7JbULop+vLAiUq32uGnMIIQ=;
  b=hXQ4AByH/tWy6X3DVaBEf5D2f2YdweGzOG4FBXLTCKLsgFSDasJDZr+x
   LHuxVZcX39vtwEV4B5j6ZTx8e396F5Jhh7BklO1czM9eM0MV4eI2DlIpP
   7j64ZwbKvEDXw76ZZu+NAAGSB64i9ztpBM+PfXPRlQ6UEGdupN/G6Uck5
   5RbO53ZJgyPZB/24MOohjfMk46ew59nzDSY3/TNkGOF5pH4uGT9YIzfPs
   cmAdZR84Z84u3DD0a81iAYUPQyoeR/V7W+gukHcHs+ccapedM5wegR4BK
   d7KrBIyf7hs5up239o2ayLassR0T05vQAX3Q2Dzk6FdACuZhAYRl20mpm
   A==;
X-CSE-ConnectionGUID: JP5zTHxoR8uUOqIIrjhskA==
X-CSE-MsgGUID: irlmwfccRRyWTlbwlScHFw==
X-IronPort-AV: E=Sophos;i="6.02,157,1688400000"; 
   d="scan'208";a="242470167"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 19 Sep 2023 04:31:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RL+n3CgOKgwotUUc4wwW+0WGssZoQCnGseaGMAzP38l9mCCReWqPI4iFbWOEhOqNTYjzQQpRfRhrl4mF31eHBDPW5/QUPy/paVFiD69n/wyzCjWeF8Hc+inahb58wjxFAQBYWda9vfQsEBnJBw5lMeGMsDaksWD28k1qObIX7dm28Gyed/eXCuDMYr9bZE15pOU5ciSC07bdrDvkaNXAtx2ii4PPHSTMiDDg1Ziuh/1rpaE4wTqPAbqR+TR3kUXHbypuwsLINrHFcn7Z4YICZYYWbNgNRqgpwm3LJJdVriwbQUnXYGrX0jE1PqK+fnUpe9NfdcuMX5alCgA8kwq9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLR9y9jp/dwHsmyEBbEnZoG0OnMt2Re+sOfsLT/YYkA=;
 b=iVFtRtte59gexHmW6UlA2OjLh/MRlEO3tgo9DBlC6IqZQDQ0lE2vLYfB0Zn6+rEtBK1hw8oLBt4lAeLEXZY6LcOME/R0PDcB+CQlZCw7QFq9mBdF4z1/2nXTrnMzs/aO2/CrYE5XOsbmUUwIRUEBI9BuBDVLHXEg3XJGt4+mVHeFafx/mz3EV9Q6Kqgk00bDEsFwWyfspIs8kv3NFdcIvpgbtYoIk2pzkmw7k9bkPpyJsbuStqqTocdHQBubqFssvNjh6mgsgWjpo9BJon5mM73aVFMfQJwaRWjS4IiTi0ZCkK3sfqbCjOLRblr7qXQGdV6rAxB65oACuj5NzKXFUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLR9y9jp/dwHsmyEBbEnZoG0OnMt2Re+sOfsLT/YYkA=;
 b=gPBeBmdUzFH3bWEdTJNzZtFWRbLMlnVO9nnfYuNIIPnGRDOkYyKi1svYDenEx/UWQgqdshzTwl4N5jOTUeG0RKIjt1GzVWq1+oH1kZ4quSQQyE9rIRfWekwqQnEl89nh8HrIHYj5kH2VOZwsMW3e+0kfqe7fHsCMFkvj/MqGKUU=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DM8PR04MB8168.namprd04.prod.outlook.com (2603:10b6:8::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.16; Mon, 18 Sep 2023 20:31:47 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::59a:f2ee:fcb1:4eca]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::59a:f2ee:fcb1:4eca%4]) with mapi id 15.20.6813.014; Mon, 18 Sep 2023
 20:31:46 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Niklas Cassel <nks@flawful.org>
CC:     Damien Le Moal <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH] ata: libata-scsi: ignore reserved bits for REPORT
 SUPPORTED OPERATION CODES
Thread-Topic: [PATCH] ata: libata-scsi: ignore reserved bits for REPORT
 SUPPORTED OPERATION CODES
Thread-Index: AQHZ6m5Qr9FDMZm9Ik+5/lwM2JYqy7AhCWuA
Date:   Mon, 18 Sep 2023 20:31:46 +0000
Message-ID: <ZQizsVzXYZWx9z1a@x1-carbon>
References: <20230918202450.19635-1-nks@flawful.org>
In-Reply-To: <20230918202450.19635-1-nks@flawful.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DM8PR04MB8168:EE_
x-ms-office365-filtering-correlation-id: ed463ba1-14d2-4654-427d-08dbb8864792
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zt3IuCF/KN4pScJaidc2khNR7LRImi/aPjRLGD+rRHb0YKuQWoHSU4WePi1qvsojMHJxzB6f/UhB+CdpN5l1aXxDtu2aJb/mxrsQ/k5KmDBx+lqXOp3dy62hlI8lVom2NBFr6nTajN4JzVF4W6gUOf5b65R9nzb/CEIS87PcRCJ3g6zHk8wNsgkpjKL5zRz8yJRihQjOJUarL1NY1ZSuCq+TflgqKTp/pBoWU8Ko1o7CeyzG6RvkBoTjAvOWlf97FZ7agxVu3WMYDLRqVIrRvy9n3ESrNBxrEofaQ1hslKu1KTAd/zaOkMRGWeVa+JOEtu6x1U4DxYBAFjes39RfvfPPd5+c7GLwQyDh1PjDuJv7mPu6DeZsoGpHPYGxkBtsDyZQXsLtT/WaPh3pVi0m4hI0glg9k0tSwiBZSAyYKPUJVwIue3GVjs3EpYxFbED5lp2JI6CTv2EHhX4NE2EdWRAD9blGmfwURpU3Ljgxy5TfpmuGKq9glOx+Prx0zzt2WjqDwOYYjK5Zbn9EOp5yhx7BHqEyEX4qH/P8rzNhElYGmMpj9VE0qrZrxToOIVuEgSc/BdZZJTuzL61yJ4RXez3Urd7Eaw/couWnyg5MII9a1EU++Td2W4/gHosCu/o/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199024)(1800799009)(186009)(478600001)(41300700001)(83380400001)(91956017)(5660300002)(71200400001)(2906002)(66446008)(66556008)(54906003)(64756008)(66476007)(76116006)(316002)(66946007)(6916009)(8676002)(8936002)(4326008)(6486002)(6506007)(9686003)(6512007)(26005)(33716001)(38070700005)(122000001)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kiLJWw/uetoVQi/e8JkcU/59D+9MuAyCFBYM9CCtqtXImfdjrZAcwRckj3rX?=
 =?us-ascii?Q?+Y8loizXPduQ68iauiFIfyN5mSLlBekzBy3UrduviUqXBXLnpatzDbagb0nK?=
 =?us-ascii?Q?A7DpgatkhIaedv6yFa/SYGYibToyK410OcFWAksEy/OHCJ3PUIMeNdEXt8Mx?=
 =?us-ascii?Q?qpsPGvwlVnhZm27kylnYYiyfsxqnYKWdG13trLoU5JJCaEQ3Vfdeldaf1gNA?=
 =?us-ascii?Q?KIJ5Onn3vLcqNrU1t5PyrQOJE8KuGjGzebL3ORKSZ6FAGjVxETw0EZe5c8Cu?=
 =?us-ascii?Q?VlvU4zskYOVpwn6vr90IbnK4bJxKY55O7Y+iIhhe+sO+uhYXzNmKtaHjZ4rg?=
 =?us-ascii?Q?/05i+MWXWLrhCrXtBU4/Uyx35AwNjRXHt1Rccke3Iad0b4+FHdjZU14Wj5Ns?=
 =?us-ascii?Q?RZbxl7q0yuRmC0G7gUvFLzCvhZzF0F48QrPAJex9xH4marslSVeLDUXTN6S0?=
 =?us-ascii?Q?qc4gcYkXhrdMEKpKTN3tT550RID9xIrOWmxhseplOMYCJKIcVpSaZ13eB9XO?=
 =?us-ascii?Q?SQxxzCeP0Fi9pJ+dYsGfLOWRmJUcbFXjZJUGFMk65CzD0R3yTcv8CLG5+yf3?=
 =?us-ascii?Q?dcJV5ciLEPM2urqv9jnt4utQXiuN2h2bqIFzoHRJh6ULNUxYVJ6Dlv39CgeP?=
 =?us-ascii?Q?/PUAqcgXApjfkwSdABgEOcMkKKNsii1iONiq7+OZSfaso/lKhiXRvA4iaMr9?=
 =?us-ascii?Q?LSKVas6BFA7qjRU5QjAwSfez6L8J5v27DtNXc+YBeAPFI4mFWVTlLudYtnfG?=
 =?us-ascii?Q?FkBqS+0vHFts4bUTtbLfeFTVY5cBeK2J1gzR0M6aQ9vutxZ9LaroBu/x6XU3?=
 =?us-ascii?Q?MLNMJuEAMEGuQRQPzKLQkVNuEnAWqPErSm7+08dCBn3bP13DyF3QJOxMeqYi?=
 =?us-ascii?Q?cu66qaCCtcoX+hD8mRAsDlTxaPDOIzd8VL2KmadDoBW6yLGY2yH76gHenGwW?=
 =?us-ascii?Q?BrFOGRdONqefFHkTsofkz/z+oKj4t67LyY/AP83IXIfjFP0p4q1FSVnvsetL?=
 =?us-ascii?Q?+nsDnX+Q3cO3hwztL7RnJW/dQsSTPE65hnkJbcX2iiKCSXCYePNAUzk9v9eC?=
 =?us-ascii?Q?dVIaim+E6zM7/GjQhHRKSy9Y0SiX473citLV7pkWhjUUqCi7hs3UnKoku9oa?=
 =?us-ascii?Q?mj/gDm+G3dhSlt/70yoVIDzPkh9Ynt2U8aMbJBqhNTs/nTBNi64C8IWlmuwj?=
 =?us-ascii?Q?K6jlJe9Rme/9v7sgzrBQ4GHGecbjtgVMT+EQtPBn1Fl0MdBqhg0Zw6z+8qe1?=
 =?us-ascii?Q?lJ+VgDaCHXdsdEwp8Dl7YI1hXos570ee6tBaAJJBLbZn6MQj4k2WDinTcFPD?=
 =?us-ascii?Q?oaw7HHQs6woI3aZAlUES7GRuRhnkHEZWO12Q3qlJfe6R0/tqPZO+oup7PD1h?=
 =?us-ascii?Q?g3Bvl7R9Yy26qmoGIJFv5THwdBo6i6RNCHvtNQVjADVijWAq+XNQR6XoG91Y?=
 =?us-ascii?Q?UqeHMVU2LKYVRJJT3aAafzgKP4fWz16EWVzU6WvhODksWj50mG3V5s2OIxd4?=
 =?us-ascii?Q?IXRRPlhNNMsARpwer1eL4WaVbPg42Am6keLVXe+rXyyO8ZyF7dZVtOJ06q43?=
 =?us-ascii?Q?BOr5MrDDW4n73MKb8LXJ8aKA6/qf8/DOTGZBO1WyN1SbtmkZ2hrYc01b/Vip?=
 =?us-ascii?Q?5w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <739D29073DD38D4B89BE4A061FF1D64A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TsFuAbHaEyTRXdmZOrJpOSX7AowhIK9DRJ0ImIfAXN5bzWPuUol+/bNSLQMSHrB0UhhP3Y0DsfPrjoPKwea66pLuw+6x6ukX9FbMIT+wwyDIzqU1oMe9turX9Ec9PAhOE5D92ukkeQQ20qBJCvVjKTxZiHk2jqfAxT2xStjB0+1LTSdX6JUYI+xy1d2l3UD5txMg3B/g84WPS7SaqbxXtZUISBLPbyy49aSDPSDqhXek3FcAuDhUqJF8ehgeqz1ej1018xrLIXOH7wYALSZGeqYu/Jywc+un+Knus5q6XaKGefOo3eQaIwheInlM2cuA31VKFquAG/+vGy91TJATECTcq5J8iqzYf5S8I6fZZYWFHyyLPO5OEuDdNoizTTeco7MGMc4yhIxz+cit7CWnFqdqzey6NpqtkW3XTIUDj1IA0aYVxM2nugZHMZDQnFAE9ZOvRXFIixP0FHETG9IMKYJIxmLUgpmd/1hDqR0vgUfRAsuyzui5Y/fvc/iiRt//JsQJF50nuJphYlMkJ5OBLyhibYvxkQG3dpxe1m2UBsvD5VrJpsEMBt4UEiT2EaCm2qbRzQ1SOcqgTFr7KtGzqYLMYH7IJLM/lZIr71OfHxY0P2J6KLLUh2wQLGC0TDQti0O4KSmjdQEB3veza3hz9xjVjtXmiYJmsHFWvDb2nAxKz2uFFf8VriLYdBBK/1tblBzVKKVWiQ6o7sxJag/bcCz3nmmkTK7UJwQQgICIQXXq3OXfjMBErsk+tDHc265bf4r0PodAMVCTXxV+qovY21BnLStJe1OnJWfSwmw0ktP6pW/4Qq20MiCfQwHufZiWjLb6E12mYolI5FSM4WS6vw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed463ba1-14d2-4654-427d-08dbb8864792
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 20:31:46.8465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NIl4dS5yB71+UeUE+s5W4zztGrJz+13gnGYAWcb0R0/5/dn5f3e04JdZ5vUMOz47+GFjEHwJspjVVnELi8ygfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8168
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Sep 18, 2023 at 10:24:50PM +0200, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> For REPORT SUPPORTED OPERATION CODES command, the service action field is
> defined as bits 0-4 in the second byte in the CDB. Bits 5-7 in the second
> byte are reserved.
>=20
> Only look at the service action field in the second byte when determining
> if the MAINTENANCE IN opcode is a REPORT SUPPORTED OPERATION CODES comman=
d.
>=20
> This matches how we only look at the service action field in the second
> byte when determining if the SERVICE ACTION IN(16) opcode is a READ
> CAPACITY(16) command (reserved bits 5-7 in the second byte are ignored).
>=20
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>  drivers/ata/libata-scsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index d3f28b82c97b..fb73c145b49a 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -4312,7 +4312,7 @@ void ata_scsi_simulate(struct ata_device *dev, stru=
ct scsi_cmnd *cmd)
>  		break;
> =20
>  	case MAINTENANCE_IN:
> -		if (scsicmd[1] =3D=3D MI_REPORT_SUPPORTED_OPERATION_CODES)
> +		if ((scsicmd[1] & 0x1f) =3D=3D MI_REPORT_SUPPORTED_OPERATION_CODES)
>  			ata_scsi_rbuf_fill(&args, ata_scsiop_maint_in);
>  		else
>  			ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
> --=20
> 2.41.0
>=20

Fixes: 7b2030942859 ("libata: Add support for SCT Write Same")=
