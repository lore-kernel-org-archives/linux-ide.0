From: Horms <horms@verge.net.au>
Subject: #undef ATA_ENABLE_PATA
Date: Fri, 26 Aug 2005 13:36:03 +0900
Message-ID: <20050826043601.GY6418__20124.8907055289$1125046116$gmane$org@verge.net.au>
References: <20050723192433.GA25240@canonical.org> <20050723201010.GE6913@bugs.debian.org> <20050723223744.GA18882@canonical.org> <20050724091729.GF6913@bugs.debian.org> <20050724140705.GA6942@canonical.org> <20050725035430.GJ10254@verge.net.au> <20050826032417.GA6065@canonical.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from koto.vergenet.net ([210.128.90.7]:14008 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1751509AbVHZEqs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Aug 2005 00:46:48 -0400
Content-Disposition: inline
In-Reply-To: <20050826032417.GA6065@canonical.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Brett Smith <debbug@brettcsmith.org>, 319659@bugs.debian.org

Hi Jeff, Hi All,

In the cause of debuging a problem with a DVD burner[1]
Brett Smith brought to my attention that there are several
variables in ./include/linux/libata.h, that when changed
from #undef to #define, enable features in the ATA subsystem.

Is there any interest in a patch to make any/all of these configurable
through Kconfig, or are they too hackish/dangerous/whatever to consider.
I'm more than happy to make a patch if there is interest, please let me
know wither way.

Specifically, I am refering to:

/*
 * compile-time options
 */
#undef ATA_DEBUG                /* debugging output */
#undef ATA_VERBOSE_DEBUG        /* yet more debugging output */
#undef ATA_IRQ_TRAP             /* define to ack screaming irqs */
#undef ATA_NDEBUG               /* define to disable quick runtime checks */
#undef ATA_ENABLE_ATAPI         /* define to enable ATAPI support */
#undef ATA_ENABLE_PATA          /* define to enable PATA support in some
                                 * low-level drivers */
#undef ATAPI_ENABLE_DMADIR      /* enables ATAPI DMADIR bridge support */


[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=319659

-- 
Horms
