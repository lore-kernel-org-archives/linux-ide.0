From: Marco Schuster <marco@harddisk.is-a-geek.org>
Subject: WDC WD1600BEVS-2 on NCQ blacklist
Date: Sun, 09 Dec 2007 11:52:07 +0100
Message-ID: <475BC8D7.5070407@harddisk.is-a-geek.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEBAFA925115DB137F068ADB3"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from velirat.de ([85.25.68.44]:35044 "EHLO www.velirat.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141AbXLILfw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 9 Dec 2007 06:35:52 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEBAFA925115DB137F068ADB3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

I use a WDC WD1600BEVS-2 SATA drive (160GB).
The controller is a standard Intel ICH8 chipset.
During high disk load (fsck, large file copies) the system or the
process (mostly both) lock up and resume some secs later. In dmesg for
every of those breaks this appears:

ata3.00: exception Emask 0x2 SAct 0x8001 SErr 0x0 action 0x2 frozen
ata3.00: spurious completions during NCQ issue=3D0x0 SAct=3D0x8001
FIS=3D004040a1:00004000
ata3.00: cmd 60/08:00:77:00:00/00:00:00:00:00/40 tag 0 cdb 0x0 data 4096 =
in
         res 40/00:7c:af:5d:83/00:00:0a:00:00/40 Emask 0x2 (HSM violation=
)
ata3.00: cmd 61/00:78:af:5d:83/04:00:0a:00:00/40 tag 15 cdb 0x0 data
524288 out
         res 40/00:7c:af:5d:83/00:00:0a:00:00/40 Emask 0x2 (HSM violation=
)
ata3: soft resetting port
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: configured for UDMA/133
ata3: EH complete
sd 2:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA


Someone other than me also has this problem with this disk, see
http://marc.info/?l=3Dlinux-kernel&m=3D118789093418142&w=3D2 for details.=

xingu on freenode/#debian suggested me to do echo 1 >
/sys/block/sdX/device/queue_depth, which solved these problems for one
session and to email you to put this drive/controller combo on the NCQ
blacklist.

Regards,
Marco Schuster


--------------enigEBAFA925115DB137F068ADB3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHW8jbW6S2GapJUuQRAkR3AJsF8guE567E5QbUR1RFsw9wra25JgCcDtvR
bsponnseFxfcmN/6HCKnzuM=
=m7g6
-----END PGP SIGNATURE-----

--------------enigEBAFA925115DB137F068ADB3--
