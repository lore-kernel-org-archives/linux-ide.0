From: Papp Tamas <tompos@martos.bme.hu>
Subject: sata_mv lockup
Date: Fri, 3 Feb 2006 16:56:37 +0100
Message-ID: <20060203155636.GA25255@martos.bme.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gaia.martos.bme.hu ([152.66.234.180]:3231 "EHLO martos.bme.hu")
	by vger.kernel.org with ESMTP id S1750842AbWBCP4n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Feb 2006 10:56:43 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: russb@emc.co
Cc: linux-ide@vger.kernel.org

Dear All,

Please CC me, I'm not on the list.

First off all: Brett, you are not in CREDITS or your email address is
not in modinfo/source, so it's not simple to find your email address.

Second: I'm sorry my poor english:)


I have 2 HP ML150 computers. The first one is with 2x80GB HDD, the
second one is with 2x250GB HDD (both are Maxtor). This is the only
significant difference.

1. I can boot with 2.6.14 but not with 2.6.15 . 

libata version 1.12 loaded.
sata_mv version 0.12
PCI: Assigned IRQ 9 for device 0000:03:04.0
PCI: Sharing IRQ 9 with 0000:03:02.0
PCI: Sharing IRQ 9 with 0000:03:03.0
ata1: SATA max PIO4 cmd 0x0 ctl 0xE08A2120 bmdma 0x0 irq 9
ata2: SATA max PIO4 cmd 0x0 ctl 0xE08A4120 bmdma 0x0 irq 9
ata3: SATA max PIO4 cmd 0x0 ctl 0xE08A6120 bmdma 0x0 irq 9
ata4: SATA max PIO4 cmd 0x0 ctl 0xE08A8120 bmdma 0x0 irq 9

After this it just locks up. I can reboot only with reset (magic sysrq
does not work).

I tried 2.6.16-rc-mm4, the same happened.

This is the first problem. This can happen.

2. With 2.6.14 I can use the first one (80 GB HDD).
Both of them are slow, the IO performance is horroristic, but the
first one is only slow. The second one is totally unusable, especially
for example if I want to use sw raid1. When it's trying to resync a
partition (for example 1GB), it just hangs up. Not exactly hangs up,
but I was not able to do a cat /proc/mdstat or anything else, that
needs IO.
But if I write to the both disk at the same time with dd, it almost
hangs up too.

The dmesgs and the lspci outputs are at
http://www.martos.bme.hu/~tompos/ml150/ .

dmesg.txt lspci-verbose.txt lspci.txt are for the first one.

The pci id's are not the same, because I tried it in other PCI slots.
But I guess, it does not matter.

Can you help me? Do you have any idea?

Thank you,

tamas
