From: Phill Jolliffe <phill.jolliffe@gmail.com>
Subject: PMP 3726 problem?
Date: Thu, 30 Dec 2010 00:44:56 +0000
Message-ID: <AANLkTi=6yROpG+nXHYPqHwbQucwQqmrai9yCyx=GFCPG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60434 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754503Ab0L3Ap1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Dec 2010 19:45:27 -0500
Received: by wwa36 with SMTP id 36so11193855wwa.1
        for <linux-ide@vger.kernel.org>; Wed, 29 Dec 2010 16:45:26 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I'm having probelms with a DAS401 edge store disk enclosure. I have
4x Hitachi HDS72202 loaded into it. Wonder is this is a PMP driver
problem?

Unfortunately I have less than 50% chance on any given system startup
that the disks are detected. As best I can tell the the DAS401 uses a
SiI3726 Port-Multiplier built into the enclosure. I connect this to
the mobo single esata builtin port.

My mobo is a Gigabyte H55N-USB3

[root@JollyBox ~]# uname -a
Linux JollyBox 2.6.18-194.26.1.el5xen #1 SMP Tue Nov 9 13:35:30 EST
2010 x86_64 x86_64 x86_64 GNU/Linux

In the below log messages I see what looks like the system struggling
to detect the disk available over the esata. Successful attempt look
similar but seem to suceed after a few SError.N (errno=-5). Very
occasionally it boot without any of these errors and /dev/sd[b-e] are
all detected.

When I'm lucky and the system is able to detect the disks at boot it
seems to run fine without problems till the next reboot. But the
system is not in production so no real load is on it.

