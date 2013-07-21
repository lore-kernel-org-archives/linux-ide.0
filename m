From: Fontana Cristian <fontana_cristian@yahoo.com>
Subject: Re: DMA timeouts with JM20330 based SATA<->IDE bridge
Date: Sun, 21 Jul 2013 14:53:56 +0000 (UTC)
Message-ID: <loom.20130721T164755-509@post.gmane.org>
References: <20100304014558.GA8837@florz.florz.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38087 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755542Ab3GUOyQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 21 Jul 2013 10:54:16 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1V0v1Z-00025q-Iq
	for linux-ide@vger.kernel.org; Sun, 21 Jul 2013 16:54:14 +0200
Received: from 190.183.21.218 ([190.183.21.218])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 21 Jul 2013 16:54:13 +0200
Received: from fontana_cristian by 190.183.21.218 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 21 Jul 2013 16:54:13 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

=46lorian Zumbiehl <florz <at> florz.de> writes:

>=20
> Hi,
>=20
> I have here a SATA<->IDE bridge based on a JM20330 connected to
> what the old IDE driver reported like this:
>=20
> | via82cxxx 0000:00:07.1: VIA vt82c686a (rev 22) IDE UDMA66
> | via82cxxx 0000:00:07.1: IDE controller (0x1106:0x0571 rev 0x10)
>=20
> At the other end, it's connected to a Seagate ST31500341AS
> SATA harddisk (well, that's kinda redundant ... .
>=20
> Now, reading from the disk seems to work perfectly, but writing
> (dding /dev/zero to the block device) causes DMA timeouts every
> few hundred megabytes - in between the timeouts, though,
> throughput seems to be ok (~ 20 MB/s).
>=20
> Once the fallback mechanism has switched back to PIO4, things seem
> to work perfectly, albeit slowly=20
>=20
> In the kernel log, the errors look something like this, with
> small variations (at least to my eyes :
>=20
> | ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
> | ata2.00: failed command: WRITE DMA EXT
> | ata2.00: cmd 35/00:00:67:19:4f/00:04:00:00:00/e0 tag 0 dma 524288 o=
ut
> |          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout=
)
> | ata2.00: status: { DRDY }
> | ata2: link is slow to respond, please be patient (ready=3D0)
> | ata2: device not ready (errno=3D-16), forcing hardreset
> | ata2: soft resetting link
> | ata2.00: configured for UDMA/66
> | ata2.00: device reported invalid CHS sector 0
> | ata2: EH complete
>=20
> That's all happening with a vanilla 2.6.33 (plus tuxonice, in case th=
at
> could have any effect on this). The legacy IDE drivers behave similar=
ly.
>=20
> So: Is there anything one could do about that, other than forcing
> PIO-only operation? If you need any further information, please let
> me know.
>=20
> BTW, the datasheet of the JM20330 can be found at
> http://www.mcuol.com/aspx/down.aspx?id=3D1266, just in case you didn'=
t
> know that yet ...
>=20
> Florian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20

I have a motherboard brand CV860c LEX (1r53) (Light embedded PC) (12vdc=
)
with an ide-sata adapter JM20330 (as331 v1.3) and a hard disk 2.5 "ide =
500gb
in secondary.

Illustrative picture of motherboard
http://i.imgur.com/pLAs7.jpg

The same had a fault identical to the above you mentioned.

ata2.00: exception Emask 0x0 0x0 SACT Serr 0x0 action 0x6 frozen
ata2.00: failed command: WRITE DMA EXT
ata2.00: cmd 35/00: 00:30:07:8 a/00: 04:57:00:00 / e0 tag 0 dma 524288 =
out
         res 40/00: ff: 00:00:00 / 00:00:00:00:00 / 40 Emask 0x4 (timeo=
ut)
ata2.00: status: {DRDY}
ata2: link is slow to respond, please be patient (ready =3D 0)
ata2: device not ready (errno =3D -16), forcing hardreset
ata2: soft resetting link
ata2.00: configured for UDMA/25
ata2.00: device Reported invalid CHS sector 0 of
ata2: EH complete

The problem occurred when copying a few megabytes to affected pc (via s=
amba
or ssh).

Writing data blocks with dd no problems. Even with different block size=
s.

Several theories were presented to me in my mind and I discarded one by=
 one
the possibilities.

n =C2=B0 1. Cable Fault: Replace the cable for another 2 without achiev=
ing
positive results.
No. 2. HDD bad: The disc was new, 3 months, so check anyway smart and g=
ave
the ok
No. 3. JM20330 bad adapter: I could verify the operation connecting the
adapter to a desktop pc and getting good transfer rates
No. 4. EXT4. had the same fault with ext3 so I've ruled out any possibl=
e
problem with the file system.
No. 5. Bios. The bios upgrade notes ensured that could read discs up to
200GB, this gave me to understand that supported 48bit. overcoming the
barrier of 137GB.
No. 6. Kernel. I updated the kernel to different versions, without posi=
tive
results.
No. 7. Libata. Try with many commands without achieving positive result=
s.
7 .. 8 .. 9 .. 10 .. 15 ..

After a while, I realized that there was something he had not done. USE=
 THE
PRIMARY IDE PORT (ide 40) and not the secondary ide (ide 44).

And Surprise!. transfers changed and to this day I HAVE NOT SEEN MORE F=
AILURES.

(The how to use the primary port on this motherboard needs a special se=
ction
because to use it you must take 5VDC to power the hard disk from the CO=
M1
for example.)

The problem may be located on a hardware incompatibility problem betwee=
n
VT82C686B + JM20330 using them in the SECONDARY IDE channel.

Hopefully will be useful to someone!

Sorry for my bad English

Greetings from Argentina, Entre Rios, Paran=C3=A1
=46ontana Cristian


