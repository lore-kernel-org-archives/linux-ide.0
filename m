From: =?iso-8859-1?Q?Simen_R=F8nning?= <sniffe@upngo.no>
Subject: sata_sx4.c - Promise SATA S150 SX4 Controller - Problems loading driver
Date: Mon, 27 Sep 2004 14:39:32 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <00ff01c4a48f$0aa412e0$3202a8c0@geneske>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail45.e.nsc.no ([193.213.115.45]:9868 "EHLO mail45.e.nsc.no")
	by vger.kernel.org with ESMTP id S261234AbUI0Mjm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Sep 2004 08:39:42 -0400
Received: from mail.upngo.no (ti211110a080-5379.bb.online.no [80.213.181.5])
	by mail45.nsc.no (8.12.11/8.12.11) with SMTP id i8RCdaE9019545
	for <linux-ide@vger.kernel.org>; Mon, 27 Sep 2004 14:39:38 +0200 (CEST)
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

I have severe problems when loading the sata_sx4.c driver.
I cannot find any relevant information on the net (I've been google'ing
for several days now) to my problem, whatsoever.

If this is a very wrong place to ask my question, I do apologize; and
please point me to the right forum for this kind of questions.

The problem is as following:
When doing "modprobe sata_sx4", it shows up with:

root@fp:/usr/src/linux/drivers/scsi# modprobe sata_sx4
/lib/modules/2.4.28-pre3/kernel/drivers/scsi/sata_sx4.o: init_module: N=
o
such device
/lib/modules/2.4.28-pre3/kernel/drivers/scsi/sata_sx4.o: Hint: insmod
errors can be caused by incorrect module parameters, including invalid
IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.28-pre3/kernel/drivers/scsi/sata_sx4.o: insmod
/lib/modules/2.4.28-pre3/kernel/drivers/scsi/sata_sx4.o failed
/lib/modules/2.4.28-pre3/kernel/drivers/scsi/sata_sx4.o: insmod sata_sx=
4
failed


When looking at DMESG I can see this output (and the usual stuff that
fills the entire screen):
libata version 1.02 loaded.
sata_sx4 version 0.50
Detect Local DIMM Fail


I have tried the following kernels with the EXACT same results:
2.4.27
2.4.28-pre3 (patches applied to 2.4.27 and libata patches)
2.6.8.1
2.6.9-rc2

The configuration of my Promise S150 SX4 controller is:
2 200GB disks, each in JBOD (single disk) mode.

My hardware is as following (briefly):
HP Netserver LH3, Intel 440BX chipset
512MB RAM
NetRaid3 RAID SCSI controller (AMI MegaRAID chipset)
HighPoint ATA controller (HPT366/368/370/370A/372 (rev 03))
Promise S150 SX4 SATA controller equipped with 64MB ECC RAM (Controller
has no complaints in POST booting process)
Onboard PIIX4 IDE controller

This server only has 1 CPU so I configured my kernel without SMP suppor=
t
(I have tried with SMP support enabled just to check).

As distro I am using Slackware 10.

To mention; I have tried EVERY possible kombination of the IDE
controller cards. I've disabled the onboard, I have removed the
HighPoint controller, I have swapped PCI slots, changed memory on SX4
controller.

I am out of options :(
If more verbose output/information is needed, just speak up and I will
provide it. I would very much like to have my controller working.

In advance; thanks for your help!

Sincerely,
Simen R=F8nning
sniffe@upngo.no

