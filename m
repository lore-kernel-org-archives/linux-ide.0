From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: devres and requesting resources
Date: Fri, 29 Feb 2008 14:01:06 +0000
Message-ID: <20080229140106.41ccc843@core>
References: <47C75392.3020606@garzik.org>
	<20080229112651.5b2a7f6f@core>
	<47C7F664.5040102@garzik.org>
	<47C7FA8B.7040306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45576 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755827AbYB2OMD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Feb 2008 09:12:03 -0500
In-Reply-To: <47C7FA8B.7040306@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Linux IDE mailing list <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

> controller like ICH AHCIs.  ata_generic or ide generic might attach to a
> controller which is already being driven by ahci under certain
> configurations.

ata_generic will not nor ata_legacy both are much too smart for that. The
legacy old IDE driver might but that probably isn't going to be fixed by
devres and is trivial to fix in that driver (just steal the code from
pata_legacy).

> have different requirements can just open code pci_request_regions() and
> pcim_iomap().  pcim_request_regions() should provide sensible default
> behavior for common cases.

Which is arguably the current behaviour. Changing the behaviour and not
the name is a really bad idea and will cause problems in future so don't
do that.
>
> I think the best solution is to allow duplicate request regions for
> managed devices which is okay as we know we're holding the resource and
> let drivers which need to reserve all regions call pci_request_regions()
> before calling pcim_request_regions().

How about

	pcim_request_all_regions()

for the behaviour Jeff wants, simple, direct, differently named and
obvious what it does.

Alan
