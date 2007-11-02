From: Krzysztof Oledzki <olel@ans.pl>
Subject: Re: pata_serverworks hangs
Date: Fri, 2 Nov 2007 18:25:56 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711021819520.19990@bizon.gios.gov.pl>
References: <Pine.LNX.4.64.0711021415300.1316@bizon.gios.gov.pl>
 <20071102164408.5529f6c8@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-187430788-1489998800-1194024356=:19990"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bizon.gios.gov.pl ([212.244.124.8]:35512 "EHLO
	bizon.gios.gov.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756239AbXKBR0K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 13:26:10 -0400
In-Reply-To: <20071102164408.5529f6c8@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---187430788-1489998800-1194024356=:19990
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Fri, 2 Nov 2007, Alan Cox wrote:

> On Fri, 2 Nov 2007 14:29:17 +0100 (CET)
> Krzysztof Oledzki <olel@ans.pl> wrote:
>
>> Hello,
>>
>> I just tried to switch from old IDE to libata but unfortunately kernel
>> (2.6.22.10) hangs during boot:
>>
>> ata1: PATA max UDMA/66 cmd 0x000101e8 ctl 0x000103ee bmdma 0x00012c40 ir=
q 11
>> ata2: DUMMY
>> ata1.00: ATAPI: HL-DT-ST CD-ROM GCR-8482B, 1.00, max MWDMA2
>> ara1.01: ATAPI: LITE-ON LTR-62327S, QS75, max UDMA/33
>> ata1.00: configured for MWDMA2
>> ata1.00: configured for UDMA/33
>> scsi 2:0:0:0: CDROM             HL-DT-ST CDROM GCR-8482B 1.00 PQ: 0 ANSI=
 5
>> (kernel hangs)
>>
>> Attaching lspci and dmesg from working system, with pata_serverworks
>> disabled.
>
>
> Interesting. Serverworks has been fairly well behaved. You seem to have a
> fairly standard CSB6 setup. Whats the motherboard

RIOWORKS PDRCA

> and is the CSB6 one of the RAID card options or just motherboard mounted=
=20
> ?

No additional RAID, only two cdroms connected to the motherboard. BTW: I=20
also have the output from old IDE if that may help:

hde: HL-DT-ST CD-ROM GCR-8482B, ATAPI CD/DVD-ROM drive
hdf: LITE-ON LTR-52327S, ATAPI CD/DVD-ROM drive
ide2 at 0x1e8-0x1ef,0x3ee on irq 11
SvrWks CSB6: IDE controller at PCI slot 0000:00:0f.1
SvrWks CSB6: chipset revision 160
SvrWks CSB6: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0x2c50-0x2c57, BIOS settings: hda:pio, hdb:pio
     ide1: BM-DMA at 0x2c58-0x2c5f, BIOS settings: hdc:pio, hdd:DMA
Probing IDE interface ide0...
Probing IDE interface ide1...
Probing IDE interface ide0...
Probing IDE interface ide1...
hde: ATAPI 48X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
hdf: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)


Best regards,

 =09=09=09=09Krzysztof Ol=EAdzki
---187430788-1489998800-1194024356=:19990--
