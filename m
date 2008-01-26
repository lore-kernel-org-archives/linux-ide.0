From: "dusty@gmx.li" <dusty@gmx.li>
Subject: Re: libata pm
Date: Sat, 26 Jan 2008 20:05:43 -0000 (UTC)
Message-ID: <49398.82.140.50.2.1201377943.squirrel@ssl.cavemail.org>
References: <52279.82.140.50.2.1201370600.squirrel@ssl.cavemail.org>
Reply-To: dusty@gmx.li
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavemail.org ([62.75.189.85]:36930 "EHLO mail.cavemail.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752650AbYAZUFu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Jan 2008 15:05:50 -0500
In-Reply-To: <52279.82.140.50.2.1201370600.squirrel@ssl.cavemail.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: dusty@gmx.li
Cc: htejun@gmail.com, linux-ide@vger.kernel.org

I could solve the problem by ncq blacklisting the "Maxtor 6V300F0" devices
in libata-core.c


Am Sa, 26.01.2008, 18:03, schrieb dusty@gmx.li:
> I'm currently running
>
>
> Linux *** 2.6.23 #1 SMP PREEMPT Sat Jan 26 17:59:58 CET 2008 x86_64
> Intel(R) Pentium(R) D CPU 3.20GHz GenuineIntel GNU/Linux
> with the libata-tj-2.6.23-20071011 path for 2.6.23
>
> and for testing purposes
>
> linux-2.6.24-rc6-mm1
>
>
> on a Asus P5WDG2-WS with two PCI-X Dawicontrol DC 4300 Controllers and
> two Dawicontrol DC 6510 PM port multipliers to get 16 sata ports. (the
> linux partition is on a ide drive)
>
> the second raid array with 8 Samsung HD-LJ 501 works great without any
> errors. but the first raid with 8 Maxtor 6V300F0 produces one error after
>  another after mounting the filesystem:
>
> Filesystem "dm-0": Disabling barriers, not supported by the underlying
> device XFS mounting filesystem dm-0
> Ending clean XFS mount for filesystem: dm-0
> Filesystem "dm-1": Disabling barriers, not supported by the underlying
> device XFS mounting filesystem dm-1
> Ending clean XFS mount for filesystem: dm-1
> ata6.04: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xb
> ata6: SError: { PHYRdyChg DevExch }
> ata6.04: hard resetting link
> ata6.04: SATA link down (SStatus 0 SControl 300)
> ata6: failed to recover some devices, retrying in 5 secs
> ata6.04: hard resetting link
> ata6.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata6.04: configured for UDMA/100
> ata6: EH complete
> sd 5:0:0:0: [sdh] 586114704 512-byte hardware sectors (300091 MB) sd
> 5:0:0:0: [sdh] Write Protect is off
> sd 5:0:0:0: [sdh] Mode Sense: 00 3a 00 00 sd 5:0:0:0: [sdh] Write cache:
> enabled, read cache: enabled, doesn't support DPO or FUA sd 5:1:0:0: [sdi]
> 586114704 512-byte hardware sectors (300091 MB)
> sd 5:1:0:0: [sdi] Write Protect is off sd 5:1:0:0: [sdi] Mode Sense: 00 3a
> 00 00
> sd 5:1:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA sd 5:2:0:0: [sdj] 586114704 512-byte hardware sectors
> (300091 MB)
> sd 5:2:0:0: [sdj] Write Protect is off sd 5:2:0:0: [sdj] Mode Sense: 00 3a
> 00 00
> sd 5:2:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA sd 5:3:0:0: [sdk] 586114704 512-byte hardware sectors
> (300091 MB)
> sd 5:3:0:0: [sdk] Write Protect is off sd 5:3:0:0: [sdk] Mode Sense: 00 3a
> 00 00
> sd 5:3:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA sd 5:4:0:0: [sdl] 586114704 512-byte hardware sectors
> (300091 MB)
> sd 5:4:0:0: [sdl] Write Protect is off sd 5:4:0:0: [sdl] Mode Sense: 00 3a
> 00 00
> sd 5:4:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA ata6.00: failed to read SCR 1 (Emask=0x40)
> ata6.01: failed to read SCR 1 (Emask=0x40)
> ata6.02: failed to read SCR 1 (Emask=0x40)
> ata6.03: failed to read SCR 1 (Emask=0x40)
> ata6.04: failed to read SCR 1 (Emask=0x40)
> ata6.05: failed to read SCR 1 (Emask=0x40)
> ata6.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata6.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata6.01: cmd c8/00:10:97:26:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 8192
> in res 50/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout) ata6.01:
> status: { DRDY }
> ata6.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata6.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata6.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata6.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata6.15: hard resetting link
> ata6.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata6.00: hard resetting link
> ata6.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata6.01: hard resetting link
> ata6.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata6.02: hard resetting link
> ata6.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata6.03: hard resetting link
> ata6.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata6.04: hard resetting link
> ata6.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata6.05: hard resetting link
> ata6.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata6.00: configured for UDMA/100
> ata6.01: configured for UDMA/100
> ata6.02: configured for UDMA/100
> ata6.03: configured for UDMA/100
> ata6.04: configured for UDMA/100
> ata6: EH complete
> sd 5:0:0:0: [sdh] 586114704 512-byte hardware sectors (300091 MB) sd
> 5:0:0:0: [sdh] Write Protect is off
> sd 5:0:0:0: [sdh] Mode Sense: 00 3a 00 00 sd 5:0:0:0: [sdh] Write cache:
> enabled, read cache: enabled, doesn't support DPO or FUA sd 5:1:0:0: [sdi]
> 586114704 512-byte hardware sectors (300091 MB)
> sd 5:1:0:0: [sdi] Write Protect is off sd 5:1:0:0: [sdi] Mode Sense: 00 3a
> 00 00
> sd 5:1:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA sd 5:2:0:0: [sdj] 586114704 512-byte hardware sectors
> (300091 MB)
> sd 5:2:0:0: [sdj] Write Protect is off sd 5:2:0:0: [sdj] Mode Sense: 00 3a
> 00 00
> sd 5:2:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA sd 5:3:0:0: [sdk] 586114704 512-byte hardware sectors
> (300091 MB)
> sd 5:3:0:0: [sdk] Write Protect is off sd 5:3:0:0: [sdk] Mode Sense: 00 3a
> 00 00
> sd 5:3:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA sd 5:4:0:0: [sdl] 586114704 512-byte hardware sectors
> (300091 MB)
> sd 5:4:0:0: [sdl] Write Protect is off sd 5:4:0:0: [sdl] Mode Sense: 00 3a
> 00 00
> sd 5:4:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA sd 5:0:0:0: [sdh] 586114704 512-byte hardware sectors
> (300091 MB)
> sd 5:0:0:0: [sdh] Write Protect is off sd 5:0:0:0: [sdh] Mode Sense: 00 3a
> 00 00
> sd 5:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA sd 5:1:0:0: [sdi] 586114704 512-byte hardware sectors
> (300091 MB)
> sd 5:1:0:0: [sdi] Write Protect is off sd 5:1:0:0: [sdi] Mode Sense: 00 3a
> 00 00
> sd 5:1:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA sd 5:2:0:0: [sdj] 586114704 512-byte hardware sectors
> (300091 MB)
> sd 5:2:0:0: [sdj] Write Protect is off sd 5:2:0:0: [sdj] Mode Sense: 00 3a
> 00 00
> sd 5:2:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA sd 5:3:0:0: [sdk] 586114704 512-byte hardware sectors
> (300091 MB)
> sd 5:3:0:0: [sdk] Write Protect is off sd 5:3:0:0: [sdk] Mode Sense: 00 3a
> 00 00
> sd 5:3:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA sd 5:4:0:0: [sdl] 586114704 512-byte hardware sectors
> (300091 MB)
> sd 5:4:0:0: [sdl] Write Protect is off sd 5:4:0:0: [sdl] Mode Sense: 00 3a
> 00 00
> sd 5:4:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
>
>
>
> these messages repeat themself for hours...
>
> attached to this message is th dmesg output and hdparam -i for all
> devices


