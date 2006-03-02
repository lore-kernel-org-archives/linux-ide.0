From: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>
Subject: Re: FUA and 311x (was Re: LibPATA code issues / 2.6.15.4)
Date: Thu, 2 Mar 2006 17:03:24 +0100 (CET)
Message-ID: <7080.192.54.193.25.1141315404.squirrel@rousalka.dyndns.org>
References: <1141239617.23202.5.camel@rousalka.dyndns.org>	
    <4405F471.8000602@rtr.ca>	
    <1141254762.11543.10.camel@rousalka.dyndns.org>	
    <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com>	
    <440650BC.5090501@pobox.com> <4406512A.9080708@pobox.com>
    <311601c90603011820u4fc89b04te1be39b9ed2ef35b@mail.gmail.com>
    <44065C7C.6090509@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:23700 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751993AbWCBQIP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Mar 2006 11:08:15 -0500
In-Reply-To: <44065C7C.6090509@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Eric D. Mudama" <edmudama@gmail.com>, Jens Axboe <axboe@suse.de>, Tejun Heo <htejun@gmail.com>, Nicolas Mailhot <nicolas.mailhot@gmail.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Carlos Pardo <carlos.pardo@siliconimage.com>


Le Jeu 2 mars 2006 03:46, Jeff Garzik a =C3=A9crit :
> Eric D. Mudama wrote:

> If its 3114 I agree un-blacklisting is the way to go... but its not
> clear to me whether the problematic configuration included sata_sil o=
r
> sata_nv.  Since I'm apparently blind :) which part of the bug points
> conclusively to sata_sil?

It's sata-sil
I'm 100% sure it's how I cabled the system
sata-nv only got a plextor drive attached
(pata-nv has two pata drives on too)


--=20
Nicolas Mailhot

