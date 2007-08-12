From: babl <babl1986@gmail.com>
Subject: Re: regression problem with Maxtor disk
Date: Mon, 13 Aug 2007 03:36:10 +0400
Message-ID: <200708130336.10603.babl1986@gmail.com>
Reply-To: babl1986@gmail.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.225]:37531 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934696AbXHLXgR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Aug 2007 19:36:17 -0400
Received: by hu-out-0506.google.com with SMTP id 19so1083085hue
        for <linux-ide@vger.kernel.org>; Sun, 12 Aug 2007 16:36:15 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I think, it's sata_nv driver problem. I have same bug too.

MB: ASUS A8N SLI Deluxe (nforce4 sli + sil3114)
Power: FSP Epsilon 700W
/dev/disk/by-id/scsi-SATA_Maxtor_6B200M0_B404ZB9H
/dev/disk/by-id/scsi-SATA_SAMSUNG_HD401LJS0HVJ1CP105426
/dev/disk/by-id/scsi-SATA_WDC_WD3200JD-00_WD-WCAMR1623763
/dev/disk/by-id/scsi-SATA_WDC_WD3200JS-00_WD-WCAPD1127756
/dev/disk/by-id/scsi-SATA_WDC_WD3200JS-00_WD-WCAPD2176538
/dev/disk/by-id/scsi-SATA_WDC_WD3200JS-60_WD-WCAPD2515626
/dev/disk/by-id/scsi-SATA_WDC_WD3200KS-00_WD-WCAPD2510753
/dev/disk/by-id/scsi-SATA_WDC_WD3200KS-00_WD-WCAPD3248212

When I try to copy files from one HDD to another, i have freeses and low 
speed. There are soft and hard resets here and regression from UDMA/133 to 
PIO.


2.6.18 (HD400LJ):
Aug 13 03:16:52 bobr kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr 
0x580000 action 0x2
Aug 13 03:16:52 bobr kernel: ata4.00: (BMDMA stat 0x20)
Aug 13 03:16:52 bobr kernel: ata4.00: tag 0 cmd 0x35 Emask 0x10 stat 0x51 err 
0x84 (ATA bus error)
Aug 13 03:16:53 bobr kernel: ata4: soft resetting port
Aug 13 03:16:53 bobr kernel: ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 
300)
Aug 13 03:16:53 bobr kernel: ata4.00: configured for UDMA/100
Aug 13 03:16:53 bobr kernel: ata4: EH complete
Aug 13 03:16:53 bobr kernel: SCSI device sdd: 625142448 512-byte hdwr sectors 
(320073 MB)
Aug 13 03:16:53 bobr kernel: sdd: Write Protect is off
Aug 13 03:16:54 bobr kernel: sdd: Mode Sense: 00 3a 00 00
Aug 13 03:16:54 bobr kernel: SCSI device sdd: drive cache: write back
Aug 13 03:17:28 bobr kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr 
0x180000 action 0x2 frozen
Aug 13 03:17:28 bobr kernel: ata4.00: (BMDMA stat 0x21)
Aug 13 03:17:28 bobr kernel: ata4.00: tag 0 cmd 0x35 Emask 0x4 stat 0x40 err 
0x0 (timeout)
Aug 13 03:17:35 bobr kernel: ata4: port is slow to respond, please be patient
Aug 13 03:17:59 bobr kernel: ata4: port failed to respond (30 secs)
Aug 13 03:17:59 bobr kernel: ata4: soft resetting port
Aug 13 03:17:59 bobr kernel: ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 
300)
Aug 13 03:17:59 bobr kernel: ata4.00: configured for UDMA/100
Aug 13 03:17:59 bobr kernel: ata4: EH complete
Aug 13 03:18:00 bobr kernel: SCSI device sdd: 625142448 512-byte hdwr sectors 
(320073 MB)
Aug 13 03:18:00 bobr kernel: sdd: Write Protect is off
Aug 13 03:18:00 bobr kernel: sdd: Mode Sense: 00 3a 00 00
Aug 13 03:18:00 bobr kernel: SCSI device sdd: drive cache: write back


