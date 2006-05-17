From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [BUGREPORT 3/3] Kernel Oops with HPT372A IDE controller
Date: Wed, 17 May 2006 18:41:29 +0400
Message-ID: <446B3619.9090909@ru.mvista.com>
References: <200605142111.42329.it21@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:12493 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S932505AbWEQOma
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 May 2006 10:42:30 -0400
In-Reply-To: <200605142111.42329.it21@arcor.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 101551.753@compuserve.com
Cc: linux-ide@vger.kernel.org

Hello.

Foli Ayivoh wrote:

> This is lspci -vvv from ubuntu 5 distro bootable CD-ROM with kernel 2.6.12-9-386

> 0000:01:08.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
> 	Subsystem: Creative Labs: Unknown device 2001
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

    Looks like the PCI bus in question was running at 33 MHz...

> 0000:01:0a.0 RAID bus controller: Triones Technologies, Inc. HPT372A (rev 02)
> 	Subsystem: Triones Technologies, Inc.: Unknown device 0001
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 120 (2000ns min, 2000ns max)
> 	Interrupt: pin A routed to IRQ 16
> 	Region 0: I/O ports at 7c00 [size=8]
> 	Region 1: I/O ports at 8000 [size=4]
> 	Region 2: I/O ports at 8400 [size=8]
> 	Region 3: I/O ports at 8800 [size=4]
> 	Region 4: I/O ports at 8c00 [size=256]
> 	Capabilities: <available only to root>

    Please send me the results of running 'lspci -xxx -s 1:a' as root; disable 
the driver and rebuild/boot the kernel without it before doing this, so that I 
can see what the regs look like as the BIOS leaves them, untainted by the 
driver...

MBR, Sergei
