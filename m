From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PIO with SSDs: needs a long DRQ-after-command timeout for
 WRITEs
Date: Tue, 30 Dec 2008 13:59:02 +0000
Message-ID: <20081230135902.560267dc@lxorguk.ukuu.org.uk>
References: <495A27E3.50801@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:33488 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751581AbYL3OCG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Dec 2008 09:02:06 -0500
In-Reply-To: <495A27E3.50801@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alan Cox <alan@redhat.com>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

> So.. how long does libata and current IDE allow for initial DRQ assertion?
> It should probably be at least 500msec or more now.

I think we need to rewrite the PIO code paths to use disable/enable_irq
masking first before getting into adding long delays on PIO paths.

Alan
