From: Brad Campbell <brad@wasp.net.au>
Subject: Re: Fun with HPT302N (Rocket Raid 1520 PCI card)
Date: Fri, 03 Nov 2006 13:19:05 +0400
Message-ID: <454B0989.9020001@wasp.net.au>
References: <23724.1161684269@redhat.com>  <454869C8.9000103@pobox.com>	 <1162383443.11965.109.camel@localhost.localdomain>	 <4548927F.10804@wasp.net.au> <1162484655.11965.212.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:3514 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S1752329AbWKCJUC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Nov 2006 04:20:02 -0500
In-Reply-To: <1162484655.11965.212.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, David Howells <dhowells@redhat.com>, linux-ide@vger.kernel.org

Alan Cox wrote:

> That one is really very useful. The error handling is leaving some kind
> of IRQ status no cleared which in turn brings the house down. I think
> there are two different things in the log here - one is the empty port,
> the other is some kind of other failure.
> 
> With a current -mm kernel can you stick ATA_FLAG_DETECT_POLLING on the
> various .flags = ATA_FLAG_SLAVE_POSS|.... lines for each ata_port_info
> structure in hpt37x_init_one then see if the identify behaviour is
> happier.

Here are three dmesg snippets. Stock -mm1, stock -mm1 with irqpoll and -mm1 with the above-mentioned 
change. (Unfortunately the net card is on the same irq as the disk controller, so I've disabled the 
raid to prevent it from blowing up and knocking out the net card irq also - allows me to get the 
dmesg out anyway). When I get a tic I'll see if moving the disk controller card around allows me to 
use another irq.

Stock 2.9.19-rc4-mm1

