From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: IDE cdrom problem with PLEXTOR DVDR PX-608AL
Date: Fri, 15 Feb 2008 11:50:31 +0100
Message-ID: <20080215105031.GG13446@gollum.tnic>
References: <200802121026.17420.hpj@urpla.net> <200802140037.51450.hpj@urpla.net> <20080214062652.GE13446@gollum.tnic> <200802141324.06731.bzolnier@gmail.com> <9ea470500802140542m325f05bdq256d3578950e4240@mail.gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:60695 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759093AbYBOKuo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Feb 2008 05:50:44 -0500
Received: by wr-out-0506.google.com with SMTP id c48so988949wra.23
        for <linux-ide@vger.kernel.org>; Fri, 15 Feb 2008 02:50:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <9ea470500802140542m325f05bdq256d3578950e4240@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Boris Petkov <petkovbb@googlemail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Hans-Peter Jansen <hpj@urpla.net>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thu, Feb 14, 2008 at 02:42:58PM +0100, Boris Petkov wrote:
> On 2/14/08, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > On Thursday 14 February 2008, Borislav Petkov wrote:
> > > On Thu, Feb 14, 2008 at 12:37:50AM +0100, Hans-Peter Jansen wrote=
:
> > >
> > > [Added Bart to CC]
> > >
> > > > Am Dienstag, 12. Februar 2008 schrieb Borislav Petkov:
> > > > > On Tue, Feb 12, 2008 at 10:26:17AM +0100, Hans-Peter Jansen w=
rote:
> > > > > > Hi,
> > > > > >
> > > > > > I suffer from unreliable cdrom operations (failing DAE and =
burn
> > > > > > sessions) with the openSUSE 2.6.18.8-0.7-bigsmp kernel.
> > > > >
> > > > >                   ^^^^
> > > > > Hi,
> > > > >
> > > > > can please you test this with a more recent kernel. Yours is =
almost
> > > > > ancient - from Sep. 2006.
> > > >
> > > > Sure, sorry. Here we go:
> > > >
> > > > Feb 14 00:18:18 kernel: hde: cdrom_pc_intr: The drive appears c=
onfused (ireason =3D 0x01).
> > > >  Trying to recover by ending request.
> > > > Feb 14 00:27:27 kernel: hdc: cdrom_pc_intr: The drive appears c=
onfused (ireason =3D 0x01).
> > > >  Trying to recover by ending request.
> > > >
> > > > ~> uname -a
> > > > Linux xrated 2.6.24.1-35-pae #1 SMP 2008/02/12 01:00:18 UTC i68=
6 athlon i386 GNU/Linux
> > >
> > > Actually the interrupt handler in ide-cd got rewritten and you're=
 still using the
> > > old one (cdrom_pc_intr vs cdrom_newpc_intr). Those changes went i=
nto mainline before
> > > the 2.6.25-rc1 so we'll be able to test the new one only when you=
 try out 2.6.25-rc1
> > > or wait until 2.6.25 is released in case you don't want to try ha=
zardous materials
> > > such as an -rc kernel[*] :).
> > >
> > > Bart?
> > >
> > > *. As a matter of fact it runs quite smoothly on my machines.
> >
> > 2.6.25-rc1-git1 if you are using IDE.
> >
> > however it may still have this problem
> >
> >        if (ireason =3D=3D 0) {
> >                write =3D 1;
> >                xferfunc =3D HWIF(drive)->atapi_output_bytes;
> >        } else if (ireason =3D=3D 2 || (ireason =3D=3D 1 &&
> >                   (blk_fs_request(rq) || blk_pc_request(rq)))) {
> >
> > we problably need to call ide_cd_check_ireason() also for REQ_TYPE_=
ATA_PC
> > requests and remove (blk_fs_request(rq) || blk_pc_request(rq) here
> >
> >                write =3D 0;
> >                xferfunc =3D HWIF(drive)->atapi_input_bytes;
> >        } else {
> >                printk(KERN_ERR "%s: %s: The drive "
> >                                "appears confused (ireason =3D 0x%02=
x). "
> >                                "Trying to recover by ending request=
=2E\n",
> >                                drive->name, __FUNCTION__, ireason);
> >                goto end_request;
> >        }
> >
> > Bart
> >
> Hans-Peter,
>=20
> i will prepare a patch against 2.6.24 for you to try later.
Hi,

i thought that backporting ide-cd to 2.6.24 would be self-contained but=
 the
problem is that it pulls in changes made in the block layer (ll_rw_blk.=
c splitup)
and if i pull those also in the patch, i can't guarantee the stability =
of your
system. Besides, this turns pretty fast into a chained pulling which wi=
ll result
into a subset of 2.6.25-rc1 applied ontop of your 2.6.24.1 kernel so th=
e only
alternative is to wait after 2.6.25 has been released and tackle the pr=
oblem then.

--=20
Regards/Gru=DF,
    Boris.
