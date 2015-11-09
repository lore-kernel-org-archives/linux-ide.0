From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] mips: sb1250_swarm_defconfig: disable IDE subsystem
Date: Mon, 9 Nov 2015 16:18:01 +0000 (GMT)
Message-ID: <alpine.LFD.2.20.1511091559180.10231@eddie.linux-mips.org>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com> <1442245918-27631-16-git-send-email-b.zolnierkie@samsung.com> <alpine.LFD.2.20.1511072211330.18958@eddie.linux-mips.org> <20151109144932.GE22591@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:41952 "EHLO
	cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbbKIQSD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Nov 2015 11:18:03 -0500
In-Reply-To: <20151109144932.GE22591@linux-mips.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 9 Nov 2015, Ralf Baechle wrote:

> > I can check if things still work correctly when routed through libata, 
> > although it'll have to wait a couple of weeks yet at the least as I have 
> > wired my SWARM for hardware debugging, making it not immediately bootable 
> > and I'll be departing soon (i.e. I have no time for complicated fiddling).  
> > The host driver itself is actually in arch/mips/sibyte/swarm/platform.c 
> > BTW.
> > 
> >  Note to self: it would be nice if physical rather than virtual MMIO 
> > addresses were reported too.
> 
> Part of the problem is that everybody who is serious about using a Swarm
> is using PCI PATA/SATA card, so this part receives very little TLC.  I
> btw. can't test because the controller on my Pass 2 board is broken ...

 I think I've been reasonably serious about my SWARM and despite issues 
elsewhere the onboard PATA interface is a part of the system I've never 
had any with.  Yes, it's limited to PIO 3, but it's not a big deal, that's 
still 11MB/s (and one of the 4 generic data movers present in the SoC 
could be used as a DMA engine to offload the CPU if anyone bothered 
implementing that in the HBA driver).  I used it for stuff like native GCC 
bootstraps, some regression testing.  Maybe I'm just lucky, I've read 
people's horror stories.  Besides I'm out of free PCI slots, I'd have to 
use an expansion box.

  Maciej
