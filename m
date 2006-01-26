From: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>
Subject: Re: regarding bug #5914 - fs corruption on SATA
Date: Thu, 26 Jan 2006 10:14:49 +0100 (CET)
Message-ID: <37416.192.54.193.25.1138266889.squirrel@rousalka.dyndns.org>
References: <20060126055050.GA4737@htj.dyndns.org>
    <43D8637F.5030207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx.laposte.net ([81.255.54.11]:15248 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S932138AbWAZJQF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 04:16:05 -0500
In-Reply-To: <43D8637F.5030207@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <axboe@suse.de>, Linux-ide <linux-ide@vger.kernel.org>


Le Jeu 26 janvier 2006 06:51, Tejun Heo a =C3=A9crit :
> Tejun Heo wrote:
>> Hello, Nicolas.  Hello, all.

Hi

>> Nicolas, I'm probably the guy who broke your filesystem.  :-p This F=
UA
>> (forced-unit-access)thing made into the mainline lately, and it seem=
s
>> that your drive is reporting FUA support but doesn't really do it
>> properly when it's asked to.
>>
>> Can you try the followings to verify the problem?
>>
>> 1. make a small partition on the affected drive and do mkfs.ext3 on =
it.
>> 2. mount -o barrier new_partition /mnt/tmp
>
> This should be 'mount -o barrier=3D1 new_partition /mnt/tmp'
>
>> 3. cd /mnt/tmp; touch asdf; sync

What parts can be done one a pre-breakage kernel and what parts on a
problem kernel (I ask this because a problem kernel will corrupt basica=
lly
any file it writes to, even in single login mode the damage is signific=
ant
so I need to limit the corruption window to minimum).

Also I have plenty of space to create partitions but that will be
lvm-on-md-raid1 space (don't know if it matters, if it does I need to
learn to shrink the lvm/md)

Regards,

BTW what's FUA in semi-layman terms ?

--=20
Nicolas Mailhot

