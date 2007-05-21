From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [3/5] 2.6.22-rc2: known regressions
Date: Mon, 21 May 2007 07:44:04 -0300
Message-ID: <1179744244.4138.47.camel@localhost>
References: <464F6DC9.80805@googlemail.com>
	 <464F74D5.9080204@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:52299 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756165AbXEUNo4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 May 2007 09:44:56 -0400
In-Reply-To: <464F74D5.9080204@googlemail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, Francis Russell <francisrussell@btopenworld.com>, Robert de Rooy <robert.de.rooy@gmail.com>, Alan Cox <alan@redhat.com>, video4linux@list.redhat.com, Hans Verkuil <hverkuil@xs4all.nl>, Robert Fitzsimons <robfitz@273k.net>

Hi Michal,

Em Dom, 2007-05-20 =C3=A0s 00:06 +0200, Michal Piotrowski escreveu:

> V4L
>=20
> Subject    : V4L ABI breakage
> References : http://lkml.org/lkml/2007/5/14/42
> Submitter  : Robert Fitzsimons <robfitz@273k.net>
> Caused-By  : Hans Verkuil <hverkuil@xs4all.nl>
>              Mauro Carvalho Chehab <mchehab@infradead.org>
>              commit 206ebaf32795cf1582b1e2ff2ec6a560c9e986b8
> Status     : Unknown

I was traveling abroad last week, without access to my devel
environment. Hans is currently working on a definitive fix for the
issue. His schedule is to have a proper solution until next week.

=46or now, it is better just to revert the bad changes. I've committed =
a
patch on my tree for that:

http://git.kernel.org/?p=3Dlinux/kernel/git/mchehab/v4l-dvb.git;a=3Dcom=
mitdiff;h=3D15ac2d293b08b6975c6ca1a80eb839d4cb0dddbf

I'm currently running some tests on my environment with the fix patches
I currently have. I should send a pull request to Linus later today.

--=20
Cheers,
Mauro

