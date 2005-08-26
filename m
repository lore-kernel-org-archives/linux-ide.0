From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: #undef ATA_ENABLE_PATA
Date: Fri, 26 Aug 2005 00:55:23 -0400
Message-ID: <430EA0BB.6080801@pobox.com>
References: <20050723192433.GA25240@canonical.org> <20050723201010.GE6913@bugs.debian.org> <20050723223744.GA18882@canonical.org> <20050724091729.GF6913@bugs.debian.org> <20050724140705.GA6942@canonical.org> <20050725035430.GJ10254@verge.net.au> <20050826032417.GA6065@canonical.org> <20050826043601.GY6418@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:51361 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751503AbVHZEz2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Aug 2005 00:55:28 -0400
In-Reply-To: <20050826043601.GY6418@verge.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Horms <horms@verge.net.au>
Cc: linux-ide@vger.kernel.org, Brett Smith <debbug@brettcsmith.org>, 319659@bugs.debian.org

Horms wrote:
> Hi Jeff, Hi All,
> 
> In the cause of debuging a problem with a DVD burner[1]
> Brett Smith brought to my attention that there are several
> variables in ./include/linux/libata.h, that when changed
> from #undef to #define, enable features in the ATA subsystem.
> 
> Is there any interest in a patch to make any/all of these configurable
> through Kconfig, or are they too hackish/dangerous/whatever to consider.
> I'm more than happy to make a patch if there is interest, please let me
> know wither way.
> 
> Specifically, I am refering to:
> 
> /*
>  * compile-time options
>  */
> #undef ATA_DEBUG                /* debugging output */
> #undef ATA_VERBOSE_DEBUG        /* yet more debugging output */

These should go away, once ATA_MSG_xxx is implemented (a la NETIF_MSG_xxx).


> #undef ATA_IRQ_TRAP             /* define to ack screaming irqs */
> #undef ATA_NDEBUG               /* define to disable quick runtime checks */
> #undef ATA_ENABLE_ATAPI         /* define to enable ATAPI support */
> #undef ATA_ENABLE_PATA          /* define to enable PATA support in some
>                                  * low-level drivers */
> #undef ATAPI_ENABLE_DMADIR      /* enables ATAPI DMADIR bridge support */

These are all things that are either incomplete, or should not be 
configured by non-developers.

When something is safe to turn on in the upstream kernel, it gets turned 
on :)  This is why ATAPI defaults to off, even though some silly distros 
turn it on.

	Jeff



