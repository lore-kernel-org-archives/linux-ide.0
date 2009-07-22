From: Tejun Heo <tj@kernel.org>
Subject: Re: Seagate 1.5TB x Suspend
Date: Wed, 22 Jul 2009 16:56:35 +0900
Message-ID: <4A66C633.6090202@kernel.org>
References: <u4jgj6-qu5.ln1@tux.abusar.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41091 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754319AbZGVH4i (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Jul 2009 03:56:38 -0400
In-Reply-To: <u4jgj6-qu5.ln1@tux.abusar.org.br>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?D=E2niel_Fraga?= <fragabr@gmail.com>
Cc: linux-ide@vger.kernel.org

D=E2niel Fraga wrote:
> Linux 2.6.30
> Asus M2N-E motherboard (nVidia MCP55 SATA Controller (rev a2))
>=20
> 	I bought a Seagate 1.5TB HD (ST31500341AS, CC1H) and I noticed
> that when I resume from suspend, it shows the following:
>=20
> Jul 20 20:07:46 tux kernel: ata1: link is slow to respond, please be =
patient (ready=3D-19)
> Jul 20 20:07:46 tux kernel: ata1: SRST failed (errno=3D-16)
> Jul 20 20:07:46 tux kernel: ata1: SATA link up 3.0 Gbps (SStatus 123 =
SControl 300)
> Jul 20 20:07:46 tux kernel: ata1.00: ACPI cmd ef/03:46:00:00:00:a0 fi=
ltered out
> Jul 20 20:07:46 tux kernel: ata1.00: ACPI cmd f5/00:00:00:00:00:a0 fi=
ltered out
> Jul 20 20:07:47 tux kernel: ata1.00: configured for UDMA/133
> Jul 20 20:07:47 tux kernel: Restarting tasks ... done.
>=20
> 	I think it's not harmful, since everything is working correclty, but=
 I=20
> want to ask you if I should be concerned about this.

The behavior is expected.  Some of those large drives take quite some
time to spin up and libata times out the initial reset and retry.
It's designed to work that way.

Thanks.

--=20
tejun
