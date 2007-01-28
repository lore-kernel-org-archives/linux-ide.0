From: "Uwe Bugla" <uwe.bugla@gmx.de>
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
Date: Sun, 28 Jan 2007 14:33:44 +0100
Message-ID: <20070128133344.214070@gmx.net>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>
 <20070127174230.GN6017@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932601AbXA1NeS@vger.kernel.org>
In-Reply-To: <20070127174230.GN6017@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>, akpm@osdl.org, torvalds@linux-foundation.org
Cc: rml@novell.com, ttb@tentacle.dhs.org, nickpiggin@yahoo.com.au, cijoml@volny.cz, linuxppc-dev@ozlabs.org, anton@samba.org, paulus@samba.org, livio@eecg.toronto.edu, petero2@telia.com, hch@lst.de, gd@spherenet.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


-------- Original-Nachricht --------
Datum: Sat, 27 Jan 2007 18:42:30 +0100
Von: Adrian Bunk <bunk@stusta.de>
An: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm=
@osdl.org>
Betreff: 2.6.20-rc6: known unfixed regressions (v2) (part 2)

> This email lists some known regressions in 2.6.20-rc6 compared to 2.6=
=2E19
> that are not yet fixed in Linus' tree.
>=20
> If you find your name in the Cc header, you are either submitter of o=
ne
> of the bugs, maintainer of an affectected subsystem or driver, a patc=
h
> of you caused a breakage or I'm considering you in any other way poss=
ibly
> involved with one or more of these issues.
>=20
> Due to the huge amount of recipients, please trim the Cc when answeri=
ng.
>=20
>=20
> Subject    : problems with CD burning
> References : http://www.spinics.net/lists/linux-ide/msg06545.html
> Submitter  : Uwe Bugla <uwe.bugla@gmx.de>
> Status     : unknown
>=20
>=20
> Subject    : pktcdvd fails with pata_amd
> References : http://bugzilla.kernel.org/show_bug.cgi?id=3D7810
>              http://lkml.org/lkml/2007/1/25/128
> Submitter  : Gerhard Dirschl <gd@spherenet.de>
> Caused-By  : Christoph Hellwig <hch@lst.de>
>              commit 3b00315799d78f76531b71435fbc2643cd71ae4c
>              commit 406c9b605cbc45151c03ac9a3f95e9acf050808c
> Status     : problem is being debugged
>=20
>=20
> Subject    : powerpc64: performance monitor exception
> References :
> http://ozlabs.org/pipermail/linuxppc-dev/2007-January/030045.html
> Submitter  : Livio Soares <livio@eecg.toronto.edu>
> Caused-By  : Paul Mackerras <paulus@samba.org>
>              commit d04c56f73c30a5e593202ecfcf25ed43d42363a2
> Status     : problem is being discussed
>=20
>=20
> Subject    : BUG: at fs/inotify.c:172 set_dentry_child_flags()
> References : http://bugzilla.kernel.org/show_bug.cgi?id=3D7785
> Submitter  : Cijoml Cijomlovic Cijomlov <cijoml@volny.cz>
> Handled-By : Nick Piggin <nickpiggin@yahoo.com.au>
> Status     : problem is being debugged
>=20

Hi everybody,
the problem I already reported for earlier release candidates of kernel=
 2.6.20
(rc1 =E2=80=93 5) unfortunately stills persists.

The regression has become more extreme: While in earlier release candid=
ates nerolinux recognized my burning devices at least after the first s=
tart and then never again after all following starts the situation in r=
c6 is different from that:

The CD and DVD burning devices aren=C2=B4t recognized even once and the=
 drive seek errors I already reported are still there.

nerolinux runs excellently with kernel 2.6.19.2, but only shows an =E2=80=
=9Cimage recorder=E2=80=9D (i. e. no burning device at all) in kernel 2=
=2E6.20-rc6.

Still hope that this terrible bug will not be part of the final version=
 of 2.6.20!

Regards

Uwe

P. S.: I already reported that 2.6.20-rc4-mm1 is not bootable at all.

--=20
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!=20
Ideal f=C3=BCr Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
