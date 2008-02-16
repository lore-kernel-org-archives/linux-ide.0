From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: IDE cdrom problem
Date: Sat, 16 Feb 2008 21:23:00 +0100
Message-ID: <20080216202300.GU13446@gollum.tnic>
References: <200802161624.47003.bzolnier@gmail.com> <20080216164912.GQ13446@gollum.tnic> <200802161840.08209.bzolnier@gmail.com> <20080216180938.GS13446@gollum.tnic> <1203190042.14195.4.camel@Jupiter>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:23348 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbYBPUXL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Feb 2008 15:23:11 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1184427fkz.5
        for <linux-ide@vger.kernel.org>; Sat, 16 Feb 2008 12:23:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1203190042.14195.4.camel@Jupiter>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: WaVeR <debian@hispeed.ch>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

On Sat, Feb 16, 2008 at 08:27:21PM +0100, WaVeR wrote:
> Hi,
>=20
>=20
> Le samedi 16 f=E9vrier 2008 =E0 19:09 +0100, Borislav Petkov a =E9cri=
t :
> > On Sat, Feb 16, 2008 at 06:40:08PM +0100, Bartlomiej Zolnierkiewicz=
 wrote:
> > > On Saturday 16 February 2008, Borislav Petkov wrote:
> > > > On Sat, Feb 16, 2008 at 04:24:46PM +0100, Bartlomiej Zolnierkie=
wicz wrote:
> > > > >=20
> > > > > [ added Borislav (ide-cd maintainer) to cc: ]
> > > > >=20
> > > > > Hi,
> > > > >=20
> > > > > Unless there are some very important reasons to keep the disc=
ussion private
> > > > > please always cc: linux-ide@ and/or linux-kernel@ ML when rep=
orting problems.
> > > > >=20
> > > > > Othewise your mail misses many knowledgeable people and is le=
ft on mercy
> > > > > of clueless IDE maintainer... ;-)
>=20
>=20
> As I mentioned, the reason why I wrote to you directly is i'm not on =
the
> linux-ide mailing list.

That doesn't matter. What Bart ment is that if you cc the mailing list,=
 more
people are going to see your bug report and the chance of the bug getti=
ng fixed
is bigger.

>=20
>=20
> Do you want me to try the 2.6.25-rc2 ? and give my feedback

Yes, please.

> > > > >=20
> > > > > ----------  Forwarded Message  ----------
> > > > >=20
> > > > > Subject: IDE cdrom problem
> > > > > Date: Saturday 16 February 2008
> > > > > From: WaVeR <debian@hispeed.ch>
> > > > > To: bzolnier@gmail.com
> > > > >=20
> > > > > Hello Bart,
> > > > >=20
> > > > > Sorry to distrub you, but I have a similar problem like this =
post
> > > > > http://lkml.org/lkml/2008/2/12/97
> > > > >=20
> > > > > I'm not subscribed to linux ML, so I decide to write you dire=
ctly.
> > > > >=20
> > > > >=20
> > > > > >From my dmesg, I get this error:
> > > > >=20
> > > > > Feb 16 08:01:58 Jupiter kernel: hdc: cdrom_pc_intr: The drive=
 appears
> > > > > confused (ireason =3D 0x01). Trying to recover by ending requ=
est.
> > > > > Feb 16 08:06:16 Jupiter kernel: hdc: cdrom_pc_intr: The drive=
 appears
> > > > > confused (ireason =3D 0x01). Trying to recover by ending requ=
est.
> > > > > Feb 16 08:10:45 Jupiter kernel: hdd: cdrom_pc_intr: The drive=
 appears
> > > > > confused (ireason =3D 0x01). Trying to recover by ending requ=
est.
> > > > > Feb 16 08:37:41 Jupiter kernel: hdd: cdrom_pc_intr: The drive=
 appears
> > > > > confused (ireason =3D 0x01). Trying to recover by ending requ=
est.
> > > > > Feb 16 08:42:10 Jupiter kernel: hdc: cdrom_pc_intr: The drive=
 appears
> > > > > confused (ireason =3D 0x01). Trying to recover by ending requ=
est.
> > > > > Feb 16 09:00:07 Jupiter kernel: hdd: cdrom_pc_intr: The drive=
 appears
> > > > > confused (ireason =3D 0x01). Trying to recover by ending requ=
est.
> > > >=20
> > > > Yeah, this is kinda funny, i think i've seen that somewhere :) =
But seriously,
> > >=20
> > > Yep, this looks to be the identical problem as discussed recently=
:
> > >=20
> > > http://www.mail-archive.com/linux-ide@vger.kernel.org/msg16131.ht=
ml
> > >=20
> > > [ + IIRC the similar issue might be already in the kernel bugzill=
a... ]
> > >=20
> > > > can you try 2.6.25-rc2 - this one should be stable enough and i=
t has the ide-cd
> > > > rewrite in there and it would be interesting to see whether the=
 new interrupt
> > > > handler shows the same behaviour.
> > > >=20
> > > > Bart, since this starts to occur often, i'm thinking of adding =
a debugging macro
> > > > similar to the ones we rewrote in ide-floppy and ide-tape besid=
es the
> > > > CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS facility in ide-cd. What ar=
e your thoughts
> > > > on the matter?
> > >=20
> > > I would rather prefer to see more code removal/unification in ide=
-cd.
> >=20
> > Yep, this is underway. Am working on removing the ide-cd internal b=
uffer and
> > will get back to you after testing it... Ide floppy will have to wa=
it.
> > >=20
> > > [ If the code is simple/clean enough and have informative printk(=
)-s for
> > >   error conditions there shouldn't be a frequent need for an extr=
a debugging
> > >   information. ]
> > >=20
> > > > > As you can see on the atached file. It's a simple IDE dvdrom =
and a cd
> > > > > burner.
> > > > >=20
> > > > > I dont have this problem with the kernel 2.6.21.3
> > > > >=20
> > > > > My actual kernel is:
> > > > > 9:28 waver@Jupiter ~% uname -a
> > > > > Linux Jupiter 2.6.24.2-waver.1 #1 Wed Feb 13 23:53:31 CET 200=
8 i686
> > > > > GNU/Linux
> > >=20
> > > It would also help us if it can be narrowed down to the specific =
commit.
> > > Please install git package, get kernel git tree from kernel.org, =
and do:
> > >=20
> > > git bisect start
> > > git bisect good 2.6.21
> > > git bisect bad 2.6.24
> >=20
> > What would decrease the number of bisection iterations would be spe=
cifying the
> > path for bisection, like so:
> >=20
> > git bisect start -- drivers/ide
> >=20
> > and then we'll nail down the evildoer significantly faster, imho.
> > >=20
> > > It will select the kernel to test - compile and boot it to see if=
 the problem
> > > is still there.  If so do "git bisect bad" which will give you ne=
w kernel
> > > to test.  If the kernel works fine do "git bisect good" instead. =
 After few
> > > iterations you should find the exact commit which introduced the =
bug.
> > >=20
> > > Thanks,
> > > Bart
> >=20

--=20
Regards/Gru=DF,
    Boris.
