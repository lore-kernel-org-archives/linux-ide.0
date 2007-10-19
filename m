From: =?ISO-8859-1?Q?Mana=EF_Mehdi?= <vonmahdon@softhome.net>
Subject: Re: pata_via refuses to detect one drive
Date: Fri, 19 Oct 2007 22:53:38 +0200
Message-ID: <ffb5gj$ekq$1@ger.gmane.org>
References: <47161F09.3040003@msgid.tls.msk.ru>	<20071017165007.77471e8d@the-village.bc.nu>	<471653C4.9090709@msgid.tls.msk.ru> <20071017213155.2589bf8f@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:49723 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751920AbXJTMkJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 20 Oct 2007 08:40:09 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IjDcY-0006vJ-U4
	for linux-ide@vger.kernel.org; Sat, 20 Oct 2007 12:40:02 +0000
Received: from 196.203.151.155 ([196.203.151.155])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 20 Oct 2007 12:40:02 +0000
Received: from vonmahdon by 196.203.151.155 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 20 Oct 2007 12:40:02 +0000
In-Reply-To: <20071017213155.2589bf8f@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Alan Cox a =E9crit :
>>> This looks like both drives end up trying to be the slave ? Its cer=
tainly
>>> very vey confused at this point. Interesting it works with the BIOS=
 doing
>>> the reset, wonder what the difference is.
>> Not only it works with BIOS, it also works with via82cxxx just fine.
>=20
> The via82cxxx driver doesn't go off and reset everything unless it ge=
ts
> bad error cases.
> =20
>>> How are the drives jumpered and does it work with just one of the t=
wo
>>> present ?
>> That's an interesting question.  The machine is remote, and there's
>> no one on site who's able to check it.  I'll try to get reach of it,
>> hopefully it will be soon enough.  In any case, it looks like the
>> jumpers are OK, or else it shouldnt work with IDE module as well.
>=20
> Maybe. But its useful to know and it helps narrow down the fault. I'v=
e no
> idea whether the problem is hardware or software. What I am sure of
> though is if the BIOS and old driver work we should be able to make t=
he
> new one work. My first guess is still a driver bug, and second some k=
ind
> of probing interaction. BIOSen usually use Hal's code so we've got a =
fair
> idea of what the BIOS will do.
>=20
> Alan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
I've got the same problem and I really don't know what to do
here is my dmesg :

SCSI subsystem initialized
usb 1-2: new low speed USB device using uhci_hcd and address 2
libata version 2.21 loaded.
pata_via 0000:00:11.1: version 0.3.1
scsi0 : pata_via
scsi1 : pata_via
ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001ff00=20
irq 14
ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001ff08=20
irq 15
usb 1-2: configuration #1 chosen from 1 choice
input: Logitech Inc. iFeel Mouse    as /class/input/input2
input: USB HID v1.00 Mouse [Logitech Inc. iFeel Mouse   ] on=20
usb-0000:00:11.2-2
ata1.00: ATA-7: Maxtor 6Y160P0, YAR41BW0, max UDMA/133
ata1.00: 320173056 sectors, multi 16: LBA48
ata1.01: ATA-4: IBM-DJNA-351520, J56OA30K, max UDMA/33
ata1.01: 30033360 sectors, multi 16: LBA
ata1.00: configured for UDMA/100
ata1.01: configured for UDMA/33
usb 2-2: new full speed USB device using uhci_hcd and address 2
ata2.00: ATAPI: SONY    DVD RW DW-U18A, UYS1, max UDMA/33
usb 2-2: configuration #1 chosen from 1 choice
ata2.00: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      Maxtor 6Y160P0   YAR4 PQ: 0 AN=
SI: 5
sd 0:0:0:0: [sda] 320173056 512-byte hardware sectors (163929 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't=20
support DPO or FUA
sd 0:0:0:0: [sda] 320173056 512-byte hardware sectors (163929 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't=20
support DPO or FUA
  sda: sda1 sda2 < sda5 sda6 sda7 >
sd 0:0:0:0: [sda] Attached SCSI disk
scsi 0:0:1:0: Direct-Access     ATA      IBM-DJNA-351520  J56O PQ: 0 AN=
SI: 5
sd 0:0:1:0: [sdb] 30033360 512-byte hardware sectors (15377 MB)
sd 0:0:1:0: [sdb] Write Protect is off
sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't=20
support DPO or FUA
sd 0:0:1:0: [sdb] 30033360 512-byte hardware sectors (15377 MB)
sd 0:0:1:0: [sdb] Write Protect is off
sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't=20
support DPO or FUA
  sdb: sdb1 sdb2 < sdb5 sdb6 >
sd 0:0:1:0: [sdb] Attached SCSI disk
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x12 data 36=
 in
          res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violat=
ion)
ata2: soft resetting port
ata2.00: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x12 data 36=
 in
          res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violat=
ion)
ata2: soft resetting port
ata2.00: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x12 data 36=
 in
          res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violat=
ion)
ata2: soft resetting port
ata2.00: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x12 data 36=
 in
          res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x2 (HSM violat=
ion)
ata2: soft resetting port
ata2.00: configured for UDMA/33
ata2: EH complete
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised:=20
dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
audit(1192825830.852:2): selinux=3D0 auid=3D4294967295
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:1:0: Attached scsi generic sg1 type 0

