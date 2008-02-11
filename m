From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Prevent IDE boot ops on NUMA system in mainline
Date: Mon, 11 Feb 2008 09:33:14 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802110929230.2920@woody.linux-foundation.org>
References: <20080211003520.GA32082@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52103 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759980AbYBKRft (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Feb 2008 12:35:49 -0500
In-Reply-To: <20080211003520.GA32082@basil.nowhere.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org



On Mon, 11 Feb 2008, Andi Kleen wrote:
> 
> Without this patch a Opteron test system here oopses at boot with currentg git. 
> 
> Calling to_pci_dev() on a NULL pointer gives a negative value so the following NULL 
> pointer check never triggers and then an illegal address is referenced. Check the 
> unadjusted original device pointer for NULL instead.
> 
> Signed-off-by: Andi Kleen <ak@suse.de>
> 
> Index: linux/include/linux/ide.h
> ===================================================================
> --- linux.orig/include/linux/ide.h
> +++ linux/include/linux/ide.h
> @@ -1294,7 +1294,7 @@ static inline void ide_dump_identify(u8 
>  static inline int hwif_to_node(ide_hwif_t *hwif)
>  {
>  	struct pci_dev *dev = to_pci_dev(hwif->dev);
> -	return dev ? pcibus_to_node(dev->bus) : -1;
> +	return hwif->dev ? pcibus_to_node(dev->bus) : -1;
>  }

Ok, I applied this, but it causes a *lot* of noise about "unused variable 
'dev'" because pcibus_to_node() is defined to be -1 when you don't do any 
strange NUMA thing (so that "dev->bus" usage thing is never even seen by 
the compiler.

So we should probably make pcibus_to_node() be an inline function for that 
case, or just make that thing be

	return hwif->dev ?
		pcibus_to_node(to_pci_dev(hwif->dev)->bus)
	       :
		-1;

or something. Because now things are really noisy.

Preferences, anybody? Bartlomiej?

		Linus
