From: Mark Lord <liml@rtr.ca>
Subject: Re: Port Multiplier access with Sil 3124
Date: Mon, 09 Feb 2009 15:09:12 -0500
Message-ID: <49908D68.8060601@rtr.ca>
References: <498F42B6.8030607@tlinx.org> <87f94c370902090635h2fc3e604n990bdd70be9c48cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:35293 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752928AbZBIUJR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Feb 2009 15:09:17 -0500
In-Reply-To: <87f94c370902090635h2fc3e604n990bdd70be9c48cd@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Linda Walsh <lkml@tlinx.org>, linux-ide@vger.kernel.org

Greg Freemyer wrote:
> In my real world tests I've never seen a single drive achieve beyond
> about 80MB/sec.  (5GB/min is the way I actually measure it.  That was
> using SATA directly on the MB which I assume is as fast a PCIe.)
..

I have had spinning drives here that coulw achieve a simple linear
read rate of 112Mbytes/sec.

Any amount of seeking thrown in and that number drops a lot,
but that's the current max I know of.

There are SATA SSDs in the wild already that are *way* faster, though.

Cheers
