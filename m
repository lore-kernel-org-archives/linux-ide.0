Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F44C54EAA
	for <linux-ide@archiver.kernel.org>; Mon, 30 Jan 2023 12:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjA3MB4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 30 Jan 2023 07:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjA3MBz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jan 2023 07:01:55 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D1010C
        for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2023 04:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675080114; x=1706616114;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=j6tjJI4cMBqRlFKUbPtv7hX8bZKg7ljX8tE3uN0o/Ow=;
  b=QvxYAcHRlAAr4kvbhnXXNIQolGa7PRB9iIRzVBSJ/YUha3RfZBfPAmxB
   4CGerXgiF6H7dYwwdhbHf2CpU87Ncy5DyLoMVr9jcoCPcdobOxVhcRPQ/
   2nzCCVGjgB5h+tdVpbjZe2GZieU4GnOi8exhbohEgbDiJTvx+5gw6fwSJ
   3A6ayCaNskQBdOo0HJ4a58UbxyrOGx45AaavfCJtlvJpusLTISiYLg9jx
   9zY7qGHamPiEWmG1ZwlWZWa0saSu9Tt2MkBqqBR6vco9uvncooW7vWJVy
   w5Uy89vUGW7SS/oiqK7n9BkMQbI8x+EdKmfry9jpEJHJciHQzXldRumzh
   A==;
X-IronPort-AV: E=Sophos;i="5.97,257,1669046400"; 
   d="scan'208";a="326367614"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2023 20:01:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5y7JKdzUKZV20FjIrL62HZ95/7dPdxZRfsrqfWYvB7W185+lu9aIFyoBd+s2GP5CD1imJzggb1aNDuQLVkWU4Y8AC4x29wB8gOBZX5x/yFF1hRs2o/0Y5oETjSOOMBJCUTq22bPdSW9jq5TJfWYKLAVqOOyAvSC2fcbGSmab+PXhKUHmCcqNNgEC3sz0Cp+k3UyfRBUcJbQMbhJxCp9vFqzjGFNOwaDLi2sOW1DclS6NiuEigx+WRCbNhVpswyqHPcLN9sKbiSBMn+cv0BfZyRBL/UKUk529ME+b2dj2pqtT+3ro4g665TGkAX/XU9JSdIGGy5mhvDcTTczcJKOug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6tjJI4cMBqRlFKUbPtv7hX8bZKg7ljX8tE3uN0o/Ow=;
 b=Qkhbqg7UAzVW9h0O4rugIISCh6dYvTYVt0MPIEV8xzDlM4Si/WeunFaD2e75391qj42EckPVcmxSfOhCyC46rti95OdyKT9nSvoZR7suN4/QyVt8l2dcttg4nE1fwHRoPXeFy1S9oQ14OBQ/24h9h+EdM7c7r6YMI6y0twdVikmWnfrE8ybGwwgragLlHw3eFBpCoQbf+REiPQDpapiSlAgRJQRswa8IKenGKBI4GfE1I5ukUOuiuI0e9C2P4jDB5qwA0lZAmQaPuklAGCaXS4++2uQstkx3yPxdifFchQroqACUPpHTgN//JmzkLL22MicPDmlGLXfF+X13kuESKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6tjJI4cMBqRlFKUbPtv7hX8bZKg7ljX8tE3uN0o/Ow=;
 b=CI02ISHyjcmIoz9XMDhPs0+fvr7ugZHA6SsaHzC3/PUZ3ndonwI537cOO7j61zdumMwbIsqbrWtQMGXjaRO8kcJ0SeqZsiIKNVudDj4aDOrFV6JCDrDujV9XPi1aMdbLKxrRjBqa2PhWJhqUtbgoZ115qBeqX5Lr/X6p40neP1Y=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BL0PR04MB4770.namprd04.prod.outlook.com (2603:10b6:208:49::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 12:01:37 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fcf:ae46:b9c4:127a]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fcf:ae46:b9c4:127a%7]) with mapi id 15.20.6043.023; Mon, 30 Jan 2023
 12:01:37 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Marius Dinu <marius@psihoexpert.ro>
Subject: Re: [PATCH] ata: libata: Fix sata_down_spd_limit() when no link speed
 is reported
Thread-Topic: [PATCH] ata: libata: Fix sata_down_spd_limit() when no link
 speed is reported
