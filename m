From: Jim Paris <jim@jtan.com>
Subject: smartctl causing HSM violation on sata_nv, 2.6.18
Date: Wed, 27 Sep 2006 14:33:39 -0400
Message-ID: <20060927183339.GA28174@jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:4304 "EHLO neurosis.jim.sh")
	by vger.kernel.org with ESMTP id S1030522AbWI0Sdm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Sep 2006 14:33:42 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi Tejun,

My NVIDIA SATA controller is having some problems with smartctl on
2.6.18 (+ the previously mentioned sata_nv patch).  If I try to enable
Attribute Autosafe (smartctl -S on) or Automatic Offline (smartctl -o
on), the controller craps out (but recovers).  Executing the same
command on an identical disk connected to a SiI3132 works fine.  Other
SMART stuff (reading attributes, running self-tests) seems to be
behaving just fine.  

-jim


### sata_nv controller (CK804):

# smartctl -data -S on /dev/disk/by-path/pci-0000:00:07.0-scsi-0:0:0:0
smartctl version 5.36 [x86_64-unknown-linux-gnu] Copyright (C) 2002-6 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF ENABLE/DISABLE COMMANDS SECTION ===
Error SMART Enable Auto-save failed: Input/output error
Smartctl: SMART Enable Attribute Autosave Failed.

A mandatory SMART command failed: exiting. To continue, add one or more '-T permissive' options.


### sata_sil24 controller (SiI3132):

# smartctl -data -S on /dev/disk/by-path/pci-0000:04:00.0-scsi-0:0:0:0
smartctl version 5.36 [x86_64-unknown-linux-gnu] Copyright (C) 2002-6 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF ENABLE/DISABLE COMMANDS SECTION ===
SMART Attribute Autosave Enabled.


### Kernel log for NVIDIA case:

[36911.153208] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[36911.153245] ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
[36911.462381] ata1: soft resetting port
[36911.618322] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[36911.620269] ata1.00: configured for UDMA/133
[36911.620277] ata1: EH complete
[36911.620410] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[36911.620442] ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
[36911.930163] ata1: soft resetting port
[36912.086097] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[36912.087984] ata1.00: configured for UDMA/133
[36912.087996] ata1: EH complete
[36912.088126] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[36912.088158] ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
[36912.397930] ata1: soft resetting port
[36912.553871] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[36912.555790] ata1.00: configured for UDMA/133
[36912.555801] ata1: EH complete
[36912.555931] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[36912.555963] ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
[36912.865705] ata1: soft resetting port
[36913.021646] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[36913.023482] ata1.00: configured for UDMA/133
[36913.023488] ata1: EH complete
[36913.023621] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[36913.023653] ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
[36913.333482] ata1: soft resetting port
[36913.489422] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[36913.491320] ata1.00: configured for UDMA/133
[36913.491327] ata1: EH complete
[36913.491461] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[36913.491493] ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
[36913.801255] ata1: soft resetting port
[36913.957198] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[36913.959100] ata1.00: configured for UDMA/133
[36913.959110] ata1: EH complete
[36913.959384] SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
[36913.959530] sda: Write Protect is off
[36913.959534] sda: Mode Sense: 00 3a 00 00
[36913.959801] SCSI device sda: drive cache: write back
[36913.960018] SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
[36913.960352] sda: Write Protect is off
[36913.960357] sda: Mode Sense: 00 3a 00 00
[36913.960544] SCSI device sda: drive cache: write back
