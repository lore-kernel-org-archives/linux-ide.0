From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 03/11] libata-core: convert to use cancel_rearming_delayed_work()
Date: Tue, 10 Jul 2007 20:55:14 -0400
Message-ID: <46942A72.90401@garzik.org>
References: <200707091846.l69IkDHc001371@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37334 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754481AbXGKAzT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Jul 2007 20:55:19 -0400
In-Reply-To: <200707091846.l69IkDHc001371@imap1.linux-foundation.org>
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

applied


