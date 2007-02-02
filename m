From: "Uwe Bugla" <uwe.bugla@gmx.de>
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
Date: Fri, 02 Feb 2007 13:58:13 +0100
Message-ID: <20070202125813.185480@gmx.net>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>
	<20070127174230.GN6017@stusta.de>	<20070128133344.214070@gmx.net>
 <20070128152131.a4354c91.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:40392 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422973AbXBBM6P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Feb 2007 07:58:15 -0500
In-Reply-To: <20070128152131.a4354c91.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: bzolnier@gmail.com, bunk@stusta.de, axboe@kernel.dk, linux-kernel-announce@vger.kernel.org, linux-ide@vger.kernel.org


-------- Original-Nachricht --------
Datum: Sun, 28 Jan 2007 15:21:31 -0800
Von: Andrew Morton <akpm@osdl.org>
An: "Uwe Bugla" <uwe.bugla@gmx.de>
CC: linux-ide@vger.kernel.org, linux-kernel-announce@vger.kernel.org, "=
Jens Axboe" <axboe@kernel.dk>, Adrian Bunk <bunk@stusta.de>, "Bartlomie=
j Zolnierkiewicz" <bzolnier@gmail.com>
Betreff: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)

> On Sun, 28 Jan 2007 14:33:44 +0100
> "Uwe Bugla" <uwe.bugla@gmx.de> wrote:
>=20
> > > Subject    : problems with CD burning
> > > References : http://www.spinics.net/lists/linux-ide/msg06545.html
> > > Submitter  : Uwe Bugla <uwe.bugla@gmx.de>
> > > Status     : unknown
> > >=20
> > >=20
> >=20
> > ...
> >
> > Hi everybody,
> > the problem I already reported for earlier release candidates of ke=
rnel
> 2.6.20
> > (rc1 =E2=80=93 5) unfortunately stills persists.
> >=20
> > The regression has become more extreme: While in earlier release
> candidates nerolinux recognized my burning devices at least after the=
 first start
> and then never again after all following starts the situation in rc6 =
is
> different from that:
> >=20
> > The CD and DVD burning devices aren=C2=B4t recognized even once and=
 the
> drive seek errors I already reported are still there.
> >=20
> > nerolinux runs excellently with kernel 2.6.19.2, but only shows an
> =E2=80=9Cimage recorder=E2=80=9D (i. e. no burning device at all) in =
kernel 2.6.20-rc6.
> >=20
> > Still hope that this terrible bug will not be part of the final ver=
sion
> of 2.6.20!
> >=20
>=20
> Not sure what to do about this.  It looks like a failure in the IDE
> driver.
> Perhaps you could start by telling us about the IDE hardware, which d=
river
> is in use, etc.
>=20
> Is the floppy-disk bug still there?

Hi Andrew and all others,
1. The floppy bug does not exist anymore. Congretulations!
My IDE hardware is Intel north and south bridge, the standard idecd dri=
ver is in use.
As I was all the time suspecting a timing error I'm looking forward to =
testing Mike=C2=B4s patch and I guess the bug will be absent then.
Lots of thanks for Mikes work!
Big regards and thanks for the late reply

Uwe

--=20
"Feel free" - 10 GB Mailbox, 100 FreeSMS/Monat ...
Jetzt GMX TopMail testen: http://www.gmx.net/de/go/topmail?ac=3DOM.GX.G=
X003K11713T4783a
