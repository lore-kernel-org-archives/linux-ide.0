From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Bug#321442: kernel-source-2.6.8: fails to compile on powerpc (drivers/ide/ppc/pmac.c)
Date: Mon, 5 Sep 2005 14:42:43 +0200
Message-ID: <58cb370e0509050542b512131@mail.gmail.com>
References: <E1E13vT-0008G7-R1@arda.LT-P.net>
	 <20050808085703.GE18551@verge.net.au>
	 <20050814005430.2e26e627@arda.LT-P.net>
	 <C2F63384-9CC2-4979-956B-8CB5DA77F4AE@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.207]:53823 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751207AbVIEMmq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Sep 2005 08:42:46 -0400
Received: by nproxy.gmail.com with SMTP id x37so339806nfc
        for <linux-ide@vger.kernel.org>; Mon, 05 Sep 2005 05:42:43 -0700 (PDT)
In-Reply-To: <C2F63384-9CC2-4979-956B-8CB5DA77F4AE@mac.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: LT-P <LT-P@lt-p.net>, Horms <horms@debian.org>, 321442@bugs.debian.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Should be fixed in 2.6.13.

On 8/16/05, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> On Aug 13, 2005, at 18:54:30, LT-P wrote:
> > Le lun 08 ao=FB 2005 17:57:04 CEST, Horms <horms@debian.org> a =E9c=
rit:
> >> Can you please enable BLK_DEV_IDEDMA_PCI and see if that resolves
> >> your
> >> problem. If it does, then the following patch should fix Kconfig
> >> so that BLK_DEV_IDEDMA_PCI needs to be enabled for BLK_DEV_IDE_PMA=
C
> >> to be enabled. It should patch cleanly against Debian's 2.6.8 and
> >> Linus' current Git tree.
> > It seems to solve the problem, thanks.
> > Sometimes, I feel like I am the only person in the world to compile
> > the kernel on
> > powerpc... :)
>=20
> Actually, I ran into this same bug a day or so ago when updating to
> 2.6.13-rc6,
> it's just I noticed the error, fixed my config, then recompiled and
> forgot
> about it completely until now :-D.  Thanks for the bug report, though=
!
>=20
> Cheers,
> Kyle Moffett
