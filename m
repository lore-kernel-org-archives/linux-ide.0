From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 0/5] ide-cd: trivial fixes
Date: Thu, 28 Feb 2008 06:52:51 +0100
Message-ID: <20080228055251.GD9545@gollum.tnic>
References: <1204136449-9490-1-git-send-email-petkovbb@gmail.com> <200802272218.40312.bzolnier@gmail.com> <20080227221814.GC9545@gollum.tnic> <200802272348.35011.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:35173 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbYB1Fw4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Feb 2008 00:52:56 -0500
Received: by ug-out-1314.google.com with SMTP id z38so143988ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 27 Feb 2008 21:52:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200802272348.35011.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, Feb 27, 2008 at 11:48:34PM +0100, Bartlomiej Zolnierkiewicz wro=
te:
> On Wednesday 27 February 2008, Borislav Petkov wrote:
> > On Wed, Feb 27, 2008 at 10:18:40PM +0100, Bartlomiej Zolnierkiewicz=
 wrote:
> > >=20
> > > Hi,
> > >=20
> > > On Wednesday 27 February 2008, Borislav Petkov wrote:
> > > > Hi Bart,
> > > >=20
> > > > here are the ide-cd trivial fixes split in an easier to digest =
format. I
> > > > cannot do the md5sum check here since all of the patches change=
 at least one
> > > > char but i hope that this'll be redundant here since they're tr=
ivially easy
> > > > to review :) now.
> > > >=20
> > > >  drivers/ide/ide-cd.c |  591 +++++++++++++++++++++++++---------=
----------------
> > > >  1 files changed, 298 insertions(+), 293 deletions(-)
> > >=20
> > > applied everything
> > >=20
> > > BTW patch #3/5 which accounts for 2/3 of the diffstat passes md5s=
um check here
> >=20
> > huh, are you sure? The fixup-comments patch adds at least one char =
to the source
> > file so the md5sums cannot be the same.
>=20
> OTOH md5sums of the resulting _binary_ files matches... ;-)=20

right, the compiler discards all comments during compilation and the so=
le code
remains unchanged.

--=20
Regards/Gru=DF,
    Boris.
