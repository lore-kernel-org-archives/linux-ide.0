From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Tue, 05 Jan 2010 08:00:26 -0500
Message-ID: <4B4337EA.1000504@garzik.org>
References: <20091224181300.GA4654@flint.arm.linux.org.uk>	<20091224215451.GA2476@flint.arm.linux.org.uk>	<20100103002314.GA16528@flint.arm.linux.org.uk>	<20100103234655.GB24920@flint.arm.linux.org.uk>	<20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk>	<20100104133024.GA10521@flint.arm.linux.org.uk>	<4B420871.2090309@garzik.org>	<20100104154212.GA18335@flint.arm.linux.org.uk>	<4B429EC3.9090305@gmail.com> <20100105112537.48ae5800@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f188.google.com ([209.85.210.188]:59646 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096Ab0AENAa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Jan 2010 08:00:30 -0500
Received: by yxe26 with SMTP id 26so15556417yxe.4
        for <linux-ide@vger.kernel.org>; Tue, 05 Jan 2010 05:00:29 -0800 (PST)
In-Reply-To: <20100105112537.48ae5800@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Hancock <hancockrwd@gmail.com>, Russell King <rmk@arm.linux.org.uk>, linux-ide@vger.kernel.org

On 01/05/2010 06:25 AM, Alan Cox wrote:
>> Indeed, which is why I suspect that a global change to handle this
>> controller may not be a good idea. Overriding sff_exec_command for this
>> driver to not do the altstatus read (just wait 600ns, maybe) might be
>> the best solution for now.
>
> Old IDE does 400nS and no read. We know that works. At least for all the
> standard PATA controllers. Thats an incredibly strong argument for doing
> command issue that way for non MMIO controllers.

To which old-IDE do you refer?  :)  This specific area of functionality 
varies from 2.4.x to 2.6.x.  Old-Old-IDE even picks and chooses whether 
or not to wait depending on protocol (PIO or not), something that has 
changed in the more recent old-IDE code.


> The MMIO case is muddy and probably simply does not matter because no
> sane hardware implementation is not going to handle it internally.

It's not muddy, the rules for MMIO are quite clear, as is kernel 
practice for drivers driving MMIO-based hardware.

Any PATA MMIO controller on a PCI card -- pata_pdc2027x comes to mind -- 
must handle this situation, because the PCI posting situation varies 
depending on where you slot in your PCI card.  That's not something a 
controller can really handle internally.

	Jeff


