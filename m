From: "Max T. Woodbury" <max.teneyck.woodbury@verizon.net>
Subject: Re: ide-io.c, ide_do_request -- race condition?
Date: Fri, 16 Jul 2004 07:12:10 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40F72B6A.6F12F454@verizon.net>
References: <40F2CFDE.66D28904@verizon.net> <20040712183505.GE26789@bounceswoosh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out002pub.verizon.net ([206.46.170.141]:1763 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S266290AbUGPGMO
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Jul 2004 02:12:14 -0400
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@bounceswoosh.org>
Cc: linux-ide@vger.kernel.org

"Eric D. Mudama" wrote:
> 
> On Mon, Jul 12 at 13:52, Max T. Woodbury wrote:
> >Still, why would PIO mode be unsafe?  (I can see slower, but I don't
> >expect speed from this beast.  Oh well.  Thanks for the pointer.)
> 
> PIO has no data integrity check, so bogus cables that glitch the data
> will not be detected.  Not sure if that is what he was talking about,
> but is definitely a problem for PIO.

Huh? Unless something major has changed since the last time I looked at
DMA hardware (and it has been a few years), DMA uses the same transfer
sequence from the devices point of view as PIO.  The fact that the 
transfer is under the control of another device rather than a program 
should be transparent to the target device.  Impedance mismatches,
reflections and constructive and destructive interference caused by
cable problems don't care about who's in control of the busses.

I can see a possible problem with cache consistency causing problems
with PIO, but there are similar (abet in some sense inverted or
reversed) problems with DMA.

max
