From: Jens Axboe <axboe@suse.de>
Subject: Re: regarding bug #5914 - fs corruption on SATA
Date: Thu, 26 Jan 2006 10:21:20 +0100
Message-ID: <20060126092120.GP4212@suse.de>
References: <20060126055050.GA4737@htj.dyndns.org> <43D8637F.5030207@gmail.com> <37416.192.54.193.25.1138266889.squirrel@rousalka.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:14683 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932139AbWAZJTY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Jan 2006 04:19:24 -0500
Content-Disposition: inline
In-Reply-To: <37416.192.54.193.25.1138266889.squirrel@rousalka.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Linux-ide <linux-ide@vger.kernel.org>

On Thu, Jan 26 2006, Nicolas Mailhot wrote:
>=20
> Le Jeu 26 janvier 2006 06:51, Tejun Heo a =E9crit :
> > Tejun Heo wrote:
> >> Hello, Nicolas.  Hello, all.
>=20
> Hi
>=20
> >> Nicolas, I'm probably the guy who broke your filesystem.  :-p This=
 FUA
> >> (forced-unit-access)thing made into the mainline lately, and it se=
ems
> >> that your drive is reporting FUA support but doesn't really do it
> >> properly when it's asked to.
> >>
> >> Can you try the followings to verify the problem?
> >>
> >> 1. make a small partition on the affected drive and do mkfs.ext3 o=
n it.
> >> 2. mount -o barrier new_partition /mnt/tmp
> >
> > This should be 'mount -o barrier=3D1 new_partition /mnt/tmp'
> >
> >> 3. cd /mnt/tmp; touch asdf; sync
>=20
> What parts can be done one a pre-breakage kernel and what parts on a
> problem kernel (I ask this because a problem kernel will corrupt basi=
cally
> any file it writes to, even in single login mode the damage is signif=
icant
> so I need to limit the corruption window to minimum).

You need a new kernel (after the barrier rework), so 2.6.16-rc1 for
instance.

> Also I have plenty of space to create partitions but that will be
> lvm-on-md-raid1 space (don't know if it matters, if it does I need to
> learn to shrink the lvm/md)

It would be best to exclude lvm/md for now, but I can see it might not
be so easy for you...

> BTW what's FUA in semi-layman terms ?

It stands for Forced Unit Access, basically a way to force the drive to
write through the cache directly to platter even when write back cachin=
g
is enabled. Or just bypass the cache on a read, but we use it for write=
s
with the barrier stuff.

--=20
Jens Axboe

