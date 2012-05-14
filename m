From: Srikanth TS <ts.srikanth@samsung.com>
Subject: Detection failed after suspend and resume
Date: Mon, 14 May 2012 13:06:03 +0900
Message-ID: <002101cd3186$e0fda3b0$a2f8eb10$%srikanth@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:44491 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326Ab2ENEGF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 May 2012 00:06:05 -0400
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M3Z00IKUVE4RY90@mailout1.samsung.com> for
 linux-ide@vger.kernel.org; Mon, 14 May 2012 13:06:04 +0900 (KST)
Received: from DOTSSRIKANT01 ([12.23.118.165])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M3Z00CZJVE3BYF1@mmp1.samsung.com> for
 linux-ide@vger.kernel.org; Mon, 14 May 2012 13:06:03 +0900 (KST)
Content-language: en-gb
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello, 

I am using ahci_platform for SSD on ARM based SOC.

Device works fine with normal operations.
But device detection fails after suspend and resume.
I also see failure message while suspend.
 
Below is the log while going to suspend.
 
[   20.106194] Suspending console(s) (use no_console_suspend to debug)
[   20.130311] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   20.131393] sd 0:0:0:0: [sda] Stopping disk
[   20.180147] ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x10200 action 0xe frozen
[   20.180153] ata1.00: irq_stat 0x00400000, PHY RDY changed
[   20.180166] ata1.00: cmd e0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[   20.180170]          res 50/00:00:00:00:00/00:00:00:00:00/a0 Emask 0x10 (ATA bus error)
[   20.180182] ata1: hard resetting link
[   20.995041] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   20.995736] ata1.00: configured for UDMA/133
[   20.995745] ata1.00: device reported invalid CHS sector 0
[   20.995763] ata1: EH complete
[   20.995788] sd 0:0:0:0: [sda] START_STOP FAILED
[   20.995793] sd 0:0:0:0: [sda]  Result: hostbyte=0x00 driverbyte=0x08
[   20.995801] sd 0:0:0:0: [sda]  Sense Key : 0xb [current] [descriptor]
[   20.995811] sd 0:0:0:0: [sda]  ASC=0x0 ASCQ=0x0
[   20.995827] pm_op(): scsi_bus_suspend+0x0/0x18 returns 134217730

Below is the log while resume.

[   22.235070] ata1: SATA link down (SStatus 0 SControl 300)
[   27.080074] exnos_usb_drd_switch_worker:device not attached by host
[   27.560070] ata1: SATA link down (SStatus 0 SControl 300)
[   27.560086] ata1: limiting SATA link speed to 1.5 Gbps
[   32.885059] ata1: SATA link down (SStatus 0 SControl 310)
[   32.885075] ata1.00: disabled
[   32.885145] ata1.00: detaching (SCSI 0:0:0:0)
[   32.885203] sd 0:0:0:0: [sda] Starting disk
[   32.885306] sd 0:0:0:0: [sda] START_STOP FAILED
[   32.885316] sd 0:0:0:0: [sda]  Result: hostbyte=0x04 driverbyte=0x00
[   32.885339] pm_op(): scsi_bus_resume_common+0x0/0x58 returns 262144
[   32.885351] PM: Device 0:0:0:0 failed to resume async: error 262144

I am using all the libahci patches till 3.3 stable.

Any suggestions?

WBRs,
srikanth.

