From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Should sata_mv work with Highpoint RocketRAID 2300?
Date: Fri, 24 Aug 2007 05:55:39 -0400
Message-ID: <46CEAB1B.9060908@garzik.org>
References: <46C1DCBB.9020308@double-you.de>	<20070814184301.3201d162@the-village.bc.nu>	<46C2047D.4040901@double-you.de> <20070815002447.40f7f206@the-village.bc.nu> <46CE8CC7.4080900@double-you.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50414 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760816AbXHXJzq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Aug 2007 05:55:46 -0400
In-Reply-To: <46CE8CC7.4080900@double-you.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Karim 'Kasi Mir' Senoucci <ks@double-you.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Karim 'Kasi Mir' Senoucci wrote:
> Alan Cox schrieb:
>>> in the sata_mv source. Should I add something like:
>>>
>>>         { PCI_VDEVICE(TTI, 0x2300), chip_604x },
>>>
>>> Yes
>>>     
> Just to not leave this thread hanging in the mail archives: this didn't 
> work for me. With the above patch, the controller is detected, but the 
> system hangs upon inclusion of the sata_mv driver. dmess shows:
> 
> [   32.240000] sata_mv 0000:06:00.0: version 0.81
> [   32.272000] ACPI: PCI Interrupt 0000:06:00.0[A] -> Done.Link [APC6] 
> ->GSI 16 (level, low) -> IRQ 17
> [   32.336000] sata_mv 0000:06:00.0: Applying B2 workarounds to unknown rev
> [   32.388000] sata_mv 0000:06:00.0: 32 slots 4 ports SCSI mode IRQ via 
> INTx
> [   32.432000] sata_mv: PCI ERROR; PCI IRQ cause=0x00000000
> [   32.464000] sata_mv: PCI ERROR; PCI IRQ cause=0x00000000
> [   32.496000] sata_mv: PCI ERROR; PCI IRQ cause=0x00000000
> [   32.528000] sata_mv: PCI ERROR; PCI IRQ cause=0x00000000
> [   32.560000] sata_mv: PCI ERROR; PCI IRQ cause=0x00000000
> [   32.592000] sata_mv: PCI ERROR; PCI IRQ cause=0x00000000
> 
> and many many more PCI ERRORS until I reboot the system. So, I guess 
> that particular Highpoint controller does not work yet with sata_mv.
> 
> Thanks very much for your efforts, anyway.

You need to use the sata_mv from kernel 2.6.23-rcX.

Patching into older drivers isn't guaranteed to work.

	Jeff



