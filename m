Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE18D1CDFB9;
	Tue, 14 Jan 2025 17:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877084; cv=none; b=jCJwxVCRQ3GHRaAS3l9f+Jj1XGvSDRf5+riWyXkoPpQuKz9s4IXnMTcCfBPkbGOPfS8kKGOZTCsGyswYO6YQDqRoAJVszqFlZmLE/t5Hjsq6CTz04TUGGux00sm/AUH8ePrgmd1Ufx2nX9xCuvG9pg7uMqmA+co9N3cqDgkhM1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877084; c=relaxed/simple;
	bh=4Ww6OB6L3VaADeKLXpxhHhwWl/zI3yHYx7PJzqKx/NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grVqwfRt+wwdgg8Jhr0ov4qufWKjneDl6+s0/M56tYF31nU+XpOhXBbciWh4mxVdF4dJlsH9l/qsRe7ZnkyevYlbJ3bjwXAEKhUBFOemM+N4eSWKw3H2Sn18bsnzU4xqC8p0nhICe8HbtRzQsYRogWW5nh4F7qY9Dc+S2cZclSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=Teoy98gj; arc=none smtp.client-ip=217.72.192.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="Teoy98gj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1736877079; x=1737481879; i=christian@heusel.eu;
	bh=4Ww6OB6L3VaADeKLXpxhHhwWl/zI3yHYx7PJzqKx/NE=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Teoy98gjedn2ice+K3okh4i1HcNlfdnno/d4FdwsxC2+qaLJp+nQ6RW99tEprnCC
	 WgOAb9iUgF9ueWJpeaZRe3fqT0fdJ9pmMdtSkgsjjBxcR6h+9A+YxhHVpJYnwwfmv
	 HAcs5DLGAgIaJzjQ/wJt9guL3FnHb3C6SIUIOT3Y8XK2WaQvoEq3KPJPeTHlqzpVk
	 jTvBn3Ht/YOk44oAbKDVq1Jt7OySowZrxkHuJSsBT2gA682xgLzUjji+NijowqoZj
	 6Lt+4JlgUZuqKNkWjsTucebaM1V8M4PjA6cp24/Y0uoGDtTLpgiVBJTT/NtXHyDUz
	 kVK2l8Ge49QD7ctDsg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Mj7yt-1t1xz10lFt-00nEM5; Tue, 14
 Jan 2025 17:40:14 +0100
Date: Tue, 14 Jan 2025 17:40:12 +0100
From: Christian Heusel <christian@heusel.eu>
To: Niklas Cassel <cassel@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION][BISECTED] BU40N Blu-Ray drive broken since
 7627a0edef54
Message-ID: <5232263d-5836-402d-9c5e-e3c601181080@heusel.eu>
References: <e2be6f70-dff6-4b79-bd49-70ec7e27fc1c@heusel.eu>
 <Z4EDf4ecHyfTq3Hp@x1-carbon>
 <69589dad-c0c8-4a72-9f3d-c1b0c29c96c1@heusel.eu>
 <e167b28c-94a2-45bf-8330-2487baf7199b@heusel.eu>
 <Z4U-rc3VUeegHGAg@ryzen>
 <Z4aLWmt1Y2jL1-pD@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v7cnc46tonprs2m5"
Content-Disposition: inline
In-Reply-To: <Z4aLWmt1Y2jL1-pD@ryzen>
X-Provags-ID: V03:K1:8BGG6VpEEVCyle+SNBNEMAWPgf6YrYXeqB1YTd+jSH4TF9h4pDq
 ZssZHVOzPpni9wqbsEKtOEoRDXCKW4kTB1/DbZzOZFh8cfl/7Nz+KNibo6h2QKq9I35Q1qt
 Ekt5XF3yu+KKxJzJtZw25baSG4jbRd3jwGLf1T3hh9+BCdojedwWoaF+f+/FqsWNLIdEbBj
 iDKAWVGlblRY+CrrBN1Zw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4RHRCQOur0Q=;I2x9gRn7RoML1JF2J538DvWSyef
 lKPozqlMn07LlhKJwGN3C/w8hU/T0gagkYjxwODE+8jkGsd0XQTRN6NJErfHmm6ztdZZ6I7zL
 8rJ1IIYF8dlx3VgTQgj7sSce909q8C84equhX0MXy4M33fsksYOVbUvlrWLpb62TNxYkXOJdD
 ookUBAu9+z5yJ4d2H/KKYg+r7s4V7cwgtXLL6Cwb9pSeewMZxzGnXzXjOZB6auMxOd7cqa5yG
 Bsqkh+ZyMuQjr8ul3ZpyKc2pmOsKOdjVZrae25bpjMbdCm6jqh1OyWcgquqTfmiFMTZOReKWu
 4h7bgTYOdsrGBbaPRLx/c/p6Wc4LMJcbUZzuQInwzMhjSx8ylklr+Whv/KnBzZErPIoBQKdpD
 epHU4oGWcXw6uhjLkvfq6nbF/Zb6oNcH/GC15J4xM4/drluamHLmwpGNTnsfdMfhVgZSqvarj
 OBc4YuD4kL0R73rhCRTx56jCQuTXlzSBWLTpr47fSPgiODlx8VbQqOZl9HYxlmasS8DgwZE/6
 sIYUhyTcBR9QAnBFYtjVITP/+ke/3jw15+ZgFd6Rnc8Cii5CByq4a+vg7UePSoFL8iozG+xZp
 FhqBB94zlz63n20GpEaOLy7gRenE/tt3zenp6wCzVkDeFURSryUAvOJEqIzuEVomBrgTbzSMm
 lx61CsxtNNko7dJzIDtzTPYmc3CDbn70B6zh+qQp52qu1/hGT7XBljOIoHQgxbJdm2OONvolU
 EuEj8sScvrEy2q45pkmmFYw8mnH1JZMQ8+f+q9502GveOsM2Vpj03aQNO6T2HOcUMLFx6SwMG
 eV+f9GUK9siU126qfyOc8hyndFktcXZ6CoEqVIRwvaSaHvsKxTeZoR521OwfRPnvce5WqWHta
 VFDGxFtfirSgrEDX7bEUrG6CKE5oRg0uOi0a8sPFmGEzW/R6nv3lW0W6aRLAiURq8D69LuH9b
 HBE0FqAY7S6bk1C5NFCpTp47h3/h2MK4KcwT58fUt6zFuWBS6Cvmh7P1dY8sgzmZxwMCYmVfU
 cBU7GHDRl8S6Lusi/lqGMK1ZNJVohd87gV5U7o/


