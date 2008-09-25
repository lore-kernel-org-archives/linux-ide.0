From: "KueiHuan Chen" <kueihuan.chen@gmail.com>
Subject: SATA disk detect problem with silicon image 3132
Date: Thu, 25 Sep 2008 10:14:12 +0800
Message-ID: <788014650809241914h46b153e0w6d88c2a1c8c65df3@mail.gmail.com>
Reply-To: khchen@synology.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:65094 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360AbYIYCON (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Sep 2008 22:14:13 -0400
Received: by rv-out-0506.google.com with SMTP id k40so221053rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 24 Sep 2008 19:14:12 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello,

  I have some problem in detect sata disk with silicon image 3132 in
Marvell platform (arm).

  I am using kernel 2.6.24 with silicon image 3132 in Marvell 5281 /
6281 platform(Driver is sata_sil24). both would has same situation
like the messages below.

  The problem is when the 3132 has disk on it, it would know it. But
the identify command would timeout. After this, all ports would not
responce for any hotplug event.

  The interesting thing is when i change the 3132 with marvell 6145
sata chip(both using PCI-Express), and the driver using AHCI in
Marvell 6281 platform.  It just work.

  And when i use 3132 in x86 or MPC85xx platform(same kernel), it also
work fine. So i don't know where might has problem.  Is there any
hint/idea for me ?

  Thanks.

messages during Boot
Intergrated Sata device found
scsi0 : Marvell SCSI to SATA adapter
scsi1 : Marvell SCSI to SATA adapter
Driver 'sd' needs updating - please use bus_type methods
scsi2 : sata_sil24
scsi3 : sata_sil24
ata1: SATA max UDMA/100 host m128@0xe8084000 port 0xe8080000 irq 9
ata2: SATA max UDMA/100 host m128@0xe8084000 port 0xe8082000 irq 9
ata1: SATA link down (SStatus 0 SControl 0)
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: failed to recover some devices, retrying in 5 secs
ata2: controller in dubious state, performing PORT_RST
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: failed to recover some devices, retrying in 5 secs
ata2: controller in dubious state, performing PORT_RST
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: failed to recover some devices, retrying in 5 secs
ata2: controller in dubious state, performing PORT_RST
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
physmap platform flash device: 00400000 at f8000000
physmap-flash physmap-flash.0: map_probe failed
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
...
After this, hotplug would not detect by system.


------------------------------------
After boot, hotplug into port 2
ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xa frozen
ata2: irq_stat 0x00a40080, device exchanged
ata2: hard resetting link
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: failed to recover some devices, retrying in 5 secs
ata2: hard resetting link
ata2: controller in dubious state, performing PORT_RST
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: failed to recover some devices, retrying in 5 secs
ata2: hard resetting link
ata2: controller in dubious state, performing PORT_RST
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: failed to recover some devices, retrying in 5 secs
ata2: hard resetting link
ata2: controller in dubious state, performing PORT_RST
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
ata2: EH complete

After this, hotplug would not detect by system.
-- 
Best Regards,
KueiHuan-Chen
