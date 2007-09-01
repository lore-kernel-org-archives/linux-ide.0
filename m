From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: Re: ATA_PIIX - soft resetting port, port is slow to respond, machine
 "freezes" for a few seconds
Date: Sat, 01 Sep 2007 14:26:23 +0200
Message-ID: <46D95A6F.6060808@wpkg.org>
References: <46D94BBB.9080403@wpkg.org> <6b9952490709010500q2a93156cq399434a3a44a2d25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.syneticon.net ([213.239.212.131]:45682 "EHLO
	mail2.syneticon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754225AbXIAM0g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Sep 2007 08:26:36 -0400
In-Reply-To: <6b9952490709010500q2a93156cq399434a3a44a2d25@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joris <joris@v5.be>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Joris schrieb:
> Hello Tomasz,
> 
> 
> This appears remarkably simelar to what I'm experiencing, altough I'm
> getting that on sata ports.
> I'm currently at a loss on what caused this, but if there's two of us... ;-)
> See: http://marc.info/?l=linux-ide&m=118812690407577&w=2
> 
> What kind of hardware are you running?

It's a dual core Xeon.

Root filesystem starts off a 2 GB Transcend IDE flash disk, and there is 
a 4-disk RAID-10 array behind a hardware RAID, with LVM on it.

I noticed it doesn't soft reset anymore once the kernel said:

ata1.00: limiting speed to MWDMA1:PIO4


# lspci
00:00.0 Host bridge: Intel Corporation E7320 Memory Controller Hub (rev 0c)
00:00.1 Class ff00: Intel Corporation E7320 Error Reporting Registers 
(rev 0c)
00:02.0 PCI bridge: Intel Corporation E7525/E7520/E7320 PCI Express Port 
A (rev 0c)
00:03.0 PCI bridge: Intel Corporation E7525/E7520/E7320 PCI Express Port 
A1 (rev 0c)
00:1c.0 PCI bridge: Intel Corporation 6300ESB 64-bit PCI-X Bridge (rev 02)
00:1d.0 USB Controller: Intel Corporation 6300ESB USB Universal Host 
Controller (rev 02)
00:1d.1 USB Controller: Intel Corporation 6300ESB USB Universal Host 
Controller (rev 02)
00:1d.4 System peripheral: Intel Corporation 6300ESB Watchdog Timer (rev 02)
00:1d.5 PIC: Intel Corporation 6300ESB I/O Advanced Programmable 
Interrupt Controller (rev 02)
00:1d.7 USB Controller: Intel Corporation 6300ESB USB2 Enhanced Host 
Controller (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 0a)
00:1f.0 ISA bridge: Intel Corporation 6300ESB LPC Interface Controller 
(rev 02)
00:1f.1 IDE interface: Intel Corporation 6300ESB PATA Storage Controller 
(rev 02)
00:1f.3 SMBus: Intel Corporation 6300ESB SMBus Controller (rev 02)
01:00.0 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet 
Controller (rev 06)
01:00.1 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet 
Controller (rev 06)
03:02.0 RAID bus controller: LSI Logic / Symbios Logic MegaRAID (rev 01)
04:02.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
04:04.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U (rev 01)


-- 
Tomasz Chmielewski
http://wpkg.org
