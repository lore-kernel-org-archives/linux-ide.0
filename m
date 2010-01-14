From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: SATA_SIL on IXP425 workaround
Date: Thu, 14 Jan 2010 21:29:38 +0100
Message-ID: <201001142129.38781.bzolnier@gmail.com>
References: <m33a4nfvva.fsf@intrepid.localdomain> <201001141659.19687.bzolnier@gmail.com> <20100114192210.62593ead@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:34149 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932349Ab0ANUb1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jan 2010 15:31:27 -0500
In-Reply-To: <20100114192210.62593ead@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

On Thursday 14 January 2010 08:22:10 pm Alan Cox wrote:
> > FWIW your patch is now in my atang tree (I'm aware that Jeff is working
> > on generic solution but in the meantime this non-intrusive patch allows
> > sata_sil to work on IXP425).
> 
> I think this is the wrong place. If your platform can't do MMIO properly
> then the platform pci_iomap or pci quirk code should do the needed
> cleaning up, not put turds into the drivers. Why not just quirk it on your
> specific platform and clear the MMIO mapping.

I think that you misinterpreted the issue -- according to Krzysztof MMIO
works just fine, only 8/16-bit MMIO reads are a problem (please note that
using mixed PIO/MMIO access is still a win over pure PIO access and also
that sata_sil doesn't support pure non-MMIO operations currently)..

However if it gets fixed in the upstream kernel in some other way I'll
simply drop the patch during the next re-base of my tree (I just collect
ATA stuff that looks useful/interesting to me and which otherwise may
become lost)..

--
Bartlomiej Zolnierkiewicz
