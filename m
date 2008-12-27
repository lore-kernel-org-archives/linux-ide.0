From: Peter Klotz <peter.klotz@aon.at>
Subject: 2.6.28: Timeout problem with AHCI SATA DVD drive
Date: Sat, 27 Dec 2008 10:10:17 +0100
Message-ID: <4955F0F9.1030700@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nat-warsl417-01.aon.at ([195.3.96.119]:5245 "EHLO email.aon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751675AbYL0JRE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 Dec 2008 04:17:04 -0500
Received: from smarthub92.highway.telekom.at (HELO email.aon.at) ([172.18.5.231])
          (envelope-sender <peter.klotz@aon.at>)
          by fallback44.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-ide@vger.kernel.org>; 27 Dec 2008 09:10:20 -0000
Received: from 212-183-97-73.adsl.highway.telekom.at (HELO [192.168.0.100]) ([212.183.97.73])
          (envelope-sender <peter.klotz@aon.at>)
          by smarthub92.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-ide@vger.kernel.org>; 27 Dec 2008 09:10:17 -0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

When inserting a DVD into the drive (HL-DT-ST GSA-T50N) it sometimes 
gets stuck and keeps spinning forever without recognizing the disc. Then 
a reboot is necessary to remove the disc.

I am using a vanilla 2.6.28 x86_64 kernel.

lspci | grep SATA:

00:1f.2 SATA controller: Intel Corporation ICH9M/M-E SATA AHCI 
Controller (rev 03)

The controller is set to AHCI mode ("Enhanced") in BIOS.

The drive works in Windows (also AHCI) so I would rule out a hardware 
problem.

Here is the (maybe relevant) dmesg output from bootup to timeout:

[    1.994977] ahci 0000:00:1f.2: version 3.0
[    1.994992] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    1.995041] ahci 0000:00:1f.2: irq 2296 for MSI/MSI-X
[    1.995118] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 4 ports 3 Gbps 
0x23 impl SATA mode
[    1.995121] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo 
pio slum part ems
[    1.995126] ahci 0000:00:1f.2: setting latency timer to 64
...
[    1.995391] scsi1 : ahci
...
[    1.995783] ata2: SATA max UDMA/133 abar m2048@0xfd6fb000 port 
0xfd6fb180 irq 2296
...
[    2.652063] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.656938] ata2.00: ACPI cmd ef/10:06:00:00:00:a0 succeeded
[    2.656941] ata2.00: ACPI cmd ef/10:03:00:00:00:a0 filtered out
[    2.661914] ata2.00: ATAPI: HL-DT-ST DVDRAM GSA-T50N, RR04, max 
UDMA/133, ATAPI AN
[    2.667430] ata2.00: ACPI cmd ef/10:06:00:00:00:a0 succeeded
[    2.667432] ata2.00: ACPI cmd ef/10:03:00:00:00:a0 filtered out
[    2.672426] ata2.00: configured for UDMA/133
...
[    3.139341] scsi 1:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-T50N 
  RR04 PQ: 0 ANSI: 5
...
[    3.145126] scsi 1:0:0:0: Attached scsi generic sg1 type 5
...
[  506.804100] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 
frozen
[  506.804117] ata2.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[  506.804119]          cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
[  506.804121]          res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 
0x4 (timeout)
[  506.804128] ata2.00: status: { DRDY }
[  506.804138] ata2: hard resetting link
[  512.164075] ata2: link is slow to respond, please be patient (ready=0)
[  516.812074] ata2: COMRESET failed (errno=-16)
[  516.812085] ata2: hard resetting link
[  522.172121] ata2: link is slow to respond, please be patient (ready=0)
[  526.820075] ata2: COMRESET failed (errno=-16)
[  526.820087] ata2: hard resetting link
[  532.180123] ata2: link is slow to respond, please be patient (ready=0)
[  561.860084] ata2: COMRESET failed (errno=-16)
[  561.860097] ata2: limiting SATA link speed to 1.5 Gbps
[  561.860103] ata2: hard resetting link
[  566.884074] ata2: COMRESET failed (errno=-16)
[  566.884086] ata2: reset failed, giving up
[  566.884091] ata2.00: disabled
[  566.884113] ata2: EH complete

Any help is appreciated.

Regards, Peter.
