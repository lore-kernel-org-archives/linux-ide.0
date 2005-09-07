From: Horms <horms@debian.org>
Subject: Re: Bug#321442: kernel-source-2.6.8: fails to compile on powerpc (drivers/ide/ppc/pmac.c)
Date: Wed, 7 Sep 2005 15:00:50 +0900
Message-ID: <20050907060050.GD22231@verge.net.au>
References: <E1E13vT-0008G7-R1@arda.LT-P.net> <20050808085703.GE18551@verge.net.au> <20050814005430.2e26e627@arda.LT-P.net> <C2F63384-9CC2-4979-956B-8CB5DA77F4AE@mac.com> <58cb370e0509050542b512131@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from koto.vergenet.net ([210.128.90.7]:3530 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1751103AbVIGHRb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Sep 2005 03:17:31 -0400
Content-Disposition: inline
In-Reply-To: <58cb370e0509050542b512131@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, LT-P <LT-P@lt-p.net>, 321442@bugs.debian.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Mon, Sep 05, 2005 at 02:42:43PM +0200, Bartlomiej Zolnierkiewicz wro=
te:
> Should be fixed in 2.6.13.
>=20
> On 8/16/05, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> > On Aug 13, 2005, at 18:54:30, LT-P wrote:
> > > Le lun 08 ao=FB 2005 17:57:04 CEST, Horms <horms@debian.org> a =E9=
crit:
> > >> Can you please enable BLK_DEV_IDEDMA_PCI and see if that resolve=
s
> > >> your
> > >> problem. If it does, then the following patch should fix Kconfig
> > >> so that BLK_DEV_IDEDMA_PCI needs to be enabled for BLK_DEV_IDE_P=
MAC
> > >> to be enabled. It should patch cleanly against Debian's 2.6.8 an=
d
> > >> Linus' current Git tree.
> > > It seems to solve the problem, thanks.
> > > Sometimes, I feel like I am the only person in the world to compi=
le
> > > the kernel on
> > > powerpc... :)
> >=20
> > Actually, I ran into this same bug a day or so ago when updating to
> > 2.6.13-rc6,
> > it's just I noticed the error, fixed my config, then recompiled and
> > forgot
> > about it completely until now :-D.  Thanks for the bug report, thou=
gh!

thanks

--=20
Horms
