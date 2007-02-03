From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata_piix: fix pio/mwdma programming (for testing, don't
 apply)
Date: Sat, 3 Feb 2007 20:04:28 +0000
Message-ID: <20070203200428.4a7a5682@localhost.localdomain>
References: <20070202151856.GD1625@htj.dyndns.org>
	<20070202174235.14b13f3e@localhost.localdomain>
	<45C3E7F0.6000506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34339 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751400AbXBCTwH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Feb 2007 14:52:07 -0500
In-Reply-To: <45C3E7F0.6000506@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: ahaas@airmail.net, linux-ide@vger.kernel.org

> > Yep and if the BIOS programmed the slave into DMA that might not be ideal.
> 
> How so?  The bit will be programmed by set_dmamode() right after
> set_piomode() is complete.

IFF we also put the device into a DMA mode. A blacklisted device would be
wrong.

> See the difference?  Smart one liners are dangerous.  ?* is _much_
> better than cryptic arithmetic.

Agreed

> 
> >> * MWDMA mode programming cleared udma_mask even when the controller
> >>   doesn't support UDMA.  This doesn't matter for your case.
> > 
> > Or on the actual hardware.
> 
> I was trying to make it more consistent with pio counterpart.  We can
> remove if() from set_piomode too.  Let's just keep things in sync
> between stuff including ide piix driver.

The one you must not touch is the UDMA register rather than added UDMA
bits in older registers.

Alan
