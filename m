From: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>
Subject: Re: FUA and 311x (was Re: LibPATA code issues / 2.6.15.4)
Date: Thu, 2 Mar 2006 16:59:43 +0100 (CET)
Message-ID: <65320.192.54.193.25.1141315183.squirrel@rousalka.dyndns.org>
References: <1141239617.23202.5.camel@rousalka.dyndns.org>	
    <4405F471.8000602@rtr.ca>	
    <1141254762.11543.10.camel@rousalka.dyndns.org>
    <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com>
    <440650BC.5090501@pobox.com> <4406512A.9080708@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751992AbWCBQGc@vger.kernel.org>
In-Reply-To: <4406512A.9080708@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, "Eric D. Mudama" <edmudama@gmail.com>, Tejun Heo <htejun@gmail.com>, Nicolas Mailhot <nicolas.mailhot@gmail.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Carlos Pardo <carlos.pardo@siliconimage.com>
List-Id: linux-ide@vger.kernel.org


Le Jeu 2 mars 2006 02:58, Jeff Garzik a =C3=A9crit :
> Jeff Garzik wrote:
>> For libata, I think an ATA_FLAG_NO_FUA would be appropriate for
>> situations like this...  assume FUA is supported in the controller, =
and
>> set a flag where it is not.  Most chips will support FUA, either by
>> design or by sheer luck.  The ones that do not support FUA are the
>> controllers that snoop the ATA command opcode, and internally choose=
 the
>> protocol based on that opcode.  For such hardware, unknown opcodes w=
ill
>> inevitably cause problems.
>
> This also begs the question... what controller was being used, when t=
he
> single Maxtor device listed in the blacklist was added?  Perhaps it w=
as
> a problem with the controller, not the device.

The controller in the bugzilla entry ie a SiI 3114.
It was a quick fix and I did expect more thorough investigation later
(probably 2.6.17 frame). Though it seems FUA-related problems are so
numerous FUA itself will be blacklisted for 2.6.16, so the limited
blacklist is no longer needed.

The thread leading to the blacklist is referenced in the bugzilla entry

--=20
Nicolas Mailhot
