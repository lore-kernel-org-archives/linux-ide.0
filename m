From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: wrap schedule_timeout_uninterruptible() in loop
Date: Tue, 09 Oct 2007 21:41:04 -0400
Message-ID: <470C2DB0.1000108@garzik.org>
References: <20071009055833.GH12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41729 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753868AbXJJBlG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Oct 2007 21:41:06 -0400
In-Reply-To: <20071009055833.GH12186@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Tasks in uninterruptible sleep might be woken up by unrelated events
> and should check whether the condition it was waiting for has actually
> triggered.  Wrap schedule_timeout_uninterruptible() in loop to achieve
> it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-eh.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

applied


