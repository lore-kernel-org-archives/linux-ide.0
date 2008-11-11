From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_pcmcia: another memory card support
Date: Tue, 11 Nov 2008 11:37:38 +0000
Message-ID: <20081111113738.26a8132b@lxorguk.ukuu.org.uk>
References: <200811061144.35556.marc.pignat@hevs.ch>
	<49193C0F.5000908@garzik.org>
	<20081111084053.GA12965@isilmar.linta.de>
	<491945D9.2080201@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42682 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753026AbYKKLhp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Nov 2008 06:37:45 -0500
In-Reply-To: <491945D9.2080201@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jeff@garzik.org>, Marc Pignat <marc.pignat@hevs.ch>, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org

> It is not normal practice to merge add-device-id patches through 
> bus-specific trees.  We do not do such things with PCI IDs, for example.

We've also been parallel applying patches via myself through Jeff and via
Bart since the beginnings of libata without a problem. So it ain't
broke ....
