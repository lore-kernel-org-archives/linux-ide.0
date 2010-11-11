From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Export ahci eSATA attribute
Date: Thu, 11 Nov 2010 00:06:18 -0500
Message-ID: <4CDB79CA.6000606@garzik.org>
References: <4CDB63E7.1040106@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58880 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704Ab0KKFGW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Nov 2010 00:06:22 -0500
Received: by vws13 with SMTP id 13so159280vws.19
        for <linux-ide@vger.kernel.org>; Wed, 10 Nov 2010 21:06:21 -0800 (PST)
In-Reply-To: <4CDB63E7.1040106@cfl.rr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: linux-ide@vger.kernel.org

> +++ b/include/linux/libata.h
> @@ -203,6 +203,7 @@ enum {
>  					      * management */
>  	ATA_FLAG_SW_ACTIVITY	= (1 << 22), /* driver supports sw activity
>  					      * led */
> +	ATA_FLAG_EXTERN		= (1 << 23), /* eSATA external port */
>
>  	/* bits 24:31 of ap->flags are reserved for LLD specific flags */


hmmm, I don't think we need a libata-wide flag just for an AHCI-specific 
attribute.  Certainly eSATA exists elsewhere, but so far this is just 
for print-out purposes, and so, seems wasteful.

	Jeff



