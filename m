From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFT] libata hpa support
Date: Wed, 21 Mar 2007 17:40:23 +0000
Message-ID: <20070321174023.GA24527@srcf.ucam.org>
References: <20070223170625.GA29931@athena.road.mcmartin.ca> <20070321130140.GA4328@athena.road.mcmartin.ca> <20070321183455.00f4732b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:52613 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933224AbXCURkm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Mar 2007 13:40:42 -0400
Content-Disposition: inline
In-Reply-To: <20070321183455.00f4732b@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kyle McMartin <kyle@canonical.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, mjg59@ubuntu.com

On Wed, Mar 21, 2007 at 06:34:55PM +0000, Alan Cox wrote:

> I'm testing a variant of it at the moment with no problems on x86. My
> first thought would be to check for endianness problems and the like but
> I don't see any.

Macbooks are x86.

> It may also fail to allow any resizing if the Macbook issues a security
> freeze from the firmware before the OS boots, if so we won't be able to
> resize the HPA or set/change passwords on the disk. If they are doing
> that then its a fairly sensible security choice.

https://launchpad.net/ubuntu/+source/linux-source-2.6.20/+bug/91940 
gives the traces we have.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
