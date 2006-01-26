From: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>
Subject: Re: regarding bug #5914 - fs corruption on SATA
Date: Thu, 26 Jan 2006 11:01:29 +0100 (CET)
Message-ID: <5840.192.54.193.25.1138269689.squirrel@rousalka.dyndns.org>
References: <20060126055050.GA4737@htj.dyndns.org>
    <43D8637F.5030207@gmail.com>
    <37416.192.54.193.25.1138266889.squirrel@rousalka.dyndns.org>
    <20060126092120.GP4212@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx.laposte.net ([81.255.54.11]:29771 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S932252AbWAZKDX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 05:03:23 -0500
In-Reply-To: <20060126092120.GP4212@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Linux-ide <linux-ide@vger.kernel.org>


Le Jeu 26 janvier 2006 10:21, Jens Axboe a =C3=A9crit :
> On Thu, Jan 26 2006, Nicolas Mailhot wrote:

>> What parts can be done one a pre-breakage kernel and what parts on a
>> problem kernel (I ask this because a problem kernel will corrupt
>> basically
>> any file it writes to, even in single login mode the damage is
>> significant
>> so I need to limit the corruption window to minimum).
>
> You need a new kernel (after the barrier rework), so 2.6.16-rc1 for
> instance.

Ok, I'll do the test this evening (CET) with the rawhide/davej kernel-o=
f
the day.

Regards,

--=20
Nicolas Mailhot

