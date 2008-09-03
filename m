From: Jim Paris <jim@jtan.com>
Subject: Re: ATA bus error - SError: { RecovData HostInt Handshk }
Date: Wed, 3 Sep 2008 04:31:20 -0400
Message-ID: <20080903083120.GA2471@psychosis.jim.sh>
References: <Pine.LNX.4.64.0809022036390.17666@lancer.cnet.absolutedigital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a.jim.sh ([75.150.123.25]:51213 "EHLO psychosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271AbYICIqd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Sep 2008 04:46:33 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0809022036390.17666@lancer.cnet.absolutedigital.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Cal Peake <cp@absolutedigital.net>
Cc: Kernel IDE Mailing List <linux-ide@vger.kernel.org>

Cal Peake wrote:
> Hello!
> 
> I'm getting the error below on this new system I've built. It appears 
> sporadicly under heavy drive access (there are six drives on this 
> controller, has appeared for each one at one point or another). If someone 
> has a second to take a look I'd appreciate any help.
..
> ata1.00: ATA-8: ST31000340AS, SD15, max UDMA/133

We ran into similar problems on two different systems we were setting
up with those same disks.  We swapped power supplies and SATA cables
and controllers but nothing made the problems go away fully.
Eventually we replaced the jumper on the back of the disk limiting it
to 1.5 Gbps and have not had any problems since.

-jim
