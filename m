From: arno@natisbad.org (Arnaud Ebalard)
Subject: [BUG,REGRESSION] SATA regression on 12.0-rc4 kernel
Date: Mon, 07 Oct 2013 21:12:37 +0200
Message-ID: <87bo303nfe.fsf@natisbad.org>
References: <87vc1ahyft.fsf@natisbad.org>
	<20131007125943.GA1332@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mic92-1-81-57-185-249.fbx.proxad.net ([81.57.185.249]:60763
	"EHLO smtp.natisbad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754766Ab3JGTUw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Oct 2013 15:20:52 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Carino <marc.ceeeee@gmail.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, willy tarreau <w@1wt.eu>, Jason Cooper <jason@lakedaemon.net>

Hi guys,

yesterday, I reported on arm kernel mailing list what looked like a sata
regression on my platform (Marvell Armada 370-based NETGEAR ReadyNAS
102). I initially thought this was an ARM-related issue. My initial
email, provided below, contains various details on the platform and the
error encountered.

Today, before starting a painful git bisect, I decided to git log
sata_mv.c code and then more generally drivers/ata to quickly end up on
commit ed36911c747c (libata: Add support for SEND/RECEIVE FPDMA QUEUED)
against which I got suspicious after looking again at the errors I had:

[  417.288155] ata1.00: exception Emask 0x0 SAct 0x1fff6001 SErr 0x0 action 0x6 frozen
[  417.295838] ata1.00: failed command: WRITE FPDMA QUEUED
[  417.301097] ata1.00: cmd 61/48:00:80:ad:0b/00:00:0c:00:00/40 tag 0 ncq 36864 out
[  417.315896] ata1.00: status: { DRDY }
[  417.319570] ata1.00: failed command: WRITE FPDMA QUEUED
[  417.324814] ata1.00: cmd 61/08:68:70:a1:87/00:00:0d:00:00/40 tag 13 ncq 4096 out
[  417.339619] ata1.00: status: { DRDY }
[  417.343288] ata1.00: failed command: WRITE FPDMA QUEUED
[  417.348536] ata1.00: cmd 61/08:70:28:a2:87/00:00:0d:00:00/40 tag 14 ncq 4096 out
[  417.363341] ata1.00: status: { DRDY }
[  417.367010] ata1.00: failed command: WRITE FPDMA QUEUED
[  417.372257] ata1.00: cmd 61/08:80:80:a3:87/00:00:0d:00:00/40 tag 16 ncq 4096 out
[  417.387061] ata1.00: status: { DRDY }
[  417.390733] ata1.00: failed command: WRITE FPDMA QUEUED
[  417.395977] ata1.00: cmd 61/08:88:58:a1:c7/00:00:0d:00:00/40 tag 17 ncq 4096 out
[  417.410782] ata1.00: status: { DRDY }

Reverting both 87fb6c31b9 (libata: Add support for queued DSM TRIM) and
ed36911c74 (libata: Add support for SEND/RECEIVE FPDMA QUEUED) makes the
problem disappear. Note: reverting 87fb6c31b9 is not enough and I cannot
compile the kernel with only the latter reverted.

If you need more info on the platform or want me to test something some
fix, do not hesitate.

Cheers,

a+

---------------->8---------------------------------------------------
Hi guys,

I was testing some code on my (Armada 370-based) ReadyNAS 102 and got
the following error while writing something on disk on *3.12-rc4* (also
happen on -rc3):

[  417.288155] ata1.00: exception Emask 0x0 SAct 0x1fff6001 SErr 0x0 action 0x6 frozen
[  417.295838] ata1.00: failed command: WRITE FPDMA QUEUED
[  417.301097] ata1.00: cmd 61/48:00:80:ad:0b/00:00:0c:00:00/40 tag 0 ncq 36864 out
[  417.315896] ata1.00: status: { DRDY }
[  417.319570] ata1.00: failed command: WRITE FPDMA QUEUED
[  417.324814] ata1.00: cmd 61/08:68:70:a1:87/00:00:0d:00:00/40 tag 13 ncq 4096 out
[  417.339619] ata1.00: status: { DRDY }
[  417.343288] ata1.00: failed command: WRITE FPDMA QUEUED
[  417.348536] ata1.00: cmd 61/08:70:28:a2:87/00:00:0d:00:00/40 tag 14 ncq 4096 out
[  417.363341] ata1.00: status: { DRDY }
[  417.367010] ata1.00: failed command: WRITE FPDMA QUEUED
[  417.372257] ata1.00: cmd 61/08:80:80:a3:87/00:00:0d:00:00/40 tag 16 ncq 4096 out
[  417.387061] ata1.00: status: { DRDY }
[  417.390733] ata1.00: failed command: WRITE FPDMA QUEUED
[  417.395977] ata1.00: cmd 61/08:88:58:a1:c7/00:00:0d:00:00/40 tag 17 ncq 4096 out
[  417.410782] ata1.00: status: { DRDY }
[  417.414450] ata1.00: failed command: WRITE FPDMA QUEUED
[  417.419697] ata1.00: cmd 61/08:90:48:a9:c7/00:00:0d:00:00/40 tag 18 ncq 4096 out
[  417.434501] ata1.00: status: { DRDY }
[  417.438173] ata1.00: failed command: WRITE FPDMA QUEUED
[  417.443417] ata1.00: cmd 61/08:98:68:a9:c7/00:00:0d:00:00/40 tag 19 ncq 4096 out
[  417.458221] ata1.00: status: { DRDY }
[  417.461890] ata1.00: failed command: WRITE FPDMA QUEUED
[  417.467134] ata1.00: cmd 61/08:a0:a0:aa:c7/00:00:0d:00:00/40 tag 20 ncq 4096 out
[  417.481940] ata1.00: status: { DRDY }
[  417.485609] ata1.00: failed command: WRITE FPDMA QUEUED
[  417.490856] ata1.00: cmd 61/08:a8:70:ad:c7/00:00:0d:00:00/40 tag 21 ncq 4096 out
[  417.505660] ata1.00: status: { DRDY }
[  417.509332] ata1.00: failed command: WRITE FPDMA QUEUED
[  417.514576] ata1.00: cmd 61/08:b0:78:b2:c7/00:00:0d:00:00/40 tag 22 ncq 4096 out
[  417.529383] ata1.00: status: { DRDY }
[  417.533051] ata1.00: failed command: WRITE FPDMA QUEUED
[  417.538299] ata1.00: cmd 61/18:b8:90:a1:07/00:00:0e:00:00/40 tag 23 ncq 12288 out
[  417.553190] ata1.00: status: { DRDY }
[  417.556859] ata1.00: failed command: WRITE FPDMA QUEUED
[  417.562106] ata1.00: cmd 61/08:c0:18:a2:07/00:00:0e:00:00/40 tag 24 ncq 4096 out
[  417.576910] ata1.00: status: { DRDY }
[  417.580582] ata1.00: failed command: WRITE FPDMA QUEUED
[  417.585826] ata1.00: cmd 61/08:c8:48:a2:07/00:00:0e:00:00/40 tag 25 ncq 4096 out
[  417.600631] ata1.00: status: { DRDY }
[  417.604300] ata1.00: failed command: WRITE FPDMA QUEUED
[  417.609546] ata1.00: cmd 61/10:d0:60:a2:07/00:00:0e:00:00/40 tag 26 ncq 8192 out
[  417.624351] ata1.00: status: { DRDY }
[  417.628020] ata1.00: failed command: WRITE FPDMA QUEUED
[  417.633267] ata1.00: cmd 61/10:d8:b0:a5:07/00:00:0e:00:00/40 tag 27 ncq 8192 out
[  417.648071] ata1.00: status: { DRDY }
[  417.651743] ata1.00: failed command: WRITE FPDMA QUEUED
[  417.656987] ata1.00: cmd 61/08:e0:10:a1:07/00:00:16:00:00/40 tag 28 ncq 4096 out
[  417.671791] ata1.00: status: { DRDY }
[  417.675466] ata1: hard resetting link
[  418.228117] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  418.336657] ata1.00: configured for UDMA/133
[  418.340954] ata1.00: device reported invalid CHS sector 0
[  418.346365] ata1.00: device reported invalid CHS sector 0
[  418.351779] ata1.00: device reported invalid CHS sector 0
[  418.357187] ata1.00: device reported invalid CHS sector 0
[  418.362599] ata1.00: device reported invalid CHS sector 0
[  418.368008] ata1.00: device reported invalid CHS sector 0
[  418.373419] ata1.00: device reported invalid CHS sector 0
[  418.378830] ata1.00: device reported invalid CHS sector 0
[  418.384238] ata1.00: device reported invalid CHS sector 0
[  418.389649] ata1.00: device reported invalid CHS sector 0
[  418.395057] ata1.00: device reported invalid CHS sector 0
[  418.400468] ata1.00: device reported invalid CHS sector 0
[  418.405876] ata1.00: device reported invalid CHS sector 0
[  418.411288] ata1.00: device reported invalid CHS sector 0
[  418.416696] ata1.00: device reported invalid CHS sector 0
[  418.422107] ata1.00: device reported invalid CHS sector 0
[  418.427533] ata1: EH complete
 
