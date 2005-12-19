From: Jae-hyeon Park <jhpark@tuhep.phys.tohoku.ac.jp>
Subject: Re: [PATCH/RFC 0/7] SATA ACPI suspend/resume support
Date: 20 Dec 2005 00:18:24 +0900
Message-ID: <871x09nmin.fsf@marrow.phys.tohoku.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tuhepnat.phys.tohoku.ac.jp ([130.34.123.133]:15370 "EHLO
	izanagi.tuhep.physp") by vger.kernel.org with ESMTP id S964772AbVLSPSf
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Dec 2005 10:18:35 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: randy_d_dunlap@linux.intel.com

This patch set does not work on my ThinkPad X41 Tablet.  I applied the
seven patches to kernel 2.6.15-rc5-git3.  I added "acpi_sleep=s3_bios"
to the kernel command line.

Let me describe how I tested in the following.  I suspend my laptop
with the following commands:

# init 1
# sync
# echo -n mem > /sys/power/state

The screen is cleared and the following is displayed:

Stopping tasks: ==========|
acpi_bus-0201 [57] bus_set_power         : Device is not power manageable
PM: Entering mem sleep

I suspect that the line "acpi_bus ..." indicates an error relevant to
this wakeup problem, although I don't know anything about kernel
hacking.  After a second, the laptop is suspended.  If I press the Fn
key to wake up the machine, it prints messages including:

...
acpi_bus-0201 [60] bus_set_power         : Device is not power manageable
...
ATA: abnormal status 0x80 on port 0x1F7
ATA: abnormal status 0x80 on port 0x1F7
ATA: abnormal status 0x80 on port 0x1F7

After a few tens of seconds, the screen before sleep is restored
showing the commands that I gave.  At this time, the hard disk LED is
off.

After I try to read the hard disk, for example by

# ls /usr/src

the hard disk LED stays on.  After a while the following message is
repeatedly printed:

ata1: command 0xc8 timeout, stat 0xd0 host_stat 0x1
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata1: status=0xd0 { Busy }
sd 0:0:0:0: SCSI error: return code = 0x8000002
sda: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
Info fld=28f6944
end_request: I/O error, dev sda, sector 29379684
ATA: abnormal status 0xD0 on port 0x1F7
ATA: abnormal status 0xD0 on port 0x1F7
ATA: abnormal status 0xD0 on port 0x1F7

ata1: command 0xca timeout, stat 0xd0 host_stat 0x1
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata1: status=0xd0 { Busy }
sd 0:0:0:0: SCSI error: return code = 0x8000002
sda: Current: sense key: Aborted Command
    Additional sense: Scsi parity error
Info fld=28f6944
end_request: I/O error, dev sda, sector 29379692
ATA: abnormal status 0xD0 on port 0x1F7
ATA: abnormal status 0xD0 on port 0x1F7
ATA: abnormal status 0xD0 on port 0x1F7

It is confusing that the symptom after an unsuccessful wakeup
basically appears to be the same as the one described in the posting,
http://marc.theaimsgroup.com/?l=linux-kernel&m=111409309804068&w=2
FYI, software suspend 2 works okay on this machine with SATA resume
patch.

Any ideas?  Thanks in advance.

Jae-hyeon
