From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: What determines which interrupts are shared under Linux?
Date: Tue, 15 Aug 2006 16:06:19 +0100
Message-ID: <1155654379.24077.286.camel@localhost.localdomain>
References: <44E1D760.6070600@atipa.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:15077 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030327AbWHOOpo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Aug 2006 10:45:44 -0400
In-Reply-To: <44E1D760.6070600@atipa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roger Heflin <rheflin@atipa.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Ar Maw, 2006-08-15 am 09:17 -0500, ysgrifennodd Roger Heflin:
> On Linux when interrupts are defined similar to below, what defines say
> ide2, ide3 to be on the same interrupt?    The bios, linux, the driver using
> the interrupt?    And can that be controlled/overrode at the 
> kernel/driver level?

Only with a soldering iron. They are the way the system is wired. Moving
boards between slots may change the IRQ allocation.

> I have identified that the disks that are shared on ide2, ide3 do funny
> things when both are being heavily used (dma_expiry), this is an older 
> driver versions

That could be occuring just through lack of PCI bus bandwidth.


