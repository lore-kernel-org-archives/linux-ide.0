From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] [POWERPC] MPC8349E-mITX: use platform IDE driver
 for CF	interface
Date: Wed, 25 Jul 2007 22:19:11 +0400
Message-ID: <46A7941F.2050300@ru.mvista.com>
References: <20070725165318.5331.23795.stgit@localhost.localdomain> <20070725165326.5331.19920.stgit@localhost.localdomain> <46A78322.3080607@ru.mvista.com> <46A78E3F.1030904@ru.mvista.com> <20070725180145.GA29689@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:25632 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755064AbXGYSRL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Jul 2007 14:17:11 -0400
In-Reply-To: <20070725180145.GA29689@ld0162-tx32.am.freescale.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Scott Wood <scottwood@freescale.com>
Cc: Vitaly Bordug <vitb@kernel.crashing.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org

Hello.

Scott Wood wrote:

>>    Also, what mmio-ide in the compat properly means in the context of 
>>ide_platform which is able to handle both port and memory mapped IDE.

> I/O-space is only valid in the context of PCI, ISA, or similar buses, and
> the bus-specific reg format indicates whether it's mmio-space or
> io-space.

    You could save time on lecturing me (and use it to look on the driver ;-).

>>I think we must get rid with this crap, and since this IDE register
>>mapping is pretty much board specific, call it something like
>>"mpc8349emitx-ide" instead.

> What is board specific about a set of standard IDE registers at a given

    The regisrer mapping used is highly non-standard.

> address?  Do we need to make board-specific glue code for all of the

    We're already in board specific code, so why the heck not? :-)

> various ns16550-compatibles out there as well?

    I never suggested that -- what I did suggest was make of_serial.c 
recognize certain chip types and register them with 8250 driver.

> -Scott

MBR, Sergei
