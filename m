From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: Re: [PATCH/RFC 0/7] SATA ACPI suspend/resume support
Date: Tue, 20 Dec 2005 10:55:14 -0800
Message-ID: <20051220105514.01815cba.randy_d_dunlap@linux.intel.com>
References: <871x09nmin.fsf@marrow.phys.tohoku.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr19.intel.com ([134.134.136.18]:63376 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750762AbVLTSyt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Dec 2005 13:54:49 -0500
In-Reply-To: <871x09nmin.fsf@marrow.phys.tohoku.ac.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jae-hyeon Park <jhpark@tuhep.phys.tohoku.ac.jp>
Cc: linux-ide@vger.kernel.org

On 20 Dec 2005 00:18:24 +0900
Jae-hyeon Park <jhpark@tuhep.phys.tohoku.ac.jp> wrote:

> This patch set does not work on my ThinkPad X41 Tablet.  I applied the
> seven patches to kernel 2.6.15-rc5-git3.  I added "acpi_sleep=s3_bios"
> to the kernel command line.
> 
> Let me describe how I tested in the following.  I suspend my laptop
> with the following commands:
> 
> # init 1
> # sync
> # echo -n mem > /sys/power/state
> 
> The screen is cleared and the following is displayed:
> 
> Stopping tasks: ==========|
> acpi_bus-0201 [57] bus_set_power         : Device is not power manageable
> PM: Entering mem sleep

I've asked for some clarification on this message, including
how serious (problematic) it is to the suspend process,
but have received no answer yet (on the acpi-devel mailing
list).  It appears to mostly be a debugging information message.

> I suspect that the line "acpi_bus ..." indicates an error relevant to
> this wakeup problem, although I don't know anything about kernel
> hacking.  After a second, the laptop is suspended.  If I press the Fn
> key to wake up the machine, it prints messages including:
> 
> ...
> acpi_bus-0201 [60] bus_set_power         : Device is not power manageable
> ...
> ATA: abnormal status 0x80 on port 0x1F7
> ATA: abnormal status 0x80 on port 0x1F7
> ATA: abnormal status 0x80 on port 0x1F7
> 
> After a few tens of seconds, the screen before sleep is restored
> showing the commands that I gave.  At this time, the hard disk LED is
> off.
> 
> After I try to read the hard disk, for example by
> 
> # ls /usr/src
> 
> the hard disk LED stays on.  After a while the following message is
> repeatedly printed:
> 
> ata1: command 0xc8 timeout, stat 0xd0 host_stat 0x1
> ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> ata1: status=0xd0 { Busy }
> sd 0:0:0:0: SCSI error: return code = 0x8000002
> sda: Current: sense key: Aborted Command
>     Additional sense: Scsi parity error
> Info fld=28f6944
> end_request: I/O error, dev sda, sector 29379684
> ATA: abnormal status 0xD0 on port 0x1F7
> ATA: abnormal status 0xD0 on port 0x1F7
> ATA: abnormal status 0xD0 on port 0x1F7
> 
> ata1: command 0xca timeout, stat 0xd0 host_stat 0x1
> ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> ata1: status=0xd0 { Busy }
> sd 0:0:0:0: SCSI error: return code = 0x8000002
> sda: Current: sense key: Aborted Command
>     Additional sense: Scsi parity error
> Info fld=28f6944
> end_request: I/O error, dev sda, sector 29379692
> ATA: abnormal status 0xD0 on port 0x1F7
> ATA: abnormal status 0xD0 on port 0x1F7
> ATA: abnormal status 0xD0 on port 0x1F7
> 
> It is confusing that the symptom after an unsuccessful wakeup
> basically appears to be the same as the one described in the posting,
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111409309804068&w=2
> FYI, software suspend 2 works okay on this machine with SATA resume
> patch.
> 
> Any ideas?  Thanks in advance.

I've read your mail several times now and don't have any real
ideas for you, but I wanted to reply so that you wouldn't feel
like you were being ignored.

I'll have a new patch series in another day or so.  Please try
it again and let me/us know how it goes.

Thanks,
---
~Randy
