From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14515] New: ATA controller losing interrupt, system stall
Date: Sat, 31 Oct 2009 01:19:42 GMT
Message-ID: <bug-14515-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:60923 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757587AbZJaBTh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Oct 2009 21:19:37 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n9V1Jgx3022233
	for <linux-ide@vger.kernel.org>; Sat, 31 Oct 2009 01:19:42 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14515

           Summary: ATA controller losing interrupt, system stall
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.31
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: lloyd@fusion.net.nz
        Regression: Yes


Created an attachment (id=23602)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=23602)
Kernel Log

I've just encountered a problem when moving from Ubuntu 9.04 to 9.10. There are
large stalls every now and again and looking at the kernel log, I'm getting
lost interrupts on the ATA interface. This did not happen with the previous
2.6.28 kernel.

Here's a sample from the log.

[   86.816503] ata1: lost interrupt (Status 0x58)
[   86.820070] ata1: drained 32768 bytes to clear DRQ.
[   86.928979] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[   86.929068] ata1.01: cmd a0/00:00:00:00:00/00:00:00:00:00/b0 tag 0
[   86.929070]          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
[   86.929072]          res 58/00:01:00:00:00/00:00:00:00:00/b0 Emask 0x2 (HSM
violation)
[   86.929277] ata1.01: status: { DRDY DRQ }
[   86.929353] ata1: soft resetting link

This is on an Acer Aspire laptop with a PIIX chipset and an Intel Mobile 945
GMA

The hard disk is a PATA WD600UE.

See attached kernel log and pci dump.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
