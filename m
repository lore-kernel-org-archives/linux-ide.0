From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: IDE cdrom problem with PLEXTOR DVDR PX-608AL
Date: Tue, 26 Feb 2008 18:46:30 +0100
Message-ID: <20080226174630.GB5497@gollum.tnic>
References: <426a98560802232138q41d45d52ta515f1b791e937f4@mail.gmail.com> <20080224173451.GB11998@gollum.tnic> <426a98560802241758j7a9be21m5eecc120ada804e4@mail.gmail.com> <20080225053404.GA3816@gollum.tnic> <426a98560802242157j61294ba6i2aaa9cce4d836a7b@mail.gmail.com> <20080225144519.GB3816@gollum.tnic> <426a98560802260032p61a81811i6b18c5f5b828ce56@mail.gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764132AbYBZRqw@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <426a98560802260032p61a81811i6b18c5f5b828ce56@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brad Rosser <brad.rosser@gmail.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, Feb 26, 2008 at 06:32:41PM +1000, Brad Rosser wrote:
Hi Brad,

> Hello Boris, Bart,
>=20
> On Tue, Feb 26, 2008 at 12:45 AM, Borislav Petkov
> <petkovbb@googlemail.com> wrote:
> >
> > On Mon, Feb 25, 2008 at 03:57:06PM +1000, Brad Rosser wrote:
> > >
> > > ... it would suggest the option 'hda=3Dnoprobe' was entered corre=
ctly?
> >
> >  ok, let's try something else: change the line "#if 0" to "#if 1" a=
t the
> >  beginning of kernel/params.c, it looks like:
> >
> >  #if 0
> >  #define DEBUGP printk
> >  #else
> >  #define DEBUGP(fmt, a...)
> >  #endif
> >
> >  rebuild your kernel, and reboot with it. Then, please send me that=
 boot log to
> >  see whether the kernel command line is being received from the boo=
t loader and
> >  what exactly is getting parsed. Thanks.
>=20
> Boris,  I've done that; the output is in attached file dmesg.debug.ou=
t.

it seems that your boot loader is not supplying the kernel with the boo=
t params
properly as can be seen from the excerpt below:

=2E..
Kernel command line: BOOT_IMAGE=3Dlinux_2.6.25rc2 ro root=3D900 md=3D0,=
/dev/sda5,/dev/sdb5 hda=3Dnoprobe
Parsing ARGS: BOOT_IMAGE=3Dlinux_2.6.25rc2 ro root=3D900 md=3D0,/dev/sd=
a5,/dev/sdb5 hda=3Dnoprobe
Unknown argument: calling c03670ce
Unknown argument: calling c03670ce
Unknown argument: calling c03670ce
Unknown argument: calling c03670ce
md: Will configure md0 (super-block) from /dev/sda5,/dev/sdb5, below.
Unknown argument: calling c03670ce
=2E..

and, as a result, the probing of hda still takes place.

> It looks to me that the kernel still found the IDE DVD drive (hda) ..=
=2E
> in addition
> to the system messages when the system was up I found the ide_cd_mod
> module loaded on top of 'cdrom' as normal.
>=20
> >  Please see whether you can apply the patch Bart just sent and if t=
hat still gets
> >  mangled and cannot be applied, consider making those changes to id=
e-cd.c by hand
> >  - after all, there are only several lines that need to be changed =
so it won't
> >  take that long.
>=20
> Bart, I was able to apply that patch file you attached with no proble=
ms, and the
> behaviour of the patched kernel changed as follows:
>=20
> - no more 'confused' messages, nor the rush of other critical message=
s
> that accompanied a system hang on one out of four tests yesterday.
>=20
> - However, a new message that popped up twice; once after a few secon=
ds
> of network activity, and then about 15-20 seconds afterwards:
>=20
> hda: ide_cd_check_ireason: wrong transfer direction!
> hda: ide_cd_check_ireason: wrong transfer direction!

Bart, can we assume here that some of the nic interrupts somehow get ha=
ndled by
ide-cd or something gets mixed up there?

> - also, I'm pretty sure that performance of both network and DVD driv=
e suffered.
>=20
> As to the last ... my new PC, on which I'm doing all this testing, ha=
s a gigabit
> Realtek NIC.  It's hooked up via null UTP cable to my older machine w=
hich has
> a 100Mb/s card.  ethtool shows that they both auto-negotiate to run a=
t 100Mb/s
> full duplex.  When I run my network test (pumping through /dev/zero a=
cross ssh
> from the old machine to the new) the network stats tell me that I'm g=
etting
> 10MB/s out of the link, which is what I would expect.
>=20
> With the patched 2.6.25-rc2 kernel running with no activity reading t=
he DVD
> but the network going flat out (on the old PC's end) I noted that I w=
as only
> getting only 8.0 or 8.1 MB/sec, rather than the 10 MB/sec I've seen i=
n the other
> tests..  There was no other network traffic or cpu load on the machin=
e(s).
>=20
> Then, when I mounted a DVD disc and did a 'wc /mnt/*' of its contents
> an iostat showed me that I was getting only about 6MB/sec out of the =
DVD
> drive, which is less than I'd expect.  As soon as I killed the networ=
k send
> iostat's report zoomed up to roughly 10MB/sec.  So it seemed to me th=
at,
> in addition to the 'wrong direction' messages, I was losing some perf=
ormance
> on both the NIC and the DVD drive.


--=20
Regards/Gru=DF,
    Boris.
