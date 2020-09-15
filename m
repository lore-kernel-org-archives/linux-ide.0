Return-Path: <SRS0=lv1h=CY=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DD1C43461
	for <linux-ide@archiver.kernel.org>; Tue, 15 Sep 2020 06:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F19D2068D
	for <linux-ide@archiver.kernel.org>; Tue, 15 Sep 2020 06:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="l/gUgp8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgIOGkm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 15 Sep 2020 02:40:42 -0400
Received: from mail-dm6nam11on2060.outbound.protection.outlook.com ([40.107.223.60]:43969
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726056AbgIOGkk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 15 Sep 2020 02:40:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHNa/s1oufZAzrhgESBnqW3eAFrQdEc8OC2LcJFp+Te6ROlE2050oJd7EHBMnOoJFSFiodBpEO4zhF7JUstkQnkZ3Uquo7IPnMaNo2LaAkZB3e5mxoGpvgDemkTtTRsAJEHTXvnTpshcF1HuAaEJ4m1wZKpu7ni/3id1APo6OlNt0Uero+6N8H5kJL5o7SP0oj9qr/ctK7I9I625yxeIwolUeWL3tpRTfRuxocv3uszIS5iiTL+3TF4fdrf1nuSvMEF0dRj5BPc52F++algQZvBRjoReJTK3orBdlT+pzy4wmaYNR4FM+Cyi23FPHchlnUpE9VVS4qfOzmTsxOVrKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPdaBrT0Qd/jn2EcR4KMMWUkTlxYMa4huYchNBh624o=;
 b=fV0Z+nCD2PReRPHs7+0C2RdeH6D0w4vYokuaRyFT5otCMzwHcLQeHGFT8nqRNrAfWNElVxrc9ccD24Z58/GcEatZzh6gCIgHQRM96lm6uIHy46s8i3+ACuQQc4yWa9T+YThT9jR5KgE+VWiyXseFXBvCteMFuXMJSX5+jGyzxlCpbja8zslvNnblKfns5JSF6VGziR171wSvVxOKqme2mqesYo1o0lbA5ZVNcIoZJq/xJ/gg09MknAW5BO/asvU6yPECP+9RuaQbe82O5gJN1FD6UaXzc98EReW2wj1sO89kqbeEEGN+KIO+ZrfeHzG02fbCwpHHffyP49eioEIYsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPdaBrT0Qd/jn2EcR4KMMWUkTlxYMa4huYchNBh624o=;
 b=l/gUgp8OIY3xNT9/3cc810ZP+MAczZiyiZNZeGtAZM2MbJDdOm2FDWs9xe5hZ7IgQBN+Lt0Y1YFNl2QQpowU1Ic2w/bDCjkqiLz9h+wI8WOic3Qp1ktzTf+o7G+TbLymqt+LQ4Tg/eMU0mmtZdaPpLmEdA/3DF/LDdd7ndQoBY4=
Received: from BYAPR02MB3975.namprd02.prod.outlook.com (2603:10b6:a02:f8::31)
 by BYAPR02MB3976.namprd02.prod.outlook.com (2603:10b6:a02:ff::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Tue, 15 Sep
 2020 06:40:34 +0000
Received: from BYAPR02MB3975.namprd02.prod.outlook.com
 ([fe80::2914:b96f:17e3:111a]) by BYAPR02MB3975.namprd02.prod.outlook.com
 ([fe80::2914:b96f:17e3:111a%7]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 06:40:34 +0000
From:   Piyush Mehta <piyushm@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>, Srinivas Goud <sgoud@xilinx.com>,
        Michal Simek <michals@xilinx.com>
Subject: RE: [PATCH 2/2] dt-bindings: ata: achi: ceva: Update documentation
 for CEVA Controller
Thread-Topic: [PATCH 2/2] dt-bindings: ata: achi: ceva: Update documentation
 for CEVA Controller
Thread-Index: AQHWgPeT5Y9ogZmFGU6Ub+uc8cm3nKloo70AgACmkxA=
Date:   Tue, 15 Sep 2020 06:40:33 +0000
Message-ID: <BYAPR02MB397553291F489C01FC8C3A88D4200@BYAPR02MB3975.namprd02.prod.outlook.com>
References: <1599030348-3334-1-git-send-email-piyush.mehta@xilinx.com>
 <1599030348-3334-3-git-send-email-piyush.mehta@xilinx.com>
 <20200914200840.GA152914@bogus>
In-Reply-To: <20200914200840.GA152914@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [115.97.165.95]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 85cb2ca6-2ae4-4be8-fe55-08d859423f7f
x-ms-traffictypediagnostic: BYAPR02MB3976:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB3976A6A697AE97C222E6CF6ED4200@BYAPR02MB3976.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W+DVBZeeH2RXjx5oK+xylsyQ0myv57C95i1At32mwt44DkBnk6iwoocnSC9YbQ69g7xxqJPMelin5P2b6kR094HhiGn6YLJDlndmc4uavYxEAjcOw23Nx+NMlR+g732hUA/jI8VDVhi8Q+FNQfKPt+XzhlH9LyhIT1qtq3KAmywT+hzXO4SKaftHoZyL5IkfZbzpQtKvtSnXFt8TvOFLuHJ19CvlzQbz8ClHvKiRsPXrBbXIvXEDnrSb5ZPR3ZTljh3eRwkwXzi5NXKkM1LQ6BbazBFIaT8/Iv8Ntg64QGnIx3BuSdL+s1SZE8J5VkGLgqt8v9HLvP2oHZvhy2aIBvlB+TcFD+5ySfICA1xuXEn9WZF4GdzfoqKeB4ZkDHuQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB3975.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(376002)(39860400002)(346002)(8676002)(33656002)(7696005)(478600001)(316002)(86362001)(66476007)(15650500001)(9686003)(53546011)(107886003)(76116006)(55016002)(64756008)(66556008)(4326008)(66446008)(6506007)(66946007)(26005)(186003)(2906002)(83380400001)(8936002)(6916009)(52536014)(54906003)(71200400001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 6LOHRrNz+aSgzF/v+id79QTD3KIN3LghobyrJUS0WyhtHrHGLsZtVzJ3kbMXxzs7hfgBIEVgxzfTDtol887WCJ1TfAwpk9y+j3YITg5a3jYyhWcRp4MwT2utzZ6qS3qGe1sGTNw+0EospqLDuzWeJ0oGw8SuIvuqrERecf8cePxG/yee55sn42EruQmv5wFTa5tBZdejfE5B6wWxGnOVwU0mU5uiGwtp73Ebuje5N10mY4BHSMZBAP3wUYgem0IlzHRt4/XP4l9ghmyxL3yokmuPeRV60Ch4O6TtXNdK/G6i0LNCF67gggtwl9a7MyKsdyQ3FBaLQGg3za/slfxleiHDkBqzgn0ci4gw/yhVkB/0Cg2zmHq3KFb6lzNWCf3LUhkxxKoWRcP3l22ESIdIUyvG94B8MlS4HaA3f8OK3jPEhDR4jlUrKUPSwWP3XjL8XqLUuim8BuzXeu22Wmc2E4LeLz9bSgcn1gXFy3JNsrteA5qQdC+HQvpySkvJwJaRdecD6+w0iRcmjD8ZAFEDl2BOYq99A91GNHWpvwBUAt8Pfd/u1kLGLKoTcNlu9mLfjK9aW0QHhJPZWdmojf2xcOtXvMy4ZobUjw5mt3cDxzwUlpJ4OmX5jGVIUCytG0NhD0Q1Rm1HS4xunnELA9Pkww==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB3975.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85cb2ca6-2ae4-4be8-fe55-08d859423f7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 06:40:33.9292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V+kZAq400TIwDTwcrhNMsIyc9coRrvWgA2pRKFK+oE5MlXPcHsEPl4NqFBhDu4bfHXv+tS2Tt8kw+cgzHg6IiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB3976
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello Rob Herring,

Thanks for review.=20

Regards,
Piyush Mehta

-----Original Message-----
From: Rob Herring <robh@kernel.org>=20
Sent: Tuesday, September 15, 2020 1:39 AM
To: Piyush Mehta <piyushm@xilinx.com>
Cc: axboe@kernel.dk; p.zabel@pengutronix.de; linux-ide@vger.kernel.org; dev=
icetree@vger.kernel.org; linux-kernel@vger.kernel.org; git <git@xilinx.com>=
; Srinivas Goud <sgoud@xilinx.com>; Michal Simek <michals@xilinx.com>
Subject: Re: [PATCH 2/2] dt-bindings: ata: achi: ceva: Update documentation=
 for CEVA Controller

On Wed, Sep 02, 2020 at 12:35:48PM +0530, Piyush Mehta wrote:
> This patch updates the documentation for the CEVA controller for=20
> adding the required properties for 'phys' and 'resets'.
>=20
> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-ceva.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/ata/ahci-ceva.txt=20
> b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
> index 7561cc4..f01d317 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-ceva.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
> @@ -35,6 +35,10 @@ Required properties:
>  			ceva,pN-retry-params =3D /bits/ 16 <RIT RCT>;
>  			RIT:  Retry Interval Timer.
>  			RCT:  Rate Change Timer.
> +  - phys: phandle for the PHY device
> +  - phy-names: Should be "sata-phy"
> +  - resets: phandle to the reset controller for the SATA IP
> +  - reset-names: Should be "sata_rst".

The names here are rather pointless. You don't really need them if only
1 entry.

> =20
>  Optional properties:
>    - ceva,broken-gen2: limit to gen1 speed instead of gen2.
> @@ -56,4 +60,8 @@ Examples:
>  		ceva,p1-burst-params =3D /bits/ 8 <0x0A 0x08 0x4A 0x06>;
>  		ceva,p1-retry-params =3D /bits/ 16 <0x0216 0x7F06>;
>  		ceva,broken-gen2;
> +		phy-names =3D "sata-phy";
> +		phys =3D <&psgtr 1 PHY_TYPE_SATA 1 1>;
> +		reset-names =3D "sata_rst";
> +		resets =3D <&zynqmp_reset ZYNQMP_RESET_SATA>;
>  	};
> --
> 2.7.4
>=20
