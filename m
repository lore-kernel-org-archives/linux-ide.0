From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Re: libata: PIO bounce copies to avoid long IRQ off
 runs
Date: Tue, 29 Apr 2008 23:01:05 +0100
Message-ID: <20080429230105.710cd464@core>
References: <20080429144754.7d2952c8@core>
	<20080429220128.GA25818@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45800 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755906AbYD2WIh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Apr 2008 18:08:37 -0400
In-Reply-To: <20080429220128.GA25818@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Tue, 29 Apr 2008 18:01:28 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> I would tend to prefer this version...
> 
> 	- allocate buffer at init time
> 	- use lesser-used KM_IRQ1

Seems reasonable enough. You actually want to deal with the buffer at run
time however because you care about two cases

1.	Box with no highmem - easy to do compile time
2.	Box with no high pages allocated - kind of hairy with gcc as
the crystal ball feature doesn't work.
