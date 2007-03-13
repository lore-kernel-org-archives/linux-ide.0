From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Asus P5B-VM motherboard:  cd drive malfunctions if internal nic
 in use.
Date: Tue, 13 Mar 2007 00:04:59 +0000
Message-ID: <20070313000459.6739c3cb@lxorguk.ukuu.org.uk>
References: <200703122212.l2CMCaxm032601@osprey.cs.arizona.edu>
	<45F5D59E.10304@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54322 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752000AbXCLXBt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Mar 2007 19:01:49 -0400
In-Reply-To: <45F5D59E.10304@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Phil Kaslo <phil@cs.arizona.edu>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> Is that a PATA cd-drive?  If so, then you must have hooked it up
> to the JMicron IDE controller.  That driver is just plain buggy.

It ought to be rock solid, perhaps you can send me a detailed bug report.
In fact it actually doesn't do very much at all as the controller is
smart enough to do all the hard work itself.

> I gave up on it for my own P5B-VM.  The libata version works better
> than the drivers/ide, but I gave up on it and got a SATA DVD/RW drive.

The two drive the devices identically although if there was a problem I
guess the libata one would recover better.

Would appreciate bug reports anyway so I can do more detailed analysis.

Alan