Dec 26 10:28:12 JollyBox kernel: ata6: SATA link up 3.0 Gbps (SStatus
123 SControl 300)
Dec 26 10:28:12 JollyBox kernel: ata6.15: Port Multiplier 1.1,
0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
Dec 26 10:28:12 JollyBox kernel: ata6.00: hard resetting link
Dec 26 10:28:12 JollyBox kernel: ata6.00: SATA link up 3.0 Gbps
(SStatus 123 SControl 320)
Dec 26 10:28:12 JollyBox kernel: ata6.01: hard resetting link
Dec 26 10:28:12 JollyBox kernel: ata6.01: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Dec 26 10:28:12 JollyBox kernel: ata6.02: hard resetting link
Dec 26 10:28:12 JollyBox kernel: ata6.02: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Dec 26 10:28:12 JollyBox kernel: ata6.03: hard resetting link
Dec 26 10:28:12 JollyBox kernel: ata6.03: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Dec 26 10:28:12 JollyBox kernel: ata6.04: hard resetting link
Dec 26 10:28:12 JollyBox kernel: ata6.04: SATA link down (SStatus 0
SControl 320)
Dec 26 10:28:12 JollyBox kernel: ata6.05: hard resetting link
Dec 26 10:28:12 JollyBox kernel: ata6.05: SATA link up 1.5 Gbps
(SStatus 113 SControl 320)
Dec 26 10:28:12 JollyBox kernel: ata6.00: failed to IDENTIFY (I/O
error, err_mask=0x100)
Dec 26 10:28:12 JollyBox kernel: ata6.15: hard resetting link
Dec 26 10:28:12 JollyBox kernel: ata6.15: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Dec 26 10:28:12 JollyBox kernel: ata6.00: hard resetting link
Dec 26 10:28:12 JollyBox kernel: ata6.00: SATA link up 3.0 Gbps
(SStatus 123 SControl 320)
Dec 26 10:28:12 JollyBox kernel: ata6.01: hard resetting link
Dec 26 10:28:12 JollyBox kernel: ata6.01: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Dec 26 10:28:12 JollyBox kernel: ata6.02: hard resetting link
Dec 26 10:28:12 JollyBox kernel: ata6.02: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Dec 26 10:28:12 JollyBox kernel: ata6.03: hard resetting link
Dec 26 10:28:12 JollyBox kernel: ata6.03: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Dec 26 10:28:12 JollyBox kernel: ata6.05: hard resetting link
Dec 26 10:28:12 JollyBox kernel: ata6.05: SATA link up 1.5 Gbps
(SStatus 113 SControl 320)
Dec 26 10:28:12 JollyBox kernel: ata6.00: failed to IDENTIFY (I/O
error, err_mask=0x100)
Dec 26 10:28:12 JollyBox kernel: ata6.15: hard resetting link
Dec 26 10:28:12 JollyBox kernel: ata6.15: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Dec 26 10:28:12 JollyBox kernel: ata6.00: hard resetting link
Dec 26 10:28:12 JollyBox kernel: ata6.00: SATA link up 3.0 Gbps
(SStatus 123 SControl 320)
Dec 26 10:28:12 JollyBox kernel: ata6.01: hard resetting link
Dec 26 10:28:12 JollyBox kernel: ata6.01: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Dec 26 10:28:12 JollyBox kernel: ata6.02: hard resetting link
Dec 26 10:28:12 JollyBox kernel: ata6.02: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Dec 26 10:28:12 JollyBox kernel: ata6.03: hard resetting link
Dec 26 10:28:12 JollyBox kernel: ata6.03: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Dec 26 10:28:12 JollyBox kernel: ata6.04: hard resetting link
Dec 26 10:28:12 JollyBox kernel: ata6.04: SATA link down (SStatus 0
SControl 320)
Dec 26 10:28:12 JollyBox kernel: ata6.05: hard resetting link
Dec 26 10:28:12 JollyBox kernel: ata6.05: SATA link up 1.5 Gbps
(SStatus 113 SControl 320)
Dec 26 10:28:12 JollyBox kernel: ata6.00: failed to IDENTIFY (I/O
error, err_mask=0x100)
Dec 26 10:28:12 JollyBox kernel: ata6.00: failed to recover link after
3 tries, disabling
Dec 26 10:28:12 JollyBox kernel: ata6: failed to recover PMP, retrying in 5 secs
Dec 26 10:28:12 JollyBox kernel: ata6.15: hard resetting link
Dec 26 10:28:12 JollyBox kernel: ata6.15: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Dec 26 10:28:12 JollyBox kernel: ata6.00: failed to read SCR 0 (Emask=0x40)
Dec 26 10:28:12 JollyBox kernel: ata6.00: failed to write SCR 1 (Emask=0x40)
Dec 26 10:28:12 JollyBox kernel: ata6.00: failed to clear SError.N (errno=-5)
Dec 26 10:28:12 JollyBox kernel: ata6: failed to recover PMP, retrying in 5 secs
Dec 26 10:28:12 JollyBox kernel: ata6.15: hard resetting link
Dec 26 10:28:12 JollyBox kernel: ata6.15: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Dec 26 10:28:12 JollyBox kernel: ata6.00: failed to read SCR 0 (Emask=0x40)
Dec 26 10:28:12 JollyBox kernel: ata6.00: failed to write SCR 1 (Emask=0x40)
Dec 26 10:28:12 JollyBox kernel: ata6.00: failed to clear SError.N (errno=-5)
Dec 26 10:28:12 JollyBox kernel: ata6: failed to recover PMP, retrying in 5 secs
Dec 26 10:28:12 JollyBox kernel: ata6.15: hard resetting link
Dec 26 10:28:12 JollyBox kernel: ata6.15: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Dec 26 10:28:12 JollyBox kernel: ata6.00: failed to read SCR 0 (Emask=0x40)
Dec 26 10:28:12 JollyBox kernel: ata6.00: failed to write SCR 1 (Emask=0x40)
Dec 26 10:28:12 JollyBox kernel: ata6.00: failed to clear SError.N (errno=-5)
Dec 26 10:28:12 JollyBox kernel: ata6: failed to recover PMP, retrying in 5 secs
Dec 26 10:28:12 JollyBox kernel: ata6.15: hard resetting link
Dec 26 10:28:12 JollyBox kernel: ata6.15: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Dec 26 10:28:12 JollyBox kernel: ata6.00: failed to read SCR 0 (Emask=0x40)
Dec 26 10:28:12 JollyBox kernel: ata6.00: failed to write SCR 1 (Emask=0x40)
Dec 26 10:28:12 JollyBox kernel: ata6.00: failed to clear SError.N (errno=-5)
Dec 26 10:28:12 JollyBox kernel: ata6: failed to recover PMP after 5
tries, giving up
Dec 26 10:28:12 JollyBox kernel: ata6.15: Port Multiplier detaching
Dec 26 10:28:12 JollyBox kernel: ata6.00: disabled
Dec 26 10:28:12 JollyBox kernel: ata6: exception Emask 0x2 SAct 0x0
SErr 0x0 action 0x6 frozen t4
Dec 26 10:28:12 JollyBox kernel: ata6: irq_stat 0x00800000, incorrect PMP
Dec 26 10:28:12 JollyBox kernel: ata6: hard resetting link
Dec 26 10:28:12 JollyBox kernel: ata6: SATA link up 3.0 Gbps (SStatus
123 SControl 300)
Dec 26 10:28:12 JollyBox kernel: ata6: EH complete

Some time I see this in dmesg as well:

Dec 26 10:55:44 JollyBox kernel: ata6.15: exception Emask 0x2 SAct 0x0
SErr 0x0 action 0x6 t3
Dec 26 10:55:44 JollyBox kernel: ata6.15: irq_stat 0x00800000, incorrect PMP


-- 
Phill Jolliffe


--
Phill Jolliffe
