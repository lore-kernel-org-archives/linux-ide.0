From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ide-io.c, ide_do_request -- race condition?
Date: Fri, 16 Jul 2004 13:45:20 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1089999920.1865.82.camel@gaston>
References: <40F2CFDE.66D28904@verizon.net>
	 <20040712183505.GE26789@bounceswoosh.org>  <40F72B6A.6F12F454@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:48265 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266409AbUGPRrK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Jul 2004 13:47:10 -0400
In-Reply-To: <40F72B6A.6F12F454@verizon.net>
List-Id: linux-ide@vger.kernel.org
To: "Max T. Woodbury" <max.teneyck.woodbury@verizon.net>
Cc: "Eric D. Mudama" <edmudama@bounceswoosh.org>, linux-ide@vger.kernel.org


> Huh? Unless something major has changed since the last time I looked at
> DMA hardware (and it has been a few years), DMA uses the same transfer
> sequence from the devices point of view as PIO.  The fact that the 
> transfer is under the control of another device rather than a program 
> should be transparent to the target device.  Impedance mismatches,
> reflections and constructive and destructive interference caused by
> cable problems don't care about who's in control of the busses.
> 
> I can see a possible problem with cache consistency causing problems
> with PIO, but there are similar (abet in some sense inverted or
> reversed) problems with DMA.

Actually, it's not the same transfer sequence (and it's not the same
ATA commands neither). Look for an ATA spec and check out the signals
on the wire, DMA is different at the device level as well.

In addition, U/DMA does CRC

Ben.


