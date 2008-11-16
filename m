From: Tejun Heo <tj@kernel.org>
Subject: Re: sata-nv and 790i
Date: Sun, 16 Nov 2008 15:11:20 +0900
Message-ID: <491FB988.50601@kernel.org>
References: <20081115004722.5158e125@werewolf.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43350 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071AbYKPGLO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Nov 2008 01:11:14 -0500
In-Reply-To: <20081115004722.5158e125@werewolf.home>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?=22J=2EA=2E_Magall=F3n=22?= <jamagallon@ono.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>, Mdv Cooker <cooker@mandrivalinux.org>

J.A. Magall=F3n wrote:
> Hi all...
>=20
> I recently put my hands on a system with an ASUS P5N64 WS Pro mobo:
>=20
> http://www.asus.com/products.aspx?l1=3D3&l2=3D11&l3=3D653&l4=3D0&mode=
l=3D2182&modelmenu=3D1
>=20
> It has a nForce 790i Ultra SLI chipset, the part for the SATA control=
ler
> is MCP55.
>=20
> The problem is that linux seems to fail to read the hard drive on boo=
t.
> I will explain.
>=20
> I have tried to install both CentOS 5.2 and Mandriva 2009.0.
> For CentOS (has a 2.6.18 kernel), the install seems ok, but when I re=
boot
> into the just intalled system the kernel hangs just after printing
> the name of the initrd. Mandriva (2.6.27-rc8) just hungs half the ins=
tall process.
> Live versions of both hang on boot saying they can not find the root
> device.
>=20
> I have found some messages in the net about the MCP55 in that board n=
ot
> being completeley suppported as AHCI in sata_nv, and that some other
> boards work puttin the SATA controller in 'compatible' mode (with
> loss of performance).
> But I can't find any setting in the P5N64 to put SATA in Compat mode.
>=20
> Can I do this via some kernel parameters ?
> Somabody has this board working ? Do current kernels have better supp=
ort
> for this chipset ?

All three flavors of sata_nv's - generic (yours), nf2/3 and ck804 - had
various detection problems from 2.6.27-rc1.  The problem was that their
hardresets all worked differently.  2.6.27-rc1 started to favor
hardresets over softresets and exposed this problem.  While trying to
fix the problem, because all three flavors unexpectedly showed differen=
t
hardreset behaviors, there were some mistakes.  A proper fix is include=
d
in upstream and is queued for -stable.  Sorry about the mess.

Thanks.

--=20
tejun
