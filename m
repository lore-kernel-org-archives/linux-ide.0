From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] pata_pcmcia: another memory card support
Date: Tue, 11 Nov 2008 12:22:43 +0100
Message-ID: <20081111112243.GA6271@comet.dominikbrodowski.net>
References: <200811061144.35556.marc.pignat@hevs.ch> <49193C0F.5000908@garzik.org> <20081111084053.GA12965@isilmar.linta.de> <491945D9.2080201@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.133.102.198]:40375 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755403AbYKKLXs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Nov 2008 06:23:48 -0500
Content-Disposition: inline
In-Reply-To: <491945D9.2080201@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Marc Pignat <marc.pignat@hevs.ch>, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org

Jeff,

On Tue, Nov 11, 2008 at 03:44:09AM -0500, Jeff Garzik wrote:
> It is not normal practice to merge add-device-id patches through 
> bus-specific trees.  We do not do such things with PCI IDs, for example.

Well, it's been normal practice for pcmcia IDs.

> I would be happy to apply the whole patch, or ACK it and let Bart apply 
> the entire patch.  Either way is fine with me.

Anyways, as it's already in my queue for Linus, it'll be a double-merge this
time. Let's just try to keep the IDs in pata_pcmcia and ide-cs coordinated
in future, ok?

Best,
	Dominik