2.6.23-rc2 (HD401LJ NCQ BLACKLISTED!!!):
Aug 12 23:39:54 bobr kernel: ata5: timeout waiting for ADMA IDLE, stat=0x440
Aug 12 23:39:54 bobr kernel: ata5.00: exception Emask 0x1 SAct 0x0 SErr 
0x380000 action 0x2
Aug 12 23:39:54 bobr kernel: ata5.00: CPB resp_flags 0x11: , CMD error
Aug 12 23:39:54 bobr kernel: ata5.00: cmd 25/00:d0:f9:6c:b9/00:01:17:00:00/e0 
tag 0 cdb 0x0 data 237568 in
Aug 12 23:39:54 bobr kernel:          res 51/84:df:ea:6d:b9/84:00:17:00:00/e0 
Emask 0x10 (ATA bus error)
Aug 12 23:39:54 bobr kernel: ata5: soft resetting port
Aug 12 23:39:55 bobr kernel: ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 
300)
Aug 12 23:39:55 bobr kernel: ata5.00: configured for UDMA/133
Aug 12 23:39:55 bobr kernel: ata5: EH complete
Aug 12 23:39:55 bobr kernel: sd 4:0:0:0: [sde] 781422768 512-byte hardware 
sectors (400088 MB)
Aug 12 23:39:55 bobr kernel: sd 4:0:0:0: [sde] Write Protect is off
Aug 12 23:39:55 bobr kernel: sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
Aug 12 23:39:56 bobr kernel: sd 4:0:0:0: [sde] Write cache: enabled, read 
cache: enabled, doesn't support DPO or FUA
Aug 12 23:40:46 bobr kernel: t. Dev: usb-0000:00:02.0-6/input0, Type: 2, Code: 
1, Value: 1
Aug 12 23:40:47 bobr kernel: ata5: EH in ADMA mode, notifier 0x0 
notifier_error 0x0 gen_ctl 0x1501000 status 0x400 next cpb count 0x0 next cpb 
idx 0x0
Aug 12 23:40:47 bobr kernel: ata5: CPB 0: ctl_flags 0xd, resp_flags 0x0
Aug 12 23:40:47 bobr kernel: ata5: timeout waiting for ADMA IDLE, stat=0x400
Aug 12 23:40:47 bobr kernel: ata5: timeout waiting for ADMA LEGACY, stat=0x400
Aug 12 23:40:47 bobr kernel: ata5: limiting SATA link speed to 1.5 Gbps
Aug 12 23:40:47 bobr kernel: ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 
action 0x6 frozen
Aug 12 23:40:47 bobr kernel: ata5.00: cmd 25/00:00:79:76:a3/00:02:17:00:00/e0 
tag 0 cdb 0x0 data 262144 in
Aug 12 23:40:47 bobr kernel:          res 40/00:8f:ba:10:a0/84:01:17:00:00/e0 
Emask 0x4 (timeout)
Aug 12 23:40:47 bobr kernel: ata5: hard resetting port
Aug 12 23:40:47 bobr kernel: ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 
310)
Aug 12 23:40:47 bobr kernel: ata5.00: configured for UDMA/133
Aug 12 23:40:47 bobr kernel: ata5: EH complete
Aug 12 23:40:47 bobr kernel: sd 4:0:0:0: [sde] 781422768 512-byte hardware 
sectors (400088 MB)
Aug 12 23:40:48 bobr kernel: sd 4:0:0:0: [sde] Write Protect is off
Aug 12 23:40:48 bobr kernel: sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
Aug 12 23:40:48 bobr kernel: sd 4:0:0:0: [sde] Write cache: enabled, read 
cache: enabled, doesn't support DPO or FUA



There is no connectors and power errors, i try to use many cables and bug is 
present. When I try to disable HD401LJ, I see the same bug on WD HDDs on 
ata1,2,3,4.... =(

I think, it's a sata_nv or sil3114 driver bug, in this mailing lists there are 
many same problems with this chipset.
