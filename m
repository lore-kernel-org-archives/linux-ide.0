From: Vincent Pelletier <plr.vincent@gmail.com>
Subject: Re: [PATCH] make ata_exec_internal_sg honor DMADIR
Date: Mon, 20 May 2013 12:51:20 +0200
Message-ID: <201305201251.20920.plr.vincent@gmail.com>
References: <CA+WQ+_13jrv6eKy7j5_Y8Tj0pvfnoWVWsb5JQtyttNONk84vKw@mail.gmail.com> <201305200820.05239.plr.vincent@gmail.com> <20130520073012.GA24222@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:54207 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228Ab3ETKvY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 May 2013 06:51:24 -0400
Received: by mail-wi0-f179.google.com with SMTP id hq7so1945365wib.0
        for <linux-ide@vger.kernel.org>; Mon, 20 May 2013 03:51:23 -0700 (PDT)
In-Reply-To: <20130520073012.GA24222@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Csaba =?iso-8859-1?q?Hal=E1sz?= <csaba.halasz@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Hello,

Le lundi 20 mai 2013 09:30:12, Tejun Heo a =E9crit :
> > Unplugging the drive would, in my understanding, loose the setting =
if
> > stored at the device level. Is there another way to trigger a new
> > initialisation attempt after changing the setting ?
> > Should I add a "rescan" device attribute ?
>=20
> But isn't that what we want?  We don't really know to which side the
> bridge is attached but given SATA supports hotplug while PATA doesn't=
,
> it's natural to assume the bridge to be part of the device rather tha=
n
> bus and reset the state on device hotplug, no?

Semantically, I agree that the bridge is part of the device.

Putting the knob on the port is just a way I thought about to hold the=20
configuration before the drive is plugged into the system (because so f=
ar I=20
was focussed on host-side being hot-pluggable, I indeed didn't consider=
 the=20
opposite situation) so it can be used before libata tries to access the=
=20
device.

So it would be something like:
- plug device (or boot up)
  -> detection times out, device "half" configured (sysfs node present,=
 drive
     not usable)
- cd $DEVICE_IN_SYSFS
- echo 1 > atapi_dmadir
- echo 1 > (rescan|reinit|...)

If it's ok, I'll write a patch to add a rescan write-only file (will al=
so be=20
independent from the 2 other patches).
I'll certainly need a few days to get it though: I feel I'll have some=20
difficulty finding the right function to call, and to call it correctly=
 (I=20
feel interrupt handler & locking, which I'm not familiar with at kernel=
=20
level). Pointers welcome !

Regards,
--=20
Vincent Pelletier
