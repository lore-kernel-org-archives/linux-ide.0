From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch for 2.6.33? 1/1] ata: call flush_dcache_page() around
 PIO data transfers in libata-aff.c
Date: Tue, 2 Feb 2010 23:30:11 +0000
Message-ID: <20100202233011.329b74cd@lxorguk.ukuu.org.uk>
References: <1265151518.2800.715.camel@mulgrave.site>
	<20100202150537.0f6a01c0.akpm@linux-foundation.org>
	<4B68B1E0.4090004@pobox.com>
	<20100202.152140.216335166.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44792 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754964Ab0BBXgF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Feb 2010 18:36:05 -0500
In-Reply-To: <20100202.152140.216335166.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: jgarzik@pobox.com, akpm@linux-foundation.org, James.Bottomley@suse.de, jeff@garzik.org, linux-ide@vger.kernel.org, catalin.marinas@arm.com, stable@kernel.org, tj@kernel.org

> ATA should do something similar instead of randomly scattering
> flush_dcache_page() calls all over the place.

ATA has an sff_data_xfer callback for standard style interfaces for
exactly the same reason that IDE did. That should be the only place that
needs touching for most controllers (either the callback point or in the
callback).

The non-standard ones that do bits of PIO will need fixing in place
because they are sufficiently weird they don't fit any standard format.
Fortunately they are almost entirely platform specific and/or DMA.

Alan
