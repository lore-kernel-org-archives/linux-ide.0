Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F90E542
	for <linux-ide@vger.kernel.org>; Tue, 23 Jul 2024 00:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721694524; cv=none; b=pgsMKgxauK4WOaizixyGb/5AckVZ4Ba39FHDU4af0ipEduepNl+kKts4w7PbmIwqh0dR8RxXgXPADgBer1Fw7UQiPhXc5lNdUpcBHvnlodNUX1X67qHlrRi1JOcurORJvgc+ApgpCLHFJrpo5is3O6224fl55Cz13CtJiFfu4S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721694524; c=relaxed/simple;
	bh=/VHtUYS0525gzU7aCHG0kD699/2HVCpTc40t6X4AKFs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFhQRxmwBYkWX+m5Ups5rzn/Vmj18q6FIqzThzl1FFQZKgwAjp60Rz0F8iHbUHV8UN53RmJAtwJGqFvTKaCd3Z0wHBYpLL14iEgwmVtGb6vK975brm1dvHXw9LdKTrooDGpLjgSodJIep071iZrAw431cLLGOTfogoJ/QV3m1Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id D5533340C37
	for <linux-ide@vger.kernel.org>; Tue, 23 Jul 2024 00:28:42 +0000 (UTC)
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	by grubbs.orbis-terrarum.net (Postfix) with ESMTP id 43901260182
	for <linux-ide@vger.kernel.org>; Tue, 23 Jul 2024 00:28:42 +0000 (UTC)
Received: (qmail 714703 invoked by uid 10000); 23 Jul 2024 00:28:42 -0000
Date: Tue, 23 Jul 2024 00:28:42 +0000
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: linux-ide@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ata: libata: Print horkages applied to devices
Message-ID: <robbat2-20240723T002725-219465571Z@orbis-terrarum.net>
References: <20240722013412.274267-1-dlemoal@kernel.org>
 <20240722013412.274267-4-dlemoal@kernel.org>
 <Zp7PjJ0dJidXmY7c@google.com>
 <0abbefb8-351a-4be9-90a7-bf26dbe969c7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c3jJ9DU8Oor3lQFK"
Content-Disposition: inline
In-Reply-To: <0abbefb8-351a-4be9-90a7-bf26dbe969c7@kernel.org>


--c3jJ9DU8Oor3lQFK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 08:10:01AM +0900, Damien Le Moal wrote:
> >=20
> > Should this check be '__ATA_HORKAGE_MAX > 32'?
> >=20
> > When __ATA_HORKAGE_MAX is 32 then the last horkage bit will be 31.
Do we need to save that last bit for a future expansion? ATA_HORKAGE2?

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation President & Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--c3jJ9DU8Oor3lQFK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAABCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAmae+ThfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsQpeg/+L9NunDqlSwlzlFnt8cLWH7qq0gsmHRkTlnU+K6R0M5A/KRJwl5W911+/
xXSz49P4Wdk2IN4Li1luLlu7qXr5kDQGyds08RU+AWxKSYos8H6Z20rZL0pF40gS
kTnmh7yhq4ja67ldj7QdIB0ChRn3KVLOskTCawxu7Lv7d4ERGfAq3adEfBEId+tO
WzQhkjr3uvrQT5Ki27PhxWzkqays6dQvCxfH3c6wm76Eyjh7hHbextmFxewa1LMu
M3IAT2u2SUwPuPewqcG9qUJKupOHYGsVVf6kaDXn/G/3wDDJlY9D5dHmPNollUXP
wPalOPEMup7byf6KTpI/jw0ivHKs6UTb4ppHLV2Ucme1Yf0Jj+RSadJOy7Vl8tuH
lpun3whjcb6y0e9LODHFrkCS9x3Ma4WuWYXTyR3jduK6nxjt9n1TBFQTpY/OYyIs
gIqh44GSVROLUlpKzlur32mMrX/LKyyKZ/hAJNMB+NT+WwD3raEuioyjltyrbKcq
XqeVTxTuQiFaBzDNNAbr9QJPjxb9ZOsafRldaxJwgeMQ3uxAHwbVpqOTiAhmGnIa
a4m35AgdBMOz3etGNE2ruqlBr/ZohFxuQ3s8AI3EGrJbQRXAhv3fMELqpr86FvXE
5swVG791S+y2F2Shps5M3ALp7KWTgDKIhGHQamIbTTbTOkH7rCE=
=/6/b
-----END PGP SIGNATURE-----

--c3jJ9DU8Oor3lQFK--
