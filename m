From: Tejun Heo <htejun@gmail.com>
Subject: Re: System reboots after insertion and removal of disks in 2.6.18
 kernel
Date: Sat, 29 Mar 2008 22:50:11 +0900
Message-ID: <47EE4913.6090202@gmail.com>
References: <3fb94e50803281948v3e08df7fu2135ed1c113b5431@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:51502 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645AbYC2NuU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Mar 2008 09:50:20 -0400
Received: by wf-out-1314.google.com with SMTP id 28so645364wff.4
        for <linux-ide@vger.kernel.org>; Sat, 29 Mar 2008 06:50:20 -0700 (PDT)
In-Reply-To: <3fb94e50803281948v3e08df7fu2135ed1c113b5431@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sagar Borikar <sagar.borikar@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello,

Sagar Borikar wrote:
> I am currently working on NAS which has sil 3114 SATA controller.There
> is some strange scenario reported by product validation team.When I
> insert the drive and remove immediately without settling down,
> the system gets reset after roughly 30 seconds. Tried to capture the
> log from drivers but couldn't get any of the stack dump or kernel
> panic in due course. I am using 2.6.18 kernel and sata_sil is enabled.
> Rest functionality works pretty fine. But only when I do insert and
> remove without time gap, the system resets. Strange thing is when I
> insert the disk and remove it back immediately the interrupt line
> asserted is only for insert and not for removal.  But if I insert
> another disk, then this interrupt is recognised properly. Sata
> controller is not getting interrupt for second immediate drive
> removal.Now based on the logs captured, I can say that in this typical
> case, sata controller first gets the request to handle drive
> insertion. It waits for some time to check the status to ensure that
> it is proper request and after that it again reads the line. It finds
> that drive is removed till that time. But actually SATA controller is
> not detecting the remove instance as it is not reflected in GPIO
> transition as well. So I get messages like COMRESET Failed and hard
> reset failed. This doesn't happen if I insert back the drive
> immediately. The system immediately recovers.

Okay, that was one long paragraph.  :-)

The behavior itself (sans triggering machine reset) is intended.  libata 
EH doesn't rely on the edge events (PHY status changed).  It relies on 
level state (PHY readiness) and as long as at least one PHY event is 
triggered after link status has changed, it doesn't care what polarity 
those events are or how many of them are.  That was the design decision 
made for robustness.

> ata2: exception Emask 0x10 SAct 0x0 SErr 0x50000 action 0x2 frozen
> ata2: hard resetting port
> ata2: port is slow to respond, please be patient
> ata2: port failed to respond (30 secs)  ---------------------> At this
> state, actually the drive is removed. But not detected.
> ata2: COMRESET failed (device not ready)
> ata2: hardreset failed, retrying in 5 secs
> ata2: hard resetting port
> ata2: SATA link down (SStatus 0 SControl 310)
> ata2: EH complete

This is a quite old kernel, right?  Recent ones take much shorter to 
detect the condition.

> PMON2000 MIPS Initializing. Standby...
> ERRORPC=bfc00004 CONFIG=0042e4bb STATUS=00400000
> CPU PRID 000034c1, MaskID 00001320
> Initializing caches...done (CONFIG=0042e4bb)
> Switching to runtime address map...done
> Setting up SDRAM controller: sdram config 0x80010000
> master clock 100 Mhz, MulFundBIU 0x02, DivXSDRAM 0x02
> sdram freq 0x09ef21aa hz, sdram period: 0x06 nsec
> dimm0: density 256Mbit, width 16, single-sided, unbuffered, size
> 0x08000000
>  supported CAS latency: 2.5 2, using 2.5 cycles, byte18=0x0c
>  RAS to CAS delay (tRCD) 0x12 nsec, byte29=0x

Okay, and the machine got reboot.  It's weird that the reset happens 
*after* EH is complete.  After EH complete is printed, libata won't 
touch the hardware.  I'm sorry but I don't have any clue why the machine 
is getting rebooted.  Does the machine reset on oops?

-- 
tejun
