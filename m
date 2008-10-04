From: Tejun Heo <tj@kernel.org>
Subject: Re: pata_ninja32 plea
Date: Sun, 05 Oct 2008 05:21:43 +0900
Message-ID: <48E7D057.8040604@kernel.org>
References: <Pine.LNX.4.64.0810041846250.13914@dolores.lan> <20081004183010.0809322b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59970 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751700AbYJDUXt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 4 Oct 2008 16:23:49 -0400
In-Reply-To: <20081004183010.0809322b@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bbee <bumble.bee@xs4all.nl>, linux-ide@vger.kernel.org, alan@redhat.com

Alan Cox wrote:
>> is something that will make it perform great on linux, all it would take is 
>> someone with a lot more clue than me to take a look at it.
>>
>> Anyone willing to take a look? Alan?
> 
> There is siome minimal information in the FreeBSD driver but they never
> got DMA to work properly AFAIK. If you want DMA support you'll have to go
> do the work to document DMA mode and I suspect it would be quite
> substantial work.

~10MB/s w/ < 25% cpu load doesn't sound like DMA.  It sounds more like
32bit PIO, no?

-- 
tejun
