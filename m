From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/5] libata: kill unused constants
Date: Wed, 04 Jun 2008 06:29:54 -0400
Message-ID: <48466EA2.8050409@garzik.org>
References: <12112174741373-git-send-email-htejun@gmail.com> <12112174751732-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46847 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752334AbYFDK3z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Jun 2008 06:29:55 -0400
In-Reply-To: <12112174751732-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, liml@rtr.ca

Tejun Heo wrote:
> Kill a few unused constants.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  include/linux/libata.h |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 95a2000..989088e 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -111,13 +111,10 @@ enum {
>  	/* various global constants */
>  	LIBATA_MAX_PRD		= ATA_MAX_PRD / 2,
>  	LIBATA_DUMB_MAX_PRD	= ATA_MAX_PRD / 4,	/* Worst case */
> -	ATA_MAX_PORTS		= 8,
>  	ATA_DEF_QUEUE		= 1,
>  	/* tag ATA_MAX_QUEUE - 1 is reserved for internal commands */
>  	ATA_MAX_QUEUE		= 32,
>  	ATA_TAG_INTERNAL	= ATA_MAX_QUEUE - 1,
> -	ATA_MAX_BUS		= 2,
> -	ATA_DEF_BUSY_WAIT	= 10000,
>  	ATA_SHORT_PAUSE		= (HZ >> 6) + 1,

applied


