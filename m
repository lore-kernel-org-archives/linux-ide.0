From: Bob Ham <rah@bash.sh>
Subject: Re: hpt374 sata (Highpoint Rocket 1540)
Date: Tue, 31 Jul 2007 21:12:50 +0100
Message-ID: <1185912770.8484.6.camel@orchid.arb.net>
References: <1185880124.3483.25.camel@localhost>
	 <20070731132347.04da4600@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YF1fmmSGYqe6c/+bceTQ"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from waffl.ing.me.uk ([217.147.94.6]:53703 "EHLO waffl.ing.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756286AbXGaVWv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Jul 2007 17:22:51 -0400
In-Reply-To: <20070731132347.04da4600@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org


--=-YF1fmmSGYqe6c/+bceTQ
Content-Type: multipart/mixed; boundary="=-J3jxdVepXzheYTcWONQ/"


--=-J3jxdVepXzheYTcWONQ/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-07-31 at 13:23 +0100, Alan Cox wrote:
> > I'm wondering if there are or will be libata drivers, or any drivers fo=
r
> > that matter, for hpt374-based SATA cards?
>=20
> The HPT374 is a PATA controller. Some people ship products with the
> HPT37x controllers and PATA/SATA bridges and those should work with the
> libata drivers.

Might I suggest something along the lines of the attached patch in order
to avoid future confusion?  The information on which cards have which
chips comes from the linuxmafia web page.

Bob

--=20
Bob Ham <rah@bash.sh>

--=-J3jxdVepXzheYTcWONQ/
Content-Disposition: attachment; filename=hpt-libata-sata-help.diff
Content-Type: text/x-patch; name=hpt-libata-sata-help.diff; charset=utf-8
Content-Transfer-Encoding: base64

LS0tIEtjb25maWcub2xkCTIwMDctMDctMzEgMTQ6Mjk6MjIuMDAwMDAwMDAwICswMTAwDQorKysg
S2NvbmZpZwkyMDA3LTA3LTMxIDIxOjA1OjAwLjAwMDAwMDAwMCArMDEwMA0KQEAgLTI5Nyw2ICsy
OTcsMTEgQEANCiAJICBUaGlzIG9wdGlvbiBlbmFibGVzIHN1cHBvcnQgZm9yIHRoZSBtYWpvcml0
eSBvZiB0aGUgbGF0ZXIgSFBUDQogCSAgUEFUQSBjb250cm9sbGVycyB2aWEgdGhlIG5ldyBBVEEg
bGF5ZXIuDQogDQorCSAgU29tZSBTQVRBIGNhcmRzLCBsaWtlIHRoZSBIaWdocG9pbnQgUm9ja2V0
L1JvY2tldFJBSUQNCisJICAxNTQwLzE1NDIvMTU0NC8xNjQwIGFuZCBzb21lIHZlcnNpb25zIG9m
IHRoZSBSb2NrZXRSQUlEIDE1MjAsDQorCSAgdXNlIHRoZXNlIFBBVEEgY29udHJvbGxlcnMgaW4g
Y29uanVuY3Rpb24gd2l0aCBhIFNBVEEvUEFUQQ0KKwkgIGJyaWRnZS4gVGhpcyBkcml2ZXIgc2hv
dWxkIHN1cHBvcnQgdGhvc2UgY2FyZHMsIHRvby4NCisNCiAJICBJZiB1bnN1cmUsIHNheSBOLg0K
IA0KIGNvbmZpZyBQQVRBX0hQVDNYMk4NCkBAIC0zMDQsNyArMzA5LDEyIEBADQogCWRlcGVuZHMg
b24gUENJICYmIEVYUEVSSU1FTlRBTA0KIAloZWxwDQogCSAgVGhpcyBvcHRpb24gZW5hYmxlcyBz
dXBwb3J0IGZvciB0aGUgTiB2YXJpYW50IEhQVCBQQVRBDQotCSAgY29udHJvbGxlcnMgdmlhIHRo
ZSBuZXcgQVRBIGxheWVyDQorCSAgY29udHJvbGxlcnMgdmlhIHRoZSBuZXcgQVRBIGxheWVyLg0K
Kw0KKwkgIFNvbWUgU0FUQSBjYXJkcywgbGlrZSB0aGUgSGlnaHBvaW50IFJvY2tldCAxNTIwIGFu
ZCBzb21lDQorCSAgdmVyc2lvbnMgb2YgdGhlIFJvY2tldFJBSUQgMTUyMCwgdXNlIHRoZXNlIFBB
VEEgY29udHJvbGxlcnMNCisJICBpbiBjb25qdW5jdGlvbiB3aXRoIGEgU0FUQS9QQVRBIGJyaWRn
ZS4gVGhpcyBkcml2ZXIgc2hvdWxkDQorCSAgc3VwcG9ydCB0aG9zZSBjYXJkcywgdG9vLg0KIA0K
IAkgIElmIHVuc3VyZSwgc2F5IE4uDQogDQo=


--=-J3jxdVepXzheYTcWONQ/--

--=-YF1fmmSGYqe6c/+bceTQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGr5e87whsMRnFexQRAsRNAKDaMfkspSuv8mnXBbrQ+76EYkFYpwCgoYWP
sdkSZsqM2NFSdXc0aLQVe9c=
=d0GM
-----END PGP SIGNATURE-----

--=-YF1fmmSGYqe6c/+bceTQ--

