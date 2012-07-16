From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 44871] New: Kernel Panic during IO from CD-ROM related to 16414
Date: Mon, 16 Jul 2012 16:01:24 +0000 (UTC)
Message-ID: <bug-44871-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:55111 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592Ab2GPQB2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Jul 2012 12:01:28 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 846C22022D
	for <linux-ide@vger.kernel.org>; Mon, 16 Jul 2012 16:01:27 +0000 (UTC)
Received: from bugzilla.kernel.org (unknown [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 82D8C20187
	for <linux-ide@vger.kernel.org>; Mon, 16 Jul 2012 16:01:25 +0000 (UTC)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=44871

           Summary: Kernel Panic during IO from CD-ROM related to 16414
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 3.2.0-3-686-pae, 3.4-trunk-686-pae
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: old_man999@gmx.de
        Regression: Yes


see <a href="http://bugzilla.kernel.org/show_bug.cgi?id=16414">16414</a>

17: SCSI 100.0: 10602 CD-ROM (DVD)                              
  [Created at block.247]
  UDI:
/org/freedesktop/Hal/devices/storage_serial_Samsung_CD_RW_DVD_ROM_SN_324B
  Unique ID: KD9E.rXgP8cnoGhD
  Parent ID: +Y+h.mcsZ0a690T4
  SysFS ID: /class/block/sr0
  SysFS BusID: 1:0:0:0
  SysFS Device Link: /devices/pci0000:00/0000:00:11.1/host1/target1:0:0/1:0:0:0
  Hardware Class: cdrom
  Model: "SAMSUNG CDRW/DVD SN-324B"
  Vendor: "SAMSUNG"
  Device: "CDRW/DVD SN-324B"
  Revision: "u103"
  Driver: "pata_via", "sr"
  Driver Modules: "pata_via"
  Device File: /dev/sr0 (/dev/sg1)
  Device Files: /dev/sr0, /dev/cdrom1, /dev/cdrw1,
/dev/disk/by-id/ata-Samsung_CD-RW_DVD-ROM_SN-324B,
/dev/disk/by-path/pci-0000:00:11.1-scsi-1:0:0:0, /dev/dvd1
  Device Number: block 11:0 (char 21:1)
  Features: CD-R, CD-RW, DVD

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
