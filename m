From: Jens Axboe <axboe@suse.de>
Subject: Re: regarding bug #5914 - fs corruption on SATA
Date: Tue, 31 Jan 2006 08:26:18 +0100
Message-ID: <20060131072618.GH4215@suse.de>
References: <20060127081319.GU4311@suse.de> <65391.192.54.193.25.1138351983.squirrel@rousalka.dyndns.org> <20060127091002.GX4311@suse.de> <20060127092046.GY4311@suse.de> <58cb370e0601270146n40a5b249v53a736a8021c82f4@mail.gmail.com> <20060127095039.GA4311@suse.de> <1138390636.3017.2.camel@rousalka.dyndns.org> <1138406042.2953.0.camel@rousalka.dyndns.org> <20060130150843.GS4209@suse.de> <1138664026.3065.0.camel@rousalka.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:4928 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030325AbWAaHYD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Jan 2006 02:24:03 -0500
Content-Disposition: inline
In-Reply-To: <1138664026.3065.0.camel@rousalka.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Linux-ide <linux-ide@vger.kernel.org>

On Tue, Jan 31 2006, Nicolas Mailhot wrote:
> Le lundi 30 janvier 2006 =E0 16:08 +0100, Jens Axboe a =E9crit :
> > On Sat, Jan 28 2006, Nicolas Mailhot wrote:
> > > I can confirm today's patch is not OK. The same baseline with
> > > yesterday's patch boot fine.
> >=20
> > Is this any better?
>=20
> This one seems to work fine.

And you don't get "w/ FUA" messages from the problematic drives - and
your data appears safe? Just checking, we cannot take these corruption
things lightly.

--=20
Jens Axboe

