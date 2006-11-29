From: Tejun Heo <htejun@gmail.com>
Subject: Re: Scary Intel SATA problem: "frozen"
Date: Wed, 29 Nov 2006 09:57:42 +0900
Message-ID: <456CDB06.40806@gmail.com>
References: <456CB72A.3010004@local.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:43020 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1758282AbWK2A5u (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Nov 2006 19:57:50 -0500
Received: by nz-out-0102.google.com with SMTP id s1so992339nze
        for <linux-ide@vger.kernel.org>; Tue, 28 Nov 2006 16:57:49 -0800 (PST)
In-Reply-To: <456CB72A.3010004@local.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jonas@local.se
Cc: torvalds@osdl.org, linux-ide@vger.kernel.org

Jonas Lundgren wrote:
[--snip--]
> Also, it doesn't matter if I enable AHCI in the BIOS (But with AHCI
> enabled the disks spin down/power down when I boot, just to power up
> again a few seconds after. The boot progress freezes until the disks
> have spun up again. (This happens when the kernel probes the sata
> controller ports at bootup, the disks spin down at the same time, but
> spin up one by one as they're getting probed))

Likely fix is pending for this problem.

> I've tried changing I/O scheduler, only noticable diffrence is when I
> use "noop". Then I get like 20mb/sec write instead of 4mb/sec. I have no
> idea why this is :P
> 
> Example of what I mean with crappy performance:
> dd if=/dev/zero of=test232 bs=1M count=100; time sync
> 100+0 records in
> 100+0 records out
> 104857600 bytes (105 MB) copied, 0.130424 s, 804 MB/s
> real 0m21.104s
> user 0m0.000s
> sys 0m0.011s
> 
> 21 seconds to do a seq write of 100mb.. And during this time ALL other
> disk IO gets starved, I can't do anything that uses disk IO for the
> duration.. (not even `ls`)

What does the kernel say during this writing?  Can you post the result 
of the following?

1. reboot
2. dmesg -c
3. time dd if=/dev/zero.. blah
4. dmesg

Also, does 'mount -o remount,barrier=0 /' change anything?

> Yet, a hdparm shows a decent read
> hdparm -tT /dev/md4
> /dev/md4:
> Timing cached reads: 8060 MB in 1.99 seconds = 4042.19 MB/sec
> Timing buffered disk reads: 400 MB in 3.00 seconds = 133.28 MB/sec
> 
> dd if=1GBzeroFile of=/dev/null bs=1M count=1000
> 1000+0 records in
> 1000+0 records out
> 1048576000 bytes (1.0 GB) copied, 11.4335 s, 91.7 MB/s
> 
> This is the cpu usage stats I get from top when running the dd write:
> Cpu0 : 0.0%us, 0.0%sy, 0.0%ni, 0.0%id, 99.0%wa, 0.5%hi, 0.5%si, 0.0%st
> Cpu1 : 0.0%us, 0.0%sy, 0.0%ni,100.0%id, 0.0%wa, 0.0%hi, 0.0%si, 0.0%st
> 
> Pretty crappy read speeds compared to what I got on my previous mobo
> (around 140mb/sec), but still alot better than the 4mb/sec I get when
> writing..

Which controller did you use on your previous mobo?  If you're using 
ata_piix and hook two hard drives as primary and secondary on the same 
channel, some level of performance degradation is expected.  ata_piix 
can only issue command to only one of the two drives at once.  Is the 
read performance still bad in ahci mode?

[--snip--]
> Dmesg output from the error(s): (sda and sdb are 2 * 74GB raptor SATA
> drives in a Linux software raid0)
> 
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: (BMDMA stat 0x20)
> ata1.00: tag 0 cmd 0xca Emask 0x4 stat 0x40 err 0x0 (timeout)

This might be a missed interrupt.  It's a write.  DMA engine is done 
finishing transferring all data.  Device is ready for the next command 
but the interrupt has never arrived.

> ata1: port is slow to respond, please be patient
> ata1: port failed to respond (30 secs)
> ata1: soft resetting port
> ATA: abnormal status 0xD0 on port 0xFA07
> ATA: abnormal status 0xD0 on port 0xFA07
> ATA: abnormal status 0xD0 on port 0xFA07
> ATA: abnormal status 0xD0 on port 0xFA07
> ATA: abnormal status 0xD0 on port 0xFA07
> ATA: abnormal status 0xD0 on port 0xFA07
> ata1.00: qc timeout (cmd 0xec)
> ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> ata1.00: revalidation failed (errno=-5)
> ata1: failed to recover some devices, retrying in 5 secs

But this is weird.  If it were a missed interrupt, softreset should have 
recovered it instantly.  Something fishy is going on.

[--snip--]
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: (BMDMA stat 0x21)
> ata1.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0 (timeout)

Same thing for read.

> ata1: port is slow to respond, please be patient
> ata1: port failed to respond (30 secs)

Again, pre-reset wait times out.  Weird.

> ata1: soft resetting port
> ata1.00: configured for UDMA/100
> ata1: EH complete
[--snip--]
> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.00: (BMDMA stat 0x21)
> ata1.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0 (timeout)

Again, for read.

> Most of the time when I get these errors the system will recover after
> anything from 10 seconds to 10 minutes of unresponsiveness (no disk
> I/O), and sometimes hang.

Yeap, libata needs stricter timing constraints for recovery.  That's 
high on to-do list.

> IF the system does recover, I start getting
> the extremly low disk write speeds that I reported above, and only a
> reboot will get the performance back to regular.

Please full dmesg after your computer got really slow.  I suspect libata 
decided to switch to PIO mode.

> I don't know what causes it, but most of the times when I've gotten it
> my system has been under heavy load (compiling, downloading torrents in
> 11mb/sec etc). Please let me know if you want any additional info, want
> me to try something out, or whatever. My recent hardware upgrade for
> around $1200 (to a core2duo system, i965 mobo) is just going to waste
> because of this problem. :/

Heh, nice machine you got there.  When you look at the dmesg, do the 
error messages occur only on one of the two drives?  Or are both 
affected?  If only one is affected,

1. swap the two.  you'll probably have to dance a little bit with boot 
loader but md should handle that fine once the kernel is loaded.  does 
the errors persist?  on which device do they occur?  do they follow the 
drive or stay on the mobo port?

2. try different cable / port.  if you change port, again, you need to 
dance w/ boot loader.  who's carrying the error messages with it?

3. try different power plug from different power lane.

> I just got so glad when I saw the post of this on linux-ide, I've been
> searching like crazy to find another person having the same problem (and
> possibly a solution) for the past 2-3 weeks or so.

My first guess is frequent transmission errors.  Please report the test 
results.  Thanks.

-- 
tejun