I though this was an hardware issue and replaced the disk by another
one with an already installed system (Debian armel for the former,
Debian armhf for the latter). After some minutes, the same kind of
problem occured. When asking smartctl, both disks have a PASSED
status. I rebooted on a 3.11.4 kernel and never got the issue.

Looking at commits touching other armada-370 .dts file, I do not think I
missed any specific changes so - I may be wrong - but it is possible
that what I get is also happening on other mvebu boards *which do use*
sata disks. Before trying and look where it comes from (sounds
promising) to put different subsystem maintainer in Cc:, it would be
good to know If I am the only one to get that and/or understand if it is
mvebu, sata or anything else related.

So if you have such a board with a sata disk connected, it would be nice
if you could give 3.12-rc4 a try and report what disk-related operations
produce.

If you have any other idea where it may come from, do not hesitate.

Cheers,

a+

ps: FWIW, here is what I get at boot in the log regarding sata config:

  libata version 3.00 loaded.
  ahci 0000:01:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
  ata1: SATA max UDMA/133 abar m512@0xe0010000 port 0xe0010100 irq 103
  ata2: SATA max UDMA/133 abar m512@0xe0010000 port 0xe0010180 irq 103
  sata_mv d00a0000.sata: version 1.28
  sata_mv d00a0000.sata: slots 32 ports 2
  scsi2 : sata_mv
  scsi3 : sata_mv
  ata3: SATA max UDMA/133 irq 23
  ata4: SATA max UDMA/133 irq 23
  ata2: SATA link down (SStatus 0 SControl 300)
  ata3: SATA link down (SStatus 0 SControl F300)
  ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
  ata1.00: ATA-7: ST3250824AS, 3.ADH, max UDMA/133
  ata1.00: 488281250 sectors, multi 0: LBA48 NCQ (depth 31/32)
  ata1.00: configured for UDMA/133
  scsi 0:0:0:0: Direct-Access     ATA      ST3250824AS      3.AD PQ: 0 ANSI: 5
  ata4: SATA link down (SStatus 0 SControl F300)

---------------->8---------------------------------------------------
