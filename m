From: Pedro Ribeiro <pedrib@gmail.com>
Subject: Long delays while hibernating
Date: Wed, 23 Dec 2009 03:50:46 +0000
Message-ID: <74fd948d0912221950m1ade8475pfe3ec3018e14d834@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:10577 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbZLWDur (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Dec 2009 22:50:47 -0500
Received: by ey-out-2122.google.com with SMTP id 4so32440eyf.5
        for <linux-ide@vger.kernel.org>; Tue, 22 Dec 2009 19:50:46 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I have a 2.6.32.2 kernel with the TuxOnIce and KDB patches. When I
hibernate, the penultimate phase is the "Atomic copy/restore". On
normal conditions, this takes 1 second or less.

I have a Thinkpad T400 with an ultrabay, which is a hot-swappable
drive enclosure, which can take in an optical drive (my case), hard
disk or extra battery.
To save some battery, I use the script here
http://www.thinkwiki.org/wiki/How_to_hotswap_UltraBay_devices#Script_for_Ultrabay_eject
to power off the ultrabay.

Then when I hibernate with the ultrabay powered off, the "Atomic
copy/restore" phase takes 30 seconds and sometimes even a hard lockup
occurs.
Just at the start of "Atomic copy/restore", the drive gets polled (the
light flashes for a second and makes some loading noise) and then
takes the CPU to 100% (I can hear the fan roar) for 30 seconds.

I'm sure this is related to the fact that the ultrabay is powered off.
There nothing else that triggers this.

I tried using KDB to interrupt during this phase but that doesn't
work. Only after the operation is complete KDB jumps in, so there is
no way to interrupt whatever is happening.

I reported this issue to the TuxOnIce developer, and he asked me to
report it to you.

What happens in dmesg after I exec the eject script:
Dec 23 03:43:03 portatel botto: ultrabay_eject starting eject of
/sys/devices/platform/dock.2
Dec 23 03:43:03 portatel botto: ultrabay_eject dock occupied, shutting
down storage device
/devices/pci0000:00/0000:00:1f.2/host1/target1:0:0/1:0:0:0
Dec 23 03:43:03 portatel kernel: [10244.666018] ata2.00: exception
Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
Dec 23 03:43:03 portatel kernel: [10244.666023] ata2.00: waking up from sleep
Dec 23 03:43:03 portatel kernel: [10244.666031] ata2: hard resetting link
Dec 23 03:43:04 portatel kernel: [10244.971059] ata2: SATA link up 1.5
Gbps (SStatus 113 SControl 300)
Dec 23 03:43:04 portatel kernel: [10245.042095] ata2.00: ACPI cmd
e3/00:79:00:00:00:a0 (IDLE) succeeded
Dec 23 03:43:04 portatel kernel: [10245.042954] ata2.00: ACPI cmd
e3/00:01:00:00:00:a0 (IDLE) succeeded
Dec 23 03:43:04 portatel kernel: [10245.053309] ata2.00: ACPI cmd
e3/00:79:00:00:00:a0 (IDLE) succeeded
Dec 23 03:43:04 portatel kernel: [10245.054188] ata2.00: ACPI cmd
e3/00:01:00:00:00:a0 (IDLE) succeeded
Dec 23 03:43:04 portatel kernel: [10245.057976] ata2.00: configured for UDMA/133
Dec 23 03:43:04 portatel kernel: [10245.167055] ata2: EH complete
Dec 23 03:43:05 portatel kernel: [10245.858366] ata2.00: disabled
Dec 23 03:43:05 portatel kernel: [10245.858422] scsi 1:0:0:0:
rejecting I/O to dead device
Dec 23 03:43:05 portatel kernel: [10245.858788] scsi 1:0:0:0:
rejecting I/O to dead device
Dec 23 03:43:06 portatel botto: ultrabay_eject undocking
/sys/devices/platform/dock.2
Dec 23 03:43:06 portatel kernel: [10246.765655] ACPI:
\_SB_.PCI0.SATA.PRT1 - undocking
Dec 23 03:43:06 portatel kernel: [10246.766119] ata2: exception Emask
0x10 SAct 0x0 SErr 0x4010000 action 0xe frozen
Dec 23 03:43:06 portatel kernel: [10246.766122] ata2: irq_stat
0x00400040, connection status changed
Dec 23 03:43:06 portatel kernel: [10246.766125] ata2: SError: {
PHYRdyChg DevExch }
Dec 23 03:43:06 portatel kernel: [10246.766132] ata2: hard resetting link
Dec 23 03:43:06 portatel botto: ultrabay_eject done
Dec 23 03:43:06 portatel kernel: [10247.490097] ata2: SATA link down
(SStatus 0 SControl 300)
Dec 23 03:43:06 portatel kernel: [10247.490119] ata2: EH complete

Some info you might find interesting:
lspci -vv, http://pastebin.com/m2c217b4e
dmesg, http://pastebin.com/m491ab4db
.config, http://pastebin.com/m2e4352fe

Thanks for your help,
Pedro
