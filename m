From: Chris Samuel <chris@csamuel.org>
Subject: Re: [PATCH 1/2] libata: Expose trim capability in sysfs
Date: Sat, 05 Apr 2014 08:49:45 +1100
Message-ID: <7474970.Ep9zfmpRio@quad>
References: <1396399357-28388-1-git-send-email-martin.petersen@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3801503.FnjoaRK0fG"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from csamuel.org ([74.50.50.137]:53971 "EHLO csamuel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752356AbaDDV4a (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Apr 2014 17:56:30 -0400
In-Reply-To: <1396399357-28388-1-git-send-email-martin.petersen@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, Marc MERLIN <marc@merlins.org>


--nextPart3801503.FnjoaRK0fG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Tue, 1 Apr 2014 08:42:36 PM Martin K. Petersen wrote:

> Now that drives with support for queued trim are starting to appear, =
it
> would be helpful to expose the chosen trim mode to userland. Create a=

> sysfs "trim" attribute for each ata_device that displays whether trim=
 is
> "unsupported", "unqueued" or "queued".

Thank you Martin, this is a really great idea following on from those=20=

discussions on the btrfs list on how to work out whether a drive suppor=
ts trim=20
and, if so, whether it's the original or new variant.

I'm hoping to have some time this weekend to test these patches out; sh=
ould I=20
test them on 3.14 or the current master for 3.15, or both?=20

Much obliged!
Chris
=2D-=20
 Chris Samuel  :  http://www.csamuel.org/  :  Melbourne, VIC


--nextPart3801503.FnjoaRK0fG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQEVAwUAUz8o+Y1yjaOTJg85AQKl+Af/cu5FGsZYXzVWv9qnX719KRbd7nLAf7eB
b3c6OfhjwwD/6ci42GhOORNwPNTDhZq3IaCAiM2Os3sCkWVyT7zVdC/xm4mlBkma
HjMqrfb06vmHKVhY/ObkFBS43N58/wyuAGYN1Fx88qd24UCueL2NDgqH0VOgxLot
CGbnJ437eVZWE49Lga70S7oFnPbhOAth+/G5wmiAkJvvLegX31jQoc3bxQ9lTk6U
2jdNKWShKmxEb5UwZZgeC/FapgPpMK62307ymHswKCvlfUtSxvZ4NJ+lLAlsL5XD
548t6pCkEmcfrDCJxT0jp5W5h11vgdE+0+1zLbZgxzxXuGlh6QllXA==
=GH0z
-----END PGP SIGNATURE-----

--nextPart3801503.FnjoaRK0fG--

