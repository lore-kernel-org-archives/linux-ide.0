From: Jim Paris <jim@jtan.com>
Subject: Disk stuck in error recovery loop with AHCI
Date: Wed, 21 Feb 2007 00:20:22 -0500
Message-ID: <20070221052022.GA15964@jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:56161 "EHLO neurosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965351AbXBUFU2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Feb 2007 00:20:28 -0500
Received: from neurosis.jim.sh (localhost [127.0.0.1])
	by neurosis.jim.sh (8.13.8/8.13.8/Debian-2) with ESMTP id l1L5KMTx016586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-ide@vger.kernel.org>; Wed, 21 Feb 2007 00:20:22 -0500
Received: (from jim@localhost)
	by neurosis.jim.sh (8.13.8/8.13.8/Submit) id l1L5KMA8016585
	for linux-ide@vger.kernel.org; Wed, 21 Feb 2007 00:20:22 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

For the past month or so I've been trying to track down data
corruption I'm seeing on my server.  It's something like 2-3 bits per
100 gigs of data, but only shows up on my 4-disk RAID5.  RAM is ECC
and fine.  Anyway, as part of my testing I swapped SATA controllers
many times (sata_nv, sata_sil24, sata_sil) then eventually switched
the motherboard/cpu/ram entirely and am now using an Intel chipset
with AHCI.  Turns out the corruption is still there (my current theory
is a bad disk or cables, doing more testing at the moment), but I saw
an error with AHCI that I hadn't seen before with the other
controllers.

Kernel is 2.6.20.  The onboard 6-port controller is:

00:1f.2 SATA controller: Intel Corporation 631xESB/632xESB SATA Storage Controller AHCI (rev 09)
00:1f.2 0106: 8086:2681 (rev 09)

It is set up in "Enhanced AHCI" mode in BIOS, because that's the only
mode in which all the disks are recognized.

After setting up the new machine, I was doing a MD "repair" operation on
the first two disks (RAID1) and the last four disks (RAID5):
   echo repair > /sys/block/md1/md/sync_action
   echo repair > /sys/block/md2/md/sync_action

Eventually I got the following errors on one of the disks in the raid1: 
(full dmesg is attached)

...
Feb 20 01:05:07 psychosis kernel: [11473.137130]          res 40/00:08:10:d7:4e/00:00:07:00:00/40 Emask 0x10 (ATA bus error)
Feb 20 01:05:07 psychosis kernel: [11473.449587] ata3: soft resetting port
Feb 20 01:05:07 psychosis kernel: [11473.952880] ata3: softreset failed, retrying in 5 secs
Feb 20 01:05:12 psychosis kernel: [11478.947007] ata3: hard resetting port
Feb 20 01:05:20 psychosis kernel: [11486.256966] ata3: port is slow to respond, please be patient (Status 0x80)
Feb 20 01:05:43 psychosis kernel: [11509.228781] ata3: hardreset failed, retrying in 5 secs
Feb 20 01:05:48 psychosis kernel: [11514.223105] ata3: hard resetting port
Feb 20 01:05:48 psychosis kernel: [11514.542508] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Feb 20 01:05:48 psychosis kernel: [11514.544548] ata3.00: configured for UDMA/133
Feb 20 01:05:48 psychosis kernel: [11514.544559] ata3: EH complete
Feb 20 01:05:48 psychosis kernel: [11514.544685] SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
Feb 20 01:05:48 psychosis kernel: [11514.544709] sda: Write Protect is off
Feb 20 01:05:48 psychosis kernel: [11514.544743] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb 20 01:05:57 psychosis kernel: [11523.816196]          res 40/00:00:10:7d:5f/00:00:07:00:00/40 Emask 0x10 (ATA bus error)
Feb 20 01:05:58 psychosis kernel: [11524.128039] ata3: soft resetting port
Feb 20 01:05:58 psychosis kernel: [11524.631101] ata3: softreset failed, retrying in 5 secs
Feb 20 01:06:03 psychosis kernel: [11529.625457] ata3: hard resetting port
Feb 20 01:06:10 psychosis kernel: [11536.935417] ata3: port is slow to respond, please be patient (Status 0x80)
Feb 20 01:06:33 psychosis kernel: [11559.907230] ata3: hardreset failed, retrying in 5 secs
Feb 20 01:06:39 psychosis kernel: [11564.901852] ata3: hard resetting port
Feb 20 01:06:39 psychosis kernel: [11565.221011] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Feb 20 01:06:39 psychosis kernel: [11565.223107] ata3.00: configured for UDMA/133
Feb 20 01:06:39 psychosis kernel: [11565.223118] ata3: EH complete
Feb 20 01:06:39 psychosis kernel: [11565.223245] SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
Feb 20 01:06:39 psychosis kernel: [11565.223268] sda: Write Protect is off
Feb 20 01:06:39 psychosis kernel: [11565.223301] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb 20 01:07:02 psychosis kernel: [11588.192660]          res 40/00:50:10:76:88/00:00:07:00:00/40 Emask 0x10 (ATA bus error)
Feb 20 01:07:02 psychosis kernel: [11588.192788]          res 40/00:50:10:76:88/00:00:07:00:00/40 Emask 0x10 (ATA bus error)
      (repeated 30 times total)
