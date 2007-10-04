From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_cs5536: ATA driver for Geode companion chip
Date: Thu, 4 Oct 2007 17:22:31 +0100
Message-ID: <20071004172231.17665123@the-village.bc.nu>
References: <20071003233012.GA8721@cosmic.amd.com>
	<yq1przva76x.fsf@sermon.lab.mkp.net>
	<20071004165819.003b86c6@the-village.bc.nu>
	<20071004160834.GA28667@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41469 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762709AbXJDQRl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Oct 2007 12:17:41 -0400
In-Reply-To: <20071004160834.GA28667@cosmic.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: "Martin K. Petersen" <mkp@mkp.net>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

> Agreed.  It sounds like there is still breakage in the BIOS - since the
> reference VSA code accounts for accesses of different alignments, but its
> probably not worth going back and forth about it.  Like I said, if Alan
> and Jeff are game, we should go with the 5536 driver, and now that we've
> debated it extensively, I'm fine with the MSR accesses - I'm satisfied
> that we at least considered the alternative and dismissed it for technically
> sound reasons.

Even if we use PCI accesses and keep them dword along with the right
timing it makes sense to have a 5536 driver for this.
> 
> Is there anything we can do to make the transition smooth for anybody who
> may be using pata_amd in 2.6.23?

We can make pata_amd pick it up if pata_cs5536 is not selected for now
