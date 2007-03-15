From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_pdc2027x: Restore various updates done on the
 driver
Date: Thu, 15 Mar 2007 12:00:40 +0000
Message-ID: <20070315120040.278b2d82@lxorguk.ukuu.org.uk>
References: <20070308233920.7371d07d@lxorguk.ukuu.org.uk>
	<45F8E206.2000206@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36551 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932205AbXCOK5y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Mar 2007 06:57:54 -0400
In-Reply-To: <45F8E206.2000206@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

> > +	/* If the master is a maxtor in UDMA6 then the slave should not use UDMA 6 */
> > +	if(strstr(model_num, "Maxtor") == 0 && pair->dma_mode == XFER_UDMA_6)
> > +		mask &= ~ (1 << (6 + ATA_SHIFT_UDMA));
> 
> Some Maxtor drives have "Maxtor" while others have "MAXTOR" in the IDENTIFY data.
> Should we check both "Maxtor" and "MAXTOR" here?

I am still waiting an answer from Jeff on this.
