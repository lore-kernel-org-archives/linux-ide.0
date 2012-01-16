From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: ASUS M2A-VM (SB600): AHCI setting in BIOS; AHCI and UDMA and
 `softreset failed (device not ready)`
Date: Mon, 16 Jan 2012 11:03:41 +0100
Message-ID: <1326708221.11113.29.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-J2GAefNbgzRCU82iRh2K"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gw90.de ([188.40.100.199]:44078 "EHLO mail.gw90.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751896Ab2APKlQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Jan 2012 05:41:16 -0500
Received: from f053034109.adsl.alicedsl.de ([78.53.34.109] helo=[192.168.178.43])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <paulepanter@users.sourceforge.net>)
	id 1RmjPt-0004Al-GX
	for linux-ide@vger.kernel.org; Mon, 16 Jan 2012 10:03:53 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--=-J2GAefNbgzRCU82iRh2K
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux folks,


please keep my address in CC list since I am not subscribed.

I am sorry for asking again for clarification for messages from Linux in
`/var/log/kern.log`.

        Jan 13 02:13:15 joe kernel: [    1.477687] ahci 0000:00:12.0: versi=
on 3.0

Whose version is this indication? Looking at the Wikipedia article [1]
and the AHCI link therein [2], specification numbers seem to 1.x.

Additionally having a sentence there, like `chipset support AHCI version
3.0` would be =E2=80=9Cbetter=E2=80=9D in my opinion. If you agree, I can s=
end a patch.

        Jan 13 02:13:15 joe kernel: [    1.477718] ahci 0000:00:12.0: PCI I=
NT A -> GSI 22 (level, low) -> IRQ 22
        Jan 13 02:13:15 joe kernel: [    1.477748] ahci 0000:00:12.0: ASUS =
M2A-VM: enabling 64bit DMA
        Jan 13 02:13:15 joe kernel: [    1.477981] ahci 0000:00:12.0: AHCI =
0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
        Jan 13 02:13:15 joe kernel: [    1.477986] ahci 0000:00:12.0: flags=
: 64bit ncq sntf ilck pm led clo pmp pio slum part ccc=20
        Jan 13 02:13:15 joe kernel: [    1.479052] scsi2 : ahci
        Jan 13 02:13:15 joe kernel: [    1.479142] scsi3 : ahci
        Jan 13 02:13:15 joe kernel: [    1.479220] scsi4 : ahci
        Jan 13 02:13:15 joe kernel: [    1.479296] scsi5 : ahci
        Jan 13 02:13:15 joe kernel: [    1.479434] ata3: SATA max UDMA/133 =
abar m1024@0xfe02f000 port 0xfe02f100 irq 22
        Jan 13 02:13:15 joe kernel: [    1.479438] ata4: SATA max UDMA/133 =
abar m1024@0xfe02f000 port 0xfe02f180 irq 22
        Jan 13 02:13:15 joe kernel: [    1.479442] ata5: SATA max UDMA/133 =
abar m1024@0xfe02f000 port 0xfe02f200 irq 22
        Jan 13 02:13:15 joe kernel: [    1.479447] ata6: SATA max UDMA/133 =
abar m1024@0xfe02f000 port 0xfe02f280 irq 22

So, AHCI and UDMA are unrelated? (Just to be sure once and for all. ;-))

        Jan 13 02:13:15 joe kernel: [    1.640626] ata1.00: ATAPI: TOSHIBA =
DVD-ROM SD-M1712, 1004, max UDMA/33
        Jan 13 02:13:15 joe kernel: [    1.656502] ata1.00: configured for =
UDMA/33
        Jan 13 02:13:15 joe kernel: [    1.796038] ata6: SATA link down (SS=
tatus 0 SControl 300)
        Jan 13 02:13:15 joe kernel: [    1.796076] ata5: SATA link down (SS=
tatus 0 SControl 300)
        Jan 13 02:13:15 joe kernel: [    1.796132] ata4: SATA link down (SS=
tatus 0 SControl 300)
        Jan 13 02:13:15 joe kernel: [    1.808018] usb 2-1: new low speed U=
SB device number 2 using ohci_hcd
        Jan 13 02:13:15 joe kernel: [    1.968017] ata3: softreset failed (=
device not ready)
        Jan 13 02:13:15 joe kernel: [    1.968063] ata3: applying PMP SRST =
workaround and retrying

This seems to be related to a hardware bug in the SB600 chipset [3]. The
discussion [4] indicates that setting `CONFIG_SATA_PMP=3Dn` fixes this
issue. Although reading the option description [5] I do not understand
what it does and if it is advisable to disable it.

        [=E2=80=A6]
       =20
        Jan 13 02:13:15 joe kernel: [    2.140032] ata3: SATA link up 3.0 G=
bps (SStatus 123 SControl 300)
        Jan 13 02:13:15 joe kernel: [    2.146085] ata3.00: ATA-8: WDC WD20=
EARS-60MVWB0, 51.0AB51, max UDMA/100
        Jan 13 02:13:15 joe kernel: [    2.146088] ata3.00: 3907029168 sect=
ors, multi 1: LBA48 NCQ (depth 31/32), AA
        Jan 13 02:13:15 joe kernel: [    2.146094] ata3.00: SB600 AHCI: lim=
iting to 255 sectors per cmd
        Jan 13 02:13:15 joe kernel: [    2.152134] ata3.00: SB600 AHCI: lim=
iting to 255 sectors per cmd
        Jan 13 02:13:15 joe kernel: [    2.152138] ata3.00: configured for =
UDMA/100

This seems to be related to [6], although the chipset SB600 seems to
support 3.0 Gbps instead of only 1.5 Gbps with the VIA K8T890. The drive
only seems to propagate UDMA/100 which is fine.

My main question is, that in the BIOS =C2=BBOnboard SATA Type=C2=AB is set =
to =C2=BBIDE
Controller=C2=AB by default. Is that true? But looking at the output AHCI
seems to be used nevertheless so the BIOS setting seems to be ignored or
does not make any difference to setting it to =C2=BBAHCI=C2=AB. So would ch=
anging
the option to =C2=BBAHCI=C2=AB give any benefit? Would it get rid of the
`softreset failed (device not ready)` too?


Thanks,

Paul


[1] https://en.wikipedia.org/wiki/Advanced_Host_Controller_Interface
[2] http://www.intel.com/technology/serialata/ahci.htm
[3] https://bugzilla.redhat.com/show_bug.cgi?id=3D468800
[4] http://www.linuxquestions.org/questions/linux-kernel-70/ata4-softreset-=
failed-device-not-ready-865155/
[5] http://cateee.net/lkddb/web-lkddb/SATA_PMP.html
[6] http://www.spinics.net/lists/linux-ide/msg41224.html

--=-J2GAefNbgzRCU82iRh2K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk8T9f4ACgkQPX1aK2wOHVgQUgCeOGBfyBgPI5+Pbk7j1Fq7xkqW
gBoAn0Wi58lFb4iJPBsJMmN6UGiLtmhp
=9bfP
-----END PGP SIGNATURE-----

--=-J2GAefNbgzRCU82iRh2K--

