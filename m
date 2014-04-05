From: Chris Samuel <chris@csamuel.org>
Subject: Re: [PATCH 1/2] libata: Expose trim capability in sysfs
Date: Sat, 05 Apr 2014 19:12:05 +1100
Message-ID: <1452108.oyGVeRVWlF@quad>
References: <1396399357-28388-1-git-send-email-martin.petersen@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1774220.pSiIysxDFc"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from csamuel.org ([74.50.50.137]:45268 "EHLO csamuel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754001AbaDEIMh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 5 Apr 2014 04:12:37 -0400
In-Reply-To: <1396399357-28388-1-git-send-email-martin.petersen@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, Marc MERLIN <marc@merlins.org>


--nextPart1774220.pSiIysxDFc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Tue, 1 Apr 2014 08:42:36 PM Martin K. Petersen wrote:

> Now that drives with support for queued trim are starting to appear, =
it
> would be helpful to expose the chosen trim mode to userland. Create a=

> sysfs "trim" attribute for each ata_device that displays whether trim=
 is
> "unsupported", "unqueued" or "queued".

Both patches applied cleanly to 3.14, kernel now reports "unsupported" =
for=20
everything other than the SSD in my ZaReason laptop (Crucial M4 mSATA S=
SD)=20
which reports "unqueued" (which is expected).

Tested-By: Chris Samuel <chris@csamuel.org>

Thanks!
Chris
=2D-=20
 Chris Samuel  :  http://www.csamuel.org/  :  Melbourne, VIC


--nextPart1774220.pSiIysxDFc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQEVAwUAUz+61Y1yjaOTJg85AQIONAf+N/dARUxV3tcXgK5KccfTxcCFvwTs8R0Z
b3rNw5yhojP8vS1UX9HDXWnqK21TVX1k2pTS0ViDcWxIkhaNxX/rH/He40ce0Yy6
1qa/3I1P/ChNf3K2oUqwRmsyiUHn1YVBQJ3fe8dIaS+TlORKjyxmqFpo5kyND7af
d6RAPhegfu00RkJ0t9PzBgkBtCgMfUfylWP5ggY4LJ9VbJfx109wwAMKZ70MGIvg
2vTPAR5yF1xUB/Kt88coYqZmtX7r3mlCurzK8CcW3Gk1il1sKJLWVdIkePt6Z+55
WXn1kW3Taq8vyT3qJ3bfwdoxgNplT5lC5BvmZSDDGucu5RWX5FA8cw==
=W2pJ
-----END PGP SIGNATURE-----

--nextPart1774220.pSiIysxDFc--

