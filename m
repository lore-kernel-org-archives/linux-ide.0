From: David Krider <david@davidkrider.com>
Subject: Various problems with MCP55 since 2.6.37
Date: Sat, 03 Dec 2011 07:29:50 -0500
Message-ID: <4EDA163E.2030501@davidkrider.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61194 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755320Ab1LCM3w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Dec 2011 07:29:52 -0500
Received: by iage36 with SMTP id e36so5614925iag.19
        for <linux-ide@vger.kernel.org>; Sat, 03 Dec 2011 04:29:52 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I'm getting lots of different problems with the MCP55 controller since
kernel 2.6.37. I have an Asus-built Nvidia 780i-based motherboard. I
have both Ubuntu and Windows 7 installed. Windows 7 doesn't seem to be
giving me any trouble at all, so I don't think it's my hardware. I have
spent many hours working on this to no avail. If I stay on Ubuntu 10.10,
which has a 2.6.35-based kernel, I don't have these problems, but that
version of Ubuntu will be rolling off support soon (and I want Gnome 3).

First, the computer won't reboot correctly. If I let it just reboot,
then, when either Windows or Linux is starting, it will just
spontaneously reboot again. This doesn't happen when rebooting from
Windows. If I simply shut down from Linux, then manually power the
computer back on, the BIOS screen will just barely pop up, then the BIOS
itself will restart, and come back up to an error screen saying that the
BIOS "crashed."

I've gotten scrambled file systems twice because of this.

I was hoping the problem was my fakeraid setup, so I bought an SSD and
replaced it. That has brought on a new set of problems. I get lots of
"interesting" messages in dmesg, but I can't figure out if they're just
informational, or if there's a serious, data-losing situation occuring.

[  922.848302] ata3.00: failed command: WRITE FPDMA QUEUED
[  922.848305] ata3.00: cmd 61/10:f0:a0:a3:f0/00:00:10:00:00/40 tag 30
ncq 8192 out
[  922.848306]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[  922.848308] ata3.00: status: { DRDY }
[  922.848311] ata3: hard resetting link
[  922.848312] ata3: nv: skipping hardreset on occupied port
[  928.360008] ata3: link is slow to respond, please be patient (ready=0)
[  932.896009] ata3: SRST failed (errno=-16)
[  932.896014] ata3: hard resetting link
[  932.896016] ata3: nv: skipping hardreset on occupied port
[  933.364026] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  933.380198] ata3.00: configured for UDMA/133
[  933.380203] ata3.00: device reported invalid CHS sector 0

Also, I occasionally get "pauses." Every once in awhile, the drive light
will come on solid, and the whole machine will simply pause for about 60
seconds, and then I get messages like this:

[ 1040.361005] sd 2:0:0:0: [sda]  Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE
[ 1040.361007] sd 2:0:0:0: [sda]  Sense Key : Aborted Command [current]
[descriptor]
[ 1040.361009] Descriptor sense data with sense descriptors (in hex):
[ 1040.361011]         72 0b 47 00 00 00 00 0c 00 0a 80 00 00 00 00 00
[ 1040.361016]         12 30 d4 48
[ 1040.361019] sd 2:0:0:0: [sda]  Add. Sense: Scsi parity error
[ 1040.361021] sd 2:0:0:0: [sda] CDB: Read(10): 28 00 12 30 d4 f8 00 00
08 00
[ 1040.361026] end_request: I/O error, dev sda, sector 305190136

I've created an Ubuntu bug on the reboot problem that is confirmed, but
I can't get any more information on there.
(https://bugs.launchpad.net/ubuntu/+source/linux/+bug/829413)

I also made a bug report on the kernel bugzilla, but -- obviously --
it's down.

I've tried half a dozen kernel boot flags.

I've tried a dozen different kernels.

I tried to switch to btrfs, but Ubuntu's kernel package has a bug that
prevents it from being installed on there.

In other words, I'm trying to say that I'm doing the work that an
end-user can be expected to do. I don't know what else to try. I'm
really desperate to get this fixed; it really bothers me. At this point,
I'm considering buying a PCIe SATA RAID card, or going back to Gentoo,
where I can really play with kernel versions and patches more
effectively, and I'm not really looking forward to that...

ANY help would be GREATLY appreciated,
dk
