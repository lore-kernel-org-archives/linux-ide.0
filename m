From: Andi Kleen <andi@firstfloor.org>
Subject: Re: AMD64 dma_alloc_coherent crashes on non PCI device (was SATA open bugs)
Date: Fri, 10 Aug 2007 01:08:58 +0200
Message-ID: <20070809230858.GA1845@one.firstfloor.org>
References: <46BA9101.6080407@gmail.com> <20070809145336.6d728f9b@the-village.bc.nu> <20070809170540.GA30700@one.firstfloor.org> <20070809182101.710c3c5b@the-village.bc.nu> <20070809172304.GB30700@one.firstfloor.org> <20070809185310.682dffbc@the-village.bc.nu> <20070809192850.GA32280@one.firstfloor.org> <20070809233458.12d8447c@the-village.bc.nu> <20070809224305.GA1611@one.firstfloor.org> <20070810001443.610185e1@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:48288 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805AbXHIXJC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 19:09:02 -0400
Content-Disposition: inline
In-Reply-To: <20070810001443.610185e1@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <andi@firstfloor.org>, Tejun Heo <htejun@gmail.com>, Natalie Protasevich <protasnb@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>


I'll submit a patch to check this in my next batch.

But as James pointed out you'll likely need similar patches on other
architectures.

-Andi
