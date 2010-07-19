From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 16414] New: Panic during IO from both hard disk and CD-ROM on
 VIA IDE chipset using pata_via
Date: Mon, 19 Jul 2010 07:56:36 GMT
Message-ID: <bug-16414-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:43460 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756155Ab0GSH4h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jul 2010 03:56:37 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.4/8.14.3) with ESMTP id o6J7ua02019568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Mon, 19 Jul 2010 07:56:37 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=16414

           Summary: Panic during IO from both hard disk and CD-ROM on VIA
                    IDE chipset using pata_via
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.35-rc5
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: ben.livengood@gmail.com
        Regression: No


Created an attachment (id=27141)
 --> (https://bugzilla.kernel.org/attachment.cgi?id=27141)
netconsole output for three kernel panics.

On an Averatec 3220 (Athlon XP-M, 512 MB RAM) with a VIA VT82Cx IDE controller
I can trigger a kernel panic by performing IO on both the hard disk (80 GB
Samsung MP080AH) and CD/DVD drive (QSI CD-RW/DVD-ROM SBW-242) at the same time.

The simplest way to trigger the panic is just to dump a CD image to the hard
disk:

dd if=/dev/cdrom of=cd-image

Reading from both the CD drive and from the hard disk at the same time also
causes a panic.

I can reproduce the problem on 2.6.33.4, 2.6.34, and the latest 2.6.35-rc5+
branch from git.  This problem does not occur with the depreciated IDE/ATA
driver (BLK_DEV_VIA82CXXX) on any of the kernels I have tried.

I have another system with a similar VIA IDE controller and I can't reproduce
the panic on that system, so I am guessing the problem is with the Averatec
hardware/firmware.  I've tried booting with pci=noacpi and acpi=off, but that
didn't help either.  I've also tried compiling the kernel with and without
preemption and dynamic ticks but still had the same problem.

All the kernel panics begin with "divide error: 0000 [#1]" and rarely occur in
the same function.  Of the functions I looked at none had a DIV instruction at
the crash address.  I used netconsole to dump all the kernel messages to
another machine, which I think accounts for the "eth0: Too much work at
interrupt, status=0x00000002." messages I see mixed in with the backtraces and
other messages.

In my attempt to debug the problem I compiled and loaded a kexec crash-dump
kernel and it began booting after the panic but it hangs during tsc
calibration.  I tested the crash dump kernel by manually kexec'ing it and it
booted fine.  When I added a printk to display the value of the PIT's counter 0
during the calibration loop, it always prints 0x0000.

For one of the crashdumps I enabled some printk output in libata-sff.c to show
when an interrupt occurs (__ata_sff_interrupt) and when a command is issued to
the IDE controller (ata_sff_exec_command).  The output
(averatec-broken-ata.txt) shows several hundred interleaved commands to ata1
and ata2 before the panic, and I can't discern any pattern that might show why
the panic occurred.  Sometimes ata1 (the hard disk) was the last device to
receive a command, sometimes it was ata2 (the cd-rom).

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
