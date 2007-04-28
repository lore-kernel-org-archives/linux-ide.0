From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata fails to recover from HSM violation involving DRQ status
Date: Sat, 28 Apr 2007 22:25:02 +0100
Message-ID: <20070428222502.26fc9bbc@the-village.bc.nu>
References: <4633AB75.7070107@rtr.ca>
	<4633B0A6.6090705@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:39185 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753607AbXD1VV2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Apr 2007 17:21:28 -0400
In-Reply-To: <4633B0A6.6090705@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

> I am reluctant to do anything about this.

This one does need dealing with. It happens in the real world and the old
IDE paths for this do get triggered and used now and then (we know this
because bugs in them were found). All it takes is a device and a
controller disagreeing about the length of a data transfer to get in a
mess. In theory resetting the bus should get you out of this, I'm
suprised we didn't get out that way.

> All manner of things can go wrong, if the taskfile protocol specified 
> disagrees with the taskfile contents.

True but at the point you are trying to do error recovery and DRQ is
wedged on its a good idea to pull remaining data out of the fifo. 

> At that point you are in undefined territory, since libata will happily 
> ARM a DMA controller or otherwise program controller registers in 
> preparation for the requested taskfile protocol.  Data corruption, hard 
> locks, anything could happen at that point.

SG_IO and other userspace interfaces can mean we issue a command that
ends up causing variants of this kind of confusion.

Alan
