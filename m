From: Florian Echtler <floe@butterbrot.org>
Subject: Switching ICH7 to ACPI mode?
Date: Sun, 04 May 2008 22:19:06 +0200
Message-ID: <1209932346.29633.17.camel@pancake.floe.gotdns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from static.88-198-47-201.clients.your-server.de ([88.198.47.201]:34138
	"EHLO butterbrot.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755782AbYEDU3k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 May 2008 16:29:40 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hello Jeff,

my wife's ACER Aspire 5550 notebook has a ICH7 controller which is
eternally in "legacy" mode - the crippled BIOS is doesn't offer any
option to switch it to AHCI mode. It's basically running fine using the
ata_piix driver, but it never comes out of resume, only the hard disk
LED lights up and stays that way.

lspci -v:
00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) SATA
IDE Controller (rev 02) (prog-if 80 [Master])
	Subsystem: Acer Incorporated [ALI] Unknown device 0108
	Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 19
	I/O ports at 01f0 [size=8]
	I/O ports at 03f4 [size=1]
	I/O ports at 0170 [size=8]
	I/O ports at 0374 [size=1]
	I/O ports at 18b0 [size=16]
	Capabilities: [70] Power Management version 2
	Kernel driver in use: ata_piix

lspci -n:
00:1f.2 0101: 8086:27c4 (rev 02)

I thought about switching the controller to AHCI mode to try suspend
with the ahci driver, and according to the Intel ICH7 spec, section
12.1.33, there's a single register (MAP) which controls the operating
mode of the chipset.

So, what I thought about is basically this:
- patch the ata_piix driver to switch the MAP register and un-claim the
device
- hope that the ahci driver then succeeds in operating the controller

A short disclaimer: I have done some kernel coding in the past, but I'm
definitely not an expert, so I may very well be completely mistaken
about this.

Therefore, cue the questions:
- Is this plan even remotely sensible? 
- If so, can you give me some pointers on how to achieve this?
- Any other hints? ;-)

Many thanks, 
Yours, Florian

P.S. Here's an excerpt from the kernel log (2.6.25):

oliver ata_piix 0000:00:1f.2: version 2.12
oliver ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ
19
oliver ata_piix 0000:00:1f.2: MAP [ IDE IDE P1 P3 ]
oliver PCI: Setting latency timer of device 0000:00:1f.2 to 64
oliver scsi0 : ata_piix
oliver scsi1 : ata_piix
oliver ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x18b0 irq 14
oliver ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x18b8 irq 15

-- 
0666 - Filemode of the Beast

