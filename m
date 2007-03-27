From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Why is NCQ enabled by default by libata? (2.6.20)
Date: Tue, 27 Mar 2007 14:38:50 -0400
Message-ID: <460964BA.8090101@garzik.org>
References: <Pine.LNX.4.64.0703241232580.11608@p34.internal.lan> <4608B2B9.7090503@garzik.org> <ACBD2F44-03C7-49BE-9A2F-ABF7078BCC5E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38151 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934167AbXC0Six (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Mar 2007 14:38:53 -0400
In-Reply-To: <ACBD2F44-03C7-49BE-9A2F-ABF7078BCC5E@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Rustad <mrustad@gmail.com>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Rustad wrote:
> reorder any queued operations. Of course if you really care about you=
r=20
> data, you don't really want to turn write cache on.

That's a gross exaggeration.  FLUSH CACHE and FUA both ensure data=20
integrity as well.

Turning write cache off has always been a performance-killing action on=
 ATA.


> Also the controller used can have unfortunate interactions. For examp=
le=20
> the Adaptec SAS controller firmware will never issue more than two=20
> queued commands to a SATA drive (even though the firmware will happil=
y=20
> accept more from the driver), so even if an attached drive is capable=
 of=20
> reordering queued commands, its performance is seriously crippled by =
not=20
> getting more commands queued up. In addition, some drive firmware see=
ms=20
> to try to bunch up queued command completions which interacts very ba=
dly=20
> with a controller that queues up so few commands. In this case turnin=
g=20
> NCQ off performs better because the drive knows it can't hold off=20
> completions to reduce interrupt load on the host =96 a good idea gone=
=20
> totally wrong when used with the Adaptec controller.

All of that can be fixed with an Adaptec firmware upgrade, so not our=20
problem here, and not a reason to disable NCQ in libata core.


> Today SATA NCQ seems to be an area where few combinations work well. =
It=20
> seems so bad to me that a whitelist might be better than a blacklist.=
=20
> That is probably overstating it, but NCQ performance is certainly a b=
ig=20
> problem.

Real world testing disagrees with you.  NCQ has been enabled for a whil=
e=20
now.  We would have screaming hordes of users if the majority of=20
configurations were problematic.

	Jeff


