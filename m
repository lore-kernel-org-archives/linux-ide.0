From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
Date: Sun, 28 Jan 2007 15:21:31 -0800
Message-ID: <20070128152131.a4354c91.akpm@osdl.org>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>
	<20070127174230.GN6017@stusta.de>
	<20070128133344.214070@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:41471 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932973AbXA1XYx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Jan 2007 18:24:53 -0500
In-Reply-To: <20070128133344.214070@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Bugla <uwe.bugla@gmx.de>
Cc: linux-ide@vger.kernel.org, linux-kernel-announce@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Adrian Bunk <bunk@stusta.de>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Sun, 28 Jan 2007 14:33:44 +0100
"Uwe Bugla" <uwe.bugla@gmx.de> wrote:

> > Subject    : problems with CD burning
> > References : http://www.spinics.net/lists/linux-ide/msg06545.html
> > Submitter  : Uwe Bugla <uwe.bugla@gmx.de>
> > Status     : unknown
> >=20
> >=20
>=20
> ...
>
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

Not sure what to do about this.  It looks like a failure in the IDE dri=
ver.
Perhaps you could start by telling us about the IDE hardware, which dri=
ver
is in use, etc.

Is the floppy-disk bug still there?