Feb 20 01:07:02 psychosis kernel: [11588.194209]          res 40/00:50:10:76:88/00:00:07:00:00/40 Emask 0x10 (ATA bus error)
Feb 20 01:07:02 psychosis kernel: [11588.504333] ata3: soft resetting port
Feb 20 01:07:03 psychosis kernel: [11589.007184] ata3: softreset failed, retrying in 5 secs
Feb 20 01:07:08 psychosis kernel: [11594.001540] ata3: hard resetting port
Feb 20 01:07:15 psychosis kernel: [11601.311499] ata3: port is slow to respond, please be patient (Status 0x80)
Feb 20 01:07:38 psychosis kernel: [11624.283314] ata3: hardreset failed, retrying in 5 secs
Feb 20 01:07:43 psychosis kernel: [11629.277637] ata3: hard resetting port
Feb 20 01:07:43 psychosis kernel: [11629.597039] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Feb 20 01:07:43 psychosis kernel: [11629.598746] ata3.00: configured for UDMA/133
Feb 20 01:07:43 psychosis kernel: [11629.598898] ata3: EH complete
...

This kept happening over and over, reducing the speed each time:

Feb 20 01:18:59 psychosis kernel: [12304.433025] ata3.00: limiting speed to UDMA/66
Feb 20 01:20:42 psychosis kernel: [12406.788586] ata3.00: limiting speed to UDMA/44
Feb 20 01:22:06 psychosis kernel: [12490.909166] ata3.00: limiting speed to UDMA/33
Feb 20 01:23:24 psychosis kernel: [12568.798521] ata3.00: limiting speed to UDMA/25
Feb 20 01:24:36 psychosis kernel: [12640.161835] ata3.00: limiting speed to UDMA/16
Feb 20 01:26:05 psychosis kernel: [12729.369247] ata3.00: limiting speed to PIO4
Feb 20 01:27:17 psychosis kernel: [12800.722750] ata3.00: limiting speed to PIO3
Feb 20 01:28:28 psychosis kernel: [12871.570376] ata3.00: limiting speed to PIO2
Feb 20 01:29:39 psychosis kernel: [12942.417995] ata3.00: limiting speed to PIO1
Feb 20 01:58:27 psychosis kernel: [13013.265629] ata3.00: limiting speed to PIO0

At this point I remember seeing on the console an error about how
speed-down was requested, but no lower speed modes were available; not
sure why that didn't get into the log.  But the messages kept coming:

