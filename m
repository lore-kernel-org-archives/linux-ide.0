From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.24-rc3-mm1: I/O error, system hangs
Date: Wed, 21 Nov 2007 14:41:16 -0800
Message-ID: <20071121144116.c932727b.akpm@linux-foundation.org>
References: <20071120204525.ff27ac98.akpm@linux-foundation.org>
	<4744A6F2.4030302@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54670 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752685AbXKUWlu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Nov 2007 17:41:50 -0500
In-Reply-To: <4744A6F2.4030302@free.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed, 21 Nov 2007 22:45:22 +0100
Laurent Riffard <laurent.riffard@free.fr> wrote:

> Le 21.11.2007 05:45, Andrew Morton a =E9crit :
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2=
4-rc3/2.6.24-rc3-mm1/
>=20
> Hello,=20
>=20
> My system hangs shortly after I logged in Gnome desktop. SysRq-W show=
s
> that a bunch of task are blocked in "D" state, they seem to wait for
> some I/O completion. I can try to hand-copy some data if requested.
>=20
> I found these messages in dmesg:
>=20
> ~$ grep -C2 end_request dmesg-2.6.24-rc3-mm1=20
> EXT3-fs: mounted filesystem with ordered data mode.
> sd 0:0:0:0: [sda] Result: hostbyte=3DDID_NO_CONNECT driverbyte=3DDRIV=
ER_OK,SUGGEST_OK
> end_request: I/O error, dev sda, sector 16460
> ReiserFS: sda7: found reiserfs format "3.6" with standard journal
> ReiserFS: sda7: using ordered data mode
> --
> ReiserFS: sda7: Using r5 hash to sort names
> sd 0:0:1:0: [sdb] Result: hostbyte=3DDID_NO_CONNECT driverbyte=3DDRIV=
ER_OK,SUGGEST_OK
> end_request: I/O error, dev sdb, sector 19632
> sd 0:0:1:0: [sdb] Result: hostbyte=3DDID_NO_CONNECT driverbyte=3DDRIV=
ER_OK,SUGGEST_OK
> end_request: I/O error, dev sdb, sector 40037363
> Adding 1048568k swap on /dev/mapper/vglinux1-lvswap.  Priority:-1 ext=
ents:1 across:1048568k
> lp0: using parport0 (interrupt-driven).
>=20
> These errors occur *only* with 2.6.24-rc3-mm1, they are 100% reproduc=
ible.
> 2.6.24-rc3 and 2.6.24-rc2-mm1 are fine.
>=20
> Maybe something is broken in pata_via driver ?
>=20

Could be - libata-reimplement-ata_acpi_cbl_80wire-using-ata_acpi_gtm_xf=
ermask.patch
and pata_amd-pata_via-de-couple-programming-of-pio-mwdma-and-udma-timin=
gs.patch
touch pata_via.c.
