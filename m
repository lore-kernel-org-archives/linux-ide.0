From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] drivers/ata/sata_via.c - Eliminate "may be used
	uninitialized" warning
Date: Sun, 06 Apr 2008 15:00:07 -0700
Message-ID: <1207519207.1803.60.camel@localhost>
References: <1207518320.1803.52.camel@localhost>
	 <20080406215054.GI30987@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 136-022.dsl.labridge.com ([206.117.136.22]:1945 "EHLO
	mail.perches.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753535AbYDFWA7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Apr 2008 18:00:59 -0400
In-Reply-To: <20080406215054.GI30987@cs181133002.pp.htv.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, 2008-04-07 at 00:50 +0300, Adrian Bunk wrote:
> On Sun, Apr 06, 2008 at 02:45:20PM -0700, Joe Perches wrote:
> > Called by svia_init_one with a temporary,
> > so there's no effective code change.
> I'm not getting any warning here.
> Are you using an older gcc?

Yes.  Slightly less than 4.3.0

$ gcc --version
gcc (GCC) 4.2.2 20071128 (prerelease) (4.2.2-3.1mdv2008.0)

$ git-show
commit 6fdf5e67fe8d3c83500dad9acae985132c2459a3
Merge: abd24df... e64a3cf...
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri Apr 4 15:09:44 2008 -0700

    Merge branch 'upstream' of git://git.kernel.org/pub/scm/linux/kerne=
l/git/ralf/upstream-linus
   =20
    * 'upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/ralf/=
upstream-linus:
      [MIPS] Make KGDB compile on UP
      [MIPS] Pb1200: Fix header breakage

$ make defconfig
[]
$ make clean
[]
$ make drivers/ata/sata_via.o
[]
  CC      drivers/ata/sata_via.o
drivers/ata/sata_via.c: In function =E2=80=98svia_init_one=E2=80=99:
drivers/ata/sata_via.c:504: warning: =E2=80=98host=E2=80=99 may be used=
 uninitialized in this function


