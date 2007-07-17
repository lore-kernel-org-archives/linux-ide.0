From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] pata_platform: Fix NULL pointer dereference
Date: Tue, 17 Jul 2007 18:02:19 +0900
Message-ID: <20070717090219.GA24991@linux-sh.org>
References: <20070717084252.29884.24167.sendpatchset@clockwork.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.ocgnet.org ([64.20.243.3]:43299 "EHLO smtp.ocgnet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752870AbXGQJDq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Jul 2007 05:03:46 -0400
Content-Disposition: inline
In-Reply-To: <20070717084252.29884.24167.sendpatchset@clockwork.opensource.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linuxsh-dev@lists.sourceforge.net, linux-ide@vger.kernel.org, Sonic Zhang <sonic.adi@gmail.com>, Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Tue, Jul 17, 2007 at 05:42:52PM +0900, Magnus Damm wrote:
> pata_platform: Fix NULL pointer dereference
> 
> The platform-specific structures may leave pdev->dev.platform_data as NULL.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Looks like the change that broke this came in the libata merge, more
specifically this change:

commit 5f45bc50976ee1f408f7171af155aec646655a37
Author: Sonic Zhang <sonic.adi@gmail.com>
Date:   Fri Jun 15 17:45:49 2007 +0800

    Add irq_flags to struct pata_platform_info

    On some embedded platforms, such as blackfin, the gpio interrupt for
    IDE interface is designed to be triggered with high voltage. The gpio
    port should be configured properly by set_irq_type() when register
    the irq. This patch enable the generic pata platform driver to
    accept platform irq flags data.

    Signed-off-by: Sonic Zhang <sonic.adi@gmail.com>
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

It would be great if libata people could actually be bothered to CC driver
authors on driver changes so that way these things don't get completely broken
in mainline when simple testing on the platforms that actually _rely_ on this
driver would have shown that this was broken.

I don't intend to poll the various libata branches on the off chance I'll find
something that's hosed my platforms, and I don't think it's an unreasonable
expectation to at least have to see the patch and sign off on it before it gets
merged. Every other subsystem works this way, I wonder why libata feels that
it's special.

This is also not the first time changes to pata_platform have caused fallout,
without finding out about it until after the changes were already merged.
