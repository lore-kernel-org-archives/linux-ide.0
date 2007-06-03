From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: YuLin: Where can I get the newest source of sata_sis?
Date: Mon, 04 Jun 2007 00:18:28 +0200
Message-ID: <46633E34.4060708@gmx.net>
References: <465E92EA.2050608@starsoftcomm.com> <465F206B.1080908@gmx.net> <465F9FEE.7030409@starsoftcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:58185 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751412AbXFCWS1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Jun 2007 18:18:27 -0400
In-Reply-To: <465F9FEE.7030409@starsoftcomm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?GB2312?B?0+HB1Q==?= <yulin@starsoftcomm.com>
Cc: linux-ide@vger.kernel.org


>>> When we used 2.6.18 and 2.6.20 on ASUS sis-671 motherboard, We have some
>>> problem: cannot find the harddisk controller.
>>> In BIOS, the SATA mode is 2P+2IDE.
>>>
>>> The official kernel 2.6.18, 2.6.20 and new 2.6.21 does not work, i get
>>> some information about sata_sis 0.7.1 from you, may I get it ?
>>>
>>> We are so urgent, please help me.
>>>
>>> Thank you very much!!!!
>>>     
>>>       
>> Asus is selling a P5X-MX SE motherboard with a SiS968
>> southbridge. The SiS671 Northbridge is not intresting for the SATA-support.
>> Currently it is only planned to support this chipset in
>> AHCI-mode. You should select the AHCI mode for the SATA-ports in the
>> BIOS. The ahci driver should support your board.
>> kernel 2.6.20 should be sufficient.
>> If this does not work, please provide the output of
>> lspci -vvxxx and the selected mode for the SATA-port.
>>
>>
>>     
>   new message:
> SATA harddisk mode: IDE in BIOS
> Port on SATA2 on motherboard failed. Dmesg said "ata2: SATA link down
> (SStatus 0 SControl 0)".
> Port on SATA1 on motherboard successed, found the harddisk and partitions.
>
> What is the difference between SATA1 port and SATA2 port on motherboard,
> is it a number of SATA port or different SATA version?
>
>   
The 966/968 has a primary and a secondary controller. Both controllers
are connected with 2 SATA-ports,a master and a slave port. That is
different to other SATA controllers.

The secondary controller on your board is not connected with SATA-ports.

The problem:
Slave only configurations may not work.If you are only connecting the
SATA-port 2, you have a slave only configuration.
The ata2 in your dmesg is the unused secondary controller.


I have retested the driver with SiS966 and kernel 2.6.22-rc3. It works
correctly on my board on all ports.

If you want to be sure that the disks are working
Please use the master device (port 1 on your board)
You can also try to use the kernel version i have tested.

Uwe Koziolek













