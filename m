From: Mark Rustad <mrustad@gmail.com>
Subject: Re: Why is NCQ enabled by default by libata? (2.6.20)
Date: Tue, 27 Mar 2007 13:18:05 -0500
Message-ID: <ACBD2F44-03C7-49BE-9A2F-ABF7078BCC5E@gmail.com>
References: <Pine.LNX.4.64.0703241232580.11608@p34.internal.lan> <4608B2B9.7090503@garzik.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=WINDOWS-1252;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:42706 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934144AbXC0SSK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Mar 2007 14:18:10 -0400
Received: by py-out-1112.google.com with SMTP id a29so1107485pyi
        for <linux-ide@vger.kernel.org>; Tue, 27 Mar 2007 11:18:09 -0700 (PDT)
In-Reply-To: <4608B2B9.7090503@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

On Mar 27, 2007, at 12:59 AM, Jeff Garzik wrote:

> Justin Piszcz wrote:
>> Without NCQ, performance is MUCH better on almost every operation, =20
>> with the exception of 2-3 items.
>
> Variables to take into account:
>
> * the drive (NCQ performance wildly varies)
> * the IO scheduler
> * the filesystem (if not measuring direct to blkdev)
> * application workload (or in your case, benchmark tool)
> 	* in particular, the threaded-ness of the apps
>
> For the overwhelming majority of combinations, NCQ should not /=20
> hurt/ performance.
>
> For the majority of combinations, NCQ helps (though it may not be =20
> often that you use more than 4-8 tags).
>
> In some cases, NCQ firmware may be broken.  There is a Maxtor =20
> firmware id, and some Hitachi ids that people are leaning towards =20
> recommending be added to the libata 'horkage' list.

Some other variables that we have noticed: Some drive firmware goes =20
into "stupid" mode when write cache is turned off. Meaning that it =20
does not reorder any queued operations. Of course if you really care =20
about your data, you don't really want to turn write cache on.

Also the controller used can have unfortunate interactions. For =20
example the Adaptec SAS controller firmware will never issue more =20
than two queued commands to a SATA drive (even though the firmware =20
will happily accept more from the driver), so even if an attached =20
drive is capable of reordering queued commands, its performance is =20
seriously crippled by not getting more commands queued up. In =20
addition, some drive firmware seems to try to bunch up queued command =20
completions which interacts very badly with a controller that queues =20
up so few commands. In this case turning NCQ off performs better =20
because the drive knows it can't hold off completions to reduce =20
interrupt load on the host =96 a good idea gone totally wrong when used=
 =20
with the Adaptec controller.

Today SATA NCQ seems to be an area where few combinations work well. =20
It seems so bad to me that a whitelist might be better than a =20
blacklist. That is probably overstating it, but NCQ performance is =20
certainly a big problem.

--=20
Mark Rustad, MRustad@gmail.com


