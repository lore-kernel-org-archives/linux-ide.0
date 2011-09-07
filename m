From: David Miller <davem@davemloft.net>
Subject: Re: Bug#590327: linux-image-2.6.32-5-amd64: Unbalanced enable for
 IRQ 19
Date: Wed, 07 Sep 2011 00:39:31 -0400 (EDT)
Message-ID: <20110907.003931.1112417911793078586.davem@davemloft.net>
References: <20110729151848.GA24689@pisco.westfalen.local>
	<20110731184933.GA2442@goneko.de>
	<1315368967.3092.430.camel@deadeye>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:53941 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237Ab1IGEjq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Sep 2011 00:39:46 -0400
In-Reply-To: <1315368967.3092.430.camel@deadeye>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ben@decadent.org.uk
Cc: linux-ide@vger.kernel.org, 590327@bugs.debian.org, jan@goneko.de

From: Ben Hutchings <ben@decadent.org.uk>
Date: Wed, 07 Sep 2011 05:16:01 +0100

> This is somewhat unusual in that the IDE controller will be sharing its
> IRQ, but that's supposed to work.
> 
> However, the IDE core attempts to disable and enable the IRQ *before* it
> allocates it.  If the UHCI driver then allocates the IRQ in the middle
> of this, the IRQ manager will reset the disable count since the IRQ is
> not yet shared!
> 
> This might be fixable by changing the IDE core to allocate the IRQ with
> a dummy interrupt handler while probing.
> 
> Aside from that, maybe pata_it8213 is ready as a replacement for it8213
> now?  (Kconfig still labels it as EXPERIMENTAL.)

I've known about this IDE layer problem for at least a year and any
fix is too risky to consider seriously.

Use the PATA drivers on modern systems, don't use the deprecated IDE
layer.
