From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Palmchip BK3710 IDE driver
Date: Wed, 23 Jan 2008 14:59:41 +0000
Message-ID: <20080123145941.4bdd01e1@lxorguk.ukuu.org.uk>
References: <200801212144.29511.asalnikov@ru.mvista.com>
	<4796526F.1090103@ru.mvista.com>
	<20080122222207.18221939@lxorguk.ukuu.org.uk>
	<4797433E.4040707@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35299 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750767AbYAWPCP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jan 2008 10:02:15 -0500
In-Reply-To: <4797433E.4040707@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Anton Salnikov <asalnikov@ru.mvista.com>, linux-ide@vger.kernel.org, bzolnier@gmail.com

On Wed, 23 Jan 2008 16:38:06 +0300
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Hello.
> 
> Alan Cox wrote:
> 
> >>    Why you chose to use ioread32() and iowrite32() if your device is strictly 
> >>memory mapped? Those functions add some overhead, and boil down to readl() and 
> 
> > There are distinct portability advantages but you shouldn't mix
> > ioread32/iowrite32 with ioremap as that isn't guaranteed to work.
> 
>     Hm, pci_iomap() boils down to ioremap(), so

For most cases on existing hardware. Do not rely on that in future.

Alan
