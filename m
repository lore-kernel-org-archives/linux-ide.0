Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCE3EDE99F
	for <linux-ide@archiver.kernel.org>; Thu, 14 Sep 2023 10:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237957AbjINKLz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 14 Sep 2023 06:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238085AbjINKLx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 14 Sep 2023 06:11:53 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D861BE8
        for <linux-ide@vger.kernel.org>; Thu, 14 Sep 2023 03:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694686309; x=1726222309;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eN4AGn3kXpWogBnEczWZgHryl6N76dBS9xtVXp03cnA=;
  b=Fmfsd0ioX5+dT2SmeUsHt9hxLC8zOofAtaXrsALh04zBEQrs5r5eV5Ou
   KwfS3h+3qxIUPjClxITjZv+nwT6PpklUp1hwRsbAw50fHn8Nzjz71uCOs
   4mnBzZpBRRwabaxZRiOeVKWhqgtzl/pXplK55PwcESpBmzSmHBXHdK1q+
   GgbeefALAxozAf7w3XT90KnXed0sjZnoNBKHNMg6l3+lgbpO8TJMZmZJ+
   PmytzZb1XgqGPdVk+tijLgCAzy1towMEr/rsrIY7tUsjdz3kyCEaXdJpV
   CaQOQu5Nci7Jc43zY+uI/7+tXaf7Ww3ZvNykQVULas8S/Dc8wTkRXSwMS
   w==;
X-CSE-ConnectionGUID: Or+SBI4eQ7+7E5TYlz+vTw==
X-CSE-MsgGUID: QCYInSDGT2mQfHTK5Q5caw==
X-IronPort-AV: E=Sophos;i="6.02,145,1688400000"; 
   d="scan'208";a="349250980"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2023 18:11:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ss4d2rIaRyNAgn1/AzdoQlkZLkI94XsAya7S/ox/O7KJQGLk0EgGvXWb0j0eoo9vEVQOBmTJiuR5PkOx8MSzDJIgpPNQMxpS0iwvTZX+KUdX/ioi1loY7DMbg6mT/Y9+4c6cgNB1rMyCb67sLR4PbWCV/xW/mk+0ogiRfohoQXeiB8VxW8aQqcnZ409Eyu0w62+Oh7ap365PbOyK4ZyWu7DNxbdEzi6FiPQ6NICT/OiSNz9MxbABTu8ZYEJgx1Ak7sRBApFY03WRX6oD7F8QEWCBo3s+PcdyQfP9I0j0E3Cz4NsFTudYelyoCDZ+x5icgbje9QefcaBA1xxepvbefA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eN4AGn3kXpWogBnEczWZgHryl6N76dBS9xtVXp03cnA=;
 b=XKkatNKi3sVV4/GMyRFEr2VXqSpPXvJZWiJ1cnhdWSqS+TWKEDYXLCJDIgtdpclq0/qglB3dUpWBIN+8wUMhbuyYE9hMznuq8XU686ZlKo9gn0PubdY1FBYj6GHEr6gd/KkVcW/IOVCgjpe86/uW6fWcOilsk8fiux7cCfXDu8Jo9uW4jzOvt/SPF63qRgGgD9XiTFlFEpM5BBY50saB/Yc7NvuCLxi/t3Bu6B9H9hqnw2TB7i6mp4mYdImKblzO9hPx9S5s9ejj8IKfaEySTWKRl1lot5JT6Sj6zd3Zz1acCGz7Hb6BY8PQ7ulf6R+ZD7e8vXw7Ih7F9MbyX7xzPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eN4AGn3kXpWogBnEczWZgHryl6N76dBS9xtVXp03cnA=;
 b=KxRhO5IJAJtTFXlVtt1HpVp8Wsu+5BPBnFuvSNc54Slh7zSRQXe0DxQoCf4YmaxpcZQ4qiIGV3U0Ylffe1Y6p6P6DYzbHAcmZtZHDeJ+7Sqko1qFjMmYLosK41XfvL4mwerhfYNz/ep1/GKNDj5XkpFHCSYr65aC0JV84dnfR4E=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by CYYPR04MB8906.namprd04.prod.outlook.com (2603:10b6:930:c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 10:11:46 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5%2]) with mapi id 15.20.6813.007; Thu, 14 Sep 2023
 10:11:45 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <dlemoal@kernel.org>
CC:     Niklas Cassel <nks@flawful.org>, Li Nan <linan122@huawei.com>,
        Li Nan <linan666@huaweicloud.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH 2/2] ata: libata-eh: do not thaw the port twice in
 ata_eh_reset()
Thread-Topic: [PATCH 2/2] ata: libata-eh: do not thaw the port twice in
 ata_eh_reset()
