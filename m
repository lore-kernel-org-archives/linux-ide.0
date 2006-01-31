From: Nicolas Mailhot <nicolas.mailhot@laposte.net>
Subject: Re: regarding bug #5914 - fs corruption on SATA
Date: Tue, 31 Jan 2006 23:54:09 +0100
Message-ID: <43DFEA91.9090405@laposte.net>
References: <20060127091002.GX4311@suse.de> <20060127092046.GY4311@suse.de> <58cb370e0601270146n40a5b249v53a736a8021c82f4@mail.gmail.com> <20060127095039.GA4311@suse.de> <1138390636.3017.2.camel@rousalka.dyndns.org> <1138406042.2953.0.camel@rousalka.dyndns.org> <20060130150843.GS4209@suse.de> <1138664026.3065.0.camel@rousalka.dyndns.org> <20060131072618.GH4215@suse.de> <5558.192.54.193.25.1138696781.squirrel@rousalka.dyndns.org> <20060131084736.GP4215@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx.laposte.net ([81.255.54.11]:56341 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S1750915AbWAaXAf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Jan 2006 18:00:35 -0500
In-Reply-To: <20060131084736.GP4215@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Linux-ide <linux-ide@vger.kernel.org>

Jens Axboe a =C3=A9crit :

> Sounds like it works, if you saw the errors so quickly.

Well you know while I was testing broken kernels the problem was more t=
o=20
keep the finger on reset on boot and act before too much damage was don=
e=20
rather than waiting for hard-to-spot symptoms. Seems root on md1+lvm is=
=20
very good to flush fua problems.

> Just trying to
> be absolutely sure, if you could check for the "w/ FUA" prints not be=
ing
> there now it would confirm that the blacklist does its job.

The patched kernel ran for a day without hiccups. I've attached its=20
demesg to the redhat bug - you can check if it's ok for you (yes I've=20
rebooted since and no it was not a ata problem - just you=20
run-of-the-mill rawhide xorg freeze)

https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=3D123941

Regards,

--=20
Nicolas Mailhot
