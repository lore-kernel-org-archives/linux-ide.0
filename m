From: Kevin Brubeck Unhammer <unhammer@fsfe.org>
Subject: Lenovo A740 gave up waiting for root device with kernels >= 4.3
Date: Mon, 06 Jun 2016 09:31:28 +0200
Message-ID: <87vb1mwz73.fsf@fsfe.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:48091 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751844AbcFFHbe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Jun 2016 03:31:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I have a Lenovo A740 (running Xubuntu 16.04) which, with kernel
versions=C2=A0>=3D 4.3.0, tested up until 4.7.0, gives this on trying to bo=
ot:

  Begin: Waiting for root file system ... Begin: Running
  /scripts/local-block ... done.
  Begin: Running /scripts/local-block ... done.
  Begin: Running /scripts/local-block ... done.
  [=E2=80=A6]
  done.
  Gave up waiting for root device.=20

and drops me into an (initramfs) shell, where my keyboard is
unresponsive. The last kernel I tried which booted fine was 4.2.8.

I reported this at https://bugzilla.kernel.org/show_bug.cgi?id=3D118401
and, after some investigation, was asked to contact ahci.c - AHCI SATA
support. The attachments in that report show some output from initramfs
(using a script in /etc/initramfs-tools/scripts/init-premount due to the
keyboard not working).

What should I do to keep debugging this issue?


best regards,
Kevin Brubeck Unhammer



--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXVSbQAAoJEPw8Hn0AkxZnHqcP/2KgSvNp5B6RxU789bmuWxvC
0O83W97qYsUwy3kCUSavOTrZODnXUDhs+WBT6IyKD03xc2LYeKRZC0SiJBAQjRAJ
0X/LlmNdZRPPHtA5dCDUHbMglLKnDmcjS6FyUlgST6n3ZXnk48nj1eTGhCveL+DS
RhzY+sfZ2BLjyVmy7QKDFjZezVpANStWlzzRxO7mqWLTUkBcOenJyBBFXIwFoZSB
z411dQR7lvCyQ56pwkT/6XuhIFcJjQKR/vuDrq9IBphWwTKwjbXrOc3ybJXdaPaW
RLU/hY4hQGI5cijnbjuiaw8mZgmb5Hhp1tCSJu8i6LxAx3FlnHwra9rolWnD2zUD
YH1r4odXBHqv39n5K7H9VZUogJQXFox4eVXzc5mBq8+P+7AhCRjBzru5bGirkYJ6
4TyxcjLp5gYCInpY13/3axqsaFkja9cnCqHdMNdQbNHYAvvmb5g69StZ0bF9Ml7s
akhjVo98ZCwHCtHW0VFU5c4wYTVmwhhEuKcmsl65QI796HlTvpsiGym1DLbB9CCR
ta9c1Tw8OBg8k9LIdzFEGLk+ovS3vvL4AqnRm/ZZ/JT2xxhX9/IJPQssMuwFUrCn
ym6/KxuLX3VD0azDdUzAO7MK3UkedTmit199sHdAIPt9ZbMN9REu19N3LII+Xu+r
at+RNNPw2CiFTZSMmVaI
=WO3X
-----END PGP SIGNATURE-----
--=-=-=--
