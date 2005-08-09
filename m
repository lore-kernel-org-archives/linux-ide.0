From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata and PATA devices
Date: Tue, 9 Aug 2005 14:01:11 -0400
Message-ID: <20050809180111.GB10315@havoc.gtf.org>
References: <200508071949.03782.inform@tiker.net> <42F6B8CD.4050100@gmail.com> <20050808030239.GA27502@havoc.gtf.org> <1123495856.22328.62.camel@localhost.localdomain> <42F8B41C.4040408@rtr.ca> <42F8B949.6070004@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:9862 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S964901AbVHISBM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Aug 2005 14:01:12 -0400
Content-Disposition: inline
In-Reply-To: <42F8B949.6070004@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, Erik Slagter <erik@slagter.name>

On Tue, Aug 09, 2005 at 10:10:17AM -0400, Mark Lord wrote:
> The PATA ATAPI works now -- perhaps it could be turned on by default
> while efforts continue to implement support for SATA ATAPI devices.

No, PATA ATAPI DMA still needs the same fixes that SATA ATAPI does.

ATAPI is incomplete, the reason why the IDE driver is preferred still.

	Jeff



