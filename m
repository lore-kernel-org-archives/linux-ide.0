From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart@free-electrons.com>
Subject: Re: [PATCH v11 3/8] ata: libahci_platform: move port_map parameters
 into the AHCI structure
Date: Wed, 30 Jul 2014 18:47:21 +0200
Message-ID: <20140730164721.GA15772@kwain>
References: <1406193450-17283-1-git-send-email-antoine.tenart@free-electrons.com>
 <1406193450-17283-4-git-send-email-antoine.tenart@free-electrons.com>
 <20140729144042.GD4791@htj.dyndns.org>
 <20140730082038.GB29900@kwain>
 <20140730153526.GB23734@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:57156 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755200AbaG3Qr3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jul 2014 12:47:29 -0400
Content-Disposition: inline
In-Reply-To: <20140730153526.GB23734@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Antoine =?iso-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, kishon@ti.com, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jul 30, 2014 at 11:35:26AM -0400, Tejun Heo wrote:
> On Wed, Jul 30, 2014 at 10:20:38AM +0200, Antoine T=E9nart wrote:
> > How do you want me to send the series? There is two conflicts when
> > applying to libata/for-3.17:
> > - patch 4/8: it takes into account a patch not in libata/for-3.17 b=
ut
> >   added before rc7. It should be better to first merge rc7, otherwi=
se
> >   some modifications won't make sense.
> > - patch 6/8: "fsl,imx53-ahci" was removed from the documentation in
> >   libata/for-3.17 but not in rc7. Resolving the conflict is really
> >   simple.
> >=20
> > I think it's better to apply the whole thing after merging rc7 into
> > libata/for-3.17, because it will only have a really simple conflict=
 to
> > resolve.
> >=20
> > Please tell me what do you prefer before I send the updated version=
=2E
>=20
> Hmmm... does pulling in libata/for-3.16-fixes into libata/for-3.17
> resolves the conflict?  If so, please send the patch on top of the
> merged branch.  I wanna avoid pulling in -rc7 wholesale at this point=
=2E

Works for me. I'll cook and send a series based on top of
libata/for-3.16-fixes merged into libata/for-3.17.

Antoine

--=20
Antoine T=E9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