[   29.782721] pata_hpt37x: BIOS has not set timing clocks.
[   29.784849] hpt37x: HPT374: Bus clock 33MHz.
[   29.784912] ACPI: PCI Interrupt 0000:00:05.0[A] -> GSI 16 (level, low) -> IRQ 17
[   29.785092] ata1: PATA max UDMA/133 cmd 0xE000 ctl 0xE102 bmdma 0xE400 irq 17
[   29.785181] ata2: PATA max UDMA/133 cmd 0xE200 ctl 0xE302 bmdma 0xE408 irq 17
[   29.785248] scsi0 : pata_hpt37x
[   29.942765] ata1.00: ATA-6, max UDMA/100, 390622887 sectors: LBA48
[   29.942821] ata1.00: ata1: dev 0 multi count 16
[   29.942883] Find mode for 12 reports A81F442
[   29.942936] Find mode for DMA 69 reports 12848242
[   29.946299] ata1.00: configured for UDMA/100
[   29.946358] scsi1 : pata_hpt37x
[   30.102932] ata2.00: ATA-6, max UDMA/100, 390625000 sectors: LBA48
[   30.102984] ata2.00: ata2: dev 0 multi count 16
[   30.103038] Find mode for 12 reports A81F442
[   30.103090] Find mode for DMA 69 reports 12848242
[   30.106865] ata2.00: configured for UDMA/100
[   30.107056] scsi 0:0:0:0: Direct-Access     ATA      WDC WD2000JB-00D 02.1 PQ: 0 ANSI: 5
[   30.107213] SCSI device sda: 390622887 512-byte hdwr sectors (199999 MB)
[   30.107277] sda: Write Protect is off
[   30.107325] sda: Mode Sense: 00 3a 00 00
[   30.107341] SCSI device sda: drive cache: write back
[   30.107443] SCSI device sda: 390622887 512-byte hdwr sectors (199999 MB)
[   30.107501] sda: Write Protect is off
[   30.107549] sda: Mode Sense: 00 3a 00 00
[   30.107563] SCSI device sda: drive cache: write back
[   30.107614]  sda: sda1
[   30.131208] sd 0:0:0:0: Attached scsi disk sda
[   30.131357] scsi 1:0:0:0: Direct-Access     ATA      WDC WD2000JB-00D 75.1 PQ: 0 ANSI: 5
[   30.131500] SCSI device sdb: 390625000 512-byte hdwr sectors (200000 MB)
[   30.131560] sdb: Write Protect is off
[   30.131608] sdb: Mode Sense: 00 3a 00 00
[   30.131622] SCSI device sdb: drive cache: write back
[   30.131702] SCSI device sdb: 390625000 512-byte hdwr sectors (200000 MB)
[   30.131761] sdb: Write Protect is off
[   30.131809] sdb: Mode Sense: 00 3a 00 00
[   30.131823] SCSI device sdb: drive cache: write back
[   30.131873]  sdb: sdb1
[   30.150656] sd 1:0:0:0: Attached scsi disk sdb
[   30.150764] pata_hpt37x: BIOS has not set timing clocks.
[   30.152828] hpt37x: HPT374: Bus clock 33MHz.
[   30.152892] ACPI: PCI Interrupt 0000:00:05.1[A] -> GSI 16 (level, low) -> IRQ 17
[   30.153043] ata3: PATA max UDMA/133 cmd 0xE500 ctl 0xE602 bmdma 0xE900 irq 17
[   30.153134] ata4: PATA max UDMA/133 cmd 0xE700 ctl 0xE802 bmdma 0xE908 irq 17
[   30.153193] scsi2 : pata_hpt37x
[   30.310793] ata3.00: ATA-6, max UDMA/100, 390622887 sectors: LBA48
[   30.310845] ata3.00: ata3: dev 0 multi count 16
[   30.310904] Find mode for 12 reports A81F442
[   30.310957] Find mode for DMA 69 reports 12848242
[   30.314783] ata3.00: configured for UDMA/100
[   30.314834] scsi3 : pata_hpt37x
[   31.604353] ATA: abnormal status 0x7F on port 0xE707
[   32.741576] ATA: abnormal status 0x7F on port 0xE707
[   33.878801] ATA: abnormal status 0x7F on port 0xE707
[   35.015216] ATA: abnormal status 0x7F on port 0xE707
[   36.151634] ATA: abnormal status 0x7F on port 0xE707
[   37.288053] ATA: abnormal status 0x7F on port 0xE707
[   67.265903] ata4.00: qc timeout (cmd 0xec)
[   67.265955] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   69.061832] ATA: abnormal status 0x7F on port 0xE707
[   70.199056] ATA: abnormal status 0x7F on port 0xE707
[   71.336281] ATA: abnormal status 0x7F on port 0xE707
[   72.472696] ATA: abnormal status 0x7F on port 0xE707
[   73.609114] ATA: abnormal status 0x7F on port 0xE707
[   74.745533] ATA: abnormal status 0x7F on port 0xE707
[  104.723382] ata4.00: qc timeout (cmd 0xec)
[  104.723433] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  106.519312] ATA: abnormal status 0x7F on port 0xE707
[  107.656624] ATA: abnormal status 0x7F on port 0xE707
[  108.793852] ATA: abnormal status 0x7F on port 0xE707
[  109.930267] ATA: abnormal status 0x7F on port 0xE707
[  111.066685] ATA: abnormal status 0x7F on port 0xE707
[  112.203104] ATA: abnormal status 0x7F on port 0xE707
[  142.180861] ata4.00: qc timeout (cmd 0xec)
[  142.180912] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  143.976792] ATA: abnormal status 0x7F on port 0xE707
[  143.976978] scsi 2:0:0:0: Direct-Access     ATA      WDC WD2000JB-00D 75.1 PQ: 0 ANSI: 5
[  143.977180] SCSI device sdc: 390622887 512-byte hdwr sectors (199999 MB)
[  143.977243] sdc: Write Protect is off
[  143.977292] sdc: Mode Sense: 00 3a 00 00
[  143.977307] SCSI device sdc: drive cache: write back
[  143.977408] SCSI device sdc: 390622887 512-byte hdwr sectors (199999 MB)
[  143.977467] sdc: Write Protect is off
[  143.977515] sdc: Mode Sense: 00 3a 00 00
[  143.977528] SCSI device sdc: drive cache: write back
[  143.977580]  sdc: sdc1
[  144.008309] sd 2:0:0:0: Attached scsi disk sdc


Stock 2.9.19-rc4-mm1 with irqpoll


