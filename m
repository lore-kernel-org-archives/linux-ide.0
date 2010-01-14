From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: SATA_SIL on IXP425 workaround
Date: Thu, 14 Jan 2010 21:00:50 +0000
Message-ID: <20100114210050.2c99c2b1@lxorguk.ukuu.org.uk>
References: <m33a4nfvva.fsf@intrepid.localdomain>
	<201001141659.19687.bzolnier@gmail.com>
	<20100114192210.62593ead@lxorguk.ukuu.org.uk>
	<201001142129.38781.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:45608 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752043Ab0ANU5p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jan 2010 15:57:45 -0500
In-Reply-To: <201001142129.38781.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

> I think that you misinterpreted the issue -- according to Krzysztof MMIO
> works just fine, only 8/16-bit MMIO reads are a problem (please note that
> using mixed PIO/MMIO access is still a win over pure PIO access and also
> that sata_sil doesn't support pure non-MMIO operations currently)..

Have we got timing measurements to prove that ?
> 
> However if it gets fixed in the upstream kernel in some other way I'll
> simply drop the patch during the next re-base of my tree (I just collect
> ATA stuff that looks useful/interesting to me and which otherwise may
> become lost)..

And that's a good thing. The question was aimed at Krzysztof. Really we
need to keep platform specific weirdness out of core drivers or the
rapidly turn into a mess.
