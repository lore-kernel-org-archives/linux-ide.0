From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream] libata: clear eh_info on reset completion
Date: Tue, 28 Jul 2009 21:20:06 -0400
Message-ID: <4A6FA3C6.4090009@garzik.org>
References: <4A5FE8D9.2040702@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40818 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754729AbZG2BUH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Jul 2009 21:20:07 -0400
In-Reply-To: <4A5FE8D9.2040702@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Zdenek Kaspar <zkaspar82@gmail.com>

Tejun Heo wrote:
> Resets are done with port frozen but some controllers still issue
> interrupts during reset and they may end up recording error conditions
> in ehi leading to unnecessary EH retrials.
> 
> This patch makes ata_eh_reset() clear ehi on reset completion.  As
> reset is the most severe recovery action, there's nothing to lose by
> clearing ehi on its completion.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Zdenek Kaspar <zkaspar82@gmail.com>
> ---
> Zdenek, I moved the clearing above a bit.  It should work the same but
> can you please test this one too?
> 
> Jeff, after Zdenek's verification, please commit this to #upstream.
> 
> Thanks.
> 
>  drivers/ata/libata-eh.c |   12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

applied


