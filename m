From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [RFC PATCH] ide-floppy: use rq->cmd for preparing and sending
	packet cmds to the drive
Date: Wed, 13 Feb 2008 13:46:25 +0100
Message-ID: <20080213124625.GB13446@gollum.tnic>
References: <20080212143715.GB4530@gollum.tnic> <200802122239.22566.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760951AbYBMMrQ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200802122239.22566.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, Feb 12, 2008 at 10:39:22PM +0100, Bartlomiej Zolnierkiewicz wro=
te:

Hi Bart,

> I think that this _really_ should be done _after_ unifying ATAPI hand=
ling [*].
> Otherwise you will be making some of the same changes to the _three_ =
copies
> of (more or less) identical code and more importantly we will have to=
 delay
> unification after _all_ drivers are converted to rq->cmd[] (+ lets no=
t forget
> that I'll have more changes to review ;).
>=20
> (*) please take a closer look at *_issue_pc(), *_transfer_pc() and *_=
pc_intr()
>     in ide-{floppy,tape,scsi} (the useful hint is that after making t=
hese
>     functions free of references to device driver specific objects/fu=
nctions
>     we can use drive->media =3D=3D ide_{floppy,tape,scsi} checks for =
handling
>     not yet fully unified / media type specific code).

I started working on probably the easiest unification we could do: unif=
y all the
pc->flags defines and move them in a header where all drivers can use t=
hem. This
raises an architectural design question: The way i see it, the generic =
ATAPI handling
is going to be sort of "serving" functionality to the drivers using ATA=
PI. Do we want
all this functionality to go to ide.{h,c} or we want specific atapi.{h,=
c} files that
contain only this unified functionality, or whatever else. In general, =
how is this
generic layer going to be distributed among headers/.c files and what d=
o we want there?

/me tends to think that special headers/files, small and easy to manage=
 and
modular, have more advantages in this case but this is just me. After w=
e've
decided on that, the rest of the issues will resolve by themselves/get =
easier to
tackle.

Thanks.

--=20
Regards/Gru=DF,
    Boris.
