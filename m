From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes 1/2] libata: allow LLDs w/o any reset
 method
Date: Mon, 10 Mar 2008 20:51:39 -0400
Message-ID: <47D5D79B.8000508@garzik.org>
References: <47CF6E7E.6090201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50855 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754151AbYCKAvm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Mar 2008 20:51:42 -0400
In-Reply-To: <47CF6E7E.6090201@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>

Tejun Heo wrote:
> Some old SFF controllers don't have any way to reset the channel.
> Currently, this isn't supported and libata EH causes an oops.  Allow
> LLDs w/o any reset method and just assume ATA class in such cases.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  drivers/ata/libata-eh.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)

applied 1-2


