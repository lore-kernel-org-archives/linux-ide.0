From: Jens Axboe <axboe@suse.de>
Subject: Re: regarding bug #5914 - fs corruption on SATA
Date: Fri, 27 Jan 2006 10:10:03 +0100
Message-ID: <20060127091002.GX4311@suse.de>
References: <20060126055050.GA4737@htj.dyndns.org> <43D8637F.5030207@gmail.com> <37416.192.54.193.25.1138266889.squirrel@rousalka.dyndns.org> <20060126092120.GP4212@suse.de> <5840.192.54.193.25.1138269692.squirrel@rousalka.dyndns.org> <1138309495.3968.3.camel@rousalka.dyndns.org> <20060127081319.GU4311@suse.de> <65391.192.54.193.25.1138351983.squirrel@rousalka.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:48974 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932430AbWA0JOF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Jan 2006 04:14:05 -0500
Content-Disposition: inline
In-Reply-To: <65391.192.54.193.25.1138351983.squirrel@rousalka.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Linux-ide <linux-ide@vger.kernel.org>

On Fri, Jan 27 2006, Nicolas Mailhot wrote:
>=20
> Le Ven 27 janvier 2006 09:13, Jens Axboe a =E9crit :
> > On Thu, Jan 26 2006, Nicolas Mailhot wrote:
> >> Le jeudi 26 janvier 2006 =E0 11:01 +0100, Nicolas Mailhot a =E9cri=
t :
> >> > Le Jeu 26 janvier 2006 10:21, Jens Axboe a =E9crit :
> >> > > On Thu, Jan 26 2006, Nicolas Mailhot wrote:
> >> >
> >> > >> What parts can be done one a pre-breakage kernel and what par=
ts on
> >> a
> >> > >> problem kernel (I ask this because a problem kernel will corr=
upt
> >> > >> basically
> >> > >> any file it writes to, even in single login mode the damage i=
s
> >> > >> significant
> >> > >> so I need to limit the corruption window to minimum).
> >> > >
> >> > > You need a new kernel (after the barrier rework), so 2.6.16-rc=
1 for
> >> > > instance.
> >> >
> >> > Ok, I'll do the test this evening (CET) with the rawhide/davej
> >> kernel-of
> >> > the day.
> >>
> >> I applied the fua backout patch and the kernel booted beautifully.
> >> Now I guess I need to see if Maxtor released a fixed firmware righ=
t ?
> >> (is it possible to change the firmware on a running system ?)
> >
> > If you can get an update firmware, it is usually done by booting fr=
om
> > DOS floppy and running a special flash utility from there. Can you =
send
> > me the hdparm -I /dev/sdX output of the problem drive? I think we s=
hould
> > just blacklist it for FUA. This bug is so obscure I think it's a be=
tter
> > solution than adding a FUA disable module parameter at this point.
>=20
> There is already fairly complete smart info available in
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D177951
> (https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=3D123604
> https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=3D123605)

I didn't notice the smart info, yes that holds enough information.
Thanks!

--=20
Jens Axboe

