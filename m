From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Mon, 04 Jan 2010 10:32:55 -0500
Message-ID: <4B420A27.9060407@garzik.org>
References: <20091224181300.GA4654@flint.arm.linux.org.uk>	<20091224215451.GA2476@flint.arm.linux.org.uk>	<20100103002314.GA16528@flint.arm.linux.org.uk>	<20100103234655.GB24920@flint.arm.linux.org.uk>	<20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk>	<20100104133024.GA10521@flint.arm.linux.org.uk> <20100104151637.559c4780@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f188.google.com ([209.85.210.188]:58226 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381Ab0ADPdA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jan 2010 10:33:00 -0500
Received: by yxe26 with SMTP id 26so14627121yxe.4
        for <linux-ide@vger.kernel.org>; Mon, 04 Jan 2010 07:32:59 -0800 (PST)
In-Reply-To: <20100104151637.559c4780@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-ide@vger.kernel.org

On 01/04/2010 10:16 AM, Alan Cox wrote:
>> If the drive immediately starts the UDMA protocol after a write to the
>> command register (as it probably will for the DMA WRITE command), then
>> we'll be accessing the taskfile in the middle of the UDMA setup, which
>> can't be good.  It's certainly a violation of the ATA specs.
>
> I concur entirely - that wants pushing into the upstream kernel ASAP and
> if its ok backporting. May also be worth seeing if that fixes the funny
> in the ALi setup.

How do you think one tests for command completion?  :)  There does not 
seem to be a general problem reading AltStatus(BSY) during a DMA 
transfer.  IDE driver and other well known codebases have been doing 
that for decades.

I think the undefined behavior is only where the AltStatus read occurs 
before the 400ns period specified by ATA...  excising the AltStatus read 
there (ata_sff_pause) should be fine for PIO, but problematic for MMIO 
chipsets that need posted writes flushed prior to the 400ns delay.

	Jeff




