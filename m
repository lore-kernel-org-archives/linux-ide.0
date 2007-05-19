From: "Indan Zupancic" <indan@nul.nu>
Subject: Re: [PATCH] sata_sil: Greatly improve DMA support
Date: Sat, 19 May 2007 18:20:30 +0200 (CEST)
Message-ID: <1441.81.207.0.53.1179591630.squirrel@secure.samage.net>
References: <20070519053532.GA32522@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from neon.samage.net ([85.17.153.66]:49508 "EHLO neon.samage.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754436AbXESQUc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 May 2007 12:20:32 -0400
In-Reply-To: <20070519053532.GA32522@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Sat, May 19, 2007 07:35, Jeff Garzik wrote:
>
> Since Alan expressed a desire to see Large Block Transfer (LBT) support
> in pata_sil680, I though I would re-post my patch for adding LBT support
> to sata_sil.
>
> Silicon Image's Large Block Transfer (LBT) support is a vendor-specific
> DMA scatter/gather engine, which enables 64-bit DMA addresses (where
> supported by platform) and eliminates the annoying 64k DMA boundary
> found in legacy PCI IDE BMDMA engines.
>
> This hardware is open hardware.  Docs for both PATA and SATA can be
> found at http://gkernel.sourceforge.net/specs/sii/
>
> LBT support works the same way in both pata_sil680 and sata_sil, so
> maybe a motivated individual could take use this patch as an inspiration
> for doing the same thing with pata_sil680.
>
> NOTE:  This patch works for me on x86 and x86-64.  However, other
> testers reported problems, which is why it is not upstream.

This patch seems to work with my SiI 3512, though I don't notice any
difference, neither a speedup, nor a slowdown. Hdparm gives the same
speeds (-tT), and cp -a'ing kernel sources is abysmal slow in both cases,
(need to look into that one) so I didn't really test it that well.

Greetings,

Indan


