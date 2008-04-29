From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10574] New: Hard disk makes bad noise at poweroff when shutting down.
Date: Mon, 28 Apr 2008 17:55:43 -0700 (PDT)
Message-ID: <bug-10574-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44549 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754574AbYD2A4R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Apr 2008 20:56:17 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3T0thc4024625
	for <linux-ide@vger.kernel.org>; Mon, 28 Apr 2008 17:55:45 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=3D10574

           Summary: Hard disk makes bad noise at poweroff when shutting
                    down.
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.24
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: ron.w@web.de


Latest working kernel version: N/A.=20
Earliest failing kernel version: all the earlier kernels I know do have=
 this
problem.
Distribution: Sidux (Debian SID). Same on Sabayon (Gentoo), Kanotix (De=
bian,
Ubuntu), Knoppix (Debian), PowerCinemaLinux (PC-Linux).
Hardware Environment: Medion MD95500 =3D Arima W810-DCX
Software Environment: N/A
Problem Description:

It seems to be the same noise as described in #7674 for S-ATA devices e=
xactly.
Now it happens with Parallel Ultra-ATA /100 (ATA/ATAPI-6, UDMA5).

Hard Drive: Seagate ST9100823A, Firmware Version FW3.02
Controller: Intel ICH6M

This noise occurs on every shutdown from linux (and from linux only!) w=
hen it
powers down the machine. It does not happen on suspend-to-ram nor on
suspend-to-disk. Same bad noise as if cutting power by pressing the pow=
er
button for 4 seconds for emergency power off.

Kernel: Linux 2.6.24-2.6.24.4.slh.5-sidux-686 i686 [ sidux 2008-01 =CE=9D=
=CF=85=CE=BE -
kde-full - (200804120009) ]

In #7674 the given solution is:
>> 1. Check whether /sys/modules/libata/parameters/spindown_compat
>> exists. If it does, write 0 to it.

This file does not exist.

So where is that patch gone?


Steps to reproduce: Power down the Notebook using K-Menu entry or
shutdown-command on commandline. Will *not* happen on Suspend-to-Disk o=
r
Suspend-to-Ram.


--=20
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=3Demail
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
