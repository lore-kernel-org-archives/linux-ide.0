From: "Gabor FUNK" <FUNK.Gabor@hunetkft.hu>
Subject: JMicron - hard resetting link
Date: Tue, 12 Feb 2008 10:48:03 +0100
Message-ID: <009401c86d5c$5eb57bf0$4d0fa8c0@M2007>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-2";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.huweb.hu ([62.112.193.37]:41622 "EHLO ns1.huweb.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759422AbYBLKPc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 Feb 2008 05:15:32 -0500
Received: from 91.83.16.75.pool.invitel.hu ([91.83.16.75] helo=M2007)
	by ns1.huweb.hu with esmtpa (Exim 4.68)
	(envelope-from <FUNK.Gabor@hunetkft.hu>)
	id 1JOrkI-00078O-BZ
	for linux-ide@vger.kernel.org; Tue, 12 Feb 2008 10:48:12 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

Hi list,

I seem to have a bug with JMicron controller in a Gigabyte GA-N680SLI-DQ6 
motherboard.
http://www.gigabyte.com.tw/Support/Motherboard/BIOS_Model.aspx?ProductID=2460
Kernel is 2.6.24.
10 on-board SATA connectors, 2+4*JMicron 20360/20363 + 4*nVidia MCP55
2*200GB disks (System - SW RAID1) on the JMicron controller and
8*500 (Data - SW RAID6) - 4 on the JMicron, 4 on the nVidia controller.

Under heavy load the JMicron controller gets exceptions, then eventually 
"hard resetting link".
All 4 disks/connector, one after another. This of course "kills" the RAID

Excerpt from syslog
Feb  9 16:16:32 storage1 kernel: ata2.00: exception Emask 0x0 SAct 0x3ffff 
SErr 0x0 action 0x2 frozen
Feb  9 16:16:32 storage1 kernel: ata1.00: exception Emask 0x0 SAct 0x1fffff 
SErr 0x0 action 0x2 frozen
Feb  9 16:16:32 storage1 kernel: ata1.00: cmd 
61/08:00:73:12:d9/00:00:23:00:00/40 tag 0 ncq 4096 out
Feb  9 16:16:32 storage1 kernel:          res 
40/00:80:c3:7c:d3/00:01:23:00:00/40 Emask 0x4 (timeout)
Feb  9 16:16:32 storage1 kernel: ata1.00: status: { DRDY }
...
Feb  9 16:16:32 storage1 kernel: ata1.00: cmd 
61/80:a0:c3:1f:d9/00:00:23:00:00/40 tag 20 ncq 65536 out
Feb  9 16:16:32 storage1 kernel:          res 
40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Feb  9 16:16:32 storage1 kernel: ata1.00: status: { DRDY }
Feb  9 16:16:32 storage1 kernel: ata1: hard resetting link

Didn't dare to post all attachments, so
    full dmesg
    lspci -nn
    syslog - from the error start
can be downloaded from:
http://www.huweb.hu/maques/tmp/jmicron

I'm lost.
Anyone seen such thing? What could it be? Hardware (MB, chipset, BIOS), 
kernel (driver) or what?
Any suggestion? Kernel version to try, dispose hardware or shoot myself in 
the head?

Thanks,
Gabor 

