From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: pata_sl82c105 can not reserve IO region
Date: Fri, 01 Dec 2006 22:05:28 +0300
Message-ID: <45707CF8.3090106@ru.mvista.com>
References: <20061130165202.GA23205@aepfle.de>	<20061130171049.7b80a40c@localhost.localdomain>	<20061130184748.GA24071@aepfle.de> <20061201183355.GA9701@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:14053 "EHLO
	imap.sh.mvista.com") by vger.kernel.org with ESMTP id S1759351AbWLATEA
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Dec 2006 14:04:00 -0500
In-Reply-To: <20061201183355.GA9701@aepfle.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

Olaf Hering wrote:

>>The printk in pci_request_region has 'bar + 1', so 6 should be possible
>>if i becomes 5.

> Does the IO region of the last bar look correct?

    I'd say it looks suspicious since it's not adjacent to all the other 
regions... In fact, after looking at your /proc/ioports/ I can say that the 
BAR is actually unassigned and its *actual* value is 0 which the driver may 
not like (the ones that lspci show are the physical memory addresses not the 
actual I/O space addresses in this case). That's why the reservation fails.

> 00:03.1 IDE interface: Symphony Labs SL82c105 (rev 05) (prog-if 8f [Master SecP SecO PriP PriO])
> 	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
> 	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Interrupt: pin A routed to IRQ 86
> 	Region 0: I/O ports at 3fd3000f000 [size=8]
> 	Region 1: I/O ports at 3fd3000f010 [size=4]
> 	Region 2: I/O ports at 3fd3000f020 [size=8]
> 	Region 3: I/O ports at 3fd3000f030 [size=4]
> 	Region 4: I/O ports at 3fd3000f040 [size=16]
> 	Region 5: I/O ports at 3fd30000000 [size=16]
> 00: ad 10 05 01 41 01 80 02 05 8f 01 01 08 48 80 00
> 10: 01 f0 00 00 11 f0 00 00 21 f0 00 00 31 f0 00 00
> 20: 41 f0 00 00 01 00 00 00 00 00 00 00 00 00 00 00

    Well, BAR5 is indeed 0.

> 30: 00 00 00 00 00 00 00 00 00 00 00 00 56 01 02 28
> 40: b3 08 ff 00 09 09 00 00 09 09 00 00 09 09 00 00
> 50: 09 09 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> name             "ide"
> linux,phandle    00d5cdc0 (14011840)
> assigned-addresses 81001910 00000000 0000f000 00000000 00000008 81001914
> 		 00000000 0000f010 00000000 00000004 81001918 00000000
> 		 0000f020 00000000 00000008 8100191c 00000000 0000f030
> 		 00000000 00000004 81001920 00000000 0000f040 00000000
> 		 00000010 81001924 00000000 00000000 00000000 00000010

    Yeah, the device tree has 0 for BAR5 too...

WBR, Sergei
