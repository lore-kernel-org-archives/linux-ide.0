From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
Date: Mon, 29 Jan 2007 07:26:03 +0100
Message-ID: <1170051963.6454.7.camel@Homer.simpson.net>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>
	 <20070127174230.GN6017@stusta.de>  <20070128133344.214070@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:50792 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933214AbXA2G0Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Jan 2007 01:26:16 -0500
In-Reply-To: <20070128133344.214070@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Bugla <uwe.bugla@gmx.de>
Cc: Adrian Bunk <bunk@stusta.de>, akpm@osdl.org, torvalds@linux-foundation.org, rml@novell.com, ttb@tentacle.dhs.org, nickpiggin@yahoo.com.au, cijoml@volny.cz, linuxppc-dev@ozlabs.org, anton@samba.org, paulus@samba.org, livio@eecg.toronto.edu, petero2@telia.com, hch@lst.de, gd@spherenet.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org

On Sun, 2007-01-28 at 14:33 +0100, Uwe Bugla wrote:
> -------- Original-Nachricht --------
> Datum: Sat, 27 Jan 2007 18:42:30 +0100
> Von: Adrian Bunk <bunk@stusta.de>
> An: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <ak=
pm@osdl.org>
> Betreff: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
>=20
> > This email lists some known regressions in 2.6.20-rc6 compared to 2=
=2E6.19
> > that are not yet fixed in Linus' tree.
> >=20
> > If you find your name in the Cc header, you are either submitter of=
 one
> > of the bugs, maintainer of an affectected subsystem or driver, a pa=
tch
> > of you caused a breakage or I'm considering you in any other way po=
ssibly
> > involved with one or more of these issues.
> >=20
> > Due to the huge amount of recipients, please trim the Cc when answe=
ring.
> >=20
> >=20
> > Subject    : problems with CD burning
> > References : http://www.spinics.net/lists/linux-ide/msg06545.html
> > Submitter  : Uwe Bugla <uwe.bugla@gmx.de>
> > Status     : unknown
=20
<snip>

> Hi everybody,
> the problem I already reported for earlier release candidates of kern=
el 2.6.20
> (rc1 =E2=80=93 5) unfortunately stills persists.
>=20
> The regression has become more extreme: While in earlier release cand=
idates nerolinux recognized my burning devices at least after the first=
 start and then never again after all following starts the situation in=
 rc6 is different from that:
>=20
> The CD and DVD burning devices aren=C2=B4t recognized even once and t=
he drive seek errors I already reported are still there.
>=20
> nerolinux runs excellently with kernel 2.6.19.2, but only shows an =E2=
=80=9Cimage recorder=E2=80=9D (i. e. no burning device at all) in kerne=
l 2.6.20-rc6.
>=20
> Still hope that this terrible bug will not be part of the final versi=
on of 2.6.20!
>=20
> Regards
>=20
> Uwe

=46WIW, I just tried it with 2.6.20-rc6, and can confirm.  Once nero is
run, the kernel never gives up retrying whatever command failed, so I
get...

[ 4362.972995] hdd: status error: status=3D0x58 { DriveReady SeekComple=
te
DataRequest }
[ 4362.981475] ide: failed opcode was: unknown
[ 4362.986183] hdd: drive not ready for command

endlessly.

	-Mike

