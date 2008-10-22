From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] pci: use pci_ioremap_bar() in drivers/ide
Date: Wed, 22 Oct 2008 10:56:08 -0700
Message-ID: <20081022105608.51ac9a6f@infradead.org>
References: <20081020214830.1586704c@infradead.org>
	<48FDA8BF.20206@ru.mvista.com>
	<48FF6595.5040203@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:58820 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbYJVRz5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Oct 2008 13:55:57 -0400
In-Reply-To: <48FF6595.5040203@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Wed, 22 Oct 2008 21:40:37 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Hello, I wrote:
> 
> >> Use the newly introduced pci_ioremap_bar() function in drivers/ide.
> >> pci_ioremap_bar() just takes a pci device and a bar number, with
> >> the goal of making it really hard to get wrong, while also having
> >> a central place to stick sanity checks.
> 
> >> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> 
> > Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
>     No, I'm takign back my ACK.
>     Since the patch intends to address all drivers/ide/, it's clearly
> no compolete -- siimage.c and scc_pata.c beg for the alike change (it
> will even permit to kill 4 local variables in the latter driver).
> 
> MBR, Sergei

I'll be happy to take a second pass, but "doesn't convert everyone"
shouldn't really be a reason to do the first pass ;-)

-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