[   30.003816] pata_hpt37x: BIOS has not set timing clocks.
[   30.005967] hpt37x: HPT374: Bus clock 33MHz.
[   30.006030] ACPI: PCI Interrupt 0000:00:05.0[A] -> GSI 16 (level, low) -> IRQ 17
[   30.006208] ata1: PATA max UDMA/133 cmd 0xE000 ctl 0xE102 bmdma 0xE400 irq 17
[   30.006295] ata2: PATA max UDMA/133 cmd 0xE200 ctl 0xE302 bmdma 0xE408 irq 17
[   30.006362] scsi0 : pata_hpt37x
[   30.162940] ata1.00: ATA-6, max UDMA/100, 390622887 sectors: LBA48
[   30.162997] ata1.00: ata1: dev 0 multi count 16
[   30.163059] Find mode for 12 reports A81F442
[   30.163112] Find mode for DMA 69 reports 12848242
[   30.167656] ata1.00: configured for UDMA/100
[   30.167715] scsi1 : pata_hpt37x
[   30.323084] ata2.00: ATA-6, max UDMA/100, 390625000 sectors: LBA48
[   30.323136] ata2.00: ata2: dev 0 multi count 16
[   30.323189] Find mode for 12 reports A81F442
[   30.323241] Find mode for DMA 69 reports 12848242
[   30.327017] ata2.00: configured for UDMA/100
[   30.327208] scsi 0:0:0:0: Direct-Access     ATA      WDC WD2000JB-00D 02.1 PQ: 0 ANSI: 5
[   30.327367] SCSI device sda: 390622887 512-byte hdwr sectors (199999 MB)
[   30.327431] sda: Write Protect is off
[   30.327480] sda: Mode Sense: 00 3a 00 00
[   30.327496] SCSI device sda: drive cache: write back
[   30.327599] SCSI device sda: 390622887 512-byte hdwr sectors (199999 MB)
[   30.327658] sda: Write Protect is off
[   30.327705] sda: Mode Sense: 00 3a 00 00
[   30.327719] SCSI device sda: drive cache: write back
[   30.327769]  sda: sda1
[   30.347419] sd 0:0:0:0: Attached scsi disk sda
[   30.347571] scsi 1:0:0:0: Direct-Access     ATA      WDC WD2000JB-00D 75.1 PQ: 0 ANSI: 5
[   30.347718] SCSI device sdb: 390625000 512-byte hdwr sectors (200000 MB)
[   30.347778] sdb: Write Protect is off
[   30.347826] sdb: Mode Sense: 00 3a 00 00
[   30.347841] SCSI device sdb: drive cache: write back
[   30.347922] SCSI device sdb: 390625000 512-byte hdwr sectors (200000 MB)
[   30.347980] sdb: Write Protect is off
[   30.348028] sdb: Mode Sense: 00 3a 00 00
[   30.348042] SCSI device sdb: drive cache: write back
[   30.348093]  sdb: sdb1
[   30.367084] sd 1:0:0:0: Attached scsi disk sdb
[   30.367195] pata_hpt37x: BIOS has not set timing clocks.
[   30.369268] hpt37x: HPT374: Bus clock 33MHz.
[   30.369331] ACPI: PCI Interrupt 0000:00:05.1[A] -> GSI 16 (level, low) -> IRQ 17
[   30.369485] ata3: PATA max UDMA/133 cmd 0xE500 ctl 0xE602 bmdma 0xE900 irq 17
[   30.369575] ata4: PATA max UDMA/133 cmd 0xE700 ctl 0xE802 bmdma 0xE908 irq 17
[   30.369634] scsi2 : pata_hpt37x
[   30.526943] ata3.00: ATA-6, max UDMA/100, 390622887 sectors: LBA48
[   30.526995] ata3.00: ata3: dev 0 multi count 16
[   30.527055] Find mode for 12 reports A81F442
[   30.527107] Find mode for DMA 69 reports 12848242
[   30.530876] ata3.00: configured for UDMA/100
[   30.530927] scsi3 : pata_hpt37x
[   31.820523] ATA: abnormal status 0x7F on port 0xE707
[   32.959379] ATA: abnormal status 0x7F on port 0xE707
[   34.098231] ATA: abnormal status 0x7F on port 0xE707
[   35.234648] ATA: abnormal status 0x7F on port 0xE707
[   36.371069] ATA: abnormal status 0x7F on port 0xE707
[   37.507488] ATA: abnormal status 0x7F on port 0xE707
[   38.644206] ATA: abnormal status 0x7F on port 0xE707
[   38.644287] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x3)
[   40.438421] ATA: abnormal status 0x7F on port 0xE707
[   41.577278] ATA: abnormal status 0x7F on port 0xE707
[   42.716129] ATA: abnormal status 0x7F on port 0xE707
[   43.852547] ATA: abnormal status 0x7F on port 0xE707
[   44.988965] ATA: abnormal status 0x7F on port 0xE707
[   46.125382] ATA: abnormal status 0x7F on port 0xE707
[   47.262101] ATA: abnormal status 0x7F on port 0xE707
[   47.262180] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x3)
[   49.056319] ATA: abnormal status 0x7F on port 0xE707
[   50.195176] ATA: abnormal status 0x7F on port 0xE707
[   51.334028] ATA: abnormal status 0x7F on port 0xE707
[   52.470445] ATA: abnormal status 0x7F on port 0xE707
[   53.606866] ATA: abnormal status 0x7F on port 0xE707
[   54.743284] ATA: abnormal status 0x7F on port 0xE707
[   55.880003] ATA: abnormal status 0x7F on port 0xE707
[   55.880083] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x3)
[   57.674218] ATA: abnormal status 0x7F on port 0xE707
[   57.674392] scsi 2:0:0:0: Direct-Access     ATA      WDC WD2000JB-00D 75.1 PQ: 0 ANSI: 5
[   57.674566] SCSI device sdc: 390622887 512-byte hdwr sectors (199999 MB)
[   57.674628] sdc: Write Protect is off
[   57.674676] sdc: Mode Sense: 00 3a 00 00
[   57.674692] SCSI device sdc: drive cache: write back
[   57.674789] SCSI device sdc: 390622887 512-byte hdwr sectors (199999 MB)
[   57.674847] sdc: Write Protect is off
[   57.674895] sdc: Mode Sense: 00 3a 00 00
[   57.674908] SCSI device sdc: drive cache: write back
[   57.674959]  sdc: sdc1
[   57.706274] sd 2:0:0:0: Attached scsi disk sdc


