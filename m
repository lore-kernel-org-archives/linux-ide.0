From: "Riccardo Castellani" <r.castellani@usl6.toscana.it>
Subject: Re: UDMA5
Date: Tue, 20 Sep 2005 09:51:00 +0200
Message-ID: <001801c5bdb8$0c204240$1f01a8c0@Ric>
References: <011401c5b2b2$becb3b40$1f01a8c0@Ric> <000a01c5b445$f9570520$1f01a8c0@Ric> <431FF0EA.2090006@yahoo.de> <00a601c5b469$3a3cdc40$1f01a8c0@Ric> <43205F0C.10607@yahoo.de> <01da01c5bcfb$3b69cd90$1f01a8c0@Ric> <432E89E8.5090409@yahoo.de> <000a01c5bd2b$cd933ff0$1f01a8c0@Ric> <58cb370e05091908167d941bee@mail.gmail.com> <003f01c5bd2f$87bbedc0$1f01a8c0@Ric> <58cb370e05091908367771dd10@mail.gmail.com>
Reply-To: "Riccardo Castellani" <r.castellani@usl6.toscana.it>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lisa.usl6.toscana.it ([159.213.44.2]:17609 "EHLO
	lisa.nord.usl6.toscana.it") by vger.kernel.org with ESMTP
	id S964909AbVITHuS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Sep 2005 03:50:18 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, Riccardo Castellani <r.castellani@usl6.toscana.it>
Cc: Stefan <gentoopower@yahoo.de>, linux-ide@vger.kernel.org

I replaced again 80 wire cable with another one for the fourth time.
I tried to connect IDE cable inverting side ends.
Now It works alright.
Thanks

hdparm -i  /dev/hda gets:

 Model=Maxtor 6Y080L0, FwRev=YAR41BW0, SerialNo=Y23TZR2C
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=4047/16/255, CurSects=16511760, LBA=yes, LBAsects=160086528
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 *udma4 udma5 udma6
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: (null):

 * signifies the current active mode


But in dmesg I saw:

EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1052216k swap on /dev/hda7.  Priority:-1 extents:1
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide: failed opcode was: unknown
ide0: reset: success

why this error ?


----- Original Message ----- 
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: "Riccardo Castellani" <r.castellani@usl6.toscana.it>
Cc: "Stefan" <gentoopower@yahoo.de>; <linux-ide@vger.kernel.org>
Sent: Monday, September 19, 2005 5:36 PM
Subject: Re: UDMA5


> On 9/19/05, Riccardo Castellani <r.castellani@usl6.toscana.it> wrote:
>> I think it's no kernel problem because after immediately POST stage 
>> (before
>> that GRUB is loaded) I see hard disk properties where UDMA is set to 2
>> value. PIO mode is set to 4.
>
> It is still worth to try (Linux VIA IDE driver overrides BIOS UDMA 
> settings,
> it depends only on BIOS doing the cable detection - but you can try 
> booting
> with "ide0=ata66" kernel parameter to force 80-wires cable).
>
>> ----- Original Message -----
>> From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
>> To: "Riccardo Castellani" <r.castellani@usl6.toscana.it>
>> Cc: "Stefan" <gentoopower@yahoo.de>; <linux-ide@vger.kernel.org>
>> Sent: Monday, September 19, 2005 5:16 PM
>> Subject: Re: UDMA5
>>
>>
>> > On 9/19/05, Riccardo Castellani <r.castellani@usl6.toscana.it> wrote:
>> >> I run Maxtor MaxPower tool and HD test is ok.
>> >> I didn't see any settings to change UDMA mode.
>> >> I tried to run Knoppix live CD into machine and I had the same result:
>> >> UDMA
>> >> 2*
>> >> I put this disk into another hardware and It worked in UDMA 6 !!!
>> >> What do you think ?
>> >
>> >>>>> Linux version 2.6.12-1.1376_FC3 (bhcompile@tweety.build.redhat.com)
>> >>>>> (gcc version 3.4.4 20050721 (Red Hat 3.4.4-2)) #1 Fri Aug 26 
>> >>>>> 23:27:26
>> >>>>> EDT 2005
>> >
>> > Try with *vanilla* kernel 2.6.13 or 2.6.14-rc1.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

