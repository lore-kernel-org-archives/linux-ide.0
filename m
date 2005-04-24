From: Daniel Egger <de@axiros.com>
Subject: Re: Primary ide disk inaccessible. 2.6.11.7, x86_64
Date: Sun, 24 Apr 2005 17:06:13 +0200
Message-ID: <064085cb719a246d17e19bde8dfcaee2@axiros.com>
References: <426B8D14.9050408@lboro.ac.uk>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-11-756503809"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 213-239-212-8.clients.your-server.de ([213.239.212.8]:18899
	"EHLO live1.axiros.com") by vger.kernel.org with ESMTP
	id S262334AbVDXPGk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 24 Apr 2005 11:06:40 -0400
In-Reply-To: <426B8D14.9050408@lboro.ac.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "A.E.Lawrence" <A.E.Lawrence@lboro.ac.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


--Apple-Mail-11-756503809
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 24.04.2005, at 14:12, A.E.Lawrence wrote:

> I have 4 sata, 1 scsi and 1 ata hard disks attached to an Asus A8N-SLI.
> The primary ata disc (connected to ide0) is inaccessible:

Are you booting from PATA or SATA? I had a similar problem
where the PATA drives wouldn't be probed if I booted from
a SATA drive. Vice versa it worked/works, though my chipset
is VIA but the boards where this problem occured are also
from Asus and daughter company.

Servus,
       Daniel

--Apple-Mail-11-756503809
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (Darwin)

iD8DBQFCa7Xmchlzsq9KoIYRAhUaAKDhmc3QqTAsBDR9OJVdBO86+bAHrwCcCUqv
7eb4cRWfL+Gx7COq5euV+i4=
=k3OM
-----END PGP SIGNATURE-----

--Apple-Mail-11-756503809--

