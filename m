From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] libata: Add ALPM power state accounting to the AHCI
 driver
Date: Sun, 15 Nov 2009 10:33:13 -0800
Message-ID: <20091115103313.4691924d@infradead.org>
References: <20091113192429.4dfc9c39@infradead.org>
	<4AFFB65F.3020201@kernel.org>
	<4AFFBB75.7050601@pobox.com>
	<20091115094630.1785b5ca@infradead.org>
	<4B004328.8060807@kernel.org>
	<20091115102334.1396eea6@infradead.org>
	<4B0047CB.5080509@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:52205 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484AbZKOSbc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Nov 2009 13:31:32 -0500
In-Reply-To: <4B0047CB.5080509@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, akpm@linux-foundation.org

On Mon, 16 Nov 2009 03:26:19 +0900
Tejun Heo <tj@kernel.org> wrote:

> Arjan van de Ven wrote:
> > On Mon, 16 Nov 2009 03:06:32 +0900
> > Tejun Heo <tj@kernel.org> wrote:
> > 
> >> There's DIPM.
> > 
> > where in the code is this?
> 
> In ata_dev_set_dipm()?
> 
> > And just to be clear: DIPM is done by the hardware so that it needs
> > sampling/etc features, rather than just straightforward (free)
> > software accounting when you do software controller transitions ?
> 
> Enabling DIPM means that the drive will be in charge of transitioning
> the link into powersave modes, so if sampling SStatus is necessary to
> determine how much time the link spends in powersave mode.

do we get a link interrupt when the state changes?
(with ALPM we do.. optionally.. which is where the flag comes in)


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
