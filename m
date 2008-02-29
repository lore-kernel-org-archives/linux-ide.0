From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: devres and requesting resources
Date: Fri, 29 Feb 2008 11:26:51 +0000
Message-ID: <20080229112651.5b2a7f6f@core>
References: <47C75392.3020606@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59381 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752657AbYB2Lhs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Feb 2008 06:37:48 -0500
In-Reply-To: <47C75392.3020606@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Linux IDE mailing list <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

> In converting to pcim_iomap_regions(), we no longer reserve /all/ 
> regions, only the ones requested.
> 
> This is actually a bug:  it was intentional to call 
> pci_request_regions(), because that ensures that no other software will 
> use our resources -- even if we are not actively using the resource in 
> question.

That would be a bug. We should only reserve the regions we are using. It
is possible that the other regions can be used correctly by another driver
(consider the CS5520 or the MPIIX where the IDE is only part of one
function of the PCI device).

I believe the current code is in fact correct.

> Or IOW, I wanted to ensure that there would be no device sharing... 
> which this devres conversion accidentally enabled.

Why ?

> The simple fix is obviously to replace pci_request_region() call with 
> pci_request_regions() in lib/devres.c, but I wonder if that will break 
> any existing driver?

It would make devres mostly useless especially outside of libata.

Alan
