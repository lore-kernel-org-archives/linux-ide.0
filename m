From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ide patches
Date: Mon, 23 Jul 2007 11:21:14 +1000
Message-ID: <1185153674.5439.83.camel@localhost.localdomain>
References: <200707222019.03684.bzolnier@gmail.com>
	 <1185148506.5439.80.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:38597 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756023AbXGWBVT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Jul 2007 21:21:19 -0400
In-Reply-To: <1185148506.5439.80.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

On Mon, 2007-07-23 at 09:55 +1000, Benjamin Herrenschmidt wrote:
> Note that with all your patches applied, it doesn't seem to auto-tune
> the speed at boot anymore and doesn't enable DMA. I can make it do so
> with hdparm -d1, in which case, for example, on this wallstreet, I get
> MDMA2 which is correct, however, it seems to also set PIO0 which it
> should set PIO4...

One of the problems is that you do XFER_PIO + pio in
pmac_ide_set_pio_mode(), which is no good. XFER_PIO is a bad constant
name and causes that sort of confusion :-)

Fix is to use XFER_PIO_0 + pio. I'll send a patch fixing that plus a few
other things on top of yours once I've found out what's up with DMA.
I've enable autotune, I see it sending the 0x22 command, but hdparm
still claims DMA isn't enabled.

Cheers,
Ben.


