From: Scott Wood <scottwood@freescale.com>
Subject: Re: Oops with PREEMPT-RT on 2.6.25.4
Date: Mon, 19 May 2008 16:38:44 -0500
Message-ID: <4831F364.8020702@freescale.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B0469010C@ismail.innsys.innovsys.com>	<4831D527.2020907@freescale.com> <DCEAAC0833DD314AB0B58112AD99B93B04690162@ismail.innsys.innovsys.com> <4831ECF0.5090101@freescale.com> <DCEAAC0833DD314AB0B58112AD99B93B04690239@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from az33egw01.freescale.net ([192.88.158.102]:36894 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755440AbYESViI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 May 2008 17:38:08 -0400
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B04690239@ismail.innsys.innovsys.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rune Torgersen <runet@innovsys.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Rune Torgersen wrote:
> Scott Wood wrote:
>> Almost certainly the latter.  Is the disk interrupt shared with any
>> other interrupts, that are marked IRQF_NODELAY?  The -rt
>> patch doesn't seem to handle mixing the two well.
> 
> Disk is on a muxed PCI interrupt. None of the other interrupts on the
> mux is fireing at the time.

Regardless of whether they're firing, any request_irq with IRQF_NODELAY 
will turn off threading for all handlers.

> Is is possible that the demuxer is not set up right? It is based loosely
> on pq2-pci-pic.c

Try calling irq_set_chip_and_handler() with handle_level_irq, rather 
than irq_set_chip().  The -rt patch doesn't seem to have threadified the 
  __do_IRQ() path.

-Scott
