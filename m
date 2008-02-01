From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: kernel BUG at ide-cd.c:1726 in 2.6.24-03863-g0ba6c33 &&
	-g8561b089
Date: Fri, 1 Feb 2008 08:51:17 +0100
Message-ID: <20080201075117.GC4500@gollum.tnic>
References: <ab418ea90801302349u945788jeed1f42021801dbf@mail.gmail.com> <20080131130558.GV15220@kernel.dk> <20080131213740.GA4500@gollum.tnic> <20080131.173556.38717303.k-ueda@ct.jp.nec.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.227]:44141 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935476AbYBAHw4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Feb 2008 02:52:56 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1375173wxd.4
        for <linux-ide@vger.kernel.org>; Thu, 31 Jan 2008 23:52:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20080131.173556.38717303.k-ueda@ct.jp.nec.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Cc: jens.axboe@oracle.com, nai.xia@gmail.com, rdreier@cisco.com, bzolnier@gmail.com, flo@rfc822.org, linux-kernel@vger.kernel.org, j-nomura@ce.jp.nec.com, linux-ide@vger.kernel.org

On Thu, Jan 31, 2008 at 05:35:56PM -0500, Kiyoshi Ueda wrote:
> Hi Boris,
>=20
> Thank you for the confirmation of original behavior.
>=20
> On Thu, 31 Jan 2008 22:37:40 +0100, Borislav Petkov wrote:
> > On Thu, Jan 31, 2008 at 02:05:58PM +0100, Jens Axboe wrote:
> > > On Thu, Jan 31 2008, Nai Xia wrote:
> > > > My dmesg relevant info is quite similar:
> > > >=20
> > > > [    6.875041] Freeing unused kernel memory: 320k freed
> > > > [    8.143120] ide-cd: rq still having bio: dev hdc: type=3D2, =
flags=3D114c8
> > > > [    8.144439]
> > > > [    8.144439] sector 10824201199534213, nr/cnr 0/0
> > > > [    8.144439] bio cf029280, biotail cf029280, buffer 00000000,=
 data
> > > > 00000000, len 158
> > > > [    8.144439] cdb: 12 00 00 00 fe 00 00 00 00 00 00 00 00 00 0=
0 00
> > > > [    8.144439] backup: data_len=3D158  bi_size=3D158
> > > > [    8.160756] ide-cd: rq still having bio: dev hdc: type=3D2, =
flags=3D114c8
> > > > [    8.160756]
> > > > [    8.160756] sector 2669858, nr/cnr 0/0
> > > > [    8.160756] bio cf029300, biotail cf029300, buffer 00000000,=
 data
> > > > 00000000, len 158
> > > > [    8.160756] cdb: 12 01 00 00 fe 00 00 00 00 00 00 00 00 00 0=
0 00
> > > > [    8.160756] backup: data_len=3D158  bi_size=3D158
> > > > [   14.851101] eth0: link up
> > > > [   27.121883] eth0: no IPv6 routers present
> > > >=20
> > > >=20
> > > > And by the way, Kiyoshi,
> > > > This can be reproduced in a typical setup vmware workstation 6.=
02 with
> > > > a vritual IDE cdrom,
> > > > in case you wanna catch that with your own eyes. :-)
> > > > Thanks for your trying hard to correct this annoying bug.
> > >=20
> > > The below fix should be enough. It's perfectly legal to have left=
over
> > > byte counts when the drive signals completion, happens all the ti=
me for
> > > eg user issued commands where you don't know an exact byte count.
> >=20
> > Actually, this behavior has been the case even before the __blk_end=
_request()
> > changes. I did test plain 2.6.24 with the following
> >=20
> >=20
> > --- linux-2.6/drivers/ide/ide-cd.c	2008-01-31 22:18:59.000000000 +0=
100
> > +++ linux-2.6/drivers/ide/ide-cd.c-new	2008-01-31 22:18:50.00000000=
0 +0100
> > @@ -1711,8 +1711,12 @@ static ide_startstop_t cdrom_newpc_intr(
> >  	/*
> >  	 * If DRQ is clear, the command has completed.
> >  	 */
> > -	if ((stat & DRQ_STAT) =3D=3D 0)
> > +	if ((stat & DRQ_STAT) =3D=3D 0) {
> > +		blk_dump_rq_flags(rq, "ide-cd: rq still having bio");
> > +		printk("backup: data_len=3D%u  bi_size=3D%u\n",
> > +				rq->data_len, rq->bio->bi_size);
> >  		goto end_request;
> > +	}
> > =20
> >  	/*
> >  	 * check which way to transfer data
> >=20
> >=20
> > to see whether we've been getting residual byte counts:
> >=20
> > Jan 31 22:10:06 gollum kernel: [   26.702877] ide-cd: rq still havi=
ng bio: dev hdc: type=3D2, flags=3D114c8
> > Jan 31 22:10:06 gollum kernel: [   26.702945]
> > Jan 31 22:10:06 gollum kernel: [   26.702946] sector 2673511, nr/cn=
r 0/0
> > Jan 31 22:10:06 gollum kernel: [   26.703052] bio dfa8ec40, biotail=
 dfa8ec40, buffer 00000000, data 00000000, len 158
> > Jan 31 22:10:06 gollum kernel: [   26.703122] cdb: 12 00 00 00 fe 0=
0 00 00 00 00 00 00 00 00 00 00
> > Jan 31 22:10:06 gollum kernel: [   26.703877] backup: data_len=3D15=
8  bi_size=3D158
> >=20
> > ... so we've been simply silently ignoring this until now so i gues=
s we don't
> > need to BUG() for something that's totally benign.

Hi Kiyoshi,
=20
> end_that_request_last() is not called when __blk_end_reuqest()
> returns 1.  Then, the issuer isn't waken up.
> So I think the BUG() or error messages should be there.

you mean, end_that_request_last() isn't called when __end_that_request_=
first()
returns an error and this is the case only for fs and pc requests. Othe=
rwise it
_is_ called, thus simulating somewhat the previous behavior. However, w=
e never BUG()'ged
on residual byte counts before and this driver has been in the kernel t=
ree for
ages, so what puzzles me now is how is BUG()'ing here better than befor=
e and
shouldn't we simply issue a warning instead of killing the interrupt ha=
ndler...

=2E.or am i missing something?

--=20
Regards/Gru=DF,
    Boris.
