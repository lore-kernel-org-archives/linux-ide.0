From: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>
Subject: Re: regarding bug #5914 - fs corruption on SATA
Date: Fri, 27 Jan 2006 09:53:03 +0100 (CET)
Message-ID: <65391.192.54.193.25.1138351983.squirrel@rousalka.dyndns.org>
References: <20060126055050.GA4737@htj.dyndns.org>
    <43D8637F.5030207@gmail.com>
    <37416.192.54.193.25.1138266889.squirrel@rousalka.dyndns.org>
    <20060126092120.GP4212@suse.de>
    <5840.192.54.193.25.1138269692.squirrel@rousalka.dyndns.org>
    <1138309495.3968.3.camel@rousalka.dyndns.org>
    <20060127081319.GU4311@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx.laposte.net ([81.255.54.11]:2415 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S932424AbWA0JFM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jan 2006 04:05:12 -0500
In-Reply-To: <20060127081319.GU4311@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Linux-ide <linux-ide@vger.kernel.org>


Le Ven 27 janvier 2006 09:13, Jens Axboe a =C3=A9crit :
> On Thu, Jan 26 2006, Nicolas Mailhot wrote:
>> Le jeudi 26 janvier 2006 =C3=A0 11:01 +0100, Nicolas Mailhot a =C3=A9=
crit :
>> > Le Jeu 26 janvier 2006 10:21, Jens Axboe a =C3=A9crit :
>> > > On Thu, Jan 26 2006, Nicolas Mailhot wrote:
>> >
>> > >> What parts can be done one a pre-breakage kernel and what parts=
 on
>> a
>> > >> problem kernel (I ask this because a problem kernel will corrup=
t
>> > >> basically
>> > >> any file it writes to, even in single login mode the damage is
>> > >> significant
>> > >> so I need to limit the corruption window to minimum).
>> > >
>> > > You need a new kernel (after the barrier rework), so 2.6.16-rc1 =
for
>> > > instance.
>> >
>> > Ok, I'll do the test this evening (CET) with the rawhide/davej
>> kernel-of
>> > the day.
>>
>> I applied the fua backout patch and the kernel booted beautifully.
>> Now I guess I need to see if Maxtor released a fixed firmware right =
?
>> (is it possible to change the firmware on a running system ?)
>
> If you can get an update firmware, it is usually done by booting from
> DOS floppy and running a special flash utility from there. Can you se=
nd
> me the hdparm -I /dev/sdX output of the problem drive? I think we sho=
uld
> just blacklist it for FUA. This bug is so obscure I think it's a bett=
er
> solution than adding a FUA disable module parameter at this point.

There is already fairly complete smart info available in
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D177951
(https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=3D123604
https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=3D123605)

I'll add hdparm info this evening if it's not sufficient

Regards,

--=20
Nicolas Mailhot

