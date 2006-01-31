From: Jens Axboe <axboe@suse.de>
Subject: Re: regarding bug #5914 - fs corruption on SATA
Date: Tue, 31 Jan 2006 09:47:36 +0100
Message-ID: <20060131084736.GP4215@suse.de>
References: <20060127091002.GX4311@suse.de> <20060127092046.GY4311@suse.de> <58cb370e0601270146n40a5b249v53a736a8021c82f4@mail.gmail.com> <20060127095039.GA4311@suse.de> <1138390636.3017.2.camel@rousalka.dyndns.org> <1138406042.2953.0.camel@rousalka.dyndns.org> <20060130150843.GS4209@suse.de> <1138664026.3065.0.camel@rousalka.dyndns.org> <20060131072618.GH4215@suse.de> <5558.192.54.193.25.1138696781.squirrel@rousalka.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:25349 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750733AbWAaIqD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Jan 2006 03:46:03 -0500
Content-Disposition: inline
In-Reply-To: <5558.192.54.193.25.1138696781.squirrel@rousalka.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Linux-ide <linux-ide@vger.kernel.org>

On Tue, Jan 31 2006, Nicolas Mailhot wrote:
>=20
> Le Mar 31 janvier 2006 08:26, Jens Axboe a =E9crit :
> > On Tue, Jan 31 2006, Nicolas Mailhot wrote:
> >> Le lundi 30 janvier 2006 =E0 16:08 +0100, Jens Axboe a =E9crit :
> >> > On Sat, Jan 28 2006, Nicolas Mailhot wrote:
> >> > > I can confirm today's patch is not OK. The same baseline with
> >> > > yesterday's patch boot fine.
> >> >
> >> > Is this any better?
> >>
> >> This one seems to work fine.
> >
> > And you don't get "w/ FUA" messages from the problematic drives - a=
nd
> > your data appears safe? Just checking, we cannot take these corrupt=
ion
> > things lightly.
>=20
> I didn't spend a lot of time on this, the build finished rather late
> in the evening/night. What I can say is the dramatic breakage I had
> before is gone and I don't think there was any error in dmesg (will
> post it this evening if you want). With dm+raid when FUA broke things
> it was difficult to miss (screenfulls of ATA/raid errors, fs
> corruption on reboot, etc)
>=20
> Now if you ask me if I did some heavy I/O to stress the system no I
> didn't yet. If problems still lurk they are a lot less extensive than
> they were before. I did trigger a full FS autorelabel so at least the
> read part was tested a bit.

Sounds like it works, if you saw the errors so quickly. Just trying to
be absolutely sure, if you could check for the "w/ FUA" prints not bein=
g
there now it would confirm that the blacklist does its job.

--=20
Jens Axboe

