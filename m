From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] ata: pata_at91.c bugfix for high master clock
Date: Sun, 12 Dec 2010 16:46:01 +0300
Message-ID: <4D04D219.4040300@ru.mvista.com>
References: <1292011430-20835-1-git-send-email-plyatov@gmail.com>	 <4D0385D1.9080209@ru.mvista.com> <1292081113.1580.21.camel@homepc>	 <4D039930.4050905@ru.mvista.com> <1292096611.27634.20.camel@homepc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f171.google.com ([209.85.215.171]:65460 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983Ab0LLNrC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Dec 2010 08:47:02 -0500
In-Reply-To: <1292096611.27634.20.camel@homepc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: plyatov@gmail.com
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, geomatsi@gmail.com

Hello.

On 11-12-2010 22:43, Igor Plyatov wrote:

>>> I do not test this driver, but I think it have the same problem, because
>>> it have the same algorithm for timings calculation.

>>      I quickly looked thru both drivers and the algorithm seemed different. :-)

> I don't think so...

    In fact, the algorithm is slightly different.

>>> If you will see "cycle" value greater then 63, then problem exists.

>>      I thought the problem was with active pulse width, not total cycle time...

> The problem was - the same "cycle" variable used to set up NRD_CYCLE
> (max value = 127) and NCS_RD_PULSE (max value = 63).
> Where NRD_CYCLE, NCS_RD_PULSE names from datasheet for AT91SAM9.
> If NCS_RD_PULSE > 63, then overflow occur and pulse is much longer then
> required.

    Ah, NCS_RD_PULSE is different from active pulse time which is in the 
variable 'nrd_pulse'.

> For the 132 MHz, driver use NCS_RD_PULSE = 80 at device detection moment
> on my board.
> Calculated cycle in at91_ide is the same as for pata_at91 driver.

    Yes, but NCS_RD_PULSE is different in these drivers, it's cycle_time in 
at91_ide.c and (cycle time - 2) in the pata_at91.c... Then there should indeed 
be an error in at91_ide.c as well.

>>> Generally, I does not see any reasons to use at91_ide, because ATA
>>> drivers subsystem going to replace IDE drivers.

>>      There may be reasons -- like larger thruput in PIO mode (you have to check
>> this though -- but generally libata seems very slow in PIO). Anyway, it
>> doesn't mean that the bugs in IDE drivers should be ignored, and the
>> replacemtn will not happen anytime soon (not all IDE drivers are ported to
>> libata yet).

> I will send next patch where this driver corrected and tested.

    Thanks. :-)

> Best regards!
> --
> Igor Plyatov

WBR, Sergei
