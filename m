From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 2/2] libata-scsi: better style in ata_msense_caching()
Date: Tue, 12 Jul 2016 16:33:54 +0300
Message-ID: <2c0c47d0-b744-6832-34a4-418fa5f4fef9@cogentembedded.com>
References: <20160712132823.1765-1-me>
 <5784f087.465c620a.e5292.ffffbf31@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:33427 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbcGLNeD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Jul 2016 09:34:03 -0400
Received: by mail-lf0-f47.google.com with SMTP id b199so13753934lfe.0
        for <linux-ide@vger.kernel.org>; Tue, 12 Jul 2016 06:34:02 -0700 (PDT)
In-Reply-To: <5784f087.465c620a.e5292.ffffbf31@mx.google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tom.ty89@gmail.com, tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org

Hello.

On 7/12/2016 4:28 PM, tom.ty89@gmail.com wrote:

> From: Tom Yan <tom.ty89@gmail.com>
>
> Signed-off-by: Tom Yan <tom.ty89@gmail.com>
>
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index bfec66f..6f7c626 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2424,10 +2424,13 @@ static void modecpy(u8 *dest, const u8 *src, int n, bool changeable)
>  static unsigned int ata_msense_caching(u16 *id, u8 *buf, bool changeable)
>  {
>  	modecpy(buf, def_cache_mpage, sizeof(def_cache_mpage), changeable);
> -	if (changeable || ata_id_wcache_enabled(id))
> -		buf[2] |= (1 << 2);	/* write cache enable */
> -	if (!changeable && !ata_id_rahead_enabled(id))
> -		buf[12] |= (1 << 5);	/* disable read ahead */
> +	if (changeable) {
> +		buf[2] |= 1 << 2; /* ata_mselect_caching() */
> +	}
> +	else {

    CodingStyle: } else {

> +		buf[2] |= ata_id_wcache_enabled(id) << 2;	/* write cache enable */
> +		buf[12] |= !ata_id_rahead_enabled(id) << 5;	/* disable read ahead */
> +	}
>  	return sizeof(def_cache_mpage);
>  }
>

MBR, Sergei

