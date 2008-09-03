From: Cal Peake <cp@absolutedigital.net>
Subject: Re: ATA bus error - SError: { RecovData HostInt Handshk }
Date: Wed, 3 Sep 2008 07:17:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0809030708300.6945@lancer.cnet.absolutedigital.net>
References: <Pine.LNX.4.64.0809022036390.17666@lancer.cnet.absolutedigital.net>
 <20080903083120.GA2471@psychosis.jim.sh>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from livid.absolutedigital.net ([66.92.46.173]:35912 "EHLO
	mx2.absolutedigital.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbYICLR1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Sep 2008 07:17:27 -0400
In-Reply-To: <20080903083120.GA2471@psychosis.jim.sh>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Paris <jim@jtan.com>
Cc: Kernel IDE Mailing List <linux-ide@vger.kernel.org>

On Wed, 3 Sep 2008, Jim Paris wrote:

> Cal Peake wrote:
> > Hello!
> > 
> > I'm getting the error below on this new system I've built. It appears 
> > sporadicly under heavy drive access (there are six drives on this 
> > controller, has appeared for each one at one point or another). If someone 
> > has a second to take a look I'd appreciate any help.
> ..
> > ata1.00: ATA-8: ST31000340AS, SD15, max UDMA/133
> 
> We ran into similar problems on two different systems we were setting
> up with those same disks.  We swapped power supplies and SATA cables
> and controllers but nothing made the problems go away fully.
> Eventually we replaced the jumper on the back of the disk limiting it
> to 1.5 Gbps and have not had any problems since.

Yeah, I've already swapped the power supply and the cables. The controller 
would be a pain since it's part of the motherboard so didn't try that yet. 
I guess if it really comes to it I can put the jumpers back on but what a 
sad way to fix things. Thanks for sharing your experience, Jim!


-- 
Cal Peake

