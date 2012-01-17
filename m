From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [git patches] libata updates for 3.3
Date: Tue, 17 Jan 2012 00:18:12 +0000
Message-ID: <20120117001812.GA9588@srcf.ucam.org>
References: <1326691403.13517.21.camel@minggr>
 <CA+55aFzqECJjbtgyOXy_H1smh09SsfgrAuVY7hK2sC-xj1GZHg@mail.gmail.com>
 <20120116194211.2cd09fb3@pyramind.ukuu.org.uk>
 <CA+55aFxNcAtCmzEejS=3+_L_rp-MOBS0yLS061YgiCsFw_Mt5Q@mail.gmail.com>
 <20120116195427.64edd96f@pyramind.ukuu.org.uk>
 <CA+55aFzXFyHTUv=8NtSmXA2UY_qO5P=HXdGnhUmF9YoA5vpX1g@mail.gmail.com>
 <CA+55aFxUyBvkAhQZFKDuiJrMx9sR2Nb3s5F3P8wDLa4eNspJ1Q@mail.gmail.com>
 <4F14881C.8040601@garzik.org>
 <20120116235427.168e13f2@pyramind.ukuu.org.uk>
 <CA+55aFyafh6cCiV=mMA6Z7qtWqBrJ_pGPev09PP14nJ8Hc=vmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:60860 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258Ab2AQASX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jan 2012 19:18:23 -0500
Content-Disposition: inline
In-Reply-To: <CA+55aFyafh6cCiV=mMA6Z7qtWqBrJ_pGPev09PP14nJ8Hc=vmg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Lin Ming <ming.m.lin@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Mon, Jan 16, 2012 at 04:02:31PM -0800, Linus Torvalds wrote:
> On Mon, Jan 16, 2012 at 3:54 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> =
wrote:
> >> Part of the problem with force-enable is that the MMIO BAR may nee=
d a
> >> value, and not have it. =A0That, and an expectations mismatch betw=
een BIOS
> >
> > That's fine - we can happily assign one at boot time.
>=20
> Actually, I think the reason that Matthews patch doesn't work for me
> is that on my device, BAR #5 really is a _port_ BAR.
>=20
> I didn't play with it much - busy merging and looking at various othe=
r
> issues - but I'm starting to wonder whether maybe that 8086:1c01 chip
> doesn't support AHCI at all. Or maybe it does something differently.
>=20
> Other reports of this have BAR#5 either clear, or an MMIO BAR.   That
>=20
>    Region 5: I/O ports at ffe0 [size=3D16]
>=20
> looks really odd. Matthew's patch uses
>=20
>   pci_assign_resource(pdev, 5);
>=20
> but if it is a PIO region, that won't help anything..

More recent ICHs may need different setup here. The datasheet should=20
have enough to figure it out, but I can take a look once I get back fro=
m=20
LCA.

--=20
Matthew Garrett | mjg59@srcf.ucam.org
