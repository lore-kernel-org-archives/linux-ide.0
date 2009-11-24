From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_hpt{37x|3x2n}: fix timing register masks
Date: Tue, 24 Nov 2009 21:20:06 +0000
Message-ID: <20091124212006.4730aacf@lxorguk.ukuu.org.uk>
References: <200911242315.52826.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41006 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932690AbZKXVSy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Nov 2009 16:18:54 -0500
In-Reply-To: <200911242315.52826.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, stable@kernel.org

On Wed, 25 Nov 2009 00:15:52 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> These drivers inherited from the older 'hpt366' IDE driver the buggy timing
> register masks in their set_piomode() metods. As a result, too low command
> cycle active time is programmed for slow PIO modes.  Quite fortunately, it's
> later "fixed up" by the set_dmamode() methods which also "helpfully" reprogram
> the command timings, usually to PIO mode 4.
> 
> However, the drivers added some breakage of their own too:  the bit that they
> set/clear to control the FIFO is wrong -- it's actually the MSB of the command
> cycle setup time; setting it in DMA mode is also wrong as this bit is only for
> PIO actually...
> 
> Fix all this and bump the drivers' versions, accounting for recenjt patches
> that forgot to do it...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Acked-by: Alan Cox <alan@linux.intel.com>
