From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: fix locking around blk_abort_request()
Date: Thu, 22 Apr 2010 21:52:31 -0400
Message-ID: <4BD0FD5F.2090004@garzik.org>
References: <4BC65671.6000309@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45141 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754855Ab0DWBwe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Apr 2010 21:52:34 -0400
Received: by gwj19 with SMTP id 19so2455648gwj.19
        for <linux-ide@vger.kernel.org>; Thu, 22 Apr 2010 18:52:32 -0700 (PDT)
In-Reply-To: <4BC65671.6000309@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 04/14/2010 07:57 PM, Tejun Heo wrote:
> blk_abort_request() expectes queue lock to be held by the caller.
> Grab it before calling the function.
>
> Lack of this synchronization led to infinite loop on corrupt
> q->timeout_list.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Cc: Jens Axboe<axboe@kernel.dk>
> Cc: stable@kernel.org
> ---
>   drivers/ata/libata-eh.c |    4 ++++
>   1 file changed, 4 insertions(+)

applied