Feb 20 01:58:27 psychosis kernel: [13650.934246]          res 40/00:20:10:ae:40/00:00:0d:00:00/40 Emask 0x4 (timeout)
Feb 20 01:58:27 psychosis kernel: [13651.245577] ata3: soft resetting port
Feb 20 01:58:27 psychosis kernel: [13651.245611] ata3: softreset failed, retrying in 5 secs
Feb 20 01:58:27 psychosis kernel: [13656.239963] ata3: hard resetting port
Feb 20 01:58:27 psychosis kernel: [13663.549923] ata3: port is slow to respond, please be patient (Status 0x80)
Feb 20 01:58:27 psychosis kernel: [13686.521729] ata3: hardreset failed, retrying in 5 secs
Feb 20 01:58:27 psychosis kernel: [13691.516061] ata3: hard resetting port
Feb 20 01:58:27 psychosis kernel: [13691.835461] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Feb 20 01:58:27 psychosis kernel: [13691.837090] ata3.00: configured for PIO0
Feb 20 01:58:27 psychosis kernel: [13691.837106] ata3: EH complete
Feb 20 01:58:27 psychosis kernel: [13721.785875]          res 40/00:20:10:ae:40/00:00:0d:00:00/40 Emask 0x4 (timeout)
Feb 20 01:58:27 psychosis kernel: [13722.097199] ata3: soft resetting port
Feb 20 01:58:27 psychosis kernel: [13722.097236] ata3: softreset failed, retrying in 5 secs
Feb 20 01:58:27 psychosis kernel: [13727.091584] ata3: hard resetting port
Feb 20 01:58:27 psychosis kernel: [13734.401547] ata3: port is slow to respond, please be patient (Status 0x80)
Feb 20 01:58:27 psychosis kernel: [13757.373357] ata3: hardreset failed, retrying in 5 secs
Feb 20 01:58:27 psychosis kernel: [13762.367683] ata3: hard resetting port
Feb 20 01:58:27 psychosis kernel: [13762.687085] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Feb 20 01:58:27 psychosis kernel: [13762.689015] ata3.00: configured for PIO0
Feb 20 01:58:27 psychosis kernel: [13762.689027] ata3: EH complete

etc etc.  Since this was one of the two disks in the RAID1 root
filesystem, all processes just froze while it tried over and over to
access the disk and went through the error handling sequence.  I guess
since the EH thought it completed successfully, it was never reported
to the MD layer as being a bad disk.

At this point I realized things were stuck.  I plugged a keyboard in,
then removed all 6 disks and replugged them (not knowing which one was
ata3).  The last one I tried was finally ata3, and I left that one out
so it would finally fail the disk:

...
Feb 20 01:58:27 psychosis kernel: [14665.593082] ata3: SATA link down (SStatus 0 SControl 300)
Feb 20 01:58:27 psychosis kernel: [14665.593089] ata3.00: disabled
Feb 20 01:58:27 psychosis kernel: [14666.096260] sd 2:0:0:0: SCSI error: return code = 0x08000002
Feb 20 01:58:27 psychosis kernel: [14666.096264] sda: Current [descriptor]: sense key: Aborted Command
Feb 20 01:58:27 psychosis kernel: [14666.096267]     Additional sense: No additional sense information
Feb 20 01:58:27 psychosis kernel: [14666.096270] Descriptor sense data with sense descriptors (in hex):
Feb 20 01:58:27 psychosis kernel: [14666.096272]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
Feb 20 01:58:27 psychosis kernel: [14666.096278]         00 00 00 00 
Feb 20 01:58:27 psychosis kernel: [14666.096282] end_request: I/O error, dev sda, sector 222342032
Feb 20 01:58:27 psychosis kernel: [14666.096731] sd 2:0:0:0: SCSI error: return code = 0x00010000
Feb 20 01:58:27 psychosis kernel: [14666.096734] end_request: I/O error, dev sda, sector 222342800
Feb 20 01:58:27 psychosis kernel: [14666.097039] md: super_written gets error=-5, uptodate=0
Feb 20 01:58:27 psychosis kernel: [14666.097044] ^IOperation continuing on 1 devices
..

Now that md failed the disk, the system came back to life and was
usable again.  I plugged ata3 back in, and it came up fine:

