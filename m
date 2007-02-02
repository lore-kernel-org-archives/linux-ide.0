From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata_piix: fix pio/mwdma programming (for testing, don't
 apply)
Date: Fri, 2 Feb 2007 17:42:35 +0000
Message-ID: <20070202174235.14b13f3e@localhost.localdomain>
References: <20070202151856.GD1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50240 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1945993AbXBBRaX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 12:30:23 -0500
In-Reply-To: <20070202151856.GD1625@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: ahaas@airmail.net, linux-ide@vger.kernel.org

> * Control bits in the timing register wasn't cleared properly while
>   programming PIO mode.

Yep and if the BIOS programmed the slave into DMA that might not be ideal.

> * MWDMA mode programming cleared the wrong part of control bits.  I
>   think this can fix your problem.

Your change does nothing here.

	0x0F + 1 * 0xE1 = 0xF0

It's just a construct to avoid the use of the ugly C "?" operator. The
rest of the code uses ? so the change makes sense for style, but it
doesn't appear to be a bug.

> * MWDMA mode programming cleared udma_mask even when the controller
>   doesn't support UDMA.  This doesn't matter for your case.

Or on the actual hardware.
