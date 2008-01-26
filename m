From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 15/14] sata_mv NCQ support
Date: Fri, 25 Jan 2008 23:28:51 -0500
Message-ID: <479AB703.8010305@pobox.com>
References: <4798FB68.70400@rtr.ca> <4799277F.8020300@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47949 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755778AbYAZE2x (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Jan 2008 23:28:53 -0500
In-Reply-To: <4799277F.8020300@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Mark Lord wrote:
> sata_mv Add missing qc_defer op.
> 
> This is necessary now that we support NCQ in the driver.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> ---
> Who says a 14-patch series cannot have a 15th patch?  :)
> 
> --- old/drivers/ata/sata_mv.c    2008-01-24 18:55:12.000000000 -0500
> +++ new/drivers/ata/sata_mv.c    2008-01-24 18:57:21.000000000 -0500
> @@ -558,6 +558,7 @@
>     .post_internal_cmd    = mv_post_int_cmd,
>     .freeze            = mv_eh_freeze,
>     .thaw            = mv_eh_thaw,
> +    .qc_defer        = ata_std_qc_defer,
> 
>     .scr_read        = mv_scr_read,
>     .scr_write        = mv_scr_write,
> @@ -586,6 +587,7 @@
>     .post_internal_cmd    = mv_post_int_cmd,
>     .freeze            = mv_eh_freeze,
>     .thaw            = mv_eh_thaw,
> +    .qc_defer        = ata_std_qc_defer,
> 
>     .scr_read        = mv_scr_read,
>     .scr_write        = mv_scr_write,

ACK; I would combine this with the NCQ-enable patch near the end of the 
series (patch #12 in this series)


