From: Scott Wood <scottwood@freescale.com>
Subject: Re: Oops with PREEMPT-RT on 2.6.25.4
Date: Mon, 19 May 2008 16:49:43 -0500
Message-ID: <4831F5F7.9050900@freescale.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B0469010C@ismail.innsys.innovsys.com>	<4831D527.2020907@freescale.com> <DCEAAC0833DD314AB0B58112AD99B93B04690162@ismail.innsys.innovsys.com> <4831ECF0.5090101@freescale.com> <DCEAAC0833DD314AB0B58112AD99B93B04690239@ismail.innsys.innovsys.com> <4831F364.8020702@freescale.com> <DCEAAC0833DD314AB0B58112AD99B93B04690276@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from az33egw02.freescale.net ([192.88.158.103]:57666 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754993AbYESVtE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 May 2008 17:49:04 -0400
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B04690276@ismail.innsys.innovsys.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rune Torgersen <runet@innovsys.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Rune Torgersen wrote:
> Scott Wood wrote:
>> Try calling irq_set_chip_and_handler() with handle_level_irq, rather
>> than irq_set_chip().  The -rt patch doesn't seem to have threadified
>>   the __do_IRQ() path.
> 
> The demuxer is setting itself up with set_irq_chained handler(), any
> pointers on how to change to irq_set_chip_and_handler()?

No, I mean the call to set_irq_chip() in pci_pic_host_map() where it 
sets up the IRQs it manages, not the cascade IRQ itself.

-Scott
