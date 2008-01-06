From: Volker Sauer <vsauer@dvs.tu-darmstadt.de>
Subject: Re: Still having problems after sata_promise: ASIC PRD table bug
	workaround
Date: Sun, 6 Jan 2008 19:22:38 +0100
Message-ID: <20080106182238.GA6037@volker-sauer.de>
References: <20080105202346.GA23026@dvs.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lnx130.hrz.tu-darmstadt.de ([130.83.174.24]:55079 "EHLO
	lnx130.hrz.tu-darmstadt.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755376AbYAFSWz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jan 2008 13:22:55 -0500
Received: from a603.volker-sauer.de (A603.ps.wh.tu-darmstadt.de [130.83.208.238])
	by lnx130.hrz.tu-darmstadt.de (8.13.4/8.12.10) with ESMTP id m06IMci4013846
	for <linux-ide@vger.kernel.org>; Sun, 6 Jan 2008 19:22:38 +0100
Received: from zaphod.volker-sauer.de (zaphod.volker-sauer.de [192.168.0.3])
	by a603.volker-sauer.de (Postfix) with ESMTP id A228A3831F03
	for <linux-ide@vger.kernel.org>; Sun,  6 Jan 2008 19:22:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080105202346.GA23026@dvs.tu-darmstadt.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sa, 05 Jan 2008, Volker Sauer <vsauer@dvs.tu-darmstadt.de> wrote:
> I'm running a Promise Technology PDC20318 (SATA150 TX4) (rev 02)=20
> controller in on of my servers and I gettig the following error from time
> to time - espacially when there's high load on the disks:

[...]

> /dev/sda: Seagate ST3250620AS
> /dev/sdb: Hitachi HDS722525VLSA80
> /dev/sdc: Seagate ST3250620AS
> /dev/sdd: Hitachi HDS722525VLSA80

Hi,

now I got an error from sdb, too:

ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata4.00: port_status 0x20200000
ata4.00: cmd 35/00:f8:b5:35:95/00:03:02:00:00/e0 tag 0 dma 520192 out
         res 51/84:00:ac:39:95/84:00:02:00:00/e2 Emask 0x10 (ATA bus error)
ata4.00: status: { DRDY ERR }
ata4.00: error: { ICRC ABRT }
ata4: soft resetting link
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: configured for UDMA/100
ata4: EH complete
sd 3:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA

I built the latest smartmontools which can query SATA disks and get:

/dev/sda: ATA Error Count: 0
/dev/sdb: ATA Error Count: 16
/dev/sdc: ATA Error Count: 0
/dev/sdd: ATA Error Count: 33

I'm thinking about replacing the Hitachi disks by 2 Seagate
ST3250620AS.....

Any comments on this?

Regards
Volker

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHgRxufjVOTV3V0OARAjYcAKCi+P+FyQSN4VmIch1wpwzcfcj9hQCeOV+/
/wZcGQW3sUTcbuRzlg8KUOU=
=TFGZ
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
