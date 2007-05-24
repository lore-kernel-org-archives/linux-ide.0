From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] libata: Add MMIO support to pata_sil680
Date: Thu, 24 May 2007 13:42:17 +1000
Message-ID: <1179978137.32247.1035.camel@localhost.localdomain>
References: <20070515061239.611A2DDEE9@ozlabs.org>
	 <1179209697.32247.153.camel@localhost.localdomain>
	 <20070523144217.5abd9fdf@the-village.bc.nu>
	 <1179960518.32247.948.camel@localhost.localdomain>
	 <20070524003123.77b9c81c@the-village.bc.nu>
	 <1179963820.32247.996.camel@localhost.localdomain>
	 <20070524001302.GA18571@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:53378 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758609AbXEXDsN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 May 2007 23:48:13 -0400
In-Reply-To: <20070524001302.GA18571@devserv.devel.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com, Linux IDE <linux-ide@vger.kernel.org>


> There are errata for config space and posting in some chipsets  and as you
> says its slow. The 400nS command writing bit applies too - they chipsets are
> not that smart in my experience.

Ok, I've start doing it, however, reset is the only case I've found.

Currently libata does the 400ns thingy in the inline ata_pause() which
unconditionally does ata_altstatus(); ndelay(400); (and thus does it on
PIO, MMIO, anything ...).

Do you want me to change that to use the MMIO flush hook as well ?

If we're going to do that, we probably need to be careful to have
everybody have a properly populated MMIO flush hook as there might be
current drivers (especially SATA) who rely on this. Jeff ?

Cheers,
Ben.
 

