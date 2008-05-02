From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 12/12] sata_mv NCQ-EH for FIS-based switching
Date: Fri, 02 May 2008 08:44:14 -0400
Message-ID: <481B0C9E.80008@rtr.ca>
References: <481AAF84.40501@rtr.ca> <481AAFB7.4090708@rtr.ca> <481AAFE0.9090101@rtr.ca> <481AB00A.3000206@rtr.ca> <481AB03A.60808@rtr.ca> <481AB070.9050707@rtr.ca> <481AB0A1.3040009@rtr.ca> <481AB0D2.3070103@rtr.ca> <481AB107.701@rtr.ca> <481AB12A.3030102@rtr.ca> <481AB15D.5020201@rtr.ca> <481AB189.3070705@rtr.ca> <481AB1B4.7050508@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2254 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757724AbYEBMoQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 May 2008 08:44:16 -0400
In-Reply-To: <481AB1B4.7050508@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>

By the way.  If anyone can point out an existing EXPORTed
"count number of one bits" in a word function, then I'll very happily
submit a followup patch to remove this (below) and use that instead.

..
> +static int mv_count_pmp_links(unsigned int pmp_map)
> +{
> +    unsigned int link_count = 0;
> +
> +    while (pmp_map) {
> +        link_count += (pmp_map & 1);
> +        pmp_map >>= 1;
> +    }
> +    return link_count;
> +} 
..

I grepped for one, but didn't find one.
But there must be several of them already out there (?)
Speed is unimportant here, so this version above
has been left simple -- no table lookups.
