From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: disable_irq() during polling IDENTIFY
Date: Mon, 7 May 2007 15:28:56 +0100
Message-ID: <20070507152856.5e817490@the-village.bc.nu>
References: <463EAB4D.3000309@tw.ibm.com>
	<463ED8B9.4060501@gmail.com>
	<463F0B25.40103@tw.ibm.com>
	<463F0DAD.5060307@gmail.com>
	<463F1374.1010100@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60867 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933999AbXEGOZa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 May 2007 10:25:30 -0400
In-Reply-To: <463F1374.1010100@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: albertcc@tw.ibm.com, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

> This reminds me of a possible issue with the patch:
> Previously the polling code assumes that the interrupt handler won't interfere
> with it and the polling code runs without holding ap->lock.
> However, with the above patch, the interrupt handler might read the
> Status register when the polling code is transfering data, etc. from the port.
> Would this cause trouble to the ATA/ATAPI devices?

Oh yes, and also some controllers will corrupt their data stream if you
do this during a PIO transfer of a block of ATA data.

Alan
