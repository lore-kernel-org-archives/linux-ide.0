From: Mark Lord <liml@rtr.ca>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Tue, 28 Feb 2006 20:04:29 -0500
Message-ID: <4404F31D.90407@rtr.ca>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <4401122A.3010908@rtr.ca>	 <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca>	 <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com>	 <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com>	 <44046CE6.60803@rtr.ca> <44046D86.7050809@pobox.com> <311601c90602280857x3f102af5l31c9a0ac1a896b4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:48256 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751103AbWCABEe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 20:04:34 -0500
In-Reply-To: <311601c90602280857x3f102af5l31c9a0ac1a896b4e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, David Greaves <david@dgreaves.com>, Tejun Heo <htejun@gmail.com>, Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>

Eric D. Mudama wrote:
> those drives should support all FUA opcodes properly, both queued and unqueued

His first drive (sda) does not support queued commands at all,
but the newer firmware in his second drive (sdb) does support NCQ.

Both drives support FUA.

cheers
