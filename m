From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Tue, 20 Jan 2009 18:33:52 +0300
Message-ID: <4975EEE0.2040406@ru.mvista.com>
References: <200901141345.42583.stf_xl@wp.pl> <4975B065.6030705@ru.mvista.com> <200901201549.31211.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:26908 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760176AbZATPdW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jan 2009 10:33:22 -0500
In-Reply-To: <200901201549.31211.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org

Stanislaw Gruszka wrote:

>>>do special things before access Task File and Data Register (functions 
>>>set_8bit_mode() and set_16bit_mode()).

>>   That part really doesn't look well -- Atmel should have put more 
>>though into it and make the register stride 2 bytes, so that 16-bit 
>>access could alwys be used...

> Actually it is possible (I realize when seeing pata_at32) when address
> lines are connected in diffrent way, h/w trick is described in AVR32 ATA
> application note. Only register addresses are multiplied by 2 then.
> However Atmel reference documents for AT91 don't describe such
> connection. I suppose AT91 evaluation boards are designed without the trick.

    It's not much of a trick, just a usual way of connection a 16-bit 
device... I'd advise that you pass the register stride info via the platform 
data, alike to what pata_platform devices do.

>>>We did not tests on Atmel sam9263ek board, because we have no proper connector
>>>for 1,8'' HDD.

>>   Not sure I've understood that. You have 1,8'' drive and the board has 
>>stndard IDE connector?
> 
> Board has 44-pin male IDE connector (rather non standard one), we have no cable

    I think it's pretty standard laptop connector.

> or any device to connect. Kelvatek's board has Compact Flash connector, we use CF
> card for testing. We currently ordered proper cable and IDE->CF adapter, so
> I'll do tests on sam9263ek.

    Besides, not all CF connectors are DMA compatible (don't have pin 43/44 
wired for DMA).

MBR, Sergei
