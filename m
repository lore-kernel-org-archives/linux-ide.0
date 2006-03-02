From: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>
Subject: Re: FUA and 311x (was Re: LibPATA code issues / 2.6.15.4)
Date: Thu, 2 Mar 2006 17:07:21 +0100 (CET)
Message-ID: <15004.192.54.193.25.1141315641.squirrel@rousalka.dyndns.org>
References: <1141239617.23202.5.camel@rousalka.dyndns.org>
    <4405F471.8000602@rtr.ca>
    <1141254762.11543.10.camel@rousalka.dyndns.org>
    <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com>
    <440650BC.5090501@pobox.com> <4406512A.9080708@pobox.com>
    <311601c90603011820u4fc89b04te1be39b9ed2ef35b@mail.gmail.com>
    <44065C7C.6090509@pobox.com>
    <311601c90603011900q7fe21fbx1020e4ba4062dc24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751999AbWCBQLP@vger.kernel.org>
In-Reply-To: <311601c90603011900q7fe21fbx1020e4ba4062dc24@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <axboe@suse.de>, Tejun Heo <htejun@gmail.com>, Nicolas Mailhot <nicolas.mailhot@gmail.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Carlos Pardo <carlos.pardo@siliconimage.com>
List-Id: linux-ide@vger.kernel.org


Le Jeu 2 mars 2006 04:00, Eric D. Mudama a =C3=A9crit :

> The "failing dmesg" has the plextor connected to sata_nv, and the two
> Maxtor drives connected to sata_sil, if I read it correctly.  They're
> ata5/ata6 ports, mapped as sda/sdb.
>
> Nicolas' comment in the thread "Re: LibPATA code issues / 2.6.15.4"
> seemed to say it was the same adapter:
>
> http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D114123989405668&w=3D=
2

Not only it's the same adapter model, but we're talking about the same
physical system. I opened the original boog, posted on lkml, etc

--=20
Nicolas Mailhot
