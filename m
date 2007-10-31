From: Vlad Codrea <vladc6@yahoo.com>
Subject: Re: IDE Problem with old Gateway laptop (1998 solo 2300)
Date: Wed, 31 Oct 2007 11:21:08 -0700 (PDT)
Message-ID: <415840.96752.qm@web54405.mail.yahoo.com>
References: <1193830965.2347.66.camel@turtle-25895.iol.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web54405.mail.yahoo.com ([206.190.49.135]:21124 "HELO
	web54405.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751852AbXJaSVJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Oct 2007 14:21:09 -0400
In-Reply-To: <1193830965.2347.66.camel@turtle-25895.iol.ie>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Declan Moriarty <declan.moriarty@iol.ie>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide <linux-ide@vger.kernel.org>

--- Declan Moriarty <declan.moriarty@iol.ie> wrote:
> piix_init
> 	scsi0: ata_piix
> 	scsi1: ata_piix
> 	ata1: PATA max udma/33 cmd 0x000101f0 ctl 0x000103f6 bmdma
> 0x0001fcd0
> irq 14
> 	ata2: PATA max udma/33 cmd 0x00010170 ctl 0x00010376 bmdma
> 0x0001fcd8
> irq 15
> 	ATA1.00: ATA-3 HITATCHI_DK226A-32 00T0A0A0 max MWDMA2
> 	ATA1.00: 6332256 sectors multi 16: LBA
> 	ATA1.00: configured for MWDMA2
> 	scsi 0:0:0:0 Direct Access ATA Hitatchi_DK226A-3 00T0 PQ: 0 ANSI 5
> 	sd 0:0:0:0 [sda] 6332256 512-byte hardware sectors (3242MB)
> 	sd 0:0:0:0 [sda] Write Protect is off
> 	sd 0:0:0:0 [sda] Write cache: disabled, read cache: enabled doesn't
> support DPO or FUA
> 	sda: sda1 sda2 sda3 ssda4
> 	sd 0:0:0:0 [sda] Attached scsi disk
> 	sd 0:0:0:0 [sda] Attached scsi generic sg0 type 0
> (piix_init returned 0 ran for 383 msec. The following ones ran for 0
> msec)
>=20
> I'm hoping just for a diagnosis - "X is wrong"

I agree that the problem is in userspace. I can think of two
diagnoses:

1) The userspace components of the distro you=92re using are
mis-configured. To eliminate this possibility, boot the computer from
Debian installation floppies:
=20
http://http.us.debian.org/debian/dists/unstable/main/installer-i386/cur=
rent/images/floppy/

See installation instructions below:
http://www.debian.org/releases/stable/i386/apas02.html.en#howto-getting=
-images-floppy

At one point during the Debian installation, you=92ll be able to press
=93Alt-Ctrl-F2=94 and get a console. From here you can manually mount t=
he
various partitions. If you can mount and read the partitions, then
everything is fine and you can go ahead and install Debian or another
distro. If any step fails, try to capture the output of the =91dmesg=92
command from the console and email it to the list.

2) If mounting fails, your drives might be formatted with a
proprietary Disk Drive Overlay (DDO). You would have to either a)
remove the DDO using the same proprietary software that installed it;
or b) reformat the disk.

Vlad

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20
