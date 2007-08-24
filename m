From: Karim 'Kasi Mir' Senoucci <ks@double-you.de>
Subject: Re: Should sata_mv work with Highpoint RocketRAID 2300?
Date: Fri, 24 Aug 2007 09:46:15 +0200
Message-ID: <46CE8CC7.4080900@double-you.de>
References: <46C1DCBB.9020308@double-you.de>	<20070814184301.3201d162@the-village.bc.nu>	<46C2047D.4040901@double-you.de> <20070815002447.40f7f206@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.melzone.de ([81.169.156.183]:33259 "EHLO mx1.melzone.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753974AbXHXIUj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Aug 2007 04:20:39 -0400
In-Reply-To: <20070815002447.40f7f206@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox schrieb:
>> in the sata_mv source. Should I add something like:
>>
>>         { PCI_VDEVICE(TTI, 0x2300), chip_604x },
>>
>> Yes
>>     
Just to not leave this thread hanging in the mail archives: this didn't 
work for me. With the above patch, the controller is detected, but the 
system hangs upon inclusion of the sata_mv driver. dmess shows:

[   32.240000] sata_mv 0000:06:00.0: version 0.81
[   32.272000] ACPI: PCI Interrupt 0000:06:00.0[A] -> Done.Link [APC6] 
->GSI 16 (level, low) -> IRQ 17
[   32.336000] sata_mv 0000:06:00.0: Applying B2 workarounds to unknown rev
[   32.388000] sata_mv 0000:06:00.0: 32 slots 4 ports SCSI mode IRQ via INTx
[   32.432000] sata_mv: PCI ERROR; PCI IRQ cause=0x00000000
[   32.464000] sata_mv: PCI ERROR; PCI IRQ cause=0x00000000
[   32.496000] sata_mv: PCI ERROR; PCI IRQ cause=0x00000000
[   32.528000] sata_mv: PCI ERROR; PCI IRQ cause=0x00000000
[   32.560000] sata_mv: PCI ERROR; PCI IRQ cause=0x00000000
[   32.592000] sata_mv: PCI ERROR; PCI IRQ cause=0x00000000

and many many more PCI ERRORS until I reboot the system. So, I guess 
that particular Highpoint controller does not work yet with sata_mv.

Thanks very much for your efforts, anyway.

Greetings, Karim.

