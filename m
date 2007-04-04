From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/4] libata: reorder HSM_ST_FIRST for easier decoding
 (take 3)
Date: Wed, 04 Apr 2007 02:12:37 -0400
Message-ID: <461341D5.30702@garzik.org>
References: <461077CC.4040708@tw.ibm.com> <46107874.3060904@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41687 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992685AbXDDGMj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Apr 2007 02:12:39 -0400
In-Reply-To: <46107874.3060904@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Linux IDE <linux-ide@vger.kernel.org>, YUP <yupadmin@gmail.com>, Vlad Codrea <VladCodrea@mail.utexas.edu>

Albert Lee wrote:
> patch 1/4:
>   Reorder HSM_ST_FIRST, such that the task state transition is easier decoded with human eyes.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> ---
> Patch against libata-dev tree, for your review, thanks.
> 
> diff -Nrup 00_libata-dev.ori/include/linux/libata.h 01_hsm_st/include/linux/libata.h
> --- 00_libata-dev.ori/include/linux/libata.h	2007-03-23 16:56:24.000000000 +0800
> +++ 01_hsm_st/include/linux/libata.h	2007-04-02 10:50:50.000000000 +0800
> @@ -315,11 +315,11 @@ enum {
>  
>  enum hsm_task_states {
>  	HSM_ST_IDLE,		/* no command on going */
> +	HSM_ST_FIRST,		/* (waiting the device to)
> +				   write CDB or first data block */
>  	HSM_ST,			/* (waiting the device to) transfer data */
>  	HSM_ST_LAST,		/* (waiting the device to) complete command */
>  	HSM_ST_ERR,		/* error */
> -	HSM_ST_FIRST,		/* (waiting the device to)
> -				   write CDB or first data block */
>  };

applied 1-4


