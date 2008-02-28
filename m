From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 4/5] ide-cd: shorten lines longer than 80 columns
Date: Thu, 28 Feb 2008 07:16:54 +0100
Message-ID: <20080228061654.GE9545@gollum.tnic>
References: <1204136449-9490-1-git-send-email-petkovbb@gmail.com> <200802272218.50537.bzolnier@gmail.com> <20080227221532.GB9545@gollum.tnic> <200802280001.43316.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:26115 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbYB1GRA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Feb 2008 01:17:00 -0500
Received: by ug-out-1314.google.com with SMTP id z38so149719ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 27 Feb 2008 22:16:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200802280001.43316.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thu, Feb 28, 2008 at 12:01:43AM +0100, Bartlomiej Zolnierkiewicz wro=
te:
> On Wednesday 27 February 2008, Borislav Petkov wrote:
> > On Wed, Feb 27, 2008 at 10:18:50PM +0100, Bartlomiej Zolnierkiewicz=
 wrote:
> > > On Wednesday 27 February 2008, Borislav Petkov wrote:
> > > > Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> > >=20
> > > interdiff for the merged version
> > >=20
>=20
> [...]
>=20
> > > diff -u b/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> > > --- b/drivers/ide/ide-cd.c
> > > +++ b/drivers/ide/ide-cd.c
> > > @@ -510,7 +510,7 @@
> > >  	default:
> > >  		if (!(rq->cmd_flags & REQ_QUIET))
> > >  			printk(KERN_INFO "ide-cd: cmd 0x%x timed out\n",
> > > -				rq->cmd[0]);
> > > +					 rq->cmd[0]);
> >=20
> > why do you push the rq->cmd[0] thingy back here. Shouldn't it be al=
igned
> > with the opening brace as the zillion others so far?
>=20
> IDE is quite consistent with the above style but maybe it is just me =
being
> used to it.  I could revert this change if you feel strong about it..=
=2E
>=20

not at all, i'm not that concerned with codestyle issues as long as it =
is mostly
readable :). The only issue of importance is consistency along all the =
source
files so i'll try to keep up with the rest of ide.

> > > @@ -819,8 +819,8 @@
> > >  static void restore_request(struct request *rq)
> > >  {
> > >  	if (rq->buffer !=3D bio_data(rq->bio)) {
> > > -		sector_t n =3D (rq->buffer - (char *) bio_data(rq->bio)) /
> > > -				SECTOR_SIZE;
> > > +		sector_t n =3D
> > > +			(rq->buffer - (char *)bio_data(rq->bio)) / SECTOR_SIZE;
> >=20
> > i must say, lines like this one always look ugly, no matter the for=
matting
> > tricks.
>=20
> For this case there is a simple solution: fix ide-cd to use hwif->sg_=
table
> instead of having it to walk rq->bio's and the whole function will va=
nish. ;-)

Is this hwif->sg_table walk something similar to what it is being done =
in
ide_build_sglist() or ide_build_dmatable()?

> [ IOW We are putting way too much time into these coding style fixes =
and as
>   the old code is replaced with the new one the coding style improves=
 itself. ]

Exactly my thoughts. On the one hand, it is important to clean up the c=
ode
before you stare at it for a magnitude of hours looking for bugs and ac=
tually this
cleanup was supposed to be really brief, to begin with, but you know ho=
w things
really work out in reality :). On the other hand, there are places in i=
de-cd that
are just horrible and need rewriting, besides API changes.

On a different note, i'm working on ripping out pipelining from ide-tap=
e
since this'll make ATAPI unification a lot easier. Do you happen to hav=
e figured
out what this tape->merge_stage is supposed to do, i know it is a pipel=
ine stage
and in all r/w requests the tape->merge_stage->bh is the buffer that
receives/sends the data to/from the device but still it looks really st=
range.
What i've done so far is remove the pipeline control algos and have kep=
t the
tape->merge_stage for simplicity. In a different cycle i'll have to kic=
k it out
too replacing it with a simple data buffer.

Any ideas?

Thanks.

--=20
Regards/Gru=DF,
    Boris.
