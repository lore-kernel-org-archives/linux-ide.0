Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAD1207A1D;
	Fri, 10 Jan 2025 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500237; cv=none; b=bDMn41yuy70oD1zce0BkwFe/XaChKWAUcqdyKh3ShaRNwKfAC2Sk8WK9w82A4iCRbC8f0TgTlkuS/Wo45wKez7Hf/ig59YyFd0/TVNFWDD2ULlhdk8s5Gnj6wtLx1wO2kTFq/YAEGCUqFVRE9gEiyxU3bSLp8wIOhHnnJQ2z0tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500237; c=relaxed/simple;
	bh=1hZ73XkgovQk9ICaDNaqrTzvVxhI6xFNqPwN+dwq8W0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EjDa9WJoh0OLeYfRUJVItVcQPzFZbgpHLWV1jWxrFAseEaT2+/cWWka9k8Rd5/ZhjTOHM0w4vzeSsTnjULNTegaL4s5COQFOURdbcumAnWPyeej1CoxBVl3jae6XmgkcF/IjZIlm4UJYg0IQdTzmO7uII8Ztpd0rmaQoxuLg6eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=ddjOXPmO; arc=none smtp.client-ip=212.227.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="ddjOXPmO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1736500232; x=1737105032; i=christian@heusel.eu;
	bh=WbIahtBu8FCxISqH3akxtwyVllMFJcJ1bSy+gqfheFE=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ddjOXPmO0fIjZwy6crnD+3vxLgZjL4UwYC/Tj6GZCcFb61+HxxPqn8CSIVx2+uDY
	 PlPxhjkm0S2ld4GQy3aXIU/c2wUtf0Bsti8VaCv+T8Bk5Gy37jgPT/IrjN3o6I02T
	 ovn1JGNIclOryUt4p0JCwUtBxy8VRlO3fflAu1X9tewlr4AbbyUA1/OTny0f1zAih
	 d3CZCOrP7gLyL/qI3r1RJ+O1G8pg3Sl09MSUJNdecyFbEgNjIuTiKiRYeJCVKaarM
	 ot+R3gQl/GFAqzNggpZ2XTxyOKqf8Ii0oRQJ2xJKSxGABnBPaQavd3Mm5hvVyZrc/
	 r+1nUnrrMGoiC4P+4g==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([80.187.64.46]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mr8zO-1tBfpH3HhW-00Zqpe; Fri, 10 Jan 2025 10:04:50 +0100
Date: Fri, 10 Jan 2025 10:04:46 +0100
From: Christian Heusel <christian@heusel.eu>
To: Mario Limonciello <mario.limonciello@amd.com>, 
	Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Subject: [REGRESSION][BISECTED] BU40N Blu-Ray drive broken since 7627a0edef54
Message-ID: <e2be6f70-dff6-4b79-bd49-70ec7e27fc1c@heusel.eu>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="agdgufwxrky6r4du"
Content-Disposition: inline
X-Provags-ID: V03:K1:XIWkKBmI7J917KIYFU1PreU8lC+l/trTY37/pShmS0K1qaEaZ2z
 Rgrcv+yDsj861tBxoZBVWS4IoexBokteKlZt2CoI8AKhGnZ8HH1UFNBzEbL4e2545LkmSe8
 NBtlbFq4p0raA1LCe9OQo6YwyLIXbOubXv9tEuXX5yERNjyRflVhKEyBMz5Y13dXaOO5Fin
 kVvb2EcsPAPWBKqkgm/gw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aZBViCBmvX0=;LkzN0gRd9J+Remob40RkRybl1vV
 rAXYjDJkut6nC8BfMzAKEe5rYv6pTX2I5PugxzZ743YfyndDjFh+e8k7sYdivlp9T7I3Iw0oO
 f8q1EFETdNYUXMC+2uXSCQKgr4eSPPeCtX9pE7LY+N4DZ9R+n0pACAm6ra0g9QLrEFManyz4V
 lEt49v4nxiphLqITHZfOG5/aEqeYHbJFGaHvNr6mPw0GLcs6Qpcwd+IvRaI9UTUdLGtVky9jG
 353knv5lTZdxu9eNe6cOS02G267rmjB7yXuaFG9dug4fuLdUb3guf4jnOG2ETw9kGimGjyuDp
 ncPvOnMRHrNtezRzk0J9X4rxBsUvuZOqsu6edCZbmkG1FOwO/dcEt9BcXV9g71ll360hR5H/E
 Di8mHgp7z6z3hLle5lfMzUCY5PNwlVHg25814HnCx3VvtIKqW5YONwRDfIO7oIVu93iDoNs/6
 8dgvZtV1YMJP1s+8nESdKSCdXNFJD7RpXPCSvlpDM1XY4Hy8xKu1BxWoMS7OU2NcTpg/XUkrH
 uTHk3gE1ViTcc6wWc6pLNs23RXl1uQX9nUVNpooqYEftbJThCAmlAzybjYkcleiPeG4ODV5Mq
 OevcM9ox95MWq89+4bur2CrH62kNlLFk3cwLfzhsDhxJZdJueu47AKZgVuhGoUEyqbT1eYVk/
 4F+aQwjyPoPEe3gJjRgnIcObIKdaDHwn9WJsxO5KIoKWtIL9GeYUh05GqpywLJ45VKqVwYoa4
 vuRdudNJBE3VbH2xij4EnGKvXwwRBd+R+QzBdxVztv5hxAfIxNkZvAdz/p3WutV5zaJdQvR1C
 M29/y2IX0/6DDFvcj7HQc8psCzKtHjyNIbONRRDEC0nESSnurn5yI6zjo2cLqZFslP


--agdgufwxrky6r4du
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [REGRESSION][BISECTED] BU40N Blu-Ray drive broken since 7627a0edef54
MIME-Version: 1.0

Hello everyone,

we have recently received a report by a user in the Arch Linux Forums
user that their Blue Ray player, a HL-DT-ST BD-RE BU40N stopped working
somewhere since kernel version v6.8.0. We have then bisected the issue
together with them within the mainline kernel sources to the following
commit that changes the default power policy:

    7627a0edef54 ("ata: ahci: Drop low power policy board type")

The user reports that adding "ahci.mobile_lpm_policy=3D1" as a kernel
parameter fixes the issue for them.

Additionally fellow forum user @loqs came up with a quirk patch, that
sadly was reported to not work:

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c085dd8..ef01ccd 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4118,6 +4118,9 @@ static const struct ata_dev_quirks_entry __ata_dev_qu=
irks[] =3D {
 	{ "SAMSUNG MZ7TD256HAFV-000L9", NULL,       ATA_QUIRK_NOLPM },
 	{ "SAMSUNG MZ7TE512HMHP-000L1", "EXT06L0Q", ATA_QUIRK_NOLPM },
=20
+	/* Hitachi-LG Data Storage models with LPM issues */
+	{ "HL-DT-ST BD-RE BU40N", NULL, ATA_QUIRK_NOLPM },
+
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500IT_*",		"MU01",	ATA_QUIRK_NO_NCQ_TRIM |
 						ATA_QUIRK_ZERO_AFTER_TRIM },

So if anyone has feedback on why the patch does not work or any
alternative ideas for a solution that would be highly appreciated!

Cheers,
gromit

[0]: https://bbs.archlinux.org/viewtopic.php?id=3D302334

---

#regzbot introduced: 7627a0edef54
#regzbot link: https://bbs.archlinux.org/viewtopic.php?id=3D302334
#regzbot title: ata: ahci: Blue Ray player broken since power policy change

--agdgufwxrky6r4du
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmeA4q4ACgkQwEfU8yi1
JYULNBAAvSTAkqzoO25BOJqQWDfSrcUvn7ET0+IgWLliubsfpxSuoB6TtT2hVkZN
/XqjT/rJBtTwB2wjhHR5kbVCqaNjU2jZaux/toDXurS9ifY719KeS8IKn/y6HEkN
0f1IH2YPcIvzwSkPdxK7MPz0N5pfCkJwNiaxGR4vIGLHPCVSnCSo/OQ1O/i1B7Ke
VH9hO6ehtNf5Eu6ha7OsO57hwO+HRGHb8BAaCr52BLCbadLHOOXHgWQDofA+Kv1q
9SX2Yt7mKPTKD8mHWkVPdK8OJBZH/FsCDwiWEbOiaTg698y6Q48WH16KtfLLKXeN
0y7AJuP6bvnTVoJ2zkELXDggojHfrkXMnC/m5zoJMZIQ0FYW8QCPesxRYogWZXWr
+UR5GeJei1gtV9JV3zdvnYRXvEnC/+BznsPBgrJB5LsPPx+4WaxHJUI4H2iiW42Q
kdQMxgIFgWyo1vumJhlW5gD9ct+rakUmlPhOcExUrgFzCnoFtndkE3N6wzWD2ZNe
ttT7WQXL00PaZNyHmxhj6rFrRzo4vUbxcWgU00bhBxpXSPjIK9DvuCH+tOIMAdrQ
MV+HT1/iRPeZ4DiQC79Z0km8K9+J+82dVj8m4VO3LoDmFVwKwco+9TmSHD96GVhC
bf/Xltb0C0Z3HS8x55oTwDII9V5WOMGAdeKejVgoANiU3Kh/URE=
=DuzK
-----END PGP SIGNATURE-----

--agdgufwxrky6r4du--
