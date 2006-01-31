From: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>
Subject: Re: regarding bug #5914 - fs corruption on SATA
Date: Tue, 31 Jan 2006 09:39:41 +0100 (CET)
Message-ID: <5558.192.54.193.25.1138696781.squirrel@rousalka.dyndns.org>
References: <20060127081319.GU4311@suse.de>
    <65391.192.54.193.25.1138351983.squirrel@rousalka.dyndns.org>
    <20060127091002.GX4311@suse.de> <20060127092046.GY4311@suse.de>
    <58cb370e0601270146n40a5b249v53a736a8021c82f4@mail.gmail.com>
    <20060127095039.GA4311@suse.de>
    <1138390636.3017.2.camel@rousalka.dyndns.org>
    <1138406042.2953.0.camel@rousalka.dyndns.org>
    <20060130150843.GS4209@suse.de>
    <1138664026.3065.0.camel@rousalka.dyndns.org>
    <20060131072618.GH4215@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx.laposte.net ([81.255.54.11]:65275 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S1030370AbWAaIkI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Jan 2006 03:40:08 -0500
In-Reply-To: <20060131072618.GH4215@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Linux-ide <linux-ide@vger.kernel.org>


Le Mar 31 janvier 2006 08:26, Jens Axboe a =C3=A9crit :
> On Tue, Jan 31 2006, Nicolas Mailhot wrote:
>> Le lundi 30 janvier 2006 =C3=A0 16:08 +0100, Jens Axboe a =C3=A9crit=
 :
>> > On Sat, Jan 28 2006, Nicolas Mailhot wrote:
>> > > I can confirm today's patch is not OK. The same baseline with
>> > > yesterday's patch boot fine.
>> >
>> > Is this any better?
>>
>> This one seems to work fine.
>
> And you don't get "w/ FUA" messages from the problematic drives - and
> your data appears safe? Just checking, we cannot take these corruptio=
n
> things lightly.

I didn't spend a lot of time on this, the build finished rather late in
the evening/night. What I can say is the dramatic breakage I had before=
 is
gone and I don't think there was any error in dmesg (will post it this
evening if you want). With dm+raid when FUA broke things it was difficu=
lt
to miss (screenfulls of ATA/raid errors, fs corruption on reboot, etc)

Now if you ask me if I did some heavy I/O to stress the system no I did=
n't
yet. If problems still lurk they are a lot less extensive than they wer=
e
before. I did trigger a full FS autorelabel so at least the read part w=
as
tested a bit.

Regards,

--=20
Nicolas Mailhot

