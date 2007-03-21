From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFT] libata hpa support
Date: Wed, 21 Mar 2007 17:58:16 +0000
Message-ID: <20070321175816.GA25053@srcf.ucam.org>
References: <20070223170625.GA29931@athena.road.mcmartin.ca> <20070321130140.GA4328@athena.road.mcmartin.ca> <20070321183455.00f4732b@lxorguk.ukuu.org.uk> <20070321174023.GA24527@srcf.ucam.org> <20070321185159.20ade94b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:51770 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbXCUR6a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Mar 2007 13:58:30 -0400
Content-Disposition: inline
In-Reply-To: <20070321185159.20ade94b@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kyle McMartin <kyle@canonical.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, mjg59@ubuntu.com

On Wed, Mar 21, 2007 at 06:51:59PM +0000, Alan Cox wrote:
> > https://launchpad.net/ubuntu/+source/linux-source-2.6.20/+bug/91940 
> > gives the traces we have.
> 
> Wrong bug number ? - seems to be nothing there that looks HPA related at
> all

That's with Kyle's HPA code - reverting it results in that failure 
vanishing.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
