From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Add a drivers/ide style  DMA disable
Date: Sat, 8 Sep 2007 19:42:41 +0100
Message-ID: <20070908194241.21ca9d72@the-village.bc.nu>
References: <20070822233710.415faaf0@the-village.bc.nu>
	<46E0CC76.70101@gmail.com>
	<46E1D4FB.8030409@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46958 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754172AbXIHSec (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2007 14:34:32 -0400
In-Reply-To: <46E1D4FB.8030409@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, akpm@osdl.org, linux-ide@vger.kernel.org

> FWIW -- as I noted to Alan personally at KS, I would rather drop the 
> "pata_" and have it apply to all, PATA or SATA.

Agreed - this is a sensible path.

You can drop a patch to do that over my changes easily enough I think,
its just a rename and removing a single check.

Alan
