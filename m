From: Ryan Burchfield <rxb023100@utdallas.edu>
Subject: Drives not detected: sil3124 PMP to sil4726 5 drive enclosure
Date: Wed, 21 May 2008 11:31:25 -0500
Message-ID: <48344E5D.1040301@utdallas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp3.utdallas.edu ([129.110.20.110]:62899 "EHLO
	smtp3.utdallas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754793AbYEUQxl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 May 2008 12:53:41 -0400
Received: from [10.40.1.9] (unknown [10.40.1.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp3.utdallas.edu (Postfix) with ESMTPSA id A2D8123DFB
	for <linux-ide@vger.kernel.org>; Wed, 21 May 2008 11:31:25 -0500 (CDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi all,
I have done a bit of digging in the archives and find lots of related 
issues but no working solutions. I don't know if this should be 
considered a bug or not so help is appreciated.
I have a sil3124 chipset PCI card flashed with base(non-RAID) BIOS. 
Connected to this card I have a sil4726 chipset 5 drive enclosure with 
up to date firmware. The enclosure has been configured using a Windows 
machine with 2 750GB drives in RAID 1. So a host PC should see 1 logical 
750GB drive + configuration drive if my understanding is correct. I have 
tried many of the latest kernels but the drives are not detected correctly.

At the moment I have just tried the latest fixes at upstream-fixes @ 
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

Attached below is a dmesg log with the above specified kernel for the 
following action.
1) Boot computer
2) Begin recording dmesg log
3) Turn on sil4726 based drive enclosure
4) Wait for dmesg activity to settle
5) Stop logging

At the end of the process I have no additional disks in /dev/sd*.

Does anyone have any suggestions or any troubleshooting steps that I 
should try? What can I do to provide more useful information?

Thanks,
Ryan

--- Begin dmesg log ---
May 21 11:06:36 ryan1900 kernel: ata2: exception Emask 0x10 SAct 0x0 
SErr 0x0 action 0xe frozen
May 21 11:06:36 ryan1900 kernel: ata2: irq_stat 0x00b40090, PHY RDY changed
May 21 11:06:36 ryan1900 kernel: ata2: hard resetting link
May 21 11:06:40 ryan1900 kernel: ata2: SATA link up 3.0 Gbps (SStatus 
123 SControl 0)
May 21 11:06:40 ryan1900 kernel: ata2.15: Port Multiplier 1.1, 
0x1095:0x4726 r31, 3 ports, feat 0x1/0x9
May 21 11:06:40 ryan1900 kernel: ata2.00: hard resetting link
May 21 11:06:41 ryan1900 kernel: ata2.00: SATA link down (SStatus 0 
SControl 0)
May 21 11:06:41 ryan1900 kernel: ata2.01: hard resetting link
May 21 11:06:41 ryan1900 kernel: ata2.01: SATA link up 3.0 Gbps (SStatus 
123 SControl 0)
May 21 11:06:41 ryan1900 kernel: ata2.02: hard resetting link
May 21 11:06:41 ryan1900 kernel: ata2.02: SATA link down (SStatus 0 
SControl 320)
May 21 11:06:41 ryan1900 kernel: ata2.01: unsupported device, disabling
May 21 11:06:41 ryan1900 kernel: ata2.01: disabled
May 21 11:06:41 ryan1900 kernel: ata2: EH complete
May 21 11:06:56 ryan1900 kernel: ata2.00: failed to read SCR 1 (Emask=0x40)
May 21 11:06:56 ryan1900 kernel: ata2.01: failed to read SCR 1 (Emask=0x40)
May 21 11:06:56 ryan1900 kernel: ata2.02: failed to read SCR 1 (Emask=0x40)
May 21 11:06:56 ryan1900 kernel: ata2.15: exception Emask 0x10 SAct 0x0 
SErr 0x80000 action 0xe frozen
May 21 11:06:56 ryan1900 kernel: ata2.15: irq_stat 0x01140010, PHY RDY 
changed
May 21 11:06:56 ryan1900 kernel: ata2: SError: { 10B8B }
May 21 11:06:56 ryan1900 kernel: ata2.00: exception Emask 0x100 SAct 0x0 
SErr 0x0 action 0x6 frozen
May 21 11:06:56 ryan1900 kernel: ata2.01: exception Emask 0x100 SAct 0x0 
SErr 0x0 action 0x6 frozen
May 21 11:06:56 ryan1900 kernel: ata2.02: exception Emask 0x100 SAct 0x0 
SErr 0x0 action 0x6 frozen
May 21 11:06:56 ryan1900 kernel: ata2.15: hard resetting link
May 21 11:07:01 ryan1900 kernel: ata2.15: SATA link up 3.0 Gbps (SStatus 
123 SControl 0)
May 21 11:07:01 ryan1900 kernel: ata2.00: hard resetting link
May 21 11:07:02 ryan1900 kernel: ata2.00: SATA link down (SStatus 0 
SControl 0)
May 21 11:07:02 ryan1900 kernel: ata2.01: hard resetting link
May 21 11:07:02 ryan1900 kernel: ata2.01: SATA link up 3.0 Gbps (SStatus 
123 SControl 0)
May 21 11:07:02 ryan1900 kernel: ata2.02: hard resetting link
May 21 11:07:02 ryan1900 kernel: ata2.02: SATA link down (SStatus 0 
SControl 320)
May 21 11:07:02 ryan1900 kernel: ata2.01: unsupported device, disabling
May 21 11:07:02 ryan1900 kernel: ata2.01: disabled
May 21 11:07:02 ryan1900 kernel: ata2: EH complete

--- End dmesg log ---

