From: Richard Mawson <richard@crow.mawsonit.co.uk>
Subject: Re: SATA driver sata_sil24
Date: Thu, 22 Apr 2010 23:33:10 +0100
Message-ID: <20100422223309.GA1883@crow.mawsonit.co.uk>
References: <20100422083226.GA6018@crow.mawsonit.co.uk> <4BD0203C.7010903@gmail.com> <20100422121747.GC6018@crow.mawsonit.co.uk> <4BD05043.10709@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smarthost01.mail.zen.net.uk ([212.23.3.140]:53277 "EHLO
	smarthost01.mail.zen.net.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752831Ab0DVWdO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Apr 2010 18:33:14 -0400
Content-Disposition: inline
In-Reply-To: <4BD05043.10709@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Tejun,

On Thu, Apr 22, 2010 at 03:33:55PM +0200, Tejun Heo wrote:
> > If you have any suggestions as to what the likely problem is, or
> > things to look for I am all ears.
>=20
> Please try non-xen vanialla kernel and report the failing kernel log.

I have compiled 2.6.33-2, and the same thing happens.
That is, modprobe sata_sil24 prints one message to the console suggesting t=
he PCI slot,
then freezes the system.

Unfortunately it doesn't seem to have managed to write anything to messages=
/kernel.log,
which is on a p-ata disk.

I managed to hand copy some of the output from alt-sysrq-t which looks like=
 it includes the
stack running as a result of the modprobe -- does this help to explain wher=
e the problem is?
This was manually copied, so there might be a typo or two:

c03118f8 ? schedule+0x897/0x94e
c014406a ? ktime_get_ts+0xd7/0xdf
c0217b42 ? cfq_rb_erase+0x1b/0x2a
c021f449 ? number+0x149/0x20e
c023a9cb ? vgacon_scroll+0x180/0x19a
c0194e0c ? __insert_vmap_area+0x5e/0x96
c017fac3 ? __alloc_pages_nodemask+0xe2/0x4ec
c019b409 ? cache_alloc_refill+0x63/0x417
c02995c9 ? pci_conf1_write+0xb2/0xc0
c029a9fb ? raw_pci_write+0x4e/0x56
c029aa40 ? pci_write+0x1c/0x21
c0228a3e ? pci_bus_write_config_dword+0x46/0x50
c022ae0c ? pcie_set_readrq+0x8c/0x9e
f9f185bc ? sil24_init_one+0x1ax/0x21a [sata_sil24]
c022d899 ? local_pci_probe+0xb/0xc
c022de7d ? pci_device_probe+0x41/0x63
c0287489 ? driver_probe_device+0x76/0xfe
c0287451 ? __driver_attach+0x40/0x5b
c0286dcd ? bus_for_each_dev0x37/0x5f
c0287270 ? driver_attach+0x11/0x13
c0287411 ? __driver_attach+0x0/0x5b
c0286852 ? bus_add_driver+0xd6/0x201
c028766b ? driver_register+0x87/0xe0
c022e050 ? __pci_register_driver+0x33/0x89
f9f1d000 ? sil24_init+0x0/0x14 [sata_sil24]
c010112d ? do_one_initcall+0x44/0x120
c014f1c2 ? sys_init_module+0xa7/0x1d7
c03130f5 ? syscall_call+0x7/0xb

I don't know that it is relevant, but the pcie card is plugged into a pci-p=
cie
converter card.


Let me know if there is anything else I can supply to help analyse this (an=
ything
I do will have to be in the next couple of days as thats all the time I hav=
e to
return the goods for a refund!!).

--=20
Richard Mawson
Mawson IT Services

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkvQzqUACgkQEqu+mbnN8VIqLQCgtbVs1LnoW/iEROYRjYJ3BEs/
pRkAn11Ik/hWLUl6YfCCev78cu6gEsM+
=iQeq
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
