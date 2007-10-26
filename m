From: Marcin Juszkiewicz <openembedded@haerwu.biz>
Subject: Re: Re-enabling Serial ATA ports possible?
Date: Fri, 26 Oct 2007 14:51:15 +0200
Message-ID: <200710261451.17154.openembedded@haerwu.biz>
References: <200710171251.l9HCpCv7021811@harpo.it.uu.se> <200710261118.47736.openembedded@haerwu.biz> <4721B7EB.7010209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from v813.rev.tld.pl ([195.149.226.213]:44492 "EHLO
	smtp.host4.kei.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbXJZMvf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Oct 2007 08:51:35 -0400
In-Reply-To: <4721B7EB.7010209@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Dnia pi=B1tek, 26 pa=BCdziernika 2007, Tejun Heo napisa=B3:
> Marcin Juszkiewicz wrote:
> > /dev/sr0:
> >
> > ATAPI CD-ROM, with removable media
> >         Model Number:       TSSTcorpCD/DVDW SH-S183A

> I have the same one.  Do you have a reliable scenario to trigger the
> problem so that I can try to reproduce it here?

Sometimes it is just boot and wait (there was no usage of drive at all)=
:

[  104.015912] usb0: no IPv6 routers present
[ 1916.018636] ata6.00: exception Emask 0x10 SAct 0x0 SErr 0x90000 acti=
on 0xa frozen
[ 1916.018642] ata6: SError: { PHYRdyChg 10B8B }
[ 1916.018648] ata6.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0 c=
db 0x0 data 0
[ 1916.018649]          res 40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0=
x14 (ATA bus error)
[ 1916.018652] ata6.00: status: { DRDY }
[ 1916.018659] ata6: hard resetting link
[ 1917.122120] ata6: SATA link down (SStatus 1 SControl 310)
[ 1917.122131] ata6: failed to recover some devices, retrying in 5 secs
[ 1919.619573] ata6: hard resetting link
[ 1920.721232] ata6: SATA link down (SStatus 1 SControl 310)
[ 1920.721245] ata6.00: limiting speed to UDMA/33:PIO3
[ 1920.721248] ata6: failed to recover some devices, retrying in 5 secs
[ 1923.218697] ata6: hard resetting link
[ 1924.319358] ata6: SATA link down (SStatus 1 SControl 310)
[ 1924.319369] ata6.00: disabled
[ 1924.569558] ata6: EH complete
[ 1924.569602] sr 5:0:0:0: rejecting I/O to offline device
[ 1924.569658] ata6.00: detaching (SCSI 5:0:0:0)

> >> Also, you can trigger rescan by "echo - - -
> >> /sys/class/scsi_host/hostX/scan".
> >
> > This does not worked here - I mean it found only online drives not
> > offline dvd/rw drive.
>
> From the log, it seems PHY went down completely.  The device probably
> needs power removed and reapplied to get out of the lock up.  Nothing
> much software can do.

This time it worked (log below). Should I check power supply and replac=
e
it if needed?

[ 6760.345046] ata6: exception Emask 0x10 SAct 0x0 SErr 0x90000 action =
0xb
[ 6760.345053] ata6: SError: { PHYRdyChg 10B8B }
[ 6760.345064] ata6: hard resetting link
[ 6760.380877] sd 4:0:0:0: [sdb] 625142448 512-byte hardware sectors (3=
20073 MB)
[ 6760.394034] sd 4:0:0:0: [sdb] Write Protect is off
[ 6760.394039] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 6760.394073] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enab=
led, doesn't support DPO or FUA
[ 6761.189114] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 6761.330641] ata6.00: ATAPI: TSSTcorpCD/DVDW SH-S183A, SB02, max UDMA=
/33
[ 6761.330646] ata6.00: applying bridge limits
[ 6761.473567] ata6.00: configured for UDMA/33
[ 6761.473579] ata6: EH complete
[ 6761.476735] scsi 5:0:0:0: CD-ROM            TSSTcorp CD/DVDW SH-S183=
A SB02 PQ: 0 ANSI: 5
[ 6761.494702] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/fo=
rm2 cdda tray
[ 6761.494763] sr 5:0:0:0: Attached scsi CD-ROM sr0
[ 6761.494801] sr 5:0:0:0: Attached scsi generic sg6 type 5

--=20
JID: hrw-jabber.org
OpenEmbedded developer/consultant

      Reincarnation: Life sucks, then you die. Then life sucks again.


