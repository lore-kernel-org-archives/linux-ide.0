From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: PATA driver for Atmel AVR32
Date: Mon, 23 Jul 2007 23:00:54 +0400
Message-ID: <46A4FAE6.5060901@ru.mvista.com>
References: <200707201108.19174.kngregertsen@norway.atmel.com>	<200707201112.12444.kngregertsen@norway.atmel.com> <20070720121443.4c1d6fa5@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:4375 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755909AbXGWS6x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jul 2007 14:58:53 -0400
In-Reply-To: <20070720121443.4c1d6fa5@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kristoffer Nyborg Gregertsen <kngregertsen@norway.atmel.com>, linux-ide@vger.kernel.org, kernel@avr32linux.org, gregerts@stud.ntnu.no

Hello.

Alan Cox wrote:

>>	/* Only use IORDY/NWAIT for PIO mode 3 and 4 */
>>	if (pio_mode < 3)
>>		info->smc.nwait_mode = 0;
>>	else
>>		info->smc.nwait_mode = 3;

> That is wrong.

    Yeah.

> Any mode for PIO2+ will use IORDY. Modes below may require
> it sometimes (and its a good signal check). See ata_pio_need_iordy(atadev)

    For PIO3+ you wanted to say? PIO2 doesn't require IORDY (and the majority 
of drives report 240 ns lowest cycle time w/o IORDY which is PIO2).

MBR, Sergei
