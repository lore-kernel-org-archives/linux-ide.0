From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [PATCH 3/3] ide: move dcache flushing to generic ide code
Date: Tue, 2 Mar 2010 22:14:15 +0100
Message-ID: <20100302211414.GA4065@Chamillionaire.breakpoint.cc>
References: <1267371341-16684-4-git-send-email-sebastian@breakpoint.cc>
 <20100228.183417.52179576.davem@davemloft.net>
 <20100301195858.GA27906@Chamillionaire.breakpoint.cc>
 <20100301.163959.177031088.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:52423 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752117Ab0CBVOT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Mar 2010 16:14:19 -0500
Content-Disposition: inline
In-Reply-To: <20100301.163959.177031088.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: sebastian@breakpoint.cc, ralf@linux-mips.org, linux-mips@linux-mips.org, linux-ide@vger.kernel.org

* David Miller | 2010-03-01 16:39:59 [-0800]:

>All buffers passed to the architecture IDE ops should be PAGE_OFFSET
>relative kernel virtual addresses for which __pa() works.
>
>Are kmap()'d things ending up here?
Ah, bounce buffers are used. So no, there no highmem which get kmap()ed.

Sebastian
