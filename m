From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: #undef ATA_ENABLE_PATA
Date: Fri, 26 Aug 2005 05:30:04 -0400
Message-ID: <430EE11C.5040409@pobox.com>
References: <20050723192433.GA25240@canonical.org>	 <20050723201010.GE6913@bugs.debian.org>	 <20050723223744.GA18882@canonical.org>	 <20050724091729.GF6913@bugs.debian.org>	 <20050724140705.GA6942@canonical.org> <20050725035430.GJ10254@verge.net.au>	 <20050826032417.GA6065@canonical.org>  <20050826043601.GY6418@verge.net.au> <1125046140.10546.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:15525 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932249AbVHZJaX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Aug 2005 05:30:23 -0400
In-Reply-To: <1125046140.10546.17.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: Horms <horms@verge.net.au>, 319659@bugs.debian.org, Brett Smith <debbug@brettcsmith.org>, linux-ide@vger.kernel.org

Erik Slagter wrote:
> On Fri, 2005-08-26 at 13:36 +0900, Horms wrote:
> 
> 
>>#undef ATA_ENABLE_ATAPI         /* define to enable ATAPI support */
>>#undef ATA_ENABLE_PATA          /* define to enable PATA support in some
> 
> 
> These two would very interesting to me to be included in Kconfig.

Neither of these are ready for prime time, with known problems.  Move 
them to Kconfig, and I have to deal with the bug reports.  No thanks...

	Jeff


