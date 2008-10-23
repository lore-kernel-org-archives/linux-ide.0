From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] pci: use pci_ioremap_bar() in drivers/ide
Date: Thu, 23 Oct 2008 21:39:24 +0200
Message-ID: <200810232139.24427.bzolnier@gmail.com>
References: <20081020214830.1586704c@infradead.org> <20081022132346.38fbc84a@infradead.org> <48FF8F3B.1090302@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.191]:1076 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473AbYJWVty (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Oct 2008 17:49:54 -0400
Received: by gv-out-0910.google.com with SMTP id e6so111620gvc.37
        for <linux-ide@vger.kernel.org>; Thu, 23 Oct 2008 14:49:53 -0700 (PDT)
In-Reply-To: <48FF8F3B.1090302@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-ide@vger.kernel.org

On Wednesday 22 October 2008, Sergei Shtylyov wrote:
> Arjan van de Ven wrote:
> 
> >>>>Use the newly introduced pci_ioremap_bar() function in drivers/ide.
> >>>>pci_ioremap_bar() just takes a pci device and a bar number, with
> >>>>the goal of making it really hard to get wrong, while also having
> >>>>a central place to stick sanity checks.
> 
> >>>>Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> 
> >>>Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> >>    No, I'm takign back my ACK.
> >>    Since the patch intends to address all drivers/ide/, it's clearly
> >>no compolete -- siimage.c and scc_pata.c beg for the alike change (it
> >>will even permit to kill 4 local variables in the latter driver).
> 
> > like this ?
> 
>     Exactly.
> 
> > From 3f88a6936f7802a5d4af6c54a1ef353d14ff1ab2 Mon Sep 17 00:00:00 2001
> > From: Arjan van de Ven <arjan@linux.intel.com>
> > Date: Wed, 22 Oct 2008 13:21:07 -0700
> > Subject: [PATCH] ide: two more pci_ioremap_bar() conversions
> 
> > based on suggestion from Sergei Shtylyov, there are two more places
> > where using pci_ioremap_bar() makes sense.
> 
> > Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
