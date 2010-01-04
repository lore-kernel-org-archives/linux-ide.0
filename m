From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Mon, 4 Jan 2010 10:37:56 +0000
Message-ID: <20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk>
References: <20091224181300.GA4654@flint.arm.linux.org.uk>
	<20091224215451.GA2476@flint.arm.linux.org.uk>
	<20100103002314.GA16528@flint.arm.linux.org.uk>
	<20100103234655.GB24920@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:34845 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752217Ab0ADKea (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jan 2010 05:34:30 -0500
In-Reply-To: <20100103234655.GB24920@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-ide@vger.kernel.org

> 1. There is no way for the 247 to see any configuration settings;
>    the only thing it can see are the taskfile reads and writes, and
>    the timing of the DMA signals from the 246.
> 
> 2. The 246 timings for MWDMA2 and UDMA0 are identical; there is no
>    programming difference between these two modes.  The only way the
>    246 can know that UDMA is selected is by looking for the SET
>    FEATURES command to the drive.

The 2026x certainly snoops SET FEATURES so that would be a reasonable
assumption.

> I've tried changing the set xfermode code to use a version of
> ata_exec_internal() which doesn't return the taskfile, but this makes no
> difference to the promise exploding with CRC errors with UDMA writes.
> Is it possible to do a similar thing with IDENTIFY?

No because you need to know if it worked.

> Also, is it possible to get rid of the additional identify and read native
> max address commands which seem to be repeated (command register writes
> listed):

You can turn off Host Protected Area support for this. You could also btw
turn *on* host protected area for the IDE stack and see what occurs but I
imagine its a red herring anyway. If the snoop is failing then it is more
likely to be that the chip has some limitations on the taskfile snooping
and perhaps requires that the device register is always written or that
the registers are written in a specific order when writing the set
features command.

Another thing to try if that fails is using a polled set features in case
the chip has problems in that area. We've seen a similar bug on some older
VIA devices.
