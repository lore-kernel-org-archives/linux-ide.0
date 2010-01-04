From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Mon, 04 Jan 2010 13:07:00 -0500
Message-ID: <4B422E44.1080501@garzik.org>
References: <20091224181300.GA4654@flint.arm.linux.org.uk>	<20091224215451.GA2476@flint.arm.linux.org.uk>	<20100103002314.GA16528@flint.arm.linux.org.uk>	<20100103234655.GB24920@flint.arm.linux.org.uk>	<20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk>	<20100104133024.GA10521@flint.arm.linux.org.uk>	<4B420871.2090309@garzik.org>	<20100104154607.0b6e51dd@lxorguk.ukuu.org.uk>	<4B421827.6050308@garzik.org>	<20100104170236.5d85959f@lxorguk.ukuu.org.uk>	<4B42251A.9030106@garzik.org> <20100104173835.3c5d3ea5@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:59579 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374Ab0ADSHD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jan 2010 13:07:03 -0500
Received: by ywh6 with SMTP id 6so15553123ywh.4
        for <linux-ide@vger.kernel.org>; Mon, 04 Jan 2010 10:07:01 -0800 (PST)
In-Reply-To: <20100104173835.3c5d3ea5@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On 01/04/2010 12:38 PM, Alan Cox wrote:
>> Early SATA controllers are just PATA controllers in disguise.  All SFF
>> controllers want that 400ns delay.  The 400ns delay should -not- be avoided.
>
> Its a signalling protocol requirement for PATA or a PATA controller with
> a PATA/SATA bridge. What makes you think a SATA controller cares one
> iota ?

Because first gen SATA controllers, notably the Promise ones, were often 
just the same old PATA silicon logic with additional PATA<->SATA 
translation glue logic, rather than a pure SATA SFF implementation.


>> Because several SATA controllers are SFF and use the code in question,
>> the MMIO issue is relevant for the code change, even if it is irrelevant
>> to drivers/ata/pata_*.c.
>
> and to SATA. It's simply not relevant at a protocol level to SATA which
> is message passing anyway.

It is not relevant to FIS-based SATA (SiI 3124, AHCI), sure.  But SFF is 
not FIS-based SATA.

	Jeff



