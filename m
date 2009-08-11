From: Jim Duda <jim@duda.tzo.com>
Subject: Re: 2.6.31-rc1 with ide-tape / STT2000A
Date: Mon, 10 Aug 2009 20:40:10 -0400
Message-ID: <h5qelb$6it$1@ger.gmane.org>
References: <h5kn9c$51r$1@ger.gmane.org>	<4A7DE735.6090409@gmail.com>	<h5krje$ec7$1@ger.gmane.org> <20090809175840.0705f2d0@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:45475 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751009AbZHKAk0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Aug 2009 20:40:26 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MafPa-0004Ac-Gr
	for linux-ide@vger.kernel.org; Tue, 11 Aug 2009 00:40:22 +0000
Received: from pool-96-252-13-163.bstnma.fios.verizon.net ([96.252.13.163])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 11 Aug 2009 00:40:22 +0000
Received: from jim by pool-96-252-13-163.bstnma.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 11 Aug 2009 00:40:22 +0000
In-Reply-To: <20090809175840.0705f2d0@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On 08/09/2009 12:58 PM, Alan Cox wrote:

On 08/10/2009 01:23 PM, Alan Cox wrote:
>> hdc: HL-DT-ST GCE-8160B, ATAPI CD/DVD-ROM drive
>> hdd: Seagate STT20000A, ATAPI TAPE drive
>> ide-cd: hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache
>> libata version 3.00 loaded.
>> ata_piix 0000:00:1f.2: version 2.13
>> ata_piix 0000:00:1f.2: PCI INT A -> GSI 18 (level, low) -> IRQ 18
>> ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
>> ata_piix 0000:00:1f.2: setting latency timer to 64
>>
>
> You have both sets of drivers loaded at once. That won't do what you
> want. You need to build without the old IDE layer.
>
>

Aha!

Removing the older IDE drivers completely restored the use of the st driver.

I'm attempting a backup using libata and st now.

Maybe I don't need ide-tape afterall.

Thanks!

Jim


libata version 3.00 loaded.
ata_piix 0000:00:1f.1: version 2.13
ata_piix 0000:00:1f.1: enabling device (0005 -> 0007)
ata_piix 0000:00:1f.1: PCI INT A -> GSI 18 (level, low) -> IRQ 18
ata_piix 0000:00:1f.1: setting latency timer to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xfc00 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xfc08 irq 15
ata_piix 0000:00:1f.2: PCI INT A -> GSI 18 (level, low) -> IRQ 18
ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
ata_piix 0000:00:1f.2: setting latency timer to 64
scsi2 : ata_piix
scsi3 : ata_piix
ata3: SATA max UDMA/133 cmd 0xefe0 ctl 0xefac bmdma 0xef60 irq 18
ata4: SATA max UDMA/133 cmd 0xefa0 ctl 0xefa8 bmdma 0xef68 irq 18
ata2.00: ATAPI: HL-DT-ST GCE-8160B, 1.02, max MWDMA2
ata2.01: ATAPI: Seagate STT20000A, 8A51, max MWDMA2
ata2.01: device is on DMA blacklist, disabling DMA

>
> Alan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


