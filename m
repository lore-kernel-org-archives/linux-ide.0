From: Mark Lord <liml@rtr.ca>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Tue, 28 Feb 2006 09:49:05 -0500
Message-ID: <440462E1.2010909@rtr.ca>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com> <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com> <44046074.4070201@rtr.ca> <Pine.LNX.4.64.0602280939280.16541@p34>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:45227 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751025AbWB1OtM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 09:49:12 -0500
In-Reply-To: <Pine.LNX.4.64.0602280939280.16541@p34>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>

Justin Piszcz wrote:
> Will your verbosity patch make it into 2.6.16-rcX?

I don't think so -- it was a bit of a hack to make the ATA opcode
visible at those points in the code.

The better approach might be to just have separate fields
for "command" and "status" in the ata tf.  With that, a much less
invasive patch could be prepared.

I can spin one quickly here if Jeff thinks it could
be gotten into 2.6.16.  Otherwise, I won't -- my code base
here is leagues behind the current libata-dev.

Cheers
