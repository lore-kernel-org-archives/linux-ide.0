From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_hpt3x3: support this chip properly including
 alternative BAR layout
Date: Fri, 29 Jun 2007 19:50:48 +0100
Message-ID: <20070629195048.02e7d18a@the-village.bc.nu>
References: <20070629191703.5d9cf602@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34822 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754755AbXF2Soz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jun 2007 14:44:55 -0400
In-Reply-To: <20070629191703.5d9cf602@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org, linux-kernel@vger.kernel.org

On Fri, 29 Jun 2007 19:17:03 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> In some cases we cannot use BAR0-BAR3 on this chip due to errata. The
> relevant interfaces are available via BAR4 and we set the chip up to use
> those instead.
> 
> This plus testing means it can move from experimental to production spec
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

Argh NAK that, just when I thought it was all stable its not
