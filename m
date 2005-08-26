From: Horms <horms@verge.net.au>
Subject: Re: #undef ATA_ENABLE_PATA
Date: Fri, 26 Aug 2005 14:44:59 +0900
Message-ID: <20050826054457.GA18638@verge.net.au>
References: <20050723192433.GA25240@canonical.org> <20050723201010.GE6913@bugs.debian.org> <20050723223744.GA18882@canonical.org> <20050724091729.GF6913@bugs.debian.org> <20050724140705.GA6942@canonical.org> <20050725035430.GJ10254@verge.net.au> <20050826032417.GA6065@canonical.org> <20050826043601.GY6418@verge.net.au> <430EA0BB.6080801@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from koto.vergenet.net ([210.128.90.7]:56504 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S932180AbVHZFrR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Aug 2005 01:47:17 -0400
Content-Disposition: inline
In-Reply-To: <430EA0BB.6080801@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Brett Smith <debbug@brettcsmith.org>, 319659@bugs.debian.org

On Fri, Aug 26, 2005 at 12:55:23AM -0400, Jeff Garzik wrote:
> Horms wrote:
> >Hi Jeff, Hi All,
> >
> >In the cause of debuging a problem with a DVD burner[1]
> >Brett Smith brought to my attention that there are several
> >variables in ./include/linux/libata.h, that when changed
> >from #undef to #define, enable features in the ATA subsystem.
> >
> >Is there any interest in a patch to make any/all of these configurable
> >through Kconfig, or are they too hackish/dangerous/whatever to consider.
> >I'm more than happy to make a patch if there is interest, please let me
> >know wither way.
> >
> >Specifically, I am refering to:
> >
> >/*
> > * compile-time options
> > */
> >#undef ATA_DEBUG                /* debugging output */
> >#undef ATA_VERBOSE_DEBUG        /* yet more debugging output */
> 
> These should go away, once ATA_MSG_xxx is implemented (a la NETIF_MSG_xxx).
> 
> 
> >#undef ATA_IRQ_TRAP             /* define to ack screaming irqs */
> >#undef ATA_NDEBUG               /* define to disable quick runtime checks 
> >*/
> >#undef ATA_ENABLE_ATAPI         /* define to enable ATAPI support */
> >#undef ATA_ENABLE_PATA          /* define to enable PATA support in some
> >                                 * low-level drivers */
> >#undef ATAPI_ENABLE_DMADIR      /* enables ATAPI DMADIR bridge support */
> 
> These are all things that are either incomplete, or should not be 
> configured by non-developers.
> 
> When something is safe to turn on in the upstream kernel, it gets turned 
> on :)  This is why ATAPI defaults to off, even though some silly distros 
> turn it on.

Thanks Jeff, I suspected something along those lines.

-- 
Horms
