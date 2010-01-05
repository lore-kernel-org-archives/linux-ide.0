From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Tue, 05 Jan 2010 08:11:28 -0500
Message-ID: <4B433A80.8010900@garzik.org>
References: <20091224181300.GA4654@flint.arm.linux.org.uk> <20091224215451.GA2476@flint.arm.linux.org.uk> <20100103002314.GA16528@flint.arm.linux.org.uk> <20100103234655.GB24920@flint.arm.linux.org.uk> <20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk> <20100104133024.GA10521@flint.arm.linux.org.uk> <4B420871.2090309@garzik.org> <20100104154212.GA18335@flint.arm.linux.org.uk> <4B429EC3.9090305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:51424 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab0AENLa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Jan 2010 08:11:30 -0500
Received: by ywh6 with SMTP id 6so16343914ywh.4
        for <linux-ide@vger.kernel.org>; Tue, 05 Jan 2010 05:11:30 -0800 (PST)
In-Reply-To: <4B429EC3.9090305@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On 01/04/2010 09:06 PM, Robert Hancock wrote:
> Indeed, which is why I suspect that a global change to handle this
> controller may not be a good idea. Overriding sff_exec_command for this
> driver to not do the altstatus read (just wait 600ns, maybe) might be
> the best solution for now.


Well, I think it's fair to say that this should be applied more 
generally than just one driver.  It is definitely conceivable that 
reading AltStatus causes a problem with more than one host controller, 
even though the ATA7 and ATA8 state diagrams recommends doing so.

One solution could be taken from the old-IDE driver: handle things at 
the other end of the transaction.  Audit the paths that check status at 
the end of a drive command, rather than focusing on the start of the 
transaction.

That is where the "hard requirements" exist, anyway.  ATA requires us to

* wait 400ns before reading Status, and/or
* wait one PIO cycle before reading Status

And logically, we only need to read Status at the end of the 
transaction, or when handling a non-DMA PCI shared interrupt.

	Jeff


