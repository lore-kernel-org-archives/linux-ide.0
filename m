From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH/RFC 2/3] libata: move err_mask to ata_queued_cmd
Date: Wed, 09 Nov 2005 01:25:52 -0500
Message-ID: <43719670.20708@pobox.com>
References: <437181D5.8070903@tw.ibm.com> <43718400.5000409@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:47839 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030419AbVKIGZ5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Nov 2005 01:25:57 -0500
In-Reply-To: <43718400.5000409@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>

Albert Lee wrote:
> Patch 2/3:
>   move err_mask to ata_queued_cmd.
> 
> Changes:
>   - Move the err_mask parameter of the complete functions to ata_queued_cmd.
>     This can make the err_mask more accessible outside the complete functions;
>     also makes the HSM easier to pass err_mask between states.
> 
> For your review and advice, thanks.
> 
> Albert
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com> 

This patch is OK in principle, but I would like it split up some more.

In particular, this patch seems to have mixed in some related changes 
along with the single "more err_mask to ata_queued_cmd" change itself.

	Jeff



