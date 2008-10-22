From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/4] libata: Drain data on errors
Date: Wed, 22 Oct 2008 17:44:42 +0100
Message-ID: <20081022174442.08e6f265@lxorguk.ukuu.org.uk>
References: <20081017180655.7781.15021.stgit@localhost.localdomain>
	<20081017180837.7781.26372.stgit@localhost.localdomain>
	<87od1cskcv.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51813 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751085AbYJVQoq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Oct 2008 12:44:46 -0400
In-Reply-To: <87od1cskcv.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

> > +	/* Drain up to 64K of data before we give up this recovery method */
> > +	for (count = 0; (ap->ops->sff_check_status(ap) & ATA_DRQ)
> > +							&& count < 65536;)
> 
> Missing count++. Sorry for not spotting that in the previous round.

Thanks - well spotted