2.9.19-rc4-mm1 with added ATA_FLAG_DETECT_POLLING

[   29.782478] pata_hpt37x: BIOS has not set timing clocks.
[   29.784599] hpt37x: HPT374: Bus clock 33MHz.
[   29.784661] ACPI: PCI Interrupt 0000:00:05.0[A] -> GSI 16 (level, low) -> IRQ 17
[   29.784840] ata1: PATA max UDMA/133 cmd 0xE000 ctl 0xE102 bmdma 0xE400 irq 17
[   29.784930] ata2: PATA max UDMA/133 cmd 0xE200 ctl 0xE302 bmdma 0xE408 irq 17
[   29.784997] scsi0 : pata_hpt37x
[   29.948363] ata1.00: ATA-6, max UDMA/100, 390622887 sectors: LBA48
[   29.948421] ata1.00: ata1: dev 0 multi count 16
[   29.948482] Find mode for 12 reports A81F442
[   29.948536] Find mode for DMA 69 reports 12848242
[   29.951924] ata1.00: configured for UDMA/100
[   29.951982] scsi1 : pata_hpt37x
[   30.116235] ata2.00: ATA-6, max UDMA/100, 390625000 sectors: LBA48
[   30.116287] ata2.00: ata2: dev 0 multi count 16
[   30.116341] Find mode for 12 reports A81F442
[   30.116392] Find mode for DMA 69 reports 12848242
[   30.120205] ata2.00: configured for UDMA/100
[   30.120397] scsi 0:0:0:0: Direct-Access     ATA      WDC WD2000JB-00D 02.1 PQ: 0 ANSI: 5
[   30.120554] SCSI device sda: 390622887 512-byte hdwr sectors (199999 MB)
[   30.120618] sda: Write Protect is off
[   30.120666] sda: Mode Sense: 00 3a 00 00
[   30.120682] SCSI device sda: drive cache: write back
[   30.120785] SCSI device sda: 390622887 512-byte hdwr sectors (199999 MB)
[   30.120843] sda: Write Protect is off
[   30.120891] sda: Mode Sense: 00 3a 00 00
[   30.120905] SCSI device sda: drive cache: write back
[   30.120955]  sda: sda1
[   30.142871] sd 0:0:0:0: Attached scsi disk sda
[   30.143021] scsi 1:0:0:0: Direct-Access     ATA      WDC WD2000JB-00D 75.1 PQ: 0 ANSI: 5
[   30.143166] SCSI device sdb: 390625000 512-byte hdwr sectors (200000 MB)
[   30.143226] sdb: Write Protect is off
[   30.143274] sdb: Mode Sense: 00 3a 00 00
[   30.143288] SCSI device sdb: drive cache: write back
[   30.143370] SCSI device sdb: 390625000 512-byte hdwr sectors (200000 MB)
[   30.143428] sdb: Write Protect is off
[   30.143476] sdb: Mode Sense: 00 3a 00 00
[   30.143490] SCSI device sdb: drive cache: write back
[   30.143540]  sdb: sdb1
[   30.165443] sd 1:0:0:0: Attached scsi disk sdb
[   30.165551] pata_hpt37x: BIOS has not set timing clocks.
[   30.167614] hpt37x: HPT374: Bus clock 33MHz.
[   30.167677] ACPI: PCI Interrupt 0000:00:05.1[A] -> GSI 16 (level, low) -> IRQ 17
[   30.167828] ata3: PATA max UDMA/133 cmd 0xE500 ctl 0xE602 bmdma 0xE900 irq 17
[   30.167916] ata4: PATA max UDMA/133 cmd 0xE700 ctl 0xE802 bmdma 0xE908 irq 17
[   30.167985] scsi2 : pata_hpt37x
[   30.332087] ata3.00: ATA-6, max UDMA/100, 390622887 sectors: LBA48
[   30.332139] ata3.00: ata3: dev 0 multi count 16
[   30.332199] Find mode for 12 reports A81F442
[   30.332252] Find mode for DMA 69 reports 12848242
[   30.336043] ata3.00: configured for UDMA/100
[   30.336094] scsi3 : pata_hpt37x
[   31.628149] ATA: abnormal status 0x7F on port 0xE707
[   32.765373] ATA: abnormal status 0x7F on port 0xE707
[   33.902597] ATA: abnormal status 0x7F on port 0xE707
[   35.039012] ATA: abnormal status 0x7F on port 0xE707
[   36.175431] ATA: abnormal status 0x7F on port 0xE707
[   37.311849] ATA: abnormal status 0x7F on port 0xE707
[   38.448266] ATA: abnormal status 0x7F on port 0xE707
[   39.585835] ATA: abnormal status 0x7F on port 0xE707
[   39.585902] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x3)
[   41.381241] ATA: abnormal status 0x7F on port 0xE707
[   42.518467] ATA: abnormal status 0x7F on port 0xE707
[   43.655692] ATA: abnormal status 0x7F on port 0xE707
[   44.792107] ATA: abnormal status 0x7F on port 0xE707
[   45.928525] ATA: abnormal status 0x7F on port 0xE707
[   47.064944] ATA: abnormal status 0x7F on port 0xE707
[   48.201361] ATA: abnormal status 0x7F on port 0xE707
[   49.338977] ATA: abnormal status 0x7F on port 0xE707
[   49.339044] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x3)
[   51.134338] ATA: abnormal status 0x7F on port 0xE707
[   52.271562] ATA: abnormal status 0x7F on port 0xE707
[   53.408787] ATA: abnormal status 0x7F on port 0xE707
[   54.545202] ATA: abnormal status 0x7F on port 0xE707
[   55.681620] ATA: abnormal status 0x7F on port 0xE707
[   56.818039] ATA: abnormal status 0x7F on port 0xE707
[   57.954456] ATA: abnormal status 0x7F on port 0xE707
[   59.092047] ATA: abnormal status 0x7F on port 0xE707
[   59.092113] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x3)
[   60.887433] ATA: abnormal status 0x7F on port 0xE707
[   60.887597] scsi 2:0:0:0: Direct-Access     ATA      WDC WD2000JB-00D 75.1 PQ: 0 ANSI: 5
[   60.887777] SCSI device sdc: 390622887 512-byte hdwr sectors (199999 MB)
[   60.887840] sdc: Write Protect is off
[   60.887888] sdc: Mode Sense: 00 3a 00 00
[   60.887904] SCSI device sdc: drive cache: write back
[   60.888000] SCSI device sdc: 390622887 512-byte hdwr sectors (199999 MB)
[   60.888058] sdc: Write Protect is off
[   60.888106] sdc: Mode Sense: 00 3a 00 00
[   60.888120] SCSI device sdc: drive cache: write back
[   60.888170]  sdc: sdc1
[   60.918685] sd 2:0:0:0: Attached scsi disk sdc


Regards,
Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
