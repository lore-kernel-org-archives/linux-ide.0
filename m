From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: 2.6.17 on VIA SP8000 sata: via_sata timeout (cmd 0xef) (retry)
Date: Thu, 29 Jun 2006 13:41:41 +0400
Message-ID: <20060629134141.221c59b3.vsu@altlinux.ru>
References: <44A2BF26.8090608@xs4all.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__29_Jun_2006_13_41_41_+0400_hl3aL9HdjKMkqPaT"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mivlgu.ru ([81.18.140.87]:60832 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S932865AbWF2Jlp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Jun 2006 05:41:45 -0400
In-Reply-To: <44A2BF26.8090608@xs4all.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Udo van den Heuvel <udovdh@xs4all.nl>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

--Signature=_Thu__29_Jun_2006_13_41_41_+0400_hl3aL9HdjKMkqPaT
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Jun 2006 19:40:54 +0200 Udo van den Heuvel wrote:

> While 2.6.16.2 runs quite OK on my VIA SP8000 Epia system, 2.6.17 gives
> (with the same config where possible) a sata problem on bootup, it gives
> a via_sata timeout(cmd 0xef). (the letters were small to make the stuff
> not scroll off the TV)
> Immediately rebooting into 2.6.16.2 gives a nice clean bootup.

For some reason I suspect that VIA IRQ quirk again...

Can you try to revert these patches from 2.6.17:

http://kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
itdiff_plain;h=3Da7b862f663d81858531dfccc0537bc9d8a2a4121

http://kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
itdiff_plain;h=3D75cf7456dd87335f574dcd53c4ae616a2ad71a11

Alternatively, you may try 2.6.16.17 - if it breaks in the same way, and
2.6.16.16 works, this is most likely that VIA IRQ problem (and reverting
the same patches from 2.6.16.17 should fix it).

--Signature=_Thu__29_Jun_2006_13_41_41_+0400_hl3aL9HdjKMkqPaT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFEo6BXW82GfkQfsqIRAuOGAJ9p5sIjEbGQb5o/BGveVdq+moi61wCdF4ij
K3mMlDdpVLyZjWW21VFYYnc=
=DwGv
-----END PGP SIGNATURE-----

--Signature=_Thu__29_Jun_2006_13_41_41_+0400_hl3aL9HdjKMkqPaT--
