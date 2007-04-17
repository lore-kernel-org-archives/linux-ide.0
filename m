From: Jesse Keating <jkeating@redhat.com>
Subject: Re: [PATCH] libata: HPA support
Date: Tue, 17 Apr 2007 15:34:56 -0400
Message-ID: <200704171534.56685.jkeating@redhat.com>
References: <20070411002313.29069ca5@the-village.bc.nu> <46251CCB.9040906@pobox.com> <20070417193057.GB22688@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3343661.eyWgWbfuRp";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:44485 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031156AbXDQTf2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Apr 2007 15:35:28 -0400
In-Reply-To: <20070417193057.GB22688@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

--nextPart3343661.eyWgWbfuRp
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 17 April 2007 15:30:57 Dave Jones wrote:
> jesse, wanna give that a shot? booting with the installer with
> sata_nv.adma=3D0 should do the trick.

That didn't effect anything.  I still saw a message about "using ADMA mode"=
=20
right before the panic(s).

I added "sata_nv.adma=3D0" to the kernel arguments.

=2D-=20
Jesse Keating
Release Engineer: Fedora

--nextPart3343661.eyWgWbfuRp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGJSFg4v2HLvE71NURAghxAJ97ylMAlZ+TbArTN4z7qCjWZ3vFsACgruA8
tvEQUH9nWtXQsPAcIlTvsTE=
=gTMM
-----END PGP SIGNATURE-----

--nextPart3343661.eyWgWbfuRp--
