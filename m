From: "Grant Grundler" <grundler@google.com>
Subject: Re: [PATCH 12/12] sata_mv NCQ-EH for FIS-based switching
Date: Fri, 2 May 2008 09:52:10 -0700
Message-ID: <da824cf30805020952g73ce5eabqdd5cd769286a90a6@mail.gmail.com>
References: <481AAF84.40501@rtr.ca> <481AB070.9050707@rtr.ca>
	 <481AB0A1.3040009@rtr.ca> <481AB0D2.3070103@rtr.ca>
	 <481AB107.701@rtr.ca> <481AB12A.3030102@rtr.ca>
	 <481AB15D.5020201@rtr.ca> <481AB189.3070705@rtr.ca>
	 <481AB1B4.7050508@rtr.ca> <481B0C9E.80008@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:24292 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759310AbYEBQwQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 May 2008 12:52:16 -0400
Received: from zps38.corp.google.com (zps38.corp.google.com [172.25.146.38])
	by smtp-out.google.com with ESMTP id m42GqBum027245
	for <linux-ide@vger.kernel.org>; Fri, 2 May 2008 17:52:12 +0100
Received: from rn-out-0910.google.com (rnge21.prod.google.com [10.38.207.21])
	by zps38.corp.google.com with ESMTP id m42GqAmF017807
	for <linux-ide@vger.kernel.org>; Fri, 2 May 2008 09:52:11 -0700
Received: by rn-out-0910.google.com with SMTP id e21so681971rng.6
        for <linux-ide@vger.kernel.org>; Fri, 02 May 2008 09:52:10 -0700 (PDT)
In-Reply-To: <481B0C9E.80008@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>

On Fri, May 2, 2008 at 5:44 AM, Mark Lord <liml@rtr.ca> wrote:
> By the way.  If anyone can point out an existing EXPORTed
>  "count number of one bits" in a word function, then I'll very happily
>  submit a followup patch to remove this (below) and use that instead.
>
>  ..
>
>
> > +static int mv_count_pmp_links(unsigned int pmp_map)
> > +{
> > +    unsigned int link_count = 0;
> > +
> > +    while (pmp_map) {
> > +        link_count += (pmp_map & 1);
> > +        pmp_map >>= 1;
> > +    }
> > +    return link_count;
> > +}
> >
>  ..
>
>  I grepped for one, but didn't find one.

include/asm-ia64/bitops.h:hweight64()

grundler <2186>fgrep hweight include/asm/*
include/asm/bitops_32.h:#include <asm-generic/bitops/hweight.h>
include/asm/bitops_64.h:#include <asm-generic/bitops/hweight.h>


>  But there must be several of them already out there (?)

yup.

hth,
grant

>  Speed is unimportant here, so this version above
>  has been left simple -- no table lookups.
>
>
>  --
>  To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
