From: Igor Plyatov <plyatov@gmail.com>
Subject: Re: [PATCH] ata: pata_at91.c bugfix for high master clock
Date: Sat, 11 Dec 2010 22:43:31 +0300
Message-ID: <1292096611.27634.20.camel@homepc>
References: <1292011430-20835-1-git-send-email-plyatov@gmail.com>
	 <4D0385D1.9080209@ru.mvista.com> <1292081113.1580.21.camel@homepc>
	 <4D039930.4050905@ru.mvista.com>
Reply-To: plyatov@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f171.google.com ([209.85.215.171]:64736 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab0LKTng (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Dec 2010 14:43:36 -0500
In-Reply-To: <4D039930.4050905@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, geomatsi@gmail.com

Dear Sergei,

> > I do not test this driver, but I think it have the same problem, because
> > it have the same algorithm for timings calculation.
> 
>     I quickly looked thru both drivers and the algorithm seemed different. :-)

I don't think so...

> > If you will see "cycle" value greater then 63, then problem exists.
> 
>     I thought the problem was with active pulse width, not total cycle time...

The problem was - the same "cycle" variable used to set up NRD_CYCLE
(max value = 127) and NCS_RD_PULSE (max value = 63).
Where NRD_CYCLE, NCS_RD_PULSE names from datasheet for AT91SAM9.
If NCS_RD_PULSE > 63, then overflow occur and pulse is much longer then
required.

For the 132 MHz, driver use NCS_RD_PULSE = 80 at device detection moment
on my board.
Calculated cycle in at91_ide is the same as for pata_at91 driver.

> > Generally, I does not see any reasons to use at91_ide, because ATA
> > drivers subsystem going to replace IDE drivers.
> 
>     There may be reasons -- like larger thruput in PIO mode (you have to check 
> this though -- but generally libata seems very slow in PIO). Anyway, it 
> doesn't mean that the bugs in IDE drivers should be ignored, and the 
> replacemtn will not happen anytime soon (not all IDE drivers are ported to 
> libata yet).

I will send next patch where this driver corrected and tested.

Best regards!
--
Igor Plyatov

