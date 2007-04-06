From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] IDE: fix PCI must_checks
Date: Fri, 6 Apr 2007 18:41:11 +0100
Message-ID: <20070406184111.3976a089@the-village.bc.nu>
References: <20070404213704.224128ec.randy.dunlap@oracle.com>
	<20070405121302.1206e748@the-village.bc.nu>
	<20070405130330.f5f8a2a6.akpm@linux-foundation.org>
	<20070405211609.5263d627@the-village.bc.nu>
	<20070405142001.6610749a.akpm@linux-foundation.org>
	<4615D532.1070704@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50746 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751613AbXDHSQA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Apr 2007 14:16:00 -0400
In-Reply-To: <4615D532.1070704@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, ide <linux-ide@vger.kernel.org>, bzolnier@gmail.com


> That's fine with me.  Any comments on that, Alan?
> 
> I'm not sure that I like the proposed return values of
> pci_try_set_mwi(), but I'm easy.

Ditto on the return codes - we can just return -EOPNOTSUPP for
unsupported stuff and be saner.

