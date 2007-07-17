From: Florian Echtler <echtler@in.tum.de>
Subject: Switching controller mode in software?
Date: Tue, 17 Jul 2007 10:10:06 +0200
Message-ID: <1184659806.15435.4.camel@pancake>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ir6mrKofmcAvcqqczHCm"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:43262 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751707AbXGQIhx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jul 2007 04:37:53 -0400
Received: from [131.159.10.70] (lapnavab35.informatik.tu-muenchen.de [131.159.10.70])
	by mail.in.tum.de (Postfix) with ESMTP id 5283E27D9
	for <linux-ide@vger.kernel.org>; Tue, 17 Jul 2007 10:10:10 +0200 (MEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--=-ir6mrKofmcAvcqqczHCm
Content-Type: multipart/mixed; boundary="=-369BM+bBPrJ9HG2REOFx"


--=-369BM+bBPrJ9HG2REOFx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello everybody,

I have a notebook with the Intel ICH7 chipset (see attached lspci
output). Unfortunately, the SATA controller is stuck in non-AHCI mode
and the braindead bios doesn't allow me to change that. Is it possible
to change the controller to AHCI mode in software, e.g. through ACPI?

Thanks, Yours, Florian



--=-369BM+bBPrJ9HG2REOFx
Content-Disposition: attachment; filename=lspci
Content-Transfer-Encoding: base64
Content-Type: text/plain; name=lspci; charset=utf8

MDA6MDAuMCAwNjAwOiA4MDg2OjI3YTAgKHJldiAwMykNCjAwOjAxLjAgMDYwNDogODA4NjoyN2Ex
IChyZXYgMDMpDQowMDoxYi4wIDA0MDM6IDgwODY6MjdkOCAocmV2IDAyKQ0KMDA6MWMuMCAwNjA0
OiA4MDg2OjI3ZDAgKHJldiAwMikNCjAwOjFjLjEgMDYwNDogODA4NjoyN2QyIChyZXYgMDIpDQow
MDoxYy4yIDA2MDQ6IDgwODY6MjdkNCAocmV2IDAyKQ0KMDA6MWQuMCAwYzAzOiA4MDg2OjI3Yzgg
KHJldiAwMikNCjAwOjFkLjEgMGMwMzogODA4NjoyN2M5IChyZXYgMDIpDQowMDoxZC4yIDBjMDM6
IDgwODY6MjdjYSAocmV2IDAyKQ0KMDA6MWQuMyAwYzAzOiA4MDg2OjI3Y2IgKHJldiAwMikNCjAw
OjFkLjcgMGMwMzogODA4NjoyN2NjIChyZXYgMDIpDQowMDoxZS4wIDA2MDQ6IDgwODY6MjQ0OCAo
cmV2IGUyKQ0KMDA6MWYuMCAwNjAxOiA4MDg2OjI3YjkgKHJldiAwMikNCjAwOjFmLjIgMDEwMTog
ODA4NjoyN2M0IChyZXYgMDIpDQowMDoxZi4zIDBjMDU6IDgwODY6MjdkYSAocmV2IDAyKQ0KMDE6
MDAuMCAwMzAwOiAxMDAyOjcxNDkNCjAzOjAwLjAgMDI4MDogODA4Njo0MjIyIChyZXYgMDIpDQow
YTowMS4wIDA4MDU6IDExODA6MDgyMiAocmV2IDE5KQ0KMGE6MDEuMSAwODgwOiAxMTgwOjA4NDMg
KHJldiAwMSkNCjBhOjAxLjIgMDg4MDogMTE4MDowNTkyIChyZXYgMGEpDQowYTowMS4zIDA4ODA6
IDExODA6MDg1MiAocmV2IDA1KQ0KMGE6MDcuMCAwMjAwOiAxMGVjOjgxMzkgKHJldiAxMCkNCjBh
OjA5LjAgMDYwNzogMTUyNDoxNDEwIChyZXYgMDEpDQo=


--=-369BM+bBPrJ9HG2REOFx--

--=-ir6mrKofmcAvcqqczHCm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGnHlc7CzyshGvatgRAoAlAKDdzqhsy5MT6s7M+XP/IMyuWSOghgCfY0Ha
JMNbrzuRwB6wpnpcn8MZh8U=
=tHn0
-----END PGP SIGNATURE-----

--=-ir6mrKofmcAvcqqczHCm--

