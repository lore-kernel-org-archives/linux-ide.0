From: Nicola <ivololeribar@yahoo.it>
Subject: SiS 180 pata
Date: Mon, 5 Jul 2004 12:53:47 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200407051253.47003.ivololeribar@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:10427 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S266017AbUGEKxm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Jul 2004 06:53:42 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: uwe.koziolek@gmx.net
Cc: linux-ide@vger.kernel.org

Dear Sirs,
I have a problem with my SiS 180 controller sata/pata, running
under Fedora Core 2 x86_64, with both kernels 2.6.5 and 2.6.6.

I own a brand new mb for my AMD3200+, Jetway S755max
with a Sis chipset 755, southbridge 963 + Sis 180.

The supplementary Sis 180 chipset controls another parallel ata port
(2 channels) and two sata ports. I'm not interested in sata ports
for the time being.

I would like to use my Pioneer dvd recorder on the
third parallel ide, controlled by the sis 180 chipset.
It is recognised from the bios and it works under xp, so it has to be
a software isse.
(the same happens if I attach a 40G drive).

However the drive is not detected by linux:

libata version 1.02 loaded.
ata1: SATA max UDMA/133 cmd 0xD800 ctl 0xDC02 bmdma 0xE800 irq 19
ata2: SATA max UDMA/133 cmd 0xE000 ctl 0xE402 bmdma 0xE808 irq 19
ata1: no device found (phy stat 00000000)
scsi1 : sata_sis
ata2: no device found (phy stat 00000000)
scsi2 : sata_sis


I have tried to mount it under every possible hd device, as well as sd one.
I have also read /usr/src/linux/Documentation/ide.txt and tried with various
ide2=... combinations at boot time, without success.


Now I'm quite confused. Does the sata_sis module covers only the sata side 
of the sis 180 chipset?

I would highly appreciate any help you could give me. I really
need this interface working.

Thanks a lot in advance

Nicola
