From: David Miller <davem@davemloft.net>
Subject: Re: [patch for 2.6.33? 1/1] ata: call flush_dcache_page() around
 PIO data transfers in libata-aff.c
Date: Tue, 02 Feb 2010 15:39:27 -0800 (PST)
Message-ID: <20100202.153927.70718550.davem@davemloft.net>
References: <4B68B1E0.4090004@pobox.com>
	<20100202.152140.216335166.davem@davemloft.net>
	<1265153568.2800.815.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:48666
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752806Ab0BBXjQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Feb 2010 18:39:16 -0500
In-Reply-To: <1265153568.2800.815.camel@mulgrave.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James.Bottomley@suse.de
Cc: jgarzik@pobox.com, akpm@linux-foundation.org, jeff@garzik.org, linux-ide@vger.kernel.org, catalin.marinas@arm.com, stable@kernel.org, tj@kernel.org

From: James Bottomley <James.Bottomley@suse.de>
Date: Tue, 02 Feb 2010 17:32:48 -0600

> What it looks like we need is kmap_for_pio() and kunmap_for_pio() which
> take flags (or API extensions) indicating whether we're transferring to
> or from the device, which return the correct kernel address to the page
> (mapping it if it's in highmem) and perform the correct
> flushes/invalidates.

That sounds like a good idea.
