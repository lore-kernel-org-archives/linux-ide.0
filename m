From: Bart Theunissen <Bart.Theunissen@pandora.be>
Subject: Re: Bug in IDE controllers when connected to PCI?
Date: Thu, 13 Mar 2003 11:23:01 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <3E705C05.7060603@pandora.be>
References: <200303121221.11335.gardiol@libero.it> <3E6F25EB.7000904@pandora.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eos.telenet-ops.be (Postfix) with SMTP id 5FB301FF4D
	for <linux-ide@vger.kernel.org>; Thu, 13 Mar 2003 11:23:06 +0100 (CET)
Received: from jupiter.universe (C38288DC.kabel.telenet.be [195.130.136.220])
	by eos.telenet-ops.be (Postfix) with SMTP id B57031FF39
	for <linux-ide@vger.kernel.org>; Thu, 13 Mar 2003 11:23:04 +0100 (CET)
In-Reply-To: <3E6F25EB.7000904@pandora.be>
List-Id: linux-ide@vger.kernel.org
To: Bart Theunissen <Bart.Theunissen@pandora.be>
Cc: gardiol@libero.it, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Harrison_Richard@emc.com, berthiaume_wayne@emc.com

Hi,

unfortunately, linux-2.4.17 does not support promise-20269 ;-(

Greetings,

Bart

Bart Theunissen wrote:

> Hi,
>
> I am experiencing the same problem. The controller is a promise-20269=
=20
> and four disks are attached to it (dma is turned on for all drives)
> I get the same error messages on the console (except for the scsi=20
> message). The message 'seeking beyond end of device' is also logged t=
o=20
> console. Additionally, file corruption occurs in files that are=20
> changed very often (logfiles, database files). It seems that the=20
> erroneous data in the logfiles comes from other files on the same=20
> partition (/var). Sometimes it takes up to 12 hours before corruption=
=20
> occurs. The program I am using to test this is a java program that=20
> does write/read/modify and uses md5 to see if a file was changed=20
> (corrupted) without accessing the file directly. Sometimes, the=20
> complete systems crashes (it cannot execute a binary or find a=20
> library). I encountered this on kernel 2.4.20.
>
> I am testing 2.4.17 to see if it has the same problem (gardiol said=20
> this one should be fine).
>
> What can be the cause of this problem ? If more information is needed=
,=20
> or additional tests are required, let me know.
>
> Greets,
>
> Bart
>
> Willy Gardiol wrote:
>
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>>
>> Hi to all,
>> i think i run into a bug in current stable kernel's regarding IDE=20
>> controllers and PCI.
>> Sorry for the long post, but i need some help from you to investigat=
e=20
>> this deeper.
>>
>> I own a CDRW Philips 1610A, here is hdparm -i and -I output:
>>
>> (hdparm -i)
>> /dev/hdf:
>> Model=3DPHILIPS CDRW1610A, FwRev=3D0.010000, SerialNo=3D5VO2149DL136=
92
>> Config=3D{ Fixed Removeable DTR<=3D5Mbs DTR>10Mbs nonMagnetic }
>> RawCHS=3D0/0/0, TrkSize=3D0, SectSize=3D0, ECCbytes=3D0
>> BuffType=3DDualPortCache, BuffSize=3D128kB, MaxMultSect=3D0
>> (maybe): CurCHS=3D0/0/0, CurSects=3D0, LBA=3Dyes, LBAsects=3D0
>> IORDY=3Dyes, tPIO=3D{min:120,w/IORDY:120}, tDMA=3D{min:120,rec:120}
>> PIO modes: pio0 pio1 pio2 pio3 pio4
>> DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 udma2
>> AdvancedPM=3Dno
>>
>> (hdparm -I)
>> /dev/hdf:
>> ATAPI CD-ROM, with removable media
>>        Model Number:           PHILIPS CDRW1610A
>>        Serial Number:          5VO2149DL13692
>>        Firmware Revision:      0.010000
>> Standards:
>> Configuration:
>>        DRQ response: 50us.
>>        Packet size: 12 bytes
>> Capabilities:
>>        LBA, IORDY(cannot be disabled)
>>        Buffer size: 128.0kB
>>        DMA: sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2 udma0 udma1 udma2
>>             Cycle time: min=3D120ns recommended=3D120ns
>>        PIO: pio0 pio1 pio2 pio3 pio4
>>             Cycle time: no flow control=3D120ns  IORDY flow control=3D=
120ns
>>
>> It works and burns correctly with DMA enabled( hdparm -d1) when=20
>> connected to the on-board IDE controller, following is /rpco/pci of =
it:
>>  Bus  0, device   4, function  1:
>>    IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master=20
>> IDE (rev 6).
>>      Master Capable.  Latency=3D32.
>>      I/O at 0xd800 [0xd80f].
>>
>> I also have two different PCI IDE ATA100/133 controllers:
>> a Promise Ultra100 TX2 (chip PDC20268)
>> a Sil  0680 based RAID ATA133 board
>> Here is /proc/pci for the 0680 (the other one is not conented right =
now)
>>  Bus  0, device  11, function  0:
>>    RAID bus controller: CMD Technology Inc PCI0680 (rev 2).
>>      IRQ 10.
>>      Master Capable.  Latency=3D32.
>>      I/O at 0x9800 [0x9807].
>>      I/O at 0x9400 [0x9403].
>>      I/O at 0x9000 [0x9007].
>>      I/O at 0x8800 [0x8803].
>>      I/O at 0x8400 [0x840f].
>>      Non-prefetchable 32 bit memory at 0xd4800000 [0xd48000ff].
>>
>> When connected to any of these two controllers (as hde, hdf or hdg,=20
>> not tryed hdh but dont think it changes something) if i enable DMA=20
>> (hdparm -d1) the kernel hangs when i try to burn: no logs are writte=
n=20
>> (!) but i managed to get this output (sending all logs to /dev/tty12=
):
>>
>> IDE_DMAPROC: chipset supported IDE_DMA_TIMEOUT only: 14
>> hdf: status timeout: status 0xd0 { Busy }
>> hdf: drive not ready for command
>> vmunix: scsi: aborting command due to timeout: pid 934, scsi0,=20
>> channel 0, id 0, lun 0 2x2a 00 00 00 00 00 00 1f 00
>> IDE_DMAPROC: chipset supported IDE_DMA_TIMEOUT only: 14
>> hdf: status timeout: status 0xd0 { Busy }
>> hdf: drive not ready for command
>> hdf: ATAPI reset complete
>> unable to handle kernel null pointer dereference at virtual address=20
>> 00018
>> (follow a register dump, omitted because i didnt copied it)
>> kernel panic: Aieee, killing interrupt handler!
>> in interrupt handler - NOT SYNCING
>>
>> I had to copy this by hand so maybe there are some typo errors.
>>
>> I also own a DVD reader, also connected to this PCI controllers whic=
h=20
>> uses UDMA5 (hdparm -d1 -X69) and has different troubles:
>> - - with the Promise PCD20268 it causes a kernel panic when i try to=
=20
>> read a dirty CD (which, on the other hand the cdburner correctly rea=
ds)
>> - - with the 0680 it reads the same CD without giving ANY read error=
s=20
>> and without hanging the kernel! (but gives many reading errors with=20
>> the burner...)
>>
>> Off course none of this problems had ever been noticed using the=20
>> motherboard-integrated IDE controllers....
>>
>> Please note, this troubles appeared first in kernel 2.4.18, and are=20
>> reproducing up to 2.4.20 (i have not tryed 2.4.21-preX nor 2.5.x).=20
>> There where no troubles with any other 2.4.x i tryed (2.4.7, 2.4.14,=
=20
>> 2.4.17 at least)
>>
>> What do you think of this? Where could be the problem? what could i=20
>> do to get more info and solve this problem?
>>
>> Thanks to all!
>>
>> - --
>> ! Willy Gardiol - gardiol@libero.it
>> goemon.polito.it/~gardiol
>> Use linux for your freedom.
>>
>>    Non ho parole, fratelli.    Quaranta paesi bambini    hanno=20
>> attaccato un asilo        e la chiamano guerra.
>>    Gli eserciti pi=F9 potenti del mondo    hanno attaccato il pi=F9=20
>> straccione.
>>
>>     Jack Folla ( 8/10/2001 )  =20
>>
>> -----BEGIN PGP SIGNATURE-----
>> Version: GnuPG v1.2.1 (GNU/Linux)
>>
>> iD8DBQE+bxgnQ9qolN/zUk4RAlF4AJ431AQ7jTaaxJPugtEQTtimaqWZ7QCgryeJ
>> TpRdVaO97yfsr08v8D6lwB0=3D
>> =3DqUwm
>> -----END PGP SIGNATURE-----
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe=20
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>> =20
>>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


