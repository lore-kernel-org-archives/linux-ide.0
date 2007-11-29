From: Nick Warne <nick@ukfsn.org>
Subject: Peculiar out-of-sync boot log lines
Date: Thu, 29 Nov 2007 19:37:28 +0000
Message-ID: <20071129193728.2f1c237e@linuxamd.linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933384AbXK2Thw@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: linux-ide@vger.kernel.org


Hi all,

2.6.23.9

I have noticed after applying Bart's patch to word93 blacklist my new
DVD drive:

http://lkml.org/lkml/2007/10/23/475

I see now in logs (look at the hdd line:

[dmesg]
hdc: 39876480 sectors (20416 MB) w/2048KiB Cache, CHS=39560/16/63,
UDMA(66)
hdc: cache flushes not supported
 hdc: hdc1
hdd: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache<7>hdd:
skipping word 93 validity check
, UDMA(66)
Uniform CD-ROM driver Revision: 3.20


<7> ??  And the ", UDMA(66)" gets new lined, so in syslog it appears all
by itself:


[/var/log/syslog]
Nov 29 19:22:00 linuxamd kernel: hda: Maxtor 6Y080L0, ATA DISK drive
Nov 29 19:22:00 linuxamd kernel: hdb: Maxtor 51536H2, ATA DISK drive
Nov 29 19:22:00 linuxamd kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov 29 19:22:00 linuxamd kernel: hdc: Maxtor 52049H3, ATA DISK drive
Nov 29 19:22:00 linuxamd kernel: hdd: TSSTcorp CDDVDW SH-S202J, ATAPI
CD/DVD-ROM drive
Nov 29 19:22:00 linuxamd kernel: ide1 at 0x170-0x177,0x376 on irq 15
Nov 29 19:22:00 linuxamd kernel: , UDMA(66)



I have tried to trace this, but cannot see anywhere printk
does this.

Nick
-- 
Free Software Foundation Associate Member 5508
