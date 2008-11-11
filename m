From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] pata_pcmcia: another memory card support
Date: Tue, 11 Nov 2008 13:25:37 +0100
Message-ID: <20081111122537.GA9958@comet.dominikbrodowski.net>
References: <49193C0F.5000908@garzik.org> <20081111084053.GA12965@isilmar.linta.de> <491945D9.2080201@garzik.org> <20081111113738.26a8132b@lxorguk.ukuu.org.uk> <200811061144.35556.marc.pignat@hevs.ch> <49193C0F.5000908@garzik.org> <20081111084053.GA12965@isilmar.linta.de> <491945D9.2080201@garzik.org> <20081111112243.GA6271@comet.dominikbrodowski.net> <20081111115910.54d86403@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.133.102.198]:52805 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755855AbYKKMzS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Nov 2008 07:55:18 -0500
Content-Disposition: inline
In-Reply-To: <20081111113738.26a8132b@lxorguk.ukuu.org.uk> <20081111115910.54d86403@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Marc Pignat <marc.pignat@hevs.ch>, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org

On Tue, Nov 11, 2008 at 11:37:38AM +0000, Alan Cox wrote:
> > It is not normal practice to merge add-device-id patches through 
> > bus-specific trees.  We do not do such things with PCI IDs, for example.
> 
> We've also been parallel applying patches via myself through Jeff and via
> Bart since the beginnings of libata without a problem. So it ain't
> broke ....

795659ef0ee175d47723f806e7a29427b171e61b . Let's just try to apply new IDs
to both files, and not cherry-pick parts of such a patch?

Best,
	Dominik
