Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FD9C636D0
	for <linux-ide@archiver.kernel.org>; Mon, 30 Jan 2023 14:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237186AbjA3OLD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 30 Jan 2023 09:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237197AbjA3OLA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jan 2023 09:11:00 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2D43C28F
        for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2023 06:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675087847; x=1706623847;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f4MfPf8VICz0s0U5CWNtX4f/SDo6v58mHsZEozm4Ur8=;
  b=NIYzh/0+CYTED9ZNFqUvalKngscKrNo996uP36pulmH64NbL5k+FW1WB
   Yc9NuDFHWPmUxeP9GrsnnxBHMN0ufcOobTbuIofExh4aoQXfaFo5gkKb8
   3JMyzepPUz7U0/89eWp9LaM/8V2Kf42XNpeTmTqwLsYatXYm60gYFpX45
   T20DI0HI0teDkzBC3uOzxIdC4ygX+4ZhOH538WA6P6vccxxw0HnIUahD5
   0pZutdK2aPyOgi1FG8bdjbvLGSDAu+AMF/9J6XggwxdVAzmqr48fE5jNg
   gIxEtff3r46hA6ErURdN2KMzOGWuYvAp4lzXRHONvaRb6/DjeZPF0qIh1
   A==;
X-IronPort-AV: E=Sophos;i="5.97,258,1669046400"; 
   d="scan'208";a="334048925"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2023 22:10:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHggXa2I29Htt095D9hbceGMKQi7Yd3t6Tfd14GPNlw1/g4f86YLsCL6wNo6zg/DNWjeYTfSx9eBrfgjWMeLYRVVGm5Jp1uyVMILk2YECguheUW+Aq070emWQ/WrMdjlrFMjmstZXJ8Eexgxnj4bxjE9L/tmQMfb92cL4g+cMNgNYly4VPZzOwo/+5alfukyjep9za6mQasF3kpR2QXKYGL7t3tlEJE4RVgt0rlNrUEf7KUC8R+55qzgcPCcPlPIugDttBjaIgOCjqihe9qNLBeQPJr7TOnCXtaAxldDgof4LkkCzbCHvyntU2Dw5gEulb9mjMVLH9Py5jG7OlZPqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/ZRsVqVhYtCLZdXFgHylFuQpEPM80V0SLxMUZn4ZLc=;
 b=K8XTPmXyJUoWdYi1rEXW8FRnyanQrUUOsa5b2UCJlIJ7wM0eb+eKyxW38AdUvIa3fUwW7dthNzOA4HW/+Ll+bXvMewdUmuT9S8xfBhpCSdWl67fSksJFlv/ysXz+TjNMlDVIGQI2BLSUn5qQ0O5FSiRo/60TyxaAiS7ByAUxEOvMt6f7G5/E2fVmO2FmOBIJFBo3iTTuOwQW8DtKPhAs+dh2JaZCGgYI6L7g/ybBVXP/ycs8zXKBbfViTUjQdjehWb4Uw28vALeY1qOxVq790ZU6KHzWHNNdww31QEasK2dMwzeEnAB5Z1nK7owNS1w2zYE0rf8nM7vUSDZlTB3BQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/ZRsVqVhYtCLZdXFgHylFuQpEPM80V0SLxMUZn4ZLc=;
 b=JD2bwQ8Dreh5JtOPD6XJK0Gy0EI+gu5G+F9b0sa7Vmw4BJC9aXjfG0PreyDITOkfcIdpco7EiVJWj0DxWGZib9lxEt09JSAkQhu72Ta3TCSU24CmxZl9reMsAN/2RFXAvBdW8Vk8N5XOLpDGWL3/yvTq7hXle4ruikd6umLFpFk=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BYAPR04MB4262.namprd04.prod.outlook.com (2603:10b6:a02:f3::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.30; Mon, 30 Jan
 2023 14:10:43 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fcf:ae46:b9c4:127a]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fcf:ae46:b9c4:127a%7]) with mapi id 15.20.6043.023; Mon, 30 Jan 2023
 14:10:43 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Marius Dinu <marius@psihoexpert.ro>,
        David Milburn <dmilburn@redhat.com>
