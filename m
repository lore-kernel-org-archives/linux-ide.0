From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 5/11v2] ata: replace macro with static inline in
 libata.h
Date: Fri, 15 Feb 2008 22:53:39 +0000
Message-ID: <20080215225339.0e2ed4e6@core>
References: <1203113215.15275.53.camel@brick>
	<20080215223036.2111edd5@core>
	<1203115574.30938.6.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40408 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757481AbYBOXBq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Feb 2008 18:01:46 -0500
In-Reply-To: <1203115574.30938.6.camel@brick>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide <linux-ide@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

> > NAK. This is a sparse bug, fix sparse.
> 
> Yes, fair enough, but that's not all the patch is about.
> 
> 1) it's using a max_t and min_t to force the comparisons as shorts, why
> not just make it a static inline?

Because max_t and min_t also force the comparsion types

> 2) the static inline is a little clearer about the intent here.

Why ?

> 3) the sparse warnings are entirely secondary (and technically correct
> when the macros expand, __x is shadowed)

In a controlled manner. I guess you could make min and max use __x and __y

> 4) I may be mistaken, but I thought then when something can be written
> as a static inline instead of a macro it was preferred. At least I've
> seen akpm say so, but I'll let him speak for himself (added to CC:)

gcc still sometimes seems to optimise macros better than inlines.

Alan
