From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Mon, 04 Jan 2010 12:27:54 -0500
Message-ID: <4B42251A.9030106@garzik.org>
References: <20091224181300.GA4654@flint.arm.linux.org.uk>	<20091224215451.GA2476@flint.arm.linux.org.uk>	<20100103002314.GA16528@flint.arm.linux.org.uk>	<20100103234655.GB24920@flint.arm.linux.org.uk>	<20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk>	<20100104133024.GA10521@flint.arm.linux.org.uk>	<4B420871.2090309@garzik.org>	<20100104154607.0b6e51dd@lxorguk.ukuu.org.uk>	<4B421827.6050308@garzik.org> <20100104170236.5d85959f@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f211.google.com ([209.85.217.211]:61408 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051Ab0ADR15 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jan 2010 12:27:57 -0500
Received: by gxk3 with SMTP id 3so2924330gxk.1
        for <linux-ide@vger.kernel.org>; Mon, 04 Jan 2010 09:27:56 -0800 (PST)
In-Reply-To: <20100104170236.5d85959f@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-ide@vger.kernel.org

On 01/04/2010 12:02 PM, Alan Cox wrote:
>> (1b)  The solution for MMIO controllers is a bit more complex:  replace
>> the dummy AltStatus register read with something else.
>
> If we had any SFF PATA controllers using MMIO. I can't find any. SATA is
> different anyway. In fact we probably want to avoid such delays on a pure
> SATA controller.

Early SATA controllers are just PATA controllers in disguise.  All SFF 
controllers want that 400ns delay.  The 400ns delay should -not- be avoided.

Because several SATA controllers are SFF and use the code in question, 
the MMIO issue is relevant for the code change, even if it is irrelevant 
to drivers/ata/pata_*.c.

	Jeff


