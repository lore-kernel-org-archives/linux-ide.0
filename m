From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] pci: use pci_ioremap_bar() in drivers/ide
Date: Thu, 23 Oct 2008 21:35:35 +0200
Message-ID: <200810232135.36757.bzolnier@gmail.com>
References: <20081020214830.1586704c@infradead.org> <48FDA8BF.20206@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.191]:1076 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535AbYJWVt4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Oct 2008 17:49:56 -0400
Received: by gv-out-0910.google.com with SMTP id e6so111620gvc.37
        for <linux-ide@vger.kernel.org>; Thu, 23 Oct 2008 14:49:55 -0700 (PDT)
In-Reply-To: <48FDA8BF.20206@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-ide@vger.kernel.org

On Tuesday 21 October 2008, Sergei Shtylyov wrote:
> Hello.
> 
> Arjan van de Ven wrote:
> 
> > Use the newly introduced pci_ioremap_bar() function in drivers/ide.
> > pci_ioremap_bar() just takes a pci device and a bar number, with the goal
> > of making it really hard to get wrong, while also having a central place
> > to stick sanity checks.
> >
> > Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
