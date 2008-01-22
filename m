From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Palmchip BK3710 IDE driver
Date: Tue, 22 Jan 2008 14:37:52 +0000
Message-ID: <20080122143752.4e4de447@lxorguk.ukuu.org.uk>
References: <200801212144.29511.asalnikov@ru.mvista.com>
	<20080121195148.146741ca@lxorguk.ukuu.org.uk>
	<200801221511.37372.asalnikov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39515 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752035AbYAVOkE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jan 2008 09:40:04 -0500
In-Reply-To: <200801221511.37372.asalnikov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Salnikov <asalnikov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

On Tue, 22 Jan 2008 15:11:37 +0300
Anton Salnikov <asalnikov@ru.mvista.com> wrote:

> > > +static inline u32 ioread(u32 reg)
> > > +{
> > > +	return ioread32(base + reg);
> > > +}
> > > +
> > > +static inline void iowrite(u32 val, u32 reg)
> > > +{
> > > +	iowrite32(val, base + reg);
> > > +}
> > 
> > Why not just use ioread32/iowrite32 directly ?
> 
> Because this increases readability and does not affect functionality at all

There I would disagree. It means that if you ever have a system with two
of these controllers in future it will break as base is a static for the
entire driver.

Easy enough to fix with a simple
	
	static inline u32 hwif_ioread32(hwif, u32 reg) { ...
hwif->dma_base ...}

version ?

Alan
