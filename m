From: Mark Lord <liml@rtr.ca>
Subject: Re: bad sectors, suspicious behaviour
Date: Fri, 08 Aug 2008 10:14:41 -0400
Message-ID: <489C54D1.5080901@rtr.ca>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca> <489C4F29.6020007@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:46659 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720AbYHHOOk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Aug 2008 10:14:40 -0400
In-Reply-To: <489C4F29.6020007@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Artem Bokhan <aptem@ngs.ru>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

Mark Lord wrote:
..
>>> [75703.296100] WARNING: at drivers/ata/libata-core.c:4732 
>>> ata_qc_issue+0x1ca/0x230 [libata]()
> ..
> That line is this one (linux-2.6.26.2):
> 
>        WARN_ON(ap->ops->error_handler && ata_tag_valid(link->active_tag));
> 
> So this should trigger only when link->active_tag is valid, which 
> doesn't normally happen.
> But the convoluted traceback shows that this code path came from the EH,
> so something in libata EH is likely neglecting to clear link->active_tag
> before issuing a new command. 
>
> Tejun?
..

Mmm.. since it happens only once in a while, and not on every EH action,
one might assume that it's a race of some kind.

One possibility, might be due to .qc_defer.

The stock ata_qc_defer relies heavily on ata_tag_valid(),
which matches what the above WARN_ON uses.

But sata_mv doesn't use ata_tag_valid, because it wants to know
about the entire port and not just a single individual link on the port.
So instead, it uses ap->nr_active_links for the test.

My guess is that these two items are not kept in sync during EH.

Tejun?
