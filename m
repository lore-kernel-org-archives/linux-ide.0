From: Kevin Tomlinson <kevin@scarpgol.demon.co.uk>
Subject: Problem with SATA Silicon Image and Maxtor 6Y160M0
Date: Fri, 11 Feb 2005 22:21:55 +0000
Message-ID: <1108160515.4656.19.camel@fedora.scarpgold.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:6155 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S262371AbVBKWV4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Feb 2005 17:21:56 -0500
Received: from scarpgol.demon.co.uk ([80.177.31.11] helo=[192.168.0.20])
	by anchor-post-31.mail.demon.net with esmtp (Exim 4.42)
	id 1Czj9H-0007QZ-4J
	for linux-ide@vger.kernel.org; Fri, 11 Feb 2005 22:20:27 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Guys,

Struggling to get things working with my Silicon Image SATA controller
and my Maxtor 6Y160M0 drive and hoping you can help me.

Running. Fedora Core 2 running 2.6.10-1.12_FC2

Installed drive and thought all was going well. Fdisk working perfect
and partitioning. Decided to partition whole drive and then create
filesystem but system just hangs when attempting to create  filesystem. 

Hangs around block 270-330... every when using 'mkfs -t ext3 -c
/dev/sda1'

/var/adm/messages reports.

Feb 10 19:55:28 fedora kernel: ata1: status=0xd9 { Busy }
Feb 10 19:55:28 fedora kernel: Current sda: sense key No Sense
Feb 10 19:55:28 fedora kernel: ASC=93 ASCQ=f8
Feb 10 19:55:28 fedora kernel: ATA: abnormal status 0xD9 on port
0xF891CE87
Feb 10 19:55:28 fedora last message repeated 2 times
Feb 10 19:55:58 fedora kernel: ata1: command 0x35 timeout, stat 0xd9
host_stat 0x1
Feb 10 19:55:58 fedora kernel: ata1: status=0xd9 { Busy }
Feb 10 19:55:58 fedora kernel: Current sda: sense key No Sense
Feb 10 19:55:58 fedora kernel: ASC=93 ASCQ=f8
Feb 10 19:55:58 fedora kernel: ATA: abnormal status 0xD9 on port
0xF891CE87
Feb 10 19:55:58 fedora last message repeated 2 times
Feb 10 19:56:28 fedora kernel: ata1: command 0x35 timeout, stat 0xd9
host_stat 0x1


Controller is

02:0b.0 RAID bus controller: Silicon Image, Inc. (formerly CMD
Technology Inc) Silicon Image Serial ATARaid Controller [ CMD/Sil
3112/3112A ] (rev 02)
        Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc)
Asus A7N8X
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 9
        I/O ports at 9000 [size=dfd80000]
        I/O ports at 8c00 [size=4]
        I/O ports at 8800 [size=8]
        I/O ports at 8400 [size=4]
        I/O ports at 8000 [size=16]
        Memory at dfefdc00 (32-bit, non-prefetchable) [size=512]
        Expansion ROM at 00080000 [disabled]
        Capabilities: [60] Power Management version 2

Thanks
Kevin.

