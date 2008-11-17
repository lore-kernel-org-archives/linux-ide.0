From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv, io stucks
Date: Mon, 17 Nov 2008 00:22:29 -0500
Message-ID: <4920FF95.1080808@rtr.ca>
References: <48F88449.1000704@ngs.ru> <49003B9C.1010303@ngs.ru> <4900A12F.3030307@rtr.ca> <491EE84B.1010600@gmail.com> <491F4096.9090701@rtr.ca> <491F5E42.8010906@gmail.com> <491FA4D8.1010708@rtr.ca> <491FA8C0.2090804@rtr.ca> <alpine.DEB.1.10.0811160412080.27319@p34.internal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:41549 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750783AbYKQFVi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Nov 2008 00:21:38 -0500
In-Reply-To: <alpine.DEB.1.10.0811160412080.27319@p34.internal.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Harri Olin <harri.olin@gmail.com>, linux-ide@vger.kernel.org, Artem Bokhan <aptem@ngs.ru>

Justin Piszcz wrote:
> ..
> As I mentioned earlier, it happens on all of my drives, 4 of 12 disks 
> are connected to a Marvell controller, in my case:
> 
> 01:00.0 SCSI storage controller: Marvell Technology Group Ltd. 88SX7042 
> PCI-e 4-port SATA-II (rev 02)
..

Whatever problem you are seeing is likely different from what the
others see.  The 7042 is a much newer rev of the chipset, with a lot
less in the way of errata and stuff to go wrong.

So, yes, you're apparently seeing some problems, but there's nothing
to suggest that those are the *same* problems as the 6081 users are seeing.

Cheers
