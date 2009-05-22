From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13365] New: 2.6.28+ cannot read a hard-drive properly through
 an "82801DB (ICH4) IDE Controller"
Date: Fri, 22 May 2009 23:16:15 GMT
Message-ID: <bug-13365-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:43577 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757295AbZEVXQO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 May 2009 19:16:14 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4MNGFg8007882
	for <linux-ide@vger.kernel.org>; Fri, 22 May 2009 23:16:15 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13365

           Summary: 2.6.28+ cannot read a hard-drive properly through an
                    "82801DB (ICH4) IDE Controller"
           Product: IO/Storage
           Version: 2.5
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: fun2program8@yahoo.com
        Regression: Yes


Created an attachment (id=21496)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=21496)
lscpi -vvvnn

This used to work in 2.6.27. 

It seems 2.6.28 or greater (tested with 2.6.28-gentoo-r5 and the latest stable
on kernel.org, 2.6.29.4) cannot use the Intel 82801DB (ICH4) IDE Controller
properly. The kernel will boot fine, and the init script will be launched, but
as soon as fsck does a check on whether the partition is /really/ fine before
the init services mount it, everything stops. fsck complains that there's a
different superblock count (few thousand difference) than what the partition
table claims.

If I bot back into 2.6.27 after booting into either of these kernels, fsck will
complain in a different way that there are errors in the file-system, but it
cleans it up and boot continues. If I reboot again into 2.6.27, then fsck
doesn't complain at all. However, as soon as I attempt .28 or .29, things go
awry again.

Attached is lspci -vvvnn output. A plain 'lspci' dump is provided below (for
Google purposes):
=== begin ===
00:00.0 Host bridge: Intel Corporation 82845G/GL[Brookdale-G]/GE/PE DRAM
Controller/Host-Hub Interface (rev 01)
00:02.0 VGA compatible controller: Intel Corporation 82845G/GL[Brookdale-G]/GE
Chipset Integrated Graphics Device (rev 01)
00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
USB UHCI Controller #1 (rev 01)
00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
USB UHCI Controller #2 (rev 01)
00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
USB UHCI Controller #3 (rev 01)
00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI
Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 81)
00:1f.0 ISA bridge: Intel Corporation 82801DB/DBL (ICH4/ICH4-L) LPC Interface
Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801DB (ICH4) IDE Controller (rev 01)
00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus
Controller (rev 01)
00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
01:07.0 Multimedia video controller: Conexant CX23880/1/2/3 PCI Video and Audio
Decoder (rev 05)
01:08.0 Network controller: Broadcom Corporation BCM4306 802.11b/g Wireless LAN
Controller (rev 03)
=== end ===

I think the important part is the IDE interface, but in case there's a conflict
in hardware I included it all.

Besides the Gentoo kernel and the vanilla kernel, I also have a unionfs patch.
However, I have left it out of the mix for 2.6.28 and .29 to make sure that
wasn't the cause.

This is my first _kernel_ bug report (*shiver* ;), so let me know if I'm
missing any info you need.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