Subject: Re: [PATCH v2] ata: libata: Fix sata_down_spd_limit() when no link
 speed is reported
Thread-Topic: [PATCH v2] ata: libata: Fix sata_down_spd_limit() when no link
 speed is reported
Thread-Index: AQHZNLSjxdtYMBO+bkW4tzdclc+edw==
Date:   Mon, 30 Jan 2023 14:10:43 +0000
Message-ID: <Y9fP4oLLvDGGqw7H@x1-carbon>
References: <20230130122427.113156-1-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20230130122427.113156-1-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BYAPR04MB4262:EE_
x-ms-office365-filtering-correlation-id: c5e478ba-32cb-414a-ee57-08db02cbc66d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zWSSrsw+7qmxBc6tgzov/fAB8vlPByF5P8+jZ0kMv4yCSy1/4IZhkk49uqrh9YrD9P4cHgR/MVQ16R6WGo7F2eHIZWWhNGA+5/17Qz0Rc1Gu2YBfisIUaUwFewBU7beMsKWGIpnX0nxjMx8IF8MXFcgfQY3ZcoKxd82NbuooD2b0B9SKuakSKp8rpcBUDd0NstGvZETN93g9xXw8SRCBuMzRMYF+PTIawDc3kP9eQl8QB8sjyzdA1OLkvvnATYk3Wikh74lyaeG6b3LCeEmGfZTpm+9nLCOOY8yR2qU2PGzfnSroWQw/kCTVhajEF+Hrdsgb0Wbx070O9NdLxEf/J+n3n6VsGM2bgwEW5PAjNOtA7vVe822a+H6K3FJ7wIkFJ4q1C8ITqjw/+vs3FdhfTMpEWCy0BTN2vehMB4YIrSMy8bBTvwgqKg+4tDW0HEj3+mVlJr8ABrrumWSz6iT9E5XrEAP6p+kg9bBq1UW4SuURZBzASYUf7L9CozQNiYJqU1jc9PC6W3ZdMwJHlKRgAgu0c2zL7XiOHrBARL2/HYNmj8uop70FydlOC53ElpidminERDmnOAFnRdacjVm07V0I44AqnbV1NWJlqUZawgdI+MV2LCAIG2QfGbJ8iPvnN1yhy3SA1Wp+Y25vfKXkVbu7GVq6zK78TH8nqDR6AKYfT9EzI/ZpRJA54vxZXHMA3ZV/7+s2UtawU8RoChBbMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199018)(33716001)(5660300002)(2906002)(122000001)(38100700002)(71200400001)(6486002)(478600001)(186003)(6512007)(6506007)(9686003)(26005)(82960400001)(38070700005)(86362001)(91956017)(54906003)(83380400001)(316002)(66556008)(64756008)(66476007)(76116006)(8676002)(66946007)(66446008)(4326008)(41300700001)(8936002)(6862004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FhG6iah2AJfo5bYye1q0ezL+PHjpHpq6YEarBKYdC394KPLgCzKtXfr91hWY?=
 =?us-ascii?Q?lhTFzUa4BeDIIW3TUcfuqzkJ5IZknQ6twuGcLvkDqfFP3u8y/KJIDlQhISkm?=
 =?us-ascii?Q?Ct7/vLsLudUO7NGZ+98DIRxqa58M3KV8gIqMTLUCe+Wf9g0iK4BDNGWe8yu4?=
 =?us-ascii?Q?iXBUfEYls6z3AZJbcp/3n99t1ZBhyIu8fkqkSoGFASls6h0wsduEPHAoh1bH?=
 =?us-ascii?Q?ry8CzS1q5wDiMG7aooNuhbwJY/HRaH1K/OfnRU96MI5m2tTntDFepLHfzwG8?=
 =?us-ascii?Q?MgbLquF75ztk4snp0sTGpIS4ODIN0xJWWvav04xR4apiPejbEhOgW3XffvOX?=
 =?us-ascii?Q?PJwh8Oi0oYtcBimb1HA4/JDK0OgJu2rzwkK7sJ9c97nFwi/lq31ilf/qUcN7?=
 =?us-ascii?Q?sH/CRUTXjlLQRGT2ZesLGtcOq92AG5rWCLtrCJoH5A+V1kGTnyi5nBTNeWSd?=
 =?us-ascii?Q?hddCmPUmo8ePzR2p6KU8rk7BgwCfRIn6bdqWsVhX/TomJqHv2iBzZ0pRMnql?=
 =?us-ascii?Q?flzBeSaekF632gtM9VaThrLUe5AZqjy2PTkTIMwOBIZxInByNhArCEvh0rDF?=
 =?us-ascii?Q?zJt+CJxvfuuGQY+bK0M3uvenF2AL4Q+b1/FhorN7rnCAN9TcVvPJ3owVUnsA?=
 =?us-ascii?Q?b/COt8zN7p0C8sxoqwSh75dCGRKbQK+7wfNq6W0O+iNIea3Dwoh9Y8F6qu/9?=
 =?us-ascii?Q?CjR0WQ+TJ4SyvFtMFKIC0Nikvuq0a799sqXW0yF0k0prSHIU5T/TcKe3CULS?=
 =?us-ascii?Q?sXRHk7EfY2YgCkTy7l8+umS7A9BNOEHdcfRh4mRJYfcNQvJpitHVezHD4Hb9?=
 =?us-ascii?Q?4MmlcEr3PGbrNDXSb/mJ9gZC1jzjINXRv4EbHc/EHpHSwp2USM16lASdhjp4?=
 =?us-ascii?Q?Lo3S2boXZkLGY5qRZMwbBRAFdNfQf0fX9Y0lywLVYo1smT6LGjG8bLAKxFkP?=
 =?us-ascii?Q?Fmenp08oU3am0L9XH8mAwHKyWv5nkjcwUM00pgTawzehGC+zvWlS4XRXqw3h?=
 =?us-ascii?Q?5zsxZYosCFJN96ooRG4vZZwfB0M1WJGwOv1VHPR3u9NL7zMU+OmEjCSzDAXD?=
 =?us-ascii?Q?vHGHjj+TfuEvth2+q+hzSmmiLQSN4hHPP1TAFR4aN+pY9L21O9zULxsKMHfj?=
 =?us-ascii?Q?/ni/k6pPwFpuxSEjzhfVsXWHqmc08FaVfxVF9UsiR8o2TYd2Gghk4HDuJE9f?=
 =?us-ascii?Q?MlC4Gf8tGZ7rU4s95mQys72PD5IDECBIJOp9eqCebQbK9E+XrJte+cUYLxKA?=
 =?us-ascii?Q?5RHxXI9khHsTFJ2XDl2sMQi+bTvlS7aSQ0ab1qKOETylt9CseJ8hgt6zgHy+?=
 =?us-ascii?Q?8Xd+zRRqnye5Vytx8UKGpkIY/1EfeqRwsgKHwYmVaE01h5FyeKzBzbaMthpA?=
 =?us-ascii?Q?O8+N8XtWp1mSzkuIbdeA7jP8QuF6kjzX4w/pPQ9iszzi4daWT3oCuuewaqMr?=
 =?us-ascii?Q?SVAWvdEfH2CXxYLK/7YzgRBhYbws2B0i98V0WCGHB18DkN5qBQ7J0I0YTaVK?=
 =?us-ascii?Q?HB4d7aEq6g+AvhpaqAqC/f3xG7plpCXbTJ25Cbb7u45ZM2+87CHdaC3pbPhg?=
 =?us-ascii?Q?8kML8oM7MnzWc6oZd0NfQStPMdDzk/6hNPhjTFSV/nNkM/h5CJVdJanVJhPJ?=
 =?us-ascii?Q?Cg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6BACA0E69D0D794E91D1536C3914AF48@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Z5wmDKoc5p5jcIu17beZ62pZJ9Wt9txnUZ29QIiiVElUmFBb8wTkZCQmfqA7amlUiz6n9Sv/KMYo1pL7Ys2lrr7dsECPe01FkY87AV6N2X1eUxQMzUyTIQi9EU1Cm3NfF73LjIW3sKEYteM/yhitfjPcQeEsWGnKjtm1K0GH1Hgfbd5PnOb+a2m8AFl8Dl+5rqUiuCSrjZMC2cnchMaNyAblJoRuTKFyMQoN10PXJ/T9xdhiMRU3b0+M/sMqyhNAgUESxyIrE+FzJDgfC6H/KOG8gAeSOJEkwEP0c9kauYe4FOCLb7L5yOULjIGqGOMHNo8Q477RInQtcqmSxcohA7XvN9KUq5B1hctI5bK5Om6bw86YDf8GQDCvxfdD8e91RBitAulbno+O9fHOsLuqnIFygT9smqnyLxG0B7dmZgbqO2l+ErSIvY3aBgOnImxmbs7s497U0SBBRQlh/DE4UZl6+c7Zkwz4607lGh2aeILc/37KraV6e205m6NO/b/Oltj8Rti71F4mR2NCkL61aZVda1aP0rd6Oq39+60zL/Ufg5CBk69gqGi+1AzCCBlwkCudb1oJQmfmJANoF/I3WiYI5ICiXCEuOB2PRUh5u1FtZtw28Uj/wtvTnskPQqcDzllrCtQGOtxxzKnaBor5SXUbAEwTBuRBVpVi2k9e1ZdSE6l9Ynlca8PgAiIBES6gsyAHO0wW3KLMM+xKJgne+HwpTx8lofjnQvMqdm/AjTrGWbsYYv1h6ilm21mLCnm82qqpGl/iwfIkxn8XaOLFRIromkuzPbJ4DT0LIPxPce5AKh6ouWTl2HulljwSyDif22wCAoA8v9Nkz7IjI2yYMoLRsF/fFOQj0gtsYPvdQPw=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e478ba-32cb-414a-ee57-08db02cbc66d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 14:10:43.3298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F3bFvsI1KdvRhraaMld4U+HI0v/5gdTECxdZeOh2+dd+9W2CbVhOaaG42NKP/0EcxGuwcn/GB7A5n0elpS0ktQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4262
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Jan 30, 2023 at 09:24:27PM +0900, Damien Le Moal wrote:
> Commit 2dc0b46b5ea3 ("libata: sata_down_spd_limit should return if
> driver has not recorded sstatus speed") changed the behavior of
> sata_down_spd_limit() to return doing nothing if a drive does not report
> a current link speed, to avoid reducing the link speed to the lowest 1.5
> Gbps speed.
>=20
> However, the change assumed that a speed was recorded before probing
> (e.g. before a suspend/resume) and set in link->sata_spd. This causes
> problems with adapters/drives combination failing to establish a link
> speed during probe autonegotiation. One example reported of this problem
> is an mvebu adapter with a 3Gbps port-multiplier box: autonegotiation
> fails, leaving no recorded link speed and no reported current link
> speed. Probe retries also fail as no action is taken by sata_set_spd()
> after each retry.
>=20
> Fix this by returning early in sata_down_spd_limit() only if we do have
> a recorded link speed, that is, if link->sata_spd is not 0. With this
> fix, a failed probe not leading to a recorded link speed is retried at
> the lower 1.5 Gbps speed, with the link speed potentially increased
> later on the second revalidate of the device if the device reports
> that it supports higher link speeds.
>=20
> Reported-by: Marius Dinu <marius@psihoexpert.ro>
> Fixes: 2dc0b46b5ea3 ("libata: sata_down_spd_limit should return if driver=
 has not recorded sstatus speed")
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>=20
> Changes from v1:
>  * Fixed commit message typos
>=20
>  drivers/ata/libata-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 884ae73b11ea..2ea572628b1c 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3109,7 +3109,7 @@ int sata_down_spd_limit(struct ata_link *link, u32 =
spd_limit)
>  	 */
>  	if (spd > 1)
>  		mask &=3D (1 << (spd - 1)) - 1;
> -	else
> +	else if (link->sata_spd)
>  		return -EINVAL;
> =20
>  	/* were we already at the bottom? */
> --=20
> 2.39.1
>=20

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
