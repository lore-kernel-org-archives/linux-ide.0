From: "Y.T. Tang" <yuantian.tang@nxp.com>
Subject: RE: [PATCH] ahci: qoriq: Revert "ahci: qoriq: Disable NCQ on ls2080a
 SoC"
Date: Thu, 29 Sep 2016 09:07:18 +0000
Message-ID: <DB6PR0402MB2837BA24F4CB8D137FA16574F0CE0@DB6PR0402MB2837.eurprd04.prod.outlook.com>
References: <1475027172-21012-1-git-send-email-yuantian.tang@nxp.com>
 <20160929085525.GE11087@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-db5eur01on0065.outbound.protection.outlook.com ([104.47.2.65]:11963
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932451AbcI2JkV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 29 Sep 2016 05:40:21 -0400
In-Reply-To: <20160929085525.GE11087@mtj.duckdns.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>



> -----Original Message-----
> From: Tejun Heo [mailto:htejun@gmail.com] On Behalf Of Tejun Heo
> Sent: Thursday, September 29, 2016 4:55 PM
> To: Y.T. Tang <yuantian.tang@nxp.com>
> Cc: linux-ide@vger.kernel.org
> Subject: Re: [PATCH] ahci: qoriq: Revert "ahci: qoriq: Disable NCQ on ls2=
080a
> SoC"
>=20
> Hello,
>=20
> On Wed, Sep 28, 2016 at 09:46:12AM +0800, yuantian.tang@nxp.com wrote:
> > From: Tang Yuantian <Yuantian.Tang@nxp.com>
> >
> > This reverts commit 640847298e2b7f19 ("ahci: qoriq: Disable NCQ on
> > ls2080a SoC")
> >
> > The erratum has been fixed in ls2080a v2.0 and later soc.
> > Since ls2080a v1.0 has rarely been released, it can be safely
> > reverted.
>=20
> Hmm... going by the description, I'm not sure whether this is a good idea=
.
> What's "rarely been released"?  Are there chips out in the wild?  Can't w=
e
> blacklist v2.0+ only?
>=20
In reality, customer will not get any ls2080a v1.0 soc. Neither apply to an=
y products. If blacklisting v2.0, we need to check the soc version which is=
 not suitable in the driver.
Anyway, reverting this commit won't create any side effect.

Regards,
Yuantian

> Thanks.
>=20
> --
> tejun