Feb 20 02:02:04 psychosis kernel: [14883.936792] ata3: waiting for device to spin up (8 secs)
Feb 20 02:02:12 psychosis kernel: [14892.125029] ata3: soft resetting port
Feb 20 02:02:12 psychosis kernel: [14892.125131] ata3: softreset failed, retrying in 5 secs
Feb 20 02:02:17 psychosis kernel: [14897.119415] ata3: hard resetting port
Feb 20 02:02:25 psychosis kernel: [14904.832598] ata3: port is slow to respond, please be patient (Status 0x80)
Feb 20 02:02:48 psychosis kernel: [14927.804508] ata3: hardreset failed, retrying in 5 secs
Feb 20 02:02:53 psychosis kernel: [14932.798737] ata3: hard resetting port
Feb 20 02:02:54 psychosis kernel: [14933.521359] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Feb 20 02:02:54 psychosis kernel: [14933.522135] ata3.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 31/32)
Feb 20 02:02:54 psychosis kernel: [14933.523485] ata3.00: configured for UDMA/133
Feb 20 02:02:54 psychosis kernel: [14933.523494] ata3: EH complete
Feb 20 02:02:54 psychosis kernel: [14933.523577] scsi 2:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
Feb 20 02:02:54 psychosis kernel: [14933.523661] SCSI device sdh: 625142448 512-byte hdwr sectors (320073 MB)
Feb 20 02:02:54 psychosis kernel: [14933.523672] sdh: Write Protect is off
Feb 20 02:02:54 psychosis kernel: [14933.523687] SCSI device sdh: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb 20 02:02:54 psychosis kernel: [14933.523741] SCSI device sdh: 625142448 512-byte hdwr sectors (320073 MB)
Feb 20 02:02:54 psychosis kernel: [14933.523750] sdh: Write Protect is off
Feb 20 02:02:54 psychosis kernel: [14933.523764] SCSI device sdh: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb 20 02:02:54 psychosis kernel: [14933.523768]  sdh: sdh1 sdh2
Feb 20 02:02:54 psychosis kernel: [14933.539428] sd 2:0:0:0: Attached scsi disk sdh

Because the error at [11588.19xx] was repeated 30 times, I suspected
NCQ.  I set the queue_depth on all 6 disks down to 1, and haven't seen
the same problem since, although once I did get:

Feb 20 22:01:01 psychosis kernel: [86680.771935]          res 50/00:00:57:58:70/00:00:00:00:00/e2 Emask 0x10 (ATA bus error)
Feb 20 22:01:01 psychosis kernel: [86681.083496] ata5: soft resetting port
Feb 20 22:01:01 psychosis kernel: [86681.083540] ata5: softreset failed, retrying in 5 secs
Feb 20 22:01:06 psychosis kernel: [86686.077882] ata5: hard resetting port
Feb 20 22:01:13 psychosis kernel: [86693.387842] ata5: port is slow to respond, please be patient (Status 0x80)
Feb 20 22:01:36 psychosis kernel: [86716.359653] ata5: hardreset failed, retrying in 5 secs
Feb 20 22:01:41 psychosis kernel: [86721.353980] ata5: hard resetting port
Feb 20 22:01:41 psychosis kernel: [86721.673381] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Feb 20 22:01:41 psychosis kernel: [86721.675047] ata5.00: configured for UDMA/133
Feb 20 22:01:41 psychosis kernel: [86721.675057] ata5: EH complete
Feb 20 22:01:42 psychosis kernel: [86721.687806] SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
Feb 20 22:01:42 psychosis kernel: [86721.690191] sdc: Write Protect is off
Feb 20 22:01:42 psychosis kernel: [86721.694914] SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA

I know it's been mentioned before that some disks have broken NCQ, but
it doesn't look like there's much in the kernel NCQ blacklist at the
moment, and the strange part is that I've never seen this problem with
the same disks and any of the other controllers I've tried that
supported NCQ (sata_nv, sata_sil24).  So I guess my concern here is
that this is actually related to AHCI in some way?

BTW - I just realized that dmesg has some error messages that are
missing from /var/log/messages, like the actual "exception Emask.."
lines.  Not sure what's up with that, but I'll give dmesg output too.

Full logs at
  http://jim.sh/~jim/ide/
Note that there's an identical disk that I sometimes had plugged into
the sata_sil24 controller; it wasn't being used at the time.

-jim
