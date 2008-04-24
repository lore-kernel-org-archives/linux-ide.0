From: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>
Subject: Re: [PATCH] ahci: retry enabling AHCI a few times before spitting out WARN_ON()
Date: Thu, 24 Apr 2008 03:51:13 +0200
Message-ID: <200804240351.13586.volker.armin.hemmann@tu-clausthal.de>
References: <480F231A.7020401@gmail.com> <200804240224.09518.volker.armin.hemmann@tu-clausthal.de> <480FE3BA.9020508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from poseidon.rz.tu-clausthal.de ([139.174.2.21]:64920 "EHLO
	poseidon.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750783AbYDXBvS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Apr 2008 21:51:18 -0400
In-Reply-To: <480FE3BA.9020508@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Peer Chen <pchen@nvidia.com>

On Donnerstag, 24. April 2008, Tejun Heo wrote:
> Volker Armin Hemmann wrote:
> > Hi,
> >
> > patch -p1 <  ../ahci.patch
> > patching file drivers/ata/ahci.c
> > Hunk #1 FAILED at 556.
> > 1 out of 1 hunk FAILED -- saving rejects to file drivers/ata/ahci.c=
=2Erej
>
> Have you backed out the original patch?  It works fine here.

I removed the whole directory and installed the sources (with emerge=20
vanilla-sources).
 After the failed attempt  I removed it again and unpacked the tarball =
- same=20
result.

I copied the text from kmail into nano and kedit - and both produced id=
entical=20
patch files. If it is some whitespace damage, it should still apply, co=
rrect?

Gl=FCck Auf,
Volker
