From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: What is the correct way to indicate an unassigned PCI resource
 ?
Date: Mon, 04 Dec 2006 18:40:09 +0300
Message-ID: <45744159.8040301@ru.mvista.com>
References: <20061130165202.GA23205@aepfle.de>	<20061204123854.GA28159@aepfle.de>	<FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>	<4574197A.2020204@ru.mvista.com>	<4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>	<45741DDE.4080509@ru.mvista.com>	<20061204132124.4f7c50a9@localhost.localdomain>	<45742253.1000807@ru.mvista.com>	<20061204142201.68d9621f@localhost.localdomain>	<457431FE.6040702@ru.mvista.com> <20061204144411.246f3700@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:8136 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S937033AbWLDPiu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Dec 2006 10:38:50 -0500
In-Reply-To: <20061204144411.246f3700@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Segher Boessenkool <segher@kernel.crashing.org>, Olaf Hering <olaf@aepfle.de>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz

Hello.

Alan wrote:

>>    When Linus remaps IRQ0 on x86, I'll follow that code as a testament. Until 
>>this happens, I consider is just an opinion. Forcing every arch but x86 to 
>>remap IRQ0 is an example of the double standards.

> Yawn.. x86 does not expose IRQ 0 outside of arch specific code.

    Can you believe, some non-x86 platofrms also don't -- for example, IRQ0 
may be internal to SOC, not shareable or routable outside of it, BUT the SOC 
device is driven by the standard driver (I'm minding 8250.c here). Yet we're 
told that we should remap it, period...

>>>The checks need pushing upwards and removing from their current place -
>>>the pci layer should check the resource length, the isa pnp should I
>>>believe check for zero address etc.

>>    So, it's OK to remove the base *address* check in ide_hwif_confiure() 
>>altogether?

> IFF you move all the other checks, verify their correctness and then get
> them tested for a while yes

    All other checks aren't hindering (at least me ATM).  What's probably 
worth doing is to check the result of ide_pci_check_iomem() some lines above 
the discussed check (it's ignored now).

WBR, Sergei
