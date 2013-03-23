From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: ata: HDIO_DRIVE_* ioctl() Linux 3.9 regression
Date: Sat, 23 Mar 2013 09:20:41 +0100
Message-ID: <20130323082040.GA19848@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: gwendal@google.com, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi,

commit 84a9a8cd9d0aa93c17e5815ab8a9cc4c0a765c63
("[libata] Set proper SK when CK_COND is set") breaks
"SMART Status command" ATA command issued by
smartctl -d ata -a /dev/sda at least on FUJITSU MHV2060AH
on ICH6 IDE Controller. The kernel returns -EIO on
HDIO_DRIVE_TASK (0x31e) or HDIO_DRIVE_CMD (0x31f) ioctl,
probably due to RECOVERED_ERROR translated to -EIO.

The regression still exists in v3.9-rc3-218-g0a7e453.

Ancient smartctl like 5.33 give up after such error:

  smartctl version 5.33 [i686-pc-linux-gnu] Copyright (C) 2002-4 Bruce Allen
  Home page is http://smartmontools.sourceforge.net/
  
  === START OF INFORMATION SECTION ===
  Device Model:     FUJITSU MHV2060AH
  Serial Number:    NT29T5B2D23C
  Firmware Version: 00830096
  User Capacity:    60,011,642,880 bytes
  Device is:        Not in smartctl database [for details use: -P showall]
  ATA Version is:   6
  ATA Standard is:  ATA/ATAPI-6 T13 1410D revision 3a
  Local Time is:    Sat Mar 23 01:55:27 2013 CET
  SMART support is: Available - device has SMART capability.
  SMART support is: Enabled
  
  SMART Disabled. Use option -s with argument 'on' to enable it.

 # strace -x smartctl-5.33 -d ata -a /dev/sda 2>&1 | tail -n 10
  write(1, "SMART support is: Available - de"..., 59SMART support is: Available - device has SMART capability.
  ) = 59
  write(1, "SMART support is: Enabled\n", 26SMART support is: Enabled
  ) = 26
  write(1, "\n", 1
  )                       = 1
  ioctl(3, 0x31f, 0x7f98a240)             = -1 EIO (Input/output error)
  write(1, "SMART Disabled. Use option -s wi"..., 63SMART Disabled. Use option -s with argument 'on' to enable it.
  ) = 63
  exit_group(0)                           = ?


Newer smartctl versions (at least 6.1) just reports an error in such
case and continue:

  Error SMART Status command failed: Input/output error

 # strace -x smartctl-6.1 -d ata -a /dev/sda 2>&1
  ...
  ioctl(3, 0x31e, 0x7fac798c)             = -1 EIO (Input/output error)
  write(1, "Error SMART Status command faile"..., 54Error SMART Status command failed: Input/output error
  ...

On older kernels ioctl() returns 0 instead of -EIO.

Thanks,
Krzysiek
