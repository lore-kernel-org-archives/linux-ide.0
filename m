From: WaVeR <debian@hispeed.ch>
Subject: Re: IDE cdrom problem
Date: Sat, 16 Feb 2008 20:27:21 +0100
Message-ID: <1203190042.14195.4.camel@Jupiter>
References: <200802161624.47003.bzolnier@gmail.com>
	 <20080216164912.GQ13446@gollum.tnic>
	 <200802161840.08209.bzolnier@gmail.com>
	 <20080216180938.GS13446@gollum.tnic>
Reply-To: debian@hispeed.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from viefep18-int.chello.at ([213.46.255.22]:55644 "EHLO
	viefep23-int.chello.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755718AbYBPT1Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Feb 2008 14:27:25 -0500
In-Reply-To: <20080216180938.GS13446@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Hi,


Le samedi 16 f=E9vrier 2008 =E0 19:09 +0100, Borislav Petkov a =E9crit =
:
> On Sat, Feb 16, 2008 at 06:40:08PM +0100, Bartlomiej Zolnierkiewicz w=
rote:
> > On Saturday 16 February 2008, Borislav Petkov wrote:
> > > On Sat, Feb 16, 2008 at 04:24:46PM +0100, Bartlomiej Zolnierkiewi=
cz wrote:
> > > >=20
> > > > [ added Borislav (ide-cd maintainer) to cc: ]
> > > >=20
> > > > Hi,
> > > >=20
> > > > Unless there are some very important reasons to keep the discus=
sion private
> > > > please always cc: linux-ide@ and/or linux-kernel@ ML when repor=
ting problems.
> > > >=20
> > > > Othewise your mail misses many knowledgeable people and is left=
 on mercy
> > > > of clueless IDE maintainer... ;-)


As I mentioned, the reason why I wrote to you directly is i'm not on th=
e
linux-ide mailing list.


Do you want me to try the 2.6.25-rc2 ? and give my feedback

> > > >=20
> > > > ----------  Forwarded Message  ----------
> > > >=20
> > > > Subject: IDE cdrom problem
> > > > Date: Saturday 16 February 2008
> > > > From: WaVeR <debian@hispeed.ch>
> > > > To: bzolnier@gmail.com
> > > >=20
> > > > Hello Bart,
> > > >=20
> > > > Sorry to distrub you, but I have a similar problem like this po=
st
> > > > http://lkml.org/lkml/2008/2/12/97
> > > >=20
> > > > I'm not subscribed to linux ML, so I decide to write you direct=
ly.
> > > >=20
> > > >=20
> > > > >From my dmesg, I get this error:
> > > >=20
> > > > Feb 16 08:01:58 Jupiter kernel: hdc: cdrom_pc_intr: The drive a=
ppears
> > > > confused (ireason =3D 0x01). Trying to recover by ending reques=
t.
> > > > Feb 16 08:06:16 Jupiter kernel: hdc: cdrom_pc_intr: The drive a=
ppears
> > > > confused (ireason =3D 0x01). Trying to recover by ending reques=
t.
> > > > Feb 16 08:10:45 Jupiter kernel: hdd: cdrom_pc_intr: The drive a=
ppears
> > > > confused (ireason =3D 0x01). Trying to recover by ending reques=
t.
> > > > Feb 16 08:37:41 Jupiter kernel: hdd: cdrom_pc_intr: The drive a=
ppears
> > > > confused (ireason =3D 0x01). Trying to recover by ending reques=
t.
> > > > Feb 16 08:42:10 Jupiter kernel: hdc: cdrom_pc_intr: The drive a=
ppears
> > > > confused (ireason =3D 0x01). Trying to recover by ending reques=
t.
> > > > Feb 16 09:00:07 Jupiter kernel: hdd: cdrom_pc_intr: The drive a=
ppears
> > > > confused (ireason =3D 0x01). Trying to recover by ending reques=
t.
> > >=20
> > > Yeah, this is kinda funny, i think i've seen that somewhere :) Bu=
t seriously,
> >=20
> > Yep, this looks to be the identical problem as discussed recently:
> >=20
> > http://www.mail-archive.com/linux-ide@vger.kernel.org/msg16131.html
> >=20
> > [ + IIRC the similar issue might be already in the kernel bugzilla.=
=2E. ]
> >=20
> > > can you try 2.6.25-rc2 - this one should be stable enough and it =
has the ide-cd
> > > rewrite in there and it would be interesting to see whether the n=
ew interrupt
> > > handler shows the same behaviour.
> > >=20
> > > Bart, since this starts to occur often, i'm thinking of adding a =
debugging macro
> > > similar to the ones we rewrote in ide-floppy and ide-tape besides=
 the
> > > CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS facility in ide-cd. What are =
your thoughts
> > > on the matter?
> >=20
> > I would rather prefer to see more code removal/unification in ide-c=
d.
>=20
> Yep, this is underway. Am working on removing the ide-cd internal buf=
fer and
> will get back to you after testing it... Ide floppy will have to wait=
=2E
> >=20
> > [ If the code is simple/clean enough and have informative printk()-=
s for
> >   error conditions there shouldn't be a frequent need for an extra =
debugging
> >   information. ]
> >=20
> > > > As you can see on the atached file. It's a simple IDE dvdrom an=
d a cd
> > > > burner.
> > > >=20
> > > > I dont have this problem with the kernel 2.6.21.3
> > > >=20
> > > > My actual kernel is:
> > > > 9:28 waver@Jupiter ~% uname -a
> > > > Linux Jupiter 2.6.24.2-waver.1 #1 Wed Feb 13 23:53:31 CET 2008 =
i686
> > > > GNU/Linux
> >=20
> > It would also help us if it can be narrowed down to the specific co=
mmit.
> > Please install git package, get kernel git tree from kernel.org, an=
d do:
> >=20
> > git bisect start
> > git bisect good 2.6.21
> > git bisect bad 2.6.24
>=20
> What would decrease the number of bisection iterations would be speci=
fying the
> path for bisection, like so:
>=20
> git bisect start -- drivers/ide
>=20
> and then we'll nail down the evildoer significantly faster, imho.
> >=20
> > It will select the kernel to test - compile and boot it to see if t=
he problem
> > is still there.  If so do "git bisect bad" which will give you new =
kernel
> > to test.  If the kernel works fine do "git bisect good" instead.  A=
fter few
> > iterations you should find the exact commit which introduced the bu=
g.
> >=20
> > Thanks,
> > Bart
>=20

