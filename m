From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/4] drivers/ata: add low-level I/O calls
Date: Sat, 13 Jan 2007 07:50:34 +1100
Message-ID: <1168635034.5011.27.camel@localhost.localdomain>
References: <200701120958.l0C9wICB019343@toshiba.co.jp>
	 <45A7BE3A.40508@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:44095 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030352AbXALUxA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Jan 2007 15:53:00 -0500
In-Reply-To: <45A7BE3A.40508@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Akira Iguchi <akira2.iguchi@toshiba.co.jp>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp, arnd@arndb.de, paulus@samba.org, linas@austin.ibm.com


> libata intentionally provides higher level hooks than just I/O accessors.
> 
> A low level I/O hook approach makes it difficult to take into account 
> platform-specific details like mmiowb(), especially on embedded platforms.
> 
> The high level hook approach also enables greater efficiency.  For 
> example, an embedded platform could do
> 
> 	__raw_writeb(datum, mmio_address + ATA_REG_FOO);
> 	__raw_writeb(datum, mmio_address + ATA_REG_BAR);
> 	eieio();
> 
> to optimize an entire taskfile-read or taskfile-write operation.

I've been looking at that for them and for Efika but it's acutally quite
a bit of a mess. I'd be happy if you could have a look as well, but it's
not simple to find the "right" level of abstraction to be able to use
the reset/probe handling with special reset accessors. And hooking at
the toplevel is such a wastage (LOTS of code duplication) that it's
really no fun (it's what Toshiba initial patch does, though you haven't
commented on it).

So some hints as to where you think the right hooks/abstractions would
be would be much welcome.
 
Ben.


