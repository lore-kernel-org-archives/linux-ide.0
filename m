From: "Jason Davis" <mohadib@openactive.org>
Subject: Hotplug
Date: Tue, 2 Sep 2008 15:27:34 -0600
Message-ID: <27a624370809021427h5d619e03qf23ea426387b0a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.228]:16918 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbYIBV1h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Sep 2008 17:27:37 -0400
Received: by wx-out-0506.google.com with SMTP id h29so698620wxd.4
        for <linux-ide@vger.kernel.org>; Tue, 02 Sep 2008 14:27:34 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, "Boulder (Colorado) Linux Users Group -- General Mailing List" <lug@lug.boulder.co.us>

Hello,
 I'm trying to confirm hot/warm plugging is working on my system. When
I plug in the drive shows up as expected. I just want to make sure the
stuff I see in the logs is ok.

Thanks,
jason

jd@linux:~$ uname -a
Linux linux 2.6.18-6-686 #1 SMP Mon Aug 18 08:42:39 UTC 2008 i686 GNU/Linux

from kern.log when I plug in:

Sep  2 15:24:04 linux kernel: ata6: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x2 frozen
Sep  2 15:24:04 linux kernel: ata6: (irq_stat 0x00b00090, PHY RDY changed)
Sep  2 15:24:05 linux kernel: ata6: waiting for device to spin up (8 secs)
Sep  2 15:24:13 linux kernel: ata6: soft resetting port
Sep  2 15:24:17 linux kernel: ata6: SATA link up 3.0 Gbps (SStatus 123
SControl 300)
Sep  2 15:24:17 linux kernel: ata6.00: ATA-8, max UDMA/133, 1953525168
sectors: LBA48 NCQ (depth 31/32)
Sep  2 15:24:17 linux kernel: ata6.00: ata6: dev 0 multi count 0
Sep  2 15:24:17 linux kernel: ata6.00: configured for UDMA/100
Sep  2 15:24:17 linux kernel: ata6: EH complete
Sep  2 15:24:17 linux kernel:   Vendor: ATA       Model: WDC
WD10EACS-00D  Rev: 01.0
Sep  2 15:24:17 linux kernel:   Type:   Direct-Access
    ANSI SCSI revision: 05
Sep  2 15:24:17 linux kernel: SCSI device sdc: 1953525168 512-byte
hdwr sectors (1000205 MB)
Sep  2 15:24:17 linux kernel: sdc: Write Protect is off
Sep  2 15:24:17 linux kernel: sdc: Mode Sense: 00 3a 00 00
Sep  2 15:24:17 linux kernel: SCSI device sdc: drive cache: write back
Sep  2 15:24:17 linux kernel: SCSI device sdc: 1953525168 512-byte
hdwr sectors (1000205 MB)
Sep  2 15:24:17 linux kernel: sdc: Write Protect is off
Sep  2 15:24:17 linux kernel: sdc: Mode Sense: 00 3a 00 00
Sep  2 15:24:17 linux kernel: SCSI device sdc: drive cache: write back
Sep  2 15:24:17 linux kernel:  sdc: sdc1
Sep  2 15:24:17 linux kernel: sd 5:0:0:0: Attached scsi disk sdc
Sep  2 15:24:47 linux kernel: kjournald starting.  Commit interval 5 seconds
Sep  2 15:24:47 linux kernel: EXT3 FS on sdc1, internal journal
Sep  2 15:24:47 linux kernel: EXT3-fs: mounted filesystem with ordered
data mode.




When I unplug:
root@linux:~# umount /mnt/other
root@linux:~# echo 1 > /sys/class/scsi_device/5\:0\:0\:0/device/delete


Sep  2 15:26:01 linux kernel: ata6.00: disabled
Sep  2 15:26:13 linux kernel: ata6: exception Emask 0x10 SAct 0x0 SErr
0x80000 action 0x2 frozen
Sep  2 15:26:13 linux kernel: ata6: (irq_stat 0x01140010, PHY RDY changed)
Sep  2 15:26:14 linux kernel: ata6: soft resetting port
Sep  2 15:26:14 linux kernel: ata6: SATA link down (SStatus 0 SControl 300)
Sep  2 15:26:14 linux kernel: ata6: EH complete
