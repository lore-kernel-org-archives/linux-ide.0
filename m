From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13882] New: Cannot read CD: "Logical unit communication CRC
 error"
Date: Thu, 30 Jul 2009 22:44:31 GMT
Message-ID: <bug-13882-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:52815 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbZG3Wob (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jul 2009 18:44:31 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n6UMiV6B011110
	for <linux-ide@vger.kernel.org>; Thu, 30 Jul 2009 22:44:31 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13882

           Summary: Cannot read CD: "Logical unit communication CRC error"
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.27.10
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: python.dev.9@gmail.com
        Regression: Yes


I have an official Ubuntu 9.04 (Jaunty) CD ordered using the Ubuntu ShipIt
service.  I put the disc in my DVD drive and attempt to validate the contents
of the CD using the following command:

md5sum -c md5sum.txt | grep -vi 'OK$'

This returns the following error message in the terminal:

md5sum: ./casper/filesystem.squashfs: Input/output error
./casper/filesystem.squashfs: FAILED open or read
md5sum: WARNING: 1 of 65 listed files could not be read

Opening /var/log/messages in a text editor shows the following:

Jul 30 18:12:23 phoenix kernel: [  724.994491] UDF-fs: No VRS found
Jul 30 18:12:23 phoenix kernel: [  724.994500] UDF-fs: No partition found (1)
Jul 30 18:13:12 phoenix kernel: [  773.810949] sr 1:0:1:0: [sr0] Unhandled
sense code
Jul 30 18:13:12 phoenix kernel: [  773.810958] sr 1:0:1:0: [sr0] Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Jul 30 18:13:12 phoenix kernel: [  773.810964] sr 1:0:1:0: [sr0] Sense Key :
Hardware Error [current] 
Jul 30 18:13:12 phoenix kernel: [  773.810971] sr 1:0:1:0: [sr0] Add. Sense:
Logical unit communication CRC error (Ultra-DMA/32)

The earliest kernel I have found that reproduces this bug is 2.6.27.10.
The latest kernel I have found that works as expected is 2.6.24.6.
This bug is reproducible using the latest stable kernel (2.6.30.3).

All these tests were conducted on a Ubuntu 8.10 (Intrepid) system, and all
kernel versions specified are mainline kernels (not Ubuntu distributed kernels)
installed using the instructions at
https://wiki.ubuntu.com/KernelTeam/MainlineBuilds.

The DVD drive used is a Lite-On 201AH DVDRW, firmware revision LL0D.  This is
an IDE drive.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
