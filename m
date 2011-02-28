From: Philippe De Muyter <phdm@macqel.be>
Subject: Intel ICH9M bug : sata unusable with usbserial
Date: Mon, 28 Feb 2011 15:01:50 +0100
Message-ID: <20110228140149.GA18189@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailrelay008.isp.belgacom.be ([195.238.6.174]:59675 "EHLO
	mailrelay008.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753915Ab1B1OBy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Feb 2011 09:01:54 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp2.macqel.be (Postfix) with ESMTP id CF395150AA2
	for <linux-ide@vger.kernel.org>; Mon, 28 Feb 2011 15:01:51 +0100 (CET)
Received: from smtp2.macqel.be ([127.0.0.1])
	by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KTDpxIgrn0MW for <linux-ide@vger.kernel.org>;
	Mon, 28 Feb 2011 15:01:50 +0100 (CET)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
	by smtp2.macqel.be (Postfix) with ESMTP id 25DEC150A82
	for <linux-ide@vger.kernel.org>; Mon, 28 Feb 2011 15:01:50 +0100 (CET)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I have encountered a big bug here with ICH9M hardware.
Switching to a newer kernel, namely 2.6.37-20-desktop (opensuse 11.4 rc1),
does not solve the problem.
The same application ran perfectly with an ICH7 hardware.

I have a serial GPS receiver connected to a USB port.

As long as I do not use it, even if it stays connected, my disk works
fine.  But, as soon as I start to listen to this USB serial GPS receiver,
I get errors for every disk access, until I reboot my computer :(

>From the messages below, DMA transfers block (READ DMA as below, and
I have seen WRITE DMA frozen also).

The running running processes keep running, and the GPS listening process
continues to get messages from the USB GPS receiver each second.

Is that a known (an fixed) problem ?

Here is a console log excerpt showing the messages appearing after I start
listening to my GPS USB receiver, recorded using netconsole :

 ata1: lost interrupt (Status 0x50)
 ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
 ata1.00: failed command: READ DMA
 ata1.00: cmd c8/00:08:88:40:01/00:00:00:00:00/e2 tag 0 dma 4096 in
	  res 40/00:00:01:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
 ata1.00: status: { DRDY }
 ata1: hard resetting link
 ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
 ata1.00: qc timeout (cmd 0x27)
 ata1.00: failed to read native max address (err_mask=0x4)
 ata1.00: revalidation failed (errno=-5)
 ata1: hard resetting link
 ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
 ata1.00: qc timeout (cmd 0x27)
 ata1.00: failed to read native max address (err_mask=0x4)
 ata1.00: revalidation failed (errno=-5)
 ata1: limiting SATA link speed to 1.5 Gbps
 ata1: hard resetting link
 ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
 ata1.00: qc timeout (cmd 0x27)
 ata1.00: failed to read native max address (err_mask=0x4)
 ata1.00: revalidation failed (errno=-5)
 ata1.00: disabled
 ata1: hard resetting link
 ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
 ata1: EH complete
 sd 0:0:0:0: [sda] Unhandled error code
 sd 0:0:0:0: [sda]  10.1.40.199 : Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
 sd 0:0:0:0: [sda] CDB: 10.1.40.199 : Read(10)10.1.40.199 : :10.1.40.199 :  2810.1.40.199 :  0010.1.40.199 :  0210.1.40.199 :  0110.1.40.199 :  4010.1.40.199 :  8810.1.40.199 :  0010.1.40.199 :  0010.1.40.199 :  0810.1.40.199 :  0010.1.40.199 :
 end_request: I/O error, dev sda, sector 33636488
 sd 0:0:0:0: [sda] Unhandled error code
 sd 0:0:0:0: [sda]  10.1.40.199 : Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
 sd 0:0:0:0: [sda] CDB: 10.1.40.199 : Write(10)10.1.40.199 : :10.1.40.199 :  2a10.1.40.199 :  0010.1.40.199 :  0010.1.40.199 :  4110.1.40.199 :  6710.1.40.199 :  d810.1.40.199 :  0010.1.40.199 :  0010.1.40.199 :  0810.1.40.199 :  0010.1.40.199 :
 end_request: I/O error, dev sda, sector 4286424
 quiet_error: 45 callbacks suppressed
 Buffer I/O error on device sda2, logical block 9723
 lost page write due to I/O error on sda2
 sd 0:0:0:0: [sda] Unhandled error code
 sd 0:0:0:0: [sda]  10.1.40.199 : Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
 sd 0:0:0:0: [sda] CDB: 10.1.40.199 : Write(10)10.1.40.199 : :10.1.40.199 :  2a10.1.40.199 :  0010.1.40.199 :  0110.1.40.199 :  8410.1.40.199 :  5e10.1.40.199 :  3010.1.40.199 :  0010.1.40.199 :  0410.1.40.199 :  0010.1.40.199 :  0010.1.40.199 :
 end_request: I/O error, dev sda, sector 25452080
 Buffer I/O error on device sda2, logical block 2655430
 lost page write due to I/O error on sda2
 sd 0:0:0:0: [sda] Unhandled error code
 sd 0:0:0:0: [sda]  10.1.40.199 : Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
 sd 0:0:0:0: [sda] CDB: 10.1.40.199 : Write(10)10.1.40.199 : :10.1.40.199 :  2a10.1.40.199 :  0010.1.40.199 :  0110.1.40.199 :  8410.1.40.199 :  6210.1.40.199 :  3010.1.40.199 :  0010.1.40.199 :  0010.1.40.199 :  c810.1.40.199 :  0010.1.40.199 :
 end_request: I/O error, dev sda, sector 25453104
 JBD2: Detected IO errors while flushing file data on sda2-8
 Aborting journal on device sda2-8.
 EXT4-fs (sda2): 10.1.40.199 : delayed block allocation failed for inode 793538 at logical offset 0 with max blocks 1 with error -3010.1.40.199 :
 EXT4-fs (sda2): 10.1.40.199 : This should not happen!! Data will be lost
 10.1.40.199 : [  150.577419]
 EXT4-fs error (device sda2) in ext4_da_writepages:3074: Journal has aborted

and here are some hardware info's :

 tmp199:~ # lspci
 00:00.0 Host bridge: Intel Corporation Mobile 4 Series Chipset Memory Controller Hub (rev 07)
 00:01.0 PCI bridge: Intel Corporation Mobile 4 Series Chipset PCI Express Graphics Port (rev 07)
 00:02.0 VGA compatible controller: Intel Corporation Mobile 4 Series Chipset Integrated Graphics Controller (rev 07)
 00:02.1 Display controller: Intel Corporation Mobile 4 Series Chipset Integrated Graphics Controller (rev 07)
 00:19.0 Ethernet controller: Intel Corporation 82567LM Gigabit Network Connection (rev 03)
 00:1a.0 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #4 (rev 03)
 00:1a.1 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #5 (rev 03)
 00:1a.2 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #6 (rev 03)
 00:1a.7 USB Controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI Controller #2 (rev 03)
 00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio Controller (rev 03)
 00:1c.0 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port 1 (rev 03)
 00:1c.1 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port 2 (rev 03)
 00:1c.2 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port 3 (rev 03)
 00:1c.3 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port 4 (rev 03)
 00:1d.0 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #1 (rev 03)
 00:1d.1 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #2 (rev 03)
 00:1d.2 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #3 (rev 03)
 00:1d.7 USB Controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI Controller #1 (rev 03)
 00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 93)
 00:1f.0 ISA bridge: Intel Corporation ICH9M LPC Interface Controller (rev 03)
 00:1f.2 IDE interface: Intel Corporation ICH9M/M-E 2 port SATA IDE Controller (rev 03)
 00:1f.3 SMBus: Intel Corporation 82801I (ICH9 Family) SMBus Controller (rev 03)
 00:1f.5 IDE interface: Intel Corporation ICH9M/M-E 2 port SATA IDE Controller (rev 03)
 02:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
 06:09.0 FireWire (IEEE 1394): VIA Technologies, Inc. VT6306/7/8 [Fire II(M)] IEEE 1394 OHCI Controller (rev 46)
 tmp199:~ #

Ask for more info if needed.

Thanks in advance

Philippe

-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
