From: Erik Slagter <erik@slagter.name>
Subject: Re: [linux-usb-devel] PCI quirks not handled and config space
	differences on resume from S3
Date: Tue, 16 Aug 2005 17:42:37 +0200
Message-ID: <1124206957.19419.12.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0508161131240.18233-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jro+3TF4/ZrHnav1OL7T"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:65417 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S1030186AbVHPPnE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Aug 2005 11:43:04 -0400
In-Reply-To: <Pine.LNX.4.44L0.0508161131240.18233-100000@iolanthe.rowland.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>, acpi-devel <acpi-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, linux-usb-devel@lists.sourceforge.net


--=-jro+3TF4/ZrHnav1OL7T
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-08-16 at 11:37 -0400, Alan Stern wrote:
> > Diff between "lspci -vvvxxx" before and after resume for all
> > problematic devices on my machine is attached.
> >=20
> > Are there any patches I can try?
>=20
> The uhci-hcd driver _does_ restore the config space for its devices=20
> properly.

Apparently something is sort of wrong though, because I need to rmmod
uhci_hcd and hci_usb before suspending, otherwise nasty things happen.

--=-jro+3TF4/ZrHnav1OL7T
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDAgltJgD/6j32wUYRAj6yAKCBe9wp/GTLkPJFhh2vvAD9VOe0WQCeMz3a
4LZvEXud+p1awbBKInhi1d4=
=1+po
-----END PGP SIGNATURE-----

--=-jro+3TF4/ZrHnav1OL7T--
