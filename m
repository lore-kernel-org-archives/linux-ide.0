From: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>
Subject: Re: [PATCH] ahci: retry enabling AHCI a few times before spitting out WARN_ON()
Date: Thu, 24 Apr 2008 05:57:42 +0200
Message-ID: <200804240557.42428.volker.armin.hemmann@tu-clausthal.de>
References: <480F231A.7020401@gmail.com> <200804240528.30511.volker.armin.hemmann@tu-clausthal.de> <48100025.6080402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from poseidon.rz.tu-clausthal.de ([139.174.2.21]:57514 "EHLO
	poseidon.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750952AbYDXD5q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Apr 2008 23:57:46 -0400
In-Reply-To: <48100025.6080402@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Peer Chen <pchen@nvidia.com>

On Donnerstag, 24. April 2008, Tejun Heo wrote:
> Volker Armin Hemmann wrote:
> > On Donnerstag, 24. April 2008, Tejun Heo wrote:
> >> Ah.. right.  The patch is for libata-dev#upstream branch which con=
tains
> >> ahci_enable_ahci() refactoring change.  You'll need to get the lat=
est
> >> linux-2.6 git tree which contains it.
> >
> > which isn't -git4
> >
> > *sigh*
> >
> > then I did:
> > git clone
> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.gi=
t
> > Initialized empty Git repository in /usr/src/linux-2.6/.git/
> > remote: Counting objects: 761806, done.
> > remote: Compressing objects: 100% (130538/130538), done.
> > remote: Total 761806 (delta 633235), reused 758782 (delta 630257)
> > Receiving objects: 100% (761806/761806), 179.18 MiB | 10975 KiB/s, =
done.
> > Resolving deltas: 100% (633235/633235), done.
> > Checking out files: 100% (23886/23886), done.
> >
> > cd linux-2.6
> > patch -p1 < ../ahci.patch
> > patching file drivers/ata/ahci.c
> > Hunk #1 FAILED at 556.
> > 1 out of 1 hunk FAILED -- saving rejects to file drivers/ata/ahci.c=
=2Erej
>
> If you can git, just do the following...
>
> $ git fetch
> git://git.kernel.org//pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> upstream:upstream $ git checkout -f upstream
> $ patch -p1 < ahci.patch
>
> Thanks.

that did not work:

git fetch=20
git://git.kernel.org//pub/scm/linux/kernel/git/jgarzik/libata-dev.git=20
upstream:upstream
fatal: Not a git repository

git fetch=20
git://git.kernel.org//pub/scm/linux/kernel/git/jgarzik/libata-dev.git
fatal: Not a git repository

git fetch git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-=
dev.git=20
upstream:upstream
fatal: Not a git repository
energy src # git fetch=20
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
fatal: Not a git repository
energy src # git clone=20
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
Initialized empty Git repository in /usr/src/libata-dev/.git/
remote: Counting objects: 743097, done.
remote: Compressing objects: 100% (127420/127420), done.
remote: Total 743097 (delta 617111), reused 740658 (delta 614672)
Receiving objects: 100% (743097/743097), 173.30 MiB | 11013 KiB/s, done=
=2E
Resolving deltas: 100% (617111/617111), done.
Checking out files: 100% (23824/23824), done.

git fetch=20
git://git.kernel.org//pub/scm/linux/kernel/git/jgarzik/libata-dev.git=20
upstream:upstream
fatal: Not a git repository
energy src # cd libata-dev
energy libata-dev # git checkout -f upstream
git checkout: updating paths is incompatible with switching branches/fo=
rcing
Did you intend to checkout 'upstream' which can not be resolved as comm=
it?
energy libata-dev # git checkout -f=20
git://git.kernel.org//pub/scm/linux/kernel/git/jgarzik/libata-dev.git=20
upstream:upstream
git checkout: updating paths is incompatible with switching branches/fo=
rcing
energy libata-dev # ls
arch   COPYING  crypto         drivers  include  ipc     kernel  MAINTA=
INERS =20
mm   README          samples  security  usr
block  CREDITS  Documentation  fs       init     Kbuild  lib     Makefi=
le    =20
net  REPORTING-BUGS  scripts  sound     virt
energy libata-dev # patch -p1 < ../ahci.patch
patching file drivers/ata/ahci.c
Hunk #1 FAILED at 556.
1 out of 1 hunk FAILED -- saving rejects to file drivers/ata/ahci.c.rej

Gl=FCck Auf,
Volker
