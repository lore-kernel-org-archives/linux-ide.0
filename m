From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Issue with AHCI driver
Date: Fri, 08 Aug 2008 17:43:19 -0400
Message-ID: <489CBDF7.8070707@pobox.com>
References: <1592636.1218228104177.JavaMail.root@elwamui-wigeon.atl.sa.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37521 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755040AbYHHVnY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Aug 2008 17:43:24 -0400
In-Reply-To: <1592636.1218228104177.JavaMail.root@elwamui-wigeon.atl.sa.earthlink.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: the4hoffmans@earthlink.net
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, blward@micron.com

the4hoffmans@earthlink.net wrote:
> Update:
> 
> We got Fedora 2.6.25-14 build running.  It recognizes our card.  It identifies our device but at some point after that we die.  Using an analyzer we found that the problem is due to a buffer alignment issue.
> 
> Our card is a prototype and currently under development.  It currently only supports memory buffers that are quadword aligned.  We are dying because we get a buffer for a subsequent identify command that is on a dword boundary.  That is the problem we need to solve next.
> 
> We know we need to change our hardware and we will do that.  However, is there a way during driver init to specify quadword buffer alignment so we can continue our testing with Linux?

Not easily, no :/  The entirety of SATA, both devices, the protocol, and 
controllers, are all very 32-bit-centric.  Given that each SATA FIS is 
one or more dwords, this fundamental feature propagates through 
everything touched by SATA:  Linux kernel drivers, controller 
interfaces, etc.

I would be surprised if standard filesystem I/O (via bio's) was 
unaligned... but all the ATA commands we use for control, various 
internal [and often controller-specific] data structures that are 
DMA-mapped and directly accessed are usually found on 32-bit boundaries, 
but nothing more than that.

Avoiding commands outside the READ DMA / WRITE DMA realm may help you 
limp along... if you want to hack things up to speed up local 
development, I would turn on libata DEBUG and VERBOSE_DEBUG, follow the 
trace until you find the failing (non-aligned) command, and try to omit 
that from the probing process.  The main non-data operation during 
probing we really care about is IDENTIFY [PACKET] DEVICE, and that 
/should/ be aligned at a minimum on a quadword boundary, if I'm not 
mistaken.

Also, avoid ATAPI devices and testing ATAPI, as you will _definitely_ 
not be getting quadword alignment there.

	Jeff




