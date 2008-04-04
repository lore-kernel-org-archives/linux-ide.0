From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] use ATA_TAG_INTERNAL in ata_tag_internal()
Date: Fri, 04 Apr 2008 03:56:03 -0400
Message-ID: <47F5DF13.1040301@garzik.org>
References: <20080228214313.70129569.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44768 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753764AbYDDH4Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Apr 2008 03:56:16 -0400
In-Reply-To: <20080228214313.70129569.yoichi_yuasa@tripeaks.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc: linux-ide@vger.kernel.org

Yoichi Yuasa wrote:
> It should be ATA_TAG_INTERNAL.
> 
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> 
> diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/include/linux/libata.h linux/include/linux/libata.h
> --- linux-orig/include/linux/libata.h	2008-02-28 13:29:13.659279943 +0900
> +++ linux/include/linux/libata.h	2008-02-28 13:29:48.221249519 +0900
> @@ -1123,7 +1123,7 @@ static inline unsigned int ata_tag_valid
>  
>  static inline unsigned int ata_tag_internal(unsigned int tag)
>  {
> -	return tag == ATA_MAX_QUEUE - 1;
> +	return tag == ATA_TAG_INTERNAL;
>  }

applied


