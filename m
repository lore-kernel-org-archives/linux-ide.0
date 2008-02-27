From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 0/5] ide-cd: trivial fixes
Date: Wed, 27 Feb 2008 23:18:14 +0100
Message-ID: <20080227221814.GC9545@gollum.tnic>
References: <1204136449-9490-1-git-send-email-petkovbb@gmail.com> <200802272218.40312.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:42623 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759305AbYB0WSR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Feb 2008 17:18:17 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1642842nfb.21
        for <linux-ide@vger.kernel.org>; Wed, 27 Feb 2008 14:18:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200802272218.40312.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, Feb 27, 2008 at 10:18:40PM +0100, Bartlomiej Zolnierkiewicz wro=
te:
>=20
> Hi,
>=20
> On Wednesday 27 February 2008, Borislav Petkov wrote:
> > Hi Bart,
> >=20
> > here are the ide-cd trivial fixes split in an easier to digest form=
at. I
> > cannot do the md5sum check here since all of the patches change at =
least one
> > char but i hope that this'll be redundant here since they're trivia=
lly easy
> > to review :) now.
> >=20
> >  drivers/ide/ide-cd.c |  591 +++++++++++++++++++++++++-------------=
------------
> >  1 files changed, 298 insertions(+), 293 deletions(-)
>=20
> applied everything
>=20
> BTW patch #3/5 which accounts for 2/3 of the diffstat passes md5sum c=
heck here

huh, are you sure? The fixup-comments patch adds at least one char to t=
he source
file so the md5sums cannot be the same.

--=20
Regards/Gru=DF,
    Boris.
