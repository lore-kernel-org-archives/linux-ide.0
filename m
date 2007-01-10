From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: hwif->rw_disk() method
Date: Wed, 10 Jan 2007 17:10:15 +0000
Message-ID: <20070110171015.5320fa17@localhost.localdomain>
References: <45A514AB.2080605@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51867 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S964952AbXAJQ7Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Jan 2007 11:59:24 -0500
In-Reply-To: <45A514AB.2080605@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>

>     Alan/Bart/anybody, could you enlighten me why hwif->rw_disk() method came 
> into being at all?

When you needed to wrap entire disk operations. The ->dma_ methods only
wrap DMA commands.

For the current support hardware it can probably go, no idea if anyone
embedded uses it any more and can't be bothered to check 8)
