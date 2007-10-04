From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: pata_cs5536: ATA driver for Geode companion chip
Date: Thu, 4 Oct 2007 10:08:34 -0600
Message-ID: <20071004160834.GA28667@cosmic.amd.com>
References: <20071003233012.GA8721@cosmic.amd.com>
 <yq1przva76x.fsf@sermon.lab.mkp.net>
 <20071004165819.003b86c6@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-fra.frontbridge.com ([62.209.45.174]:64089 "EHLO
	outbound4-fra-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760424AbXJDQIG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Oct 2007 12:08:06 -0400
In-Reply-To: <20071004165819.003b86c6@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Martin K. Petersen" <mkp@mkp.net>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On 04/10/07 16:58 +0100, Alan Cox wrote:
> > For kicks I switched my driver over to using PCI config registers
> > instead of MSRs.  And it still worked!
> > 
> > When I changed my driver I did a quickie conversion from wrmsr() to
> > pci_write_config_dword().  If I use pci_write_config_byte() instead
> > (like pata_amd.c), things fail miserably.  A register dump reveals
> > that any value I write becomes a 0.  Yay!
> 
> At that point its probaly a good idea to take CS5536 out of AMD and use
> your driver for it, whether in PCI or MSR mode (or perhaps supporting
> either)

Agreed.  It sounds like there is still breakage in the BIOS - since the
reference VSA code accounts for accesses of different alignments, but its
probably not worth going back and forth about it.  Like I said, if Alan
and Jeff are game, we should go with the 5536 driver, and now that we've
debated it extensively, I'm fine with the MSR accesses - I'm satisfied
that we at least considered the alternative and dismissed it for technically
sound reasons.

Is there anything we can do to make the transition smooth for anybody who
may be using pata_amd in 2.6.23?

Jordan

-- 
Jordan Crouse
Systems Software Development Engineer 
Advanced Micro Devices, Inc.