Thread-Index: AQHZNKCp15DTN5v8+U6V60ONrRy3aq622piAgAABWwA=
Date:   Mon, 30 Jan 2023 12:01:37 +0000
Message-ID: <Y9exoBdE0LVbf+Ps@x1-carbon>
References: <20230130110721.111776-1-damien.lemoal@opensource.wdc.com>
 <Y9euXc/Zdr062nJo@x1-carbon>
 <798fcc56-b841-ea7c-e169-0387f1f024c3@opensource.wdc.com>
In-Reply-To: <798fcc56-b841-ea7c-e169-0387f1f024c3@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BL0PR04MB4770:EE_
x-ms-office365-filtering-correlation-id: 922424b6-c4a3-4c2d-b133-08db02b9bd51
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WwuUWLIqSSUFOtpn2O5lYBr4r04ERpuYUciFp8LuV8C3AIH1tFTkA1eM7gx/6B597Gwesz0l5uIDSVl7ShfwPfsIerGoN4nrYxxe0IO7gi5LygKkN53UhN8TNLko6ZaH2MAuIZ86fbcWhTgQ1KsaZPyNLoFLUWsbV/wM8z1Eytidh3RAvdw/4FkFzEDMHw02LxSHOMYbn4FiGfyRBFQx1XKtB0uPS553QqNp5gOKSrOI+Dx2YdLTPBIPuLo4WKfk4E/7ctuo/j9DOXhx2L4S/pqsb5fxKb17QwoQT5hmrlXcd4WJVD8tXkv5afv8QSpbDKfaeOfNN9NEuzCRkEn5FrZr0xN9lZYHHT/pCxzKpSYBnOPSbZ7NGu2z71ev85cXSpKF7TTT7ngZJGq2AYGr0jEe6Av9NMEdtsJImqtcqrujxdKQeY3QAosDNcz7aYFEEBUjU1J3oZcGz17dcYL0aMiQ6oysyHRy6eoqjk7DlyU76nNf9Ys8UzJ1h+HVIQiWPXDsvX12gxoDcmU/Sp0w9TrLZWEV4M73LoRph32n4bxSQz+wnlaK1OHqwNo4POyKSEfoiW4nXadktLb072i8Qmlf6EusO+e6SQxU3Qf75uopvZocI8EPlzKtk0ZwhQcUMTaCtqU41707LeIUclGg2PhdwgwaR0zVEPbAAr593l8lQsyGqgiTFcm0inhF6N4WSt/QvNfV45IqShH++mjnOwkmBTKAHyVSw+HiJBqD9y0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199018)(186003)(6506007)(53546011)(478600001)(26005)(6512007)(9686003)(8676002)(6486002)(66446008)(76116006)(4326008)(64756008)(66476007)(66556008)(82960400001)(91956017)(66946007)(122000001)(83380400001)(41300700001)(8936002)(86362001)(33716001)(6862004)(38100700002)(71200400001)(2906002)(5660300002)(316002)(54906003)(38070700005)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OTv8sA1F8rJufiHuJfz3PLxKJF6mttm9L8gJk3/j3Fya1nFHZExdL1r7oK1X?=
 =?us-ascii?Q?G+9T0JC4zVWcbysC0o/3yL/e+ELd/9soPBGWdavZxRDiFt6ut2GYj5qD76gu?=
 =?us-ascii?Q?saCR/b7jUZx6WOMOF8TJwhruCF/H6+JO1fzyP1F+8ruH8qnHlyt8hClA/RZI?=
 =?us-ascii?Q?k/MkaH2ugHQOSnLcwuEONVK/+2VnyZN7vYiczpTWMRIeEITFuNCRkCgKnEQ0?=
 =?us-ascii?Q?yNs2uWvp2Npfaa3VYJTHiZywWfO9KeeN+gtQkmEX9pB5GDS7ZiDa/VDMUMxb?=
 =?us-ascii?Q?gnwCoa6nO+laoqm/vFHRrRh54JkiENwyXlzF81Fi383DPSDIiP8WdXgBcC/9?=
 =?us-ascii?Q?AJcvkFil7clAUt4Ex8pcg6sWVcAgJwNlyi+uGyKU4Mnhe8Z/wpPApVAd0/Kv?=
 =?us-ascii?Q?iUAsWarJ1v/j6ev52Rp2+ulHuCxrNIusNz1+XO30rUofWs1ZCvKX32Le8zAO?=
 =?us-ascii?Q?f1vKlvuOpIj5uF+UbzZazqNaTTPYQk1euhRIyp8JFTh00FxSFd/DJy4EOHc0?=
 =?us-ascii?Q?DFAUcB1IpgBxNrKt+AUQHkso6CeJPA7oiTtXykALB+l8g/+X5YkgGQC2PW6c?=
 =?us-ascii?Q?bgcwJMfeyb47XH9Pem2G/1uFhdycfvq3IsEmJcYDfFTD5iyXJIl/Bn2Me51O?=
 =?us-ascii?Q?C67tRLBzVjnWYZSG7DhzGzBvo+C4V9PboLbHkD/Y7AWviw0+z0/0l8YuAwOb?=
 =?us-ascii?Q?+1jFzJL1XCtXFCwlF5H+gIVhK7+suUp+eOs6c1+Igpoh/P41M7zymsHQ3hLn?=
 =?us-ascii?Q?qZiv0yVdj5LPkneTk26xJvuKUJ3OQimsqUdlI/neRiy4NqJRVJe8qnIVRvry?=
 =?us-ascii?Q?O09CoDBq+lFEqi/E0IzdUsot6XEKHv7Ce1Jy3UoW59tF2/sxPB9/ewN0Z6Ld?=
 =?us-ascii?Q?mBqw0mFeLwBRzhFj+j4qoo/NmT3jm+aadq6ENWcUNRUM8AGAoQTQ1rljHqZz?=
 =?us-ascii?Q?6qm/zAGjLaA29TKJsBjoD2HG4/8X9zMGqhBRaBYjmjW0YFP1r0tSVIcOjdTb?=
 =?us-ascii?Q?4zE7jhT6E5P4Teqgo0t9dvovQqhmyebCbvEEIrL2veW8e9of/Or2lDHBh1eC?=
 =?us-ascii?Q?SK0j0+zah6I6Ea4ZdzmkK2+N8swdyAKDlw+7ovX7oom+7obh5wPhdqD4sFJj?=
 =?us-ascii?Q?IqopMJIGHam6RR5r5uLgVwmrP29llbPskzRKmj13Im5duqNTNSZ+GpRUmU8u?=
 =?us-ascii?Q?oh2jNjDoIB6yr/Lc277QK1zWwl6Naawcr+cFcbkOCgwtODI23bMSBk9NHqac?=
 =?us-ascii?Q?7HQlcM5inE5ehWpoBFALz4CqFVklOejRoVpVhSdRpg68ul2vuZ5so9B0MSe7?=
 =?us-ascii?Q?vKS3u2nYl8Fx/TCQp58i7ABPf0gG8giJyGS4qLWKbOctj3AyAfZUJcwTJny8?=
 =?us-ascii?Q?sBAElX99SshzHjZF4D6dwv3r2f/CF9Py+ygkCPnwAsL4rTVe9zoFdLWQONvt?=
 =?us-ascii?Q?yVI2upSMHGZrzAZBrplLlgVJkBpOtYzJVfoHAk6rbywIwA42NU7G+tIlvznL?=
 =?us-ascii?Q?dmmlHxbVT5tsUoup5KoGHeXKW6mlbaIu+8LnzxfrR0zEswPsQ7sV8UT8kPWl?=
 =?us-ascii?Q?t01b9inMRJzPP0Y4SP/MDCSC2XFo2/bsByzNTGay3sArZ+YDfUlt5AITOhoy?=
 =?us-ascii?Q?sA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ACFACC00B0831748B63EC81B3278195A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0h21u3XvqOeVq7Usk5dKRFYqBdX/HYRAwALWPtdA2yXUNRuLaKNfOLCOJ4VRxETNS2kngr7FL3hvkDVdqzcE3xoEf2NxMJ300/hWnOI+X+2MMGH/ly0xtR0kvyCGIbHu3QWusi8GBbELY1V5KUXlKONTD6vu9Wu8obsnRwExw7dxlZ/Z2oKKhunnHamG4jnUIbrZgMctHVa+k0yKtb5z8NSwojFkElQzYrxdVsY43bM87+Q160WyP1BvJwugLRGHh9ho9IcbyQtzcMxSKN+4xO+xyrKaQwvrn88E513lYBvnXCP5CVFouZFqBueguPMNad7ZGbwHA0bvOAtnqn8Rowk//f+uZ+SimQGIxm8OZpfJjnuzBerf0LktLUWW+rV4XfwAcnwUPKLrjniB/1f3eiHMj1wN2BcMO2d/rLbrAWdDhJz91wUznP3z0btg1WgtGKPYFjxF/BQB0B3lW628lgyzqpMrSHFHQcQ5YOgeyL38DDhutCH3OwkXiTqWAhf7v5GBlHSdId3yu72Wpv53sx18EDIOf3qIzB6Fcr7dRfxxpo5dTL5YbsyypwbvJnYATKlbErZ6W2aqdsC+NsvZ7KEUlw1wWdAhqSSSWxicQzHD8kc0t5P6vchCXPH7+GE9wubxPSfD1Rnwkt7KMzMrrfICtarCT/4dRSp3ieTPgY9MWl+jLWr+BVyBVYy+jcUQxXopDNSAXh/TVol2nrozz1zrpdxVvZotGHmt31AE8dS6Oj3/XQrSRycSJK5dSaxfnfez7g6Q8yzhZgn/cnE0LYSfcYlxu6uoAGbEVkNtv8SAJ3sMxrOg3DrIJNGGkC1o
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 922424b6-c4a3-4c2d-b133-08db02b9bd51
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 12:01:37.1197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZQjlt65wyK0IPXQmgWROxQ8CZ609Kzlnptwq/OzCAilGWuNwydnmuFz+9Hu4dTEkOeJYvSGJaugEHL+OzVqOKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4770
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Mon, Jan 30, 2023 at 08:56:45PM +0900, Damien Le Moal wrote:
> On 1/30/23 20:47, Niklas Cassel wrote:
> > On Mon, Jan 30, 2023 at 08:07:21PM +0900, Damien Le Moal wrote:
> >> Commit 2dc0b46b5ea3 ("libata: sata_down_spd_limit should return if
> >> driver has not recorded sstatus speed") changed the behavior of
> >> sata_down_spd_limit() to return doing nothing if a drive does not repo=
rt
> >> a current link speed, to avoid reducing the link speed to the lowest 1=
.5
> >> Gbps speed.
> >>
> >> However, the change assumed that a speed was recorded before probing
> >> (e.g. before a suspend/resume) and set in link->sata_spd. This causes
> >> problems with adapters/drives combination failing to establish a link
> >> speed during probe autonegotiation. One exampe reported of this proble=
m
> >=20
> > s/exampe/example/
> >=20
> >> is an mvebu adapter with a 3Gbps port-multiplier box: autonegotiation
> >> fails, leaving no recorded link speed and no rep@orted current link
> >=20
> > s/rep@orted/reported/
> >=20
> >> speed. Probe retries also fail as no action is taken by sata_set_spd()
> >> after each retry.
> >>
> >> Fix this by returning early in sata_down_spd_limit() only if we do hav=
e
> >> a recorded link speed, that is, if link->sata_spd is not 0. With this
> >> fix, a failed probe not leading to a recorded link speed is retried at
> >> the lower 1.5 Gbps speed, with the link speed potentially increased
> >> later on the second revalidate of the device if the device reports
> >> that it supports higher link speeds.
> >>
> >> Reported-by: Marius Dinu <marius@psihoexpert.ro>
> >> Fixes: 2dc0b46b5ea3 ("libata: sata_down_spd_limit should return if dri=
ver has not recorded sstatus speed")
> >=20
> > IIRC, checkpatch.pl with the default options should put the author on t=
he
> > commit being fixed on CC. CC:ing the original author is a good practice=
 IMHO.
>=20
> Funny that I did run checkpatch and it did not complain about the above t=
ypos :)
> Thanks for the review, will fix this.

Sorry, I meant that get_maintainer.pl with the default options usually retu=
rns
the author of the commit being fixed (see "blamed_fixes"):

$ ./scripts/get_maintainer.pl 0001-ata-libata-Fix-sata_down_spd_limit-when-=
no-link-spee.patch
Damien Le Moal <damien.lemoal@opensource.wdc.com> (maintainer:LIBATA SUBSYS=
TEM (Serial and Parallel ATA drivers))
Tejun Heo <tj@kernel.org> (blamed_fixes:1/1=3D100%)
David Milburn <dmilburn@redhat.com> (blamed_fixes:1/1=3D100%)
linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and Parallel =
ATA drivers))
linux-kernel@vger.kernel.org (open list)


Kind regards,
Niklas=