Thread-Index: AQHZ5pCNEcjhzZrKnU+Mimna/ikZI7AZbTEAgACbP4CAAA+dAIAAAosA
Date:   Thu, 14 Sep 2023 10:11:45 +0000
Message-ID: <ZQLcYP2a/og3mCN4@x1-carbon>
References: <20230913221917.1217856-1-nks@flawful.org>
 <20230913221917.1217856-2-nks@flawful.org>
 <1da815e4-1335-83dd-f625-7fdcbec348eb@kernel.org>
 <ZQLNJf9qr5FjpgM2@x1-carbon>
 <2bc9d113-1119-12c3-f459-4dab8d8f6aa6@kernel.org>
In-Reply-To: <2bc9d113-1119-12c3-f459-4dab8d8f6aa6@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|CYYPR04MB8906:EE_
x-ms-office365-filtering-correlation-id: ce9ffc87-06fb-4f2e-1a76-08dbb50b0007
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vcz7UXSOPzNnGa/NvO1oELXpjLaJjsOUt+lJRJouzuFlUV0/x/DOUiNAg8UKUJ2P2cRmXKtfM2ZTBD+yrXF7Cxo7ujNILwKhnWHlozLI8CGvCNU6wxY7m/4jt0KB5dtra2soOMUv03S1mNX8/oJ2G2+XELCMbcG3cGjzavLNQ8oa617eSJ7LFnLVo5iYg4clg/Zy+Qi/8h+dmDHQqDLauA+VcF0rpEfHZ4koZ7Ead1ZK93UnmuFb8JZum3b3Mw9WjOaaf/mxXx/dCYkBQt4DoK/FsS0WjHToLUzTfLzP+Z6SUei0CEUW4LhPFaeDPz5w/R3jWDxE/vBHCmN85Ts5w9bill3TNFPBNgdmkGyFHfvBD6js+w5+K9p2Cl1eKU6EC7Cxb90sBQZ1bjl781RVi2HJU8z7wARUs4M4jpepK6NdPmi8ZphJcBLA7/9Z/4zQAc0efdM+Oej09LU2TH3UF1Jhbj3NDUIfOjDUxV+9Cj+yXct7U1r64KNbsyjPy3tUci/jWJv+aBg3rxI07Eh/hCohHugsIaX8ZDa0klrHd6jIgN4CU0h5od0sZyzNnriShZAyoG5yGaFMNE8+JqQZnQdhziRw4EJLLgvrPYjK3zDabW6Ym+ayMMcVzApnPBILyHjPctrrEaYXhwVgC65hWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199024)(1800799009)(186009)(9686003)(6506007)(71200400001)(53546011)(122000001)(6486002)(478600001)(966005)(6512007)(91956017)(41300700001)(2906002)(76116006)(33716001)(26005)(66556008)(66476007)(54906003)(64756008)(316002)(66946007)(8676002)(6916009)(66446008)(4326008)(8936002)(5660300002)(86362001)(38100700002)(38070700005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FrJcEkF5tXvLePJjczPT0+iChyvAB+q9KqC8VHid3uQFdUT0UZrXUCIoSE78?=
 =?us-ascii?Q?68RUh+l9Mfdtcw66YMkYe0iC8TP/dqWPUPdW6KjZjTYeyqqVQDloXGy1c9Yx?=
 =?us-ascii?Q?Oc4yVafHgU/deUo5ulkE/tXV6Uee8StY+vjCvUcBizbtrvQiBPDb54K6JYT0?=
 =?us-ascii?Q?cQPud7hMntfkRtScMgffZoTv2dJaJBI1zAseqG95j23z+eUEgQLaSSa+66LP?=
 =?us-ascii?Q?thCyxxTNUeWPmBH8CZqh1DW+M6J9iZyM9vQr72UXhxmW3iYlOXXcKLqtiFkE?=
 =?us-ascii?Q?VpwhOdhqxSINu4z/uYdy9rCURPlTPP6KTqbiT3NIChTGD9YVz+Z+HSi+U6AY?=
 =?us-ascii?Q?4P2+jMeoTYPvccqyxMyE0F7GvmaoUFn6AiNKxSBS/TSuboOdYKv3/XfGDrjx?=
 =?us-ascii?Q?E548T81v2wLnctBwaYmHtkq90u6yinCIejq2rR29G1rHtJUKta684kKlk44l?=
 =?us-ascii?Q?vdO48BbiASEANNyo4wR2tLrtP0tIBgJC8WKYgzAm/1HdfHw2PBA6UOzCCuIQ?=
 =?us-ascii?Q?BIi0YQRTe5XTG9kZHmA2uFV90/4cEXoXwVnjqOJnO6v6LGQ1qlBZCOc5Tp7C?=
 =?us-ascii?Q?9t3kt8Eh+yA8/JfPCpHdqBH34xwxHdZ699H9ugXbqZLnT//3ipuiVvDvU34z?=
 =?us-ascii?Q?vPyW961I1tBq2N8Ndgm5Ys64TfrqV8BMhAIhU+UsQUrikCgHmQ44ajDq/5fS?=
 =?us-ascii?Q?1mfWzhWJt9NXkjTu5l3wWUKdYHWlGSvzLOfEpRaSCw2BBaccVIZ7iGc2FJQ7?=
 =?us-ascii?Q?F48PxnuLiU6WKRTfwfidOpGsWeigR+3CMDt3rSdeKa3TVCSs9fLcsDfq2WnQ?=
 =?us-ascii?Q?ScUk921fZErW3qHfRtwO0jPM9ViPKVTgu+lAorqpf5DGTZfm29wQV++DgzGL?=
 =?us-ascii?Q?VOjU8aVcHNmTvQjMWRm9x5iPINd8WrUp3UVYdcMXSyH9bWe2i1ODpyn/ab1H?=
 =?us-ascii?Q?W6uA5/q+Mqy87gQUK4O9jPw4dqklCDz9c4wjMnwGH+peF1Myhp6Fech0n9cD?=
 =?us-ascii?Q?PA7+WK+b9Fy0k5TrFsRbTMp8Iox8R3/WuF+blVilfW10oHCTyE85q1TmI/Xc?=
 =?us-ascii?Q?UTMs+qe9X9gpExYQEGX+5H9QjpFQ68qohGBnPZ3nBvqn0J1sYw7g4fQjp6Ra?=
 =?us-ascii?Q?NE8iQXjMTGOx+t4Y6O2v0H94btjrv5y0VcQKBUluV6j3ETdXEjbJ6QVgz2h1?=
 =?us-ascii?Q?Ak7AAJAdwu+vhTEGwUYMwWkPcbGqJa7aVqnaBoO0X30qvS/OFRX+QDkVJsON?=
 =?us-ascii?Q?hFGng1AZi4QdZQTq45fRFhWN9AyWB3Uz6ndFHEB1DXcXF7pMyqtbIzihJq7x?=
 =?us-ascii?Q?YjSCgrPXduhTYruj1LqdPYYBLWycU0/57tlYOf4y70mypnttMgVW1LXvAGa4?=
 =?us-ascii?Q?vSD+BD1RilGnbFljXR0baRL2FmuJ/a23x0wopQOqef8Tbjs51+jA4ly0lV0j?=
 =?us-ascii?Q?qpm+ybdR9TIT33K9fNEdmPwu/+LU5Hz+4fNdaa5E+bEcj/ocEelAuXjEyeOd?=
 =?us-ascii?Q?oHC2ynf4y2uChfJlTK1eGmB4vZfhmt5oZnjkmzDzRkF9tfNVtii2MB8PdKQE?=
 =?us-ascii?Q?921Ut0EkHN3D4dpF59PYZhpuyfiY9toxgRCHPmLgVRASyT/uQBkeffr2Nltb?=
 =?us-ascii?Q?+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EB9EC6DE119F2D4CA5354F3419470FD2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5q/vOcC7DLU+9cmn1rbuo+xyMIwWohxdPlQbB8mNeabeV2Y22Y3lyPuh11V+Q9WBQDprLuowtBX7i+lRZB6gerETWRrN1iLI+LjdBukry51lzXJlqnJUM3vXTDnVDPO8dp8Y8NzkvFVkyL79X1e4VR+Wp36RLJ3s/mqqSnw+uvibJiwkI1UqNDi7aIL0v9s+mFz/qQa7YBE578VrQnhs3Sncj0hilGtjB0lnCSicN0C23hp/L7CgsdN/aDkNWGGkcObCAzYyCJTE0GtLxkipe9zgQ+mSQ0hR0V33g0uNJEJlgnsVFgM2eDXGtZ9Y/XeCK6I8cMrcS6qFhNfXzRvF2NDS0k3ZKufB95qH/hn6uUK3bXG84LNJuOv9APmp+HTgYqUBIVbwsC6j0jIwz5JmCjTVuF2NZUKnPRB2togG2cfNvuEqjrK6c9/g9vY/y3bCYl3VhsJojj1sM1ZLiuRZob+VHxDTcox/W7r/Zf1bmRGEd/q1HKO14FGUNVANN3eKBBr7HQ9KEJL7MeWrK9TwuOMPykiliAov/qXnKir3rAvmjxVWru3fF1EWTX51o4kGQXfCMwZGRuptTT7X198M+ur5ipGnr7bUbHamMNE8HJiAUdtpFS3iMpMACUvdbXkHAWCCETgxfyl42idqzDPkDLBTlRMkqzemoYdgz147oQPpVhesEu7SQmoYTojsJGL9kJgbERxXpda8/ZlIaxj1bM9J0bBzHu7Bhk7Aa7XR2Zexrn2M8jgQPmMf72+89InHZltIMDL2JqAUErQ2A7DKTx6nPTsHB62aA/YOxGuzWm4iRp9P9Vqy8xubhJs9GiR3EpejEFiHLlAg6TaEUTWk58u/kb9DDIveCW+iiWSZddS82UGpT6uApCsQCnWFvY4U5J716tV/dg6aMg5BYsrizsHVIkR4IiYObsxnQEVugQ4=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9ffc87-06fb-4f2e-1a76-08dbb50b0007
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 10:11:45.2377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mGQIhB+18v0BEzP4I3ENVz7F7FNDbPYrREPMj4IP0HWUKucBWkN7GIA/Y57LqzX0xe9PSHZUPGMxDwxkNfLssw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB8906
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, Sep 14, 2023 at 07:02:38PM +0900, Damien Le Moal wrote:
> On 9/14/23 18:06, Niklas Cassel wrote:
> > On Thu, Sep 14, 2023 at 08:51:06AM +0900, Damien Le Moal wrote:
> >> On 9/14/23 07:19, Niklas Cassel wrote:
> >>> From: Niklas Cassel <niklas.cassel@wdc.com>
> >>>
> >>> commit 1e641060c4b5 ("libata: clear eh_info on reset completion") add=
ed
> >>> a workaround that broke the retry mechanism in ATA EH.
> >>>
> >>> Tejun himself suggested to remove this workaround when it was identif=
ied
> >>> to cause additional problems:
> >>> https://lore.kernel.org/linux-ide/20110426135027.GI878@htj.dyndns.org=
/
> >>>
> >>> He and even said:
> >>> "Hmm... it seems I wasn't thinking straight when I added that work ar=
ound."
> >>> https://lore.kernel.org/linux-ide/20110426155229.GM878@htj.dyndns.org=
/
> >>>
> >>> While removing the workaround solved the issue, however, the workarou=
nd was
> >>> kept to avoid "spurious hotplug events during reset", and instead ano=
ther
> >>> workaround was added on top of the existing workaround in commit
> >>> 8c56cacc724c ("libata: fix unexpectedly frozen port after ata_eh_rese=
t()").
> >>>
> >>> Because these IRQs happened when the port was frozen, we know that th=
ey
> >>> were actually a side effect of PxIS and IS.IPS(x) not being cleared b=
efore
> >>> the COMRESET. This is now done in commit 94152042eaa9 ("ata: libahci:=
 clear
> >>> pending interrupt status"), so these workarounds can now be removed.
> >>>
> >>> Since commit 1e641060c4b5 ("libata: clear eh_info on reset completion=
") has
> >>> now been reverted, the ATA EH retry mechanism is functional again, so=
 there
> >>> is once again no need to thaw the port more than once in ata_eh_reset=
().
> >>>
> >>> This reverts "the workaround on top of the workaround" introduced in =
commit
> >>> 8c56cacc724c ("libata: fix unexpectedly frozen port after ata_eh_rese=
t()").
> >>>
> >>> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> >>
> >> We need a fixes tag. Same for patch 1.
> >=20
> > The workaround introduced in commit 1e641060c4b5 ("libata: clear eh_inf=
o on
> > reset completion") broke ATA EH retry logic, so the proper commit that =
we
> > fix is that commit.
> >=20
> > However, if we put a Fixes tag with that commit, then this patch will g=
et
> > backported to all possible stable kernels that has that commit, somethi=
ng
> > that we do _not_ want.
> >=20
> > We can only remove this workaround for kernels that has commit 94152042=
eaa9
> > ("ata: libahci: clear pending interrupt status").
>=20
> Squash the 2 fixes together in a single commit ?

We can do that, but the problem would be the same.

commit 94152042eaa9 ("ata: libahci: clear pending interrupt status") is
currently in your for-next branch. Patch 1 and patch 2 in this series
depend on this commit.

Both of these fixes (patch 1 and patch 2 in this series) fix issues caused
by commit 1e641060c4b5 ("libata: clear eh_info on reset completion"),
a 14 year old commit.

We could add a Fixes that on 1e641060c4b5 ("libata: clear eh_info on reset
completion").
But might get this patch to get backported to all old kernels.
We don't want that, as we depend on 94152042eaa9 ("ata: libahci: clear
pending interrupt status").


So... skip a Fixes tag or add a Fixes against on the commit that we depend
on? (Even tough we are not "fixing" that commit.)


Kind regards,
Niklas=
