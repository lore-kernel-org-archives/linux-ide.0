From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata-core: Allow longer timeout for drive spinup from
 PUIS
Date: Wed, 30 Mar 2016 14:38:46 -0400
Message-ID: <20160330183846.GK7822@mtj.duckdns.org>
References: <539D1F09-E6EB-47F1-A66E-C182CA675359@hgst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:36522 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984AbcC3Sis (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Mar 2016 14:38:48 -0400
Received: by mail-yw0-f172.google.com with SMTP id g3so69430249ywa.3
        for <linux-ide@vger.kernel.org>; Wed, 30 Mar 2016 11:38:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <539D1F09-E6EB-47F1-A66E-C182CA675359@hgst.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Damien Le Moal <Damien.LeMoal@hgst.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello, Damien.

On Tue, Mar 22, 2016 at 08:22:22AM +0000, Damien Le Moal wrote:
> diff --git a/include/linux/ata.h b/include/linux/ata.h
> index c1a2f34..f460e7f 100644
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
> @@ -371,7 +371,8 @@ enum {
>  	SETFEATURES_AAM_ON	= 0x42,
>  	SETFEATURES_AAM_OFF	= 0xC2,
>  
> -	SETFEATURES_SPINUP	= 0x07, /* Spin-up drive */
> +	SETFEATURES_SPINUP		= 0x07, /* Spin-up drive */
> +	SETFEATURES_SPINUP_TIMEOUT	= 30, /* 30s timeout for drive spin-up from PUIS */

Other timeout constants are defined in msecs.  Let's do the same here.
Also, can you please send the email as plain-text without the base64
encoding?  If you can't, please send the patch as an attachment
instead.

Thanks.

-- 
tejun