--v7cnc46tonprs2m5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [REGRESSION][BISECTED] BU40N Blu-Ray drive broken since
 7627a0edef54
MIME-Version: 1.0

On 25/01/14 05:05PM, Niklas Cassel wrote:
> Hello Christian,

Hello Niklas,

> Looking at the Arch Linux thread, it seems that the person reporting the
> problem says that even on a working kernel, you only see the device the
> user presses the open button on the Blu-Ray player.
>=20
> This suggests to me that it sends a hotplug/PhyRdy event when the user
> presses the open button.
>=20
> In Linux, if we don't detect anything connected to the port during initial
> boot, and if the port is not marked (by firmware) as either Hotplug Capab=
le,
> or External, then we mask the PhyRdy interrupt.
>=20
> We could reconsider this, and leave the PhyRdy interrupt enabled even for=
 a
> port that is not Hotplug Capable or External, if there is no devices dete=
cted
> on the port.
>=20
>=20
> However, a device should really show up after a COMRESET... A device that
> does not do so seems to be non-spec compliant.
> It would be nice if we could understand why this device does not show up
> after a COMRESET. (If it did, we most likely would not need the workaround
> suggested above.)
>=20
> Could you please run with this debug prints, which might tell us what is
> going on:

Thanks for investigating this further, I was typing my previous mail and
sent it just after yours because I didn't see it x)

> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> <snip-patch>

Building a kernel with the patch applied just now! I will get back to
you once I have heard back from the user.

On a sidenote it seems like your mail client or something converts the
tabs to spaces on these inline patches, which makes them quite hard to
apply for me (I had to manually apply and format-patch).
Could add them as attachment in the future or reply via git send-mail?

> Kind regards,
> Niklas

Cheers,
Chris

--v7cnc46tonprs2m5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmeGk2wACgkQwEfU8yi1
JYUfgxAAhR1uKAdukCdNrArWkOWMz/D2cGcLjEFI3jBGTPxa7VM3o9dQBAvqufS2
DNd89R9a8Tq1/S6PAYWNDS8Fl7aJyO8capQFj6uPvBJtYGkGGaVaL0HYVLyefgxx
fTc6/W59OoRFVb1SxWiSfMMwXsmsFVq+jB/sH8BlOQz7qmJmRMfaeB096OeFA/9Y
fa7jDiae6GfJnHlg8SoQt//KsE45XEqMA03eRrsIlcQa5kY1MXGk2eYSVsGWCKXm
1raAvhZRNOkbhWYQooGyohevXf0Oeujipj7As3XOJMVLd2Ddlwh9b/sh0i3e67Kf
bHqTSXN+6mMmiHzpw08YoArk/g+/2XRqNoYE964eKBE5H54xSNWIQt13wgl76+3R
tJVqApPWt313zu6+jZT8BLkOzyQRb4COmqY2WvgN9JNwqy5ihYH5jBLjxIax9JC3
GKFYdrDD7GSu/qT8QfQPCx7/ZTyQ1pGrPOfQlYJkehsAePrk0UDnxfEWvbGJETix
0uMwqGcJChYt9HYJmeGm1PH19haX4PftKq6Z1nI0sIFIU975CQJ9Pf7AW6Z8PLsu
imD38hQPr7y9fLDRTE0Y7vVZfX3+SkQudJRF4j8P0ZF+m+y+upfdk7XYyk4WzwN9
cecrUMGHM7uIC6jTlWnoDoKAZlTRH5aCV99CGMhDUR5Wk6gF0DY=
=pSaz
-----END PGP SIGNATURE-----

--v7cnc46tonprs2m5--
