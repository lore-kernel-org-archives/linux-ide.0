From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 12/20] libata-core: convert to use cancel_rearming_delayed_work()
Date: Fri, 11 May 2007 18:15:44 -0400
Message-ID: <4644EB10.5010307@garzik.org>
References: <200705110548.l4B5mr2h007648@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43654 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760444AbXEKWPv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 May 2007 18:15:51 -0400
In-Reply-To: <200705110548.l4B5mr2h007648@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, oleg@tv-sign.ru

akpm@linux-foundation.org wrote:
> From: Oleg Nesterov <oleg@tv-sign.ru>
> 
> We should not use cancel_work_sync(delayed_work->work). This works, but not
> good. We can use cancel_rearming_delayed_work(), this also simplifies the
> code.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/libata-core.c |   44 +++---------------------------------
>  include/linux/libata.h    |    1 
>  2 files changed, 4 insertions(+), 41 deletions(-)

Agreed with Tejun, this can be cleaned up further.  OK with general approach


