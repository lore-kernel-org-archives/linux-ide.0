From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] IDE: fix PCI must_checks
Date: Thu, 5 Apr 2007 21:16:09 +0100
Message-ID: <20070405211609.5263d627@the-village.bc.nu>
References: <20070404213704.224128ec.randy.dunlap@oracle.com>
	<20070405121302.1206e748@the-village.bc.nu>
	<20070405130330.f5f8a2a6.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51740 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1767284AbXDEUOW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Apr 2007 16:14:22 -0400
In-Reply-To: <20070405130330.f5f8a2a6.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, ide <linux-ide@vger.kernel.org>, bzolnier@gmail.com

> pci_set_mwi() is an advisory thing, and on certain platforms it might fail
> to set the cacheline size to the desired number.  This is not a fatal error
> and the driver can successfully run at a lesser performance level.

Correct.

> If that description is accurate then I'd contend that pci_set_mwi() is
> misdesigned.  It should not be returning a negative error code for
> something which is not an error.

It is an error to *some* drivers but not all. Kind of like setting some
of the other features may be essential for some chips and not others.

> And we *need* to be excessively anal in the PCI setup code.  We have metric
> shitloads of bugs due to problems in that area, and the more formality and
> error handling and error reporting we can get in there the better off we
> will be.

No argument there

If we want to deal with some of the mess we should also remove all direct
writing of PCI latency timers and replace them with a function to stop
drivers setting unsafe values and ignoring chip errata the core knows
about but they dont
