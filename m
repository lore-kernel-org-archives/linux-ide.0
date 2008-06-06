From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ide cdrom problems on new imac
Date: Fri, 6 Jun 2008 21:49:47 +0100
Message-ID: <20080606214947.06e19074@core>
References: <484970DC.3060209@cse.yorku.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:33940 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756602AbYFFVGB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Jun 2008 17:06:01 -0400
In-Reply-To: <484970DC.3060209@cse.yorku.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jason Keltz <jas@cse.yorku.ca>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

> It isn't clear to me whether the device is recognized by libata 
> ata_piix, or just by a separate kernel IDE Intel PIIX driver?

One slot by each - CD by old IDE  disk by libata in the dump you gave

> [<c025d0ae>] (ide_intr+0x0/0x11e)
> Disabling IRQ #185

and old IDE broke

No kernel that old supports the needed workarounds for the ICH behaviour
change. Intel changed the ICH behaviour on IRQ handling in the later
chips in some configurations that are mostly used on the mac.

The SATA backport in Centos 4.x doesn't include the needed changes nor
does the IDE layer. Ditto I believe 5.x.

You need to use the current IRQ clearing logic for both drivers - the old
logic only clears the ata status register on PIO events, the newer one
clears both the ata and DMA status to work around the Intel funny.

[By a strict reading of the spec the Intel behaviour does appear allowed,
 although I hope Intel didn't intend it ...]

Alan
