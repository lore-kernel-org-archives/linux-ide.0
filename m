From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 111151] New: [pata_amd][pata_acpi] Internal base address
 register error prevents initialization of PATA drive
Date: Thu, 21 Jan 2016 19:55:31 +0000
Message-ID: <bug-111151-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35393 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908AbcAUTzf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Jan 2016 14:55:35 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id AD280202E9
	for <linux-ide@vger.kernel.org>; Thu, 21 Jan 2016 19:55:34 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 4E78420328
	for <linux-ide@vger.kernel.org>; Thu, 21 Jan 2016 19:55:32 +0000 (UTC)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=111151

            Bug ID: 111151
           Summary: [pata_amd][pata_acpi] Internal base address register
                    error prevents initialization of PATA drive
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 4.2.0-10-generic
          Hardware: i386
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: IDE
          Assignee: io_ide@kernel-bugs.osdl.org
          Reporter: andi3@gmx.net
        Regression: No

I guess this problem must have started when I replaced the mainboard of this
old machine from a ECS Elitegroup one to a DFI NFII Ultra-AL.

As there are so many different older DFIs, it's so easy to get confused by
them.

chipset: nVIDIA nForce2 Ultra 400 and nForce2 MCP
sata|ide interface: based on Marvell 88i8030 controller chip

First of all, you may NOT connect a SATA drive to the SATA port AND a PATA
drive to Primary _Master_. (PATA to Primary _Slave_ is OK.)
This is the crude specialty of this board, respectively of the Marvell chipset
used: the SATA drive will appear as PATA IDE channel 0! 

(NB: Can be very useful as in my case, because Victoria 3.3.3 (free) for DOS
will _always_ hang when accessing my add-in cards; no matter whether SiI, VIA
or Promise---tried them all. So this functionality is worth as gold, because
otherwise I couldn't operate on a SATA drive with Victoria that way.)

So why not get rid of my second add-on card and boot my Ubuntu off my onboard
SATA? 

EPIC FAIL...

Couldn't find root device.
Disconnected ALL drives BUT the SATA one with Ubuntu installed on it, plugged
it into the onboard port - root device not found.
I got the following, very cryptic, error:

[1.916367] pata_amd 0000:00:09.0: version 0.4.1
[1.916383] pata_amd 0000:00:09.0: can't enable device: BAR 0 [io  size 0x0008]
not assigned
[1.916453] pata_amd: probe of 0000:00:09.0 failed with error -22
[2.509228] pata_acpi 0000:00:09.0: can't enable device: BAR 0 [io  size 0x0008]
not assigned
[2.509299] pata_acpi: probe of 0000:00:09.0 failed with error -22


Took me quite awhile of googling, until I figured out that BAR stands for Base
Address Register.
OK, so it tries to enable the PATA drive via pata_amd, then as this fails, it
tries pata_acpi.

** Biggest problem: **
pata_amd has "absolutist power" in Linux 4.
There is no fallback if pata_amd fails.
So blacklisting it (modprobe.blacklist=...) gets rid of the error messages but
pretends as if the drive is not there.

** Also interesting: **
As mentioned, it does work in Victoria (DOS). Can boot off Hiren's Boot CD,
launch Victoria, initialize the drive, read its SMART data, and everything
else.

So the SATA/IDE controller combo _works_ on that board and it's clearly a Linux
kernel shortcoming.
Possibly this weird SATA-showing-up-as-IDE0 thing simply hasn't been thought
about yet.

As I assume that this problem might be a VERY tough task to debug, I could even
agree to send my physical mainboard via snail-mail to a kernel developer for
debugging on bit level.
Did I just make you laugh?
Well, it's no laughing matter. First of all, I doubt that w/o such kind of
board physically at hand (beware! they've become rare), there'll be anything to
do about that.
Second, another reason are the pata_amd / pata_acpi module messages which are
WAY too sparse and non-descriptive.


But we'll see...

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
