From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 3/4] libata-sff.c: add another IRQ calls
Date: Tue, 16 Jan 2007 17:05:45 -0500
Message-ID: <45AD4C39.3050202@garzik.org>
References: <200701161046.l0GAkE5u029367@toshiba.co.jp> <20070116120450.1bb44ebb@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59063 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659AbXAPWFs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Jan 2007 17:05:48 -0500
In-Reply-To: <20070116120450.1bb44ebb@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Akira Iguchi <akira2.iguchi@toshiba.co.jp>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp, benh@kernel.crashing.org, arnd@arndb.de, paulus@samba.org, linas@austin.ibm.com

Alan wrote:
> On Tue, 16 Jan 2007 19:46:23 +0900
> Akira Iguchi <akira2.iguchi@toshiba.co.jp> wrote:
> 
>> When enabling IRQ, ap->ops->irq_on is checked.
>> Because most drivers can use ata_irq_on() as is, this
>> patch allows ap->ops->irq_on to be NULL.
>> If it is NULL, ata_irq_on() are used.
> 
> 
> I believe you can now remove the if(ap->ioaddr.ctl_addr) check as any
> device lacking a ctl_addr can now provide an irq_on() method using your
> changes.
> 
> You've fixed the FIXME 

Agreed.

Abstracting out the Control/Alt-Status register block operations has 
been a long-standing TODO that I knew would be required, sometime down 
the line.  I certainly support adding such abstractions, as they are 
required for several non-x86 IDE drivers, not just Cell.

	Jeff



