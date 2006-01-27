From: Jens Axboe <axboe@suse.de>
Subject: Re: regarding bug #5914 - fs corruption on SATA
Date: Fri, 27 Jan 2006 09:13:19 +0100
Message-ID: <20060127081319.GU4311@suse.de>
References: <20060126055050.GA4737@htj.dyndns.org> <43D8637F.5030207@gmail.com> <37416.192.54.193.25.1138266889.squirrel@rousalka.dyndns.org> <20060126092120.GP4212@suse.de> <5840.192.54.193.25.1138269692.squirrel@rousalka.dyndns.org> <1138309495.3968.3.camel@rousalka.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:45075 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750752AbWA0IYP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Jan 2006 03:24:15 -0500
Content-Disposition: inline
In-Reply-To: <1138309495.3968.3.camel@rousalka.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Linux-ide <linux-ide@vger.kernel.org>

On Thu, Jan 26 2006, Nicolas Mailhot wrote:
> Le jeudi 26 janvier 2006 =E0 11:01 +0100, Nicolas Mailhot a =E9crit :
> > Le Jeu 26 janvier 2006 10:21, Jens Axboe a =E9crit :
> > > On Thu, Jan 26 2006, Nicolas Mailhot wrote:
> >=20
> > >> What parts can be done one a pre-breakage kernel and what parts =
on a
> > >> problem kernel (I ask this because a problem kernel will corrupt
> > >> basically
> > >> any file it writes to, even in single login mode the damage is
> > >> significant
> > >> so I need to limit the corruption window to minimum).
> > >
> > > You need a new kernel (after the barrier rework), so 2.6.16-rc1 f=
or
> > > instance.
> >=20
> > Ok, I'll do the test this evening (CET) with the rawhide/davej kern=
el-of
> > the day.
>=20
> I applied the fua backout patch and the kernel booted beautifully.
> Now I guess I need to see if Maxtor released a fixed firmware right ?
> (is it possible to change the firmware on a running system ?)

If you can get an update firmware, it is usually done by booting from
DOS floppy and running a special flash utility from there. Can you send
me the hdparm -I /dev/sdX output of the problem drive? I think we shoul=
d
just blacklist it for FUA. This bug is so obscure I think it's a better
solution than adding a FUA disable module parameter at this point.

--=20
Jens Axboe

