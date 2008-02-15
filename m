From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH 5/11v2] ata: replace macro with static inline in
	libata.h
Date: Fri, 15 Feb 2008 15:08:50 -0800
Message-ID: <1203116930.30938.12.camel@brick>
References: <1203113215.15275.53.camel@brick> <20080215223036.2111edd5@core>
	 <1203115574.30938.6.camel@brick>  <20080215225339.0e2ed4e6@core>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:37377 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757AbYBOXIw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Feb 2008 18:08:52 -0500
Received: by rv-out-0910.google.com with SMTP id k20so616391rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 15 Feb 2008 15:08:51 -0800 (PST)
In-Reply-To: <20080215225339.0e2ed4e6@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide <linux-ide@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Fri, 2008-02-15 at 22:53 +0000, Alan Cox wrote:
> > > NAK. This is a sparse bug, fix sparse.
> > 
> > Yes, fair enough, but that's not all the patch is about.
> > 
> > 1) it's using a max_t and min_t to force the comparisons as shorts, why
> > not just make it a static inline?
> 
> Because max_t and min_t also force the comparsion types

Umm, maybe I'm missing something then, but how does the static inline
not do this?

> 
> > 2) the static inline is a little clearer about the intent here.
> 
> Why ?

OK, maybe not much clearer.  But isn't the inline easier to see at
a glance that it is returning a value constrained to be

vmin <= v <= vmax

I suppose the variable names make it clear, but the macro construction
is (slightly) less obvious.

> 
> > 3) the sparse warnings are entirely secondary (and technically correct
> > when the macros expand, __x is shadowed)
> 
> In a controlled manner. I guess you could make min and max use __x and __y
> 

__mint __maxt...but I'm not proposing that.

> > 4) I may be mistaken, but I thought then when something can be written
> > as a static inline instead of a macro it was preferred. At least I've
> > seen akpm say so, but I'll let him speak for himself (added to CC:)
> 
> gcc still sometimes seems to optimise macros better than inlines.

OK, I didn't realize that, any pointers?

Harvey

