From: Rusty Conover <rconover@infogears.com>
Subject: Assistance with error
Date: Tue, 18 Nov 2008 00:59:19 -0700
Message-ID: <C907368E-3242-4D88-B879-AF621A17A93A@infogears.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.infogears.com ([69.51.90.143]:46172 "EHLO
	mail.infogears.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbYKRIV2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Nov 2008 03:21:28 -0500
Received: from mail.infogears.com (localhost.localdomain [127.0.0.1])
	by mail.infogears.com (Postfix) with ESMTP id 021D030980B1
	for <linux-ide@vger.kernel.org>; Tue, 18 Nov 2008 00:59:20 -0700 (MST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello Linux IDE Guys,

I'm encountering this error after a few days of decent load on the  
disks:

ata4.00: exception Emask 0x40 SAct 0x1 SErr 0x80800 action 0x6 frozen
ata4: SError: { HostInt 10B8B }
ata4.00: cmd 61/58:00:8d:40:08/00:00:01:00:00/40 tag 0 ncq 45056 out
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x44 (timeout)
ata4.00: status: { DRDY }
ata4: hard resetting link
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: configured for UDMA/133
ata4: EH complete
sd 3:0:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
sd 3:0:0:0: [sdd] Write Protect is off
sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
ata4.00: exception Emask 0x50 SAct 0x1 SErr 0x480900 action 0x6 frozen
ata4.00: irq_stat 0x08000000, interface fatal error
ata4: SError: { UnrecovData HostInt 10B8B Handshk }
ata4.00: cmd 61/08:00:fd:41:08/00:00:01:00:00/40 tag 0 ncq 4096 out
          res 40/00:00:fd:41:08/00:00:01:00:00/40 Emask 0x50 (ATA bus  
error)
ata4.00: status: { DRDY }
ata4: hard resetting link
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: qc timeout (cmd 0xec)
ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata4.00: revalidation failed (errno=-5)
ata4: failed to recover some devices, retrying in 5 secs
ata4: hard resetting link
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: configured for UDMA/133
ata4: exception Emask 0x40 SAct 0x0 SErr 0x80800 action 0x7 t4
ata4: SError: { HostInt 10B8B }
ata4: hard resetting link
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: configured for UDMA/133
ata4: EH complete
sd 3:0:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
sd 3:0:0:0: [sdd] Write Protect is off
sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 3:0:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
sd 3:0:0:0: [sdd] Write Protect is off
sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
ata4.00: exception Emask 0x40 SAct 0x1 SErr 0x80800 action 0x6 frozen
ata4: SError: { HostInt 10B8B }
ata4.00: cmd 61/08:00:fd:41:08/00:00:01:00:00/40 tag 0 ncq 4096 out
          res 40/00:00:fd:41:08/00:00:01:00:00/40 Emask 0x44 (timeout)
ata4.00: status: { DRDY }
ata4: hard resetting link
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: qc timeout (cmd 0x27)
ata4.00: failed to read native max address (err_mask=0x4)
ata4.00: HPA support seems broken, skipping HPA handling
ata4.00: revalidation failed (errno=-5)
ata4: failed to recover some devices, retrying in 5 secs
ata4: hard resetting link
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: qc timeout (cmd 0xec)
ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata4.00: revalidation failed (errno=-5)
ata4: failed to recover some devices, retrying in 5 secs
ata4: hard resetting link
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: configured for UDMA/133
ata4: exception Emask 0x40 SAct 0x0 SErr 0x80800 action 0x7 t4
ata4: SError: { HostInt 10B8B }
ata4: hard resetting link
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: configured for UDMA/133
ata4: EH complete
sd 3:0:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
sd 3:0:0:0: [sdd] Write Protect is off
sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 3:0:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
sd 3:0:0:0: [sdd] Write Protect is off
sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
ata4: limiting SATA link speed to 1.5 Gbps
ata4.00: exception Emask 0x40 SAct 0x1fe SErr 0x80800 action 0x6 frozen
ata4: SError: { HostInt 10B8B }
ata4.00: cmd 61/10:08:8d:77:4c/00:00:0f:00:00/40 tag 1 ncq 8192 out
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x44 (timeout)
ata4.00: status: { DRDY }
ata4.00: cmd 61/08:10:65:06:b4/00:00:16:00:00/40 tag 2 ncq 4096 out
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x44 (timeout)
ata4.00: status: { DRDY }
ata4.00: cmd 61/08:18:15:07:b4/00:00:16:00:00/40 tag 3 ncq 4096 out
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x44 (timeout)
ata4.00: status: { DRDY }
ata4.00: cmd 61/10:20:9d:9b:63/00:00:17:00:00/40 tag 4 ncq 8192 out
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x44 (timeout)
ata4.00: status: { DRDY }
ata4.00: cmd 61/08:28:25:58:3d/00:00:23:00:00/40 tag 5 ncq 4096 out
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x44 (timeout)
ata4.00: status: { DRDY }
ata4.00: cmd 61/08:30:d5:68:7e/00:00:25:00:00/40 tag 6 ncq 4096 out
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x44 (timeout)
ata4.00: status: { DRDY }
ata4.00: cmd 61/08:38:f5:ab:9e/00:00:32:00:00/40 tag 7 ncq 4096 out
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x44 (timeout)
ata4.00: status: { DRDY }
ata4.00: cmd 61/08:40:25:ac:9e/00:00:32:00:00/40 tag 8 ncq 4096 out
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x44 (timeout)
ata4.00: status: { DRDY }
ata4: hard resetting link
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata4.00: qc timeout (cmd 0xec)
ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata4.00: revalidation failed (errno=-5)
ata4: failed to recover some devices, retrying in 5 secs
ata4: hard resetting link
ata4: link is slow to respond, please be patient (ready=0)
ata4: softreset failed (device not ready)
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)

Its always on the same device sdd, I've swapped out the physical disks  
and the error persists.  Do you have any ideas what the cause could  
be?  I've checked connections, could it be a bad SATA cable?

The full dmesg output is available at:

http://www.infogears.com/disk-failure.log

Kernel is:

Linux version 2.6.26.6-79.fc9.i686.PAE (mockbuild@) (gcc version 4.3.0  
20080428 (Red Hat 4.3.0-8) (GCC) ) #1 SMP Fri Oct 17 1
4:38:28 EDT 2008

The FAQ mentions power issues being a possibility but I'm not sure if  
there is a way to tell if that is the cause since it it always the  
same device in a 6 device array.

Any insight would be most appreciated.

Thanks,

Rusty
--
Rusty Conover
rconover@infogears.com
InfoGears Inc / GearBuyer.com / FootwearBuyer.com
http://www.infogears.com
http://www.gearbuyer.com
http://www.footwearbuyer.com

