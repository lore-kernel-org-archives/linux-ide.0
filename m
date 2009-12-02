From: Erik Postma <e.j.postma+linux-ide@gmail.com>
Subject: Re: PROBLEM: "lost interrupt (Status 0x50)" from DVD drive, long wait
	on 2.6.31 till 2.6.32rc6
Date: Tue, 1 Dec 2009 21:26:43 -0500
Message-ID: <d4db24520912011826p6766f89g8d475eebe11a7cfb@mail.gmail.com>
References: <d4db24520911150535pc4cddbufe86713cb317d7c9@mail.gmail.com>
	 <d4db24520911151957s781902e0v2bc9e9c20f3ebdd5@mail.gmail.com>
	 <4B14B3A3.4090103@kernel.org>
	 <d4db24520912010641j398506b4h50fdab4fde5e7b73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:63001 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755028AbZLBC0i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Dec 2009 21:26:38 -0500
Received: by fxm21 with SMTP id 21so4987737fxm.1
        for <linux-ide@vger.kernel.org>; Tue, 01 Dec 2009 18:26:43 -0800 (PST)
In-Reply-To: <d4db24520912010641j398506b4h50fdab4fde5e7b73@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

2009/12/1 Erik Postma <e.j.postma+linux-ide@gmail.com>:
> (...)
> Having media in the drive does not make a difference. I'll check if
> the drive is usable afterwards tonight, or worst case some time later
> this week.

Hm. When I tried just now, in about 25 times, I couldn't get the
machine to usably boot up with 2.6.31 even once. Independent of the
drive being closed or open, USB devices being plugged in, etc., I got
up to this message:

[    1.344085] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.352564] ata1.00: ATA-7: Hitachi HTS541680J9SA00, SB2OC7DP, max
UDMA/100
[    1.352617] ata1.00: 156301488 sectors, multi 16: LBA48 NCQ (depth
0/32)
[    1.368586] ata1.00: configured for UDMA/100
[    1.368800] scsi 0:0:0:0: Direct-Access     ATA      Hitachi
HTS54168 SB2O PQ: 0 ANSI: 5
[    1.369155] sd 0:0:0:0: [sda] 156301488 512-byte logical blocks:
(80.0 GB/74.5 GiB)
[    1.369269] sd 0:0:0:0: [sda] Write Protect is off
[    1.369322] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.369350] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    1.369564]  sda:
[    1.369847] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.660046] usb 2-1: new low speed USB device using ohci_hcd and
address 2
[    1.688065] ata2: SATA link down (SStatus 0 SControl 300)
[    1.756716]  sda1 sda2 sda3 < sda5 sda6 >
[    1.794512] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.852642] ata4.00: ATAPI: MATSHITADVD-RAM UJ-850S, 1.10, max
UDMA/33
[    1.868615] ata4.00: configured for UDMA/33
[    1.871398] scsi 3:0:0:0: CD-ROM            MATSHITA DVD-RAM
UJ-850S  1.10 PQ: 0 ANSI: 5
[    1.872289] usb 2-1: configuration #1 chosen from 1 choice

Then initially nothing would happen.
If I banged on the keyboard a few times, I would get: Clocksource tsc
unstable (delta = <some huge number> ns), and the qc timeout messages
would follow.
Also, from that moment on, time stamps would be extremely far off; the
clock seemed to just stop and only pick up again for a few seconds
when I hit a few keys. I could leave it for a minute and nothing would
happen, then I'd hit a few keys, then get a time stamp that is just a
second or so later than the earlier time stamp, followed by qc timeout
messages again.
I tried overriding the clock source using clocksource=acpi_pm (which
is the source autoselected on 2.6.30 on this machine) and
clocksource=hpet hpet=force (since HPET seems to be disabled in BIOS),
but that made no difference, other than the "clocksource tsc unstable"
message not appearing anymore.

In the end, I sort of got the machine to boot up by keeping the space
bar pressed down and waiting for a few minutes. It would get to either
the graphical login screen or Ubuntu's text-based "rescue mode"
what-to-do-next selector, depending on the presence of the "single"
boot option. For the graphical login screen, the machine would not
respond to my USB keyboard anymore, but using the builtin (laptop)
keyboard I could login. Then however my mouse and keyboard both
stopped responding, whereas my startup applications still kept
starting and appearing on screen. For the rescue mode screen, the
machine did not visibly respond to any input other than the power
button.

So... does this still look like an IDE issue? I guess I could try
disabling the drive in BIOS and seeing if stuff still goes wrong...

Erik.
