From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 52821] New: ata_piix ATA_HOST_IGNORE_ATA for Hyper-V also
 affects Virtual PC 7
Date: Sat, 19 Jan 2013 00:11:28 +0000 (UTC)
Message-ID: <bug-52821-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:54722 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092Ab3ASALc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jan 2013 19:11:32 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 6E2AD202AF
	for <linux-ide@vger.kernel.org>; Sat, 19 Jan 2013 00:11:31 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id C3433202C6
	for <linux-ide@vger.kernel.org>; Sat, 19 Jan 2013 00:11:28 +0000 (UTC)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D52821

           Summary: ata_piix ATA_HOST_IGNORE_ATA for Hyper-V also affec=
ts
                    Virtual PC 7
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 3.4+
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: linuxuser330250@gmx.net
        Regression: No


[PATCH 2/2] ata_piix: defer disks to the Hyper-V drivers by default
Sat, 14 Apr 2012 16:53:16 +0100

https://lkml.org/lkml/2012/4/14/136

This patch apparently also affects Virtual PC 7.0.3 for Mac, with the r=
esult
that only the emulated CD/DVD drive is visible to the system due to a m=
issing
paravirtualised
driver for the ATA device. An installation of Linux (with a kernel 3.4 =
and
newer) in the emulated environment of VPC7 is therefor impossible.

The problem seems to be that VPC7 also provides DMI 2.3, which also con=
tains
the strings "Microsoft Corporation" and "Virtual Machine" -- just like =
Hyper-V.

VPC6 (Connectix Virtual PC 6.0) is not affected. (UNCONFIRMED, but 99% =
sure:
there cannot be "Microsoft Corporation" in it, because it was from Conn=
ectix!)

I don=E2=80=99t know how, but piix_ignore_devices_quirk should either b=
e more thorough
in identifying Hyper-V or it should confirm that it is not running insi=
de
Virtual PC.

I would be happy to help with inside data, like a DMI dump or anything,=
 but
you=E2=80=99d have to tell me exactly what to do.

--=20
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=3Demai=
l
------- You are receiving this mail because: -------
You are watching the assignee of the bug.