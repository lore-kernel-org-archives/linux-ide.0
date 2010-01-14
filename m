From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: SATA_SIL on IXP425 workaround
Date: Thu, 14 Jan 2010 19:22:10 +0000
Message-ID: <20100114192210.62593ead@lxorguk.ukuu.org.uk>
References: <m33a4nfvva.fsf@intrepid.localdomain>
	<201001141659.19687.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:34052 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932297Ab0ANTTI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jan 2010 14:19:08 -0500
In-Reply-To: <201001141659.19687.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

> FWIW your patch is now in my atang tree (I'm aware that Jeff is working
> on generic solution but in the meantime this non-intrusive patch allows
> sata_sil to work on IXP425).

I think this is the wrong place. If your platform can't do MMIO properly
then the platform pci_iomap or pci quirk code should do the needed
cleaning up, not put turds into the drivers. Why not just quirk it on your
specific platform and clear the MMIO mapping.

