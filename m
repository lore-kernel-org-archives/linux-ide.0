From: "Peter Wells" <pete.wells@gmail.com>
Subject: Re: IT8212 driver seems to be broken - no DMA or functionality in general
Date: Mon, 18 Aug 2008 18:51:18 +0100
Message-ID: <4405b24e0808181051n7fbcbd1eu17f0f398ea7d644a@mail.gmail.com>
References: <4405b24e0808120446s14c42968t870de56a0af109c4@mail.gmail.com>
	 <4405b24e0808120449r7ce1466bm3387319549dbaa0b@mail.gmail.com>
	 <20080812125735.40f46775@lxorguk.ukuu.org.uk>
	 <58cb370e0808120547t75cad09ci973f668d4e8fc6fd@mail.gmail.com>
	 <4405b24e0808120609v25abbe54s605ad9b3ad96a6f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:45290 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbYHRRvT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Aug 2008 13:51:19 -0400
Received: by gxk9 with SMTP id 9so4011266gxk.13
        for <linux-ide@vger.kernel.org>; Mon, 18 Aug 2008 10:51:18 -0700 (PDT)
In-Reply-To: <4405b24e0808120609v25abbe54s605ad9b3ad96a6f9@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Hi Guys,

Thanks for your help,

The RAID array is back up and running now.  The device seems to take a
little while to be recognised and there are still; some error messages
in dmesg but it's working none the less.

I've included the output of dmesg below in case it's useful.
Hopefully it's the relevant chunk.

Thanks again,

Kind regards,

Pete


Uniform Multi-Platform E-IDE driver
alim15x3 0000:00:0f.0: IDE controller (0x10b9:0x5229 rev 0xc2)
ALI15x3_IDE 0000:00:0f.0: can't derive routing for PCI INT A
alim15x3 0000:00:0f.0: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007
    ide1: BM-DMA at 0xf008-0xf00f
Probing IDE interface ide0...
hda: ST320410A, ATA DISK drive
hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hda: host side 80-wire cable detection failed, limiting max speed to UDMA33
hda: UDMA/33 mode selected
Probing IDE interface ide1...
hdc: SAMSUNG SP1604N, ATA DISK drive
hdd: WDC WD1200BB-00CAA1, ATA DISK drive
hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hdc: UDMA/66 mode selected
hdd: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hdd: UDMA/66 mode selected
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63
hda: cache flushes not supported
 hda: hda1 hda2 hda3
hdc: max request size: 128KiB
hdc: cannot use LBA48 DMA - PIO mode will be used for accessing sectors > 26843
456
hdc: 312581808 sectors (160041 MB) w/2048KiB Cache, CHS=19457/255/63
hdc: cache flushes supported
 hdc: hdc1
hdd: max request size: 128KiB
hdd: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=65535/16/63
hdd: cache flushes not supported
 hdd: hdd1
Driver 'sd' needs updating - please use bus_type methods
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
pata_it821x 0000:00:09.0: PCI INT A -> Link[LNKB] -> GSI 10 (level, low) -> IRQ
10
pata_it821x: controller in smart mode.
pata_it821x 0000:00:09.0: setting latency timer to 64
pata_it821x: Firmware 02/09/3030
0: MWDMA2 RAID1RAID 0+1 Volume: 0 WDC WD600BB-00CAA1
1: MWDMA2 RAID1RAID 0+1 Volume: 0 WDC WD600AB-60BVA0
scsi0 : pata_it821x
scsi1 : pata_it821x
ata1: PATA max UDMA/133 cmd 0xd400 ctl 0xd800 bmdma 0xe400 irq 10
ata2: PATA max UDMA/133 cmd 0xdc00 ctl 0xe000 bmdma 0xe408 irq 10
ata1: link is slow to respond, please be patient (ready=0)
ata1: SRST failed (errno=-16)
ata1: link is slow to respond, please be patient (ready=0)
ata1: SRST failed (errno=-16)
ata1: link is slow to respond, please be patient (ready=0)
ata1.00: ATA-4: Integrated Technology Express Inc, , max MWDMA2
ata1.00: 117231406 sectors, multi 0: LBA
ata1.00: RAID1 volume.
ata1.00: configured for DMA
scsi 0:0:0:0: Direct-Access     ATA      Integrated Techn n/a  PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 117231406 512-byte hardware sectors (60022 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support D
O or FUA
sd 0:0:0:0: [sda] 117231406 512-byte hardware sectors (60022 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support D
O or FUA
 sda: sda1
sd 0:0:0:0: [sda] Attached SCSI disk



2008/8/12 Peter Wells <pete.wells@gmail.com>:
> Hi Guys,
>
> Thanks for your help,
>
> I shall try 2.6.27-rc2 tonight.
>
> Kind regards,
>
> Pete
>
> 2008/8/12 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>:
>> On Tue, Aug 12, 2008 at 1:57 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>>>> The post is located at http://kerneltrap.org/node/16482 and looks like this:
>>>>
>>>> IT8212 driver seems to be broken - no DMA or functionality in general
>>>
>>> I sent Jeff a set of fixes for this for the libata driver. Some changes
>>> in libata broke some tricks the pata_it821x driver did. I've rewritten
>>> those bits and parts of the core libata to sort that out and my IT821x
>>> RAID card is back to health with libata. Hopefully .27 will behave
>>> somewhat better therefore.
>>>
>>> No idea about the old IDE driver. I don't think anyone maintains that one
>>> any more but it certainly used to work.
>>
>> It should still work.  Peter, please try with 2.6.27-rc2 (2.6.26 needs
>> a fix which is queued for the next -stable release).
>>
>
