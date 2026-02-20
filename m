Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C94C365A05
	for <linux-ide@vger.kernel.org>; Fri, 20 Feb 2026 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771608796; cv=none; b=XTobZRntztyNT6wlqEBj0n1/fGdkL3ltAJ9n0HS9+fIzAbrM8NrgZ9/07CRh+ok0GNyVfNpcDzhSxJ5lJB1LBnkRP/R/lZVvwOV2BKP6Y8NpbeTPbaDeBAr9Z9CjXDFNdTjOfb6j1HwSTIv4COwY+XpP9l58fmnKHeE80Ot3Y4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771608796; c=relaxed/simple;
	bh=QM9KB71maLtomvW0oGH8RoFZ39kQmEj1ytElqGFmwLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nz5VWjvDtwni0CKy9uS6dK3q6c0mq9wJChWJlPC0+iivW4YYvUT7eJMm4GxKHUEyNZB+nZx8JrMsGIzYd7l4aNgDHIuWcj0AoRjfZxTcOj+dcOg7iWhr6X/5cD2VdDlPYoJSe/jVuRNPzuWsCz8kH/yHEhPaFO/z3XtLsZadBbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IAxN+Zya; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IAxN+Zya"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a885af8ee7so82865ad.1
        for <linux-ide@vger.kernel.org>; Fri, 20 Feb 2026 09:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771608794; x=1772213594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AWBWqzlUth5wxMx03K52CSxerrwNm7iygbTmKzcY4WA=;
        b=IAxN+ZyajLsZ3MJRcV3bn8TLfYHwyutkvDmFQg9u2pWu04QeCfaGDrYluE/vEwfFt6
         +THlgpzg+P3IrPzNhS3FdhSv1bnLzfnNy+VtWOKfNHDRsy8/9DtIiqO0Wi3M0gVdSWqI
         AgWqNN+I0n1Hap+lEYjAVCEQHiR7N+YWWRJRrGDBBvvljD80sB00UujygII7aYmTcCDP
         5PT12nTqO8IyyJzqtlM+KpagiXWSsPuQfm/ejygyA6HVO7BbEsKA8XVkzT/4kaPwahfV
         yOPRCt4nAUpWfoQtxAuzWVimNNdOiVxoD4UxGfjvBeQ0oLzSaxrvJnoB3f9k/mZ7IRBb
         PWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771608794; x=1772213594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWBWqzlUth5wxMx03K52CSxerrwNm7iygbTmKzcY4WA=;
        b=a8AVMmhb4YEfBfpDA1r6r8Q1u3ggmFxFJTW4AaMMpCw8KjbTwh0S8uth7pRimZD/Pp
         AN/E3vHBv6NA6MQuPmwfL5gvv17FB+pRqa5nszbv1FuZlB4ino5vo+aUr3FC8iv+HY/E
         JIxgDBIwsQG0k+9Cz0xDjNuS93DB1VDC+AoHK3lmeCoVOZLtu4I50mN8wUt3ZIaqego0
         JH9OB5EH70mmmUf2U/LIyeoEkiLrK8dLyy6HgWHHTq/Nfa2U+Zm5yeVx8W1xveMvwu9e
         5xqbofVDNcvAmnw03xD+/7imcRKJMjJ0RPpBw4w0MOdtupBLgYRylW0QX36bgsXdbbIo
         OOlg==
X-Gm-Message-State: AOJu0Yyl0CfdreCfGlV8ppPbycWTqWM7mX+M99WlaSnlY0kCqFYbURdt
	4dzUhYYeOS/TKN0FU+Jo69v78mVfgfAZKMTXg/FAOLG8z0lMQ8BEFIpeg58c3xOOwprP9nyTh9Y
	pBczQ7nid
X-Gm-Gg: AZuq6aKOat5RJSs5xEPHtuRZ82T7mnKptPZPQiQ2iBop0F/5errSNec4VZ2zxKIBxfM
	YcVNz9nsH4QrsmgPN4GuaYi8MUQsZG106fbN4HR0BMGPBcLhG/4NvAvf07cby6+6N6HbeF3jX9q
	29sV++qLRGo2D2DyosHtl48nKm2XiOiUTC/1cpyfj1IN9ovNwS/1DbbzbIzIzlNuWsBNXqOtTvT
	8a5lJDkisAQzslOOzT5EAA6YzELkALS0ZQsmsmmgYpItGINqGakKZsb8Xy9rHqgGrQdra2GNZ4m
	giPm75ITqsqcQPZmIl1YSO+Nd/fRbGBlLx6Y79ZuybPNwplHM2BQ6t1XuK1Vll6FjDEZUf4DO0L
	6JsmY+EU9GolPiKwO1a7tGQql1aPfghi0kwH1mycWbqCcB7dBrRLO2WIBy6+9YMW249EeNEJ0YD
	SMKlI6iUOnOqbykWw1fZuUyBXsBi1d8UPoj1AaCm7Cmt075qW7w0BqQWdPSLnfbg==
X-Received: by 2002:a17:903:1a27:b0:2a8:ffed:4663 with SMTP id d9443c01a7336-2ad69e81213mr2102465ad.12.1771608794071;
        Fri, 20 Feb 2026 09:33:14 -0800 (PST)
Received: from google.com (185.29.127.34.bc.googleusercontent.com. [34.127.29.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a546edsm23494439b3a.25.2026.02.20.09.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 09:33:13 -0800 (PST)
Date: Fri, 20 Feb 2026 09:33:09 -0800
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH 2/2] ata: libata-core: fix cancellation of a port
 deferred qc work
Message-ID: <aZia1dnJ9pVkf3pq@google.com>
References: <20260220050053.390135-1-dlemoal@kernel.org>
 <20260220050053.390135-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220050053.390135-3-dlemoal@kernel.org>

On Fri, Feb 20, 2026 at 02:00:53PM +0900, Damien Le Moal wrote:
> cancel_work_sync() is a sleeping function so it cannot be called with
> the spin lock of a port being held. Move the call to this function in
> ata_port_detach() before locking the port and add a call to
> ata_scsi_requeue_deferred_qc() to make sure there are no remaining
> deferred qc.
> 
> Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/libata-core.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index beb6984b379a..54afa4df987e 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -6254,9 +6254,18 @@ static void ata_port_detach(struct ata_port *ap)
>  	/* Wait for any ongoing EH */
>  	ata_port_wait_eh(ap);
>  
> +	/* Requeue any remaining deferred qc. */
> +	ata_scsi_requeue_deferred_qc(ap);
> +

ata_scsi_requeue_deferred_qc() requires the port lock to be held (function
has a lockdep assert).

>  	mutex_lock(&ap->scsi_scan_mutex);
> +
> +	/* Make sure the deferred qc work finished. */
> +	cancel_work_sync(&ap->deferred_qc_work);
> +
>  	spin_lock_irqsave(ap->lock, flags);
>  
> +	WARN_ON(ap->deferred_qc);
> +
>  	/* Remove scsi devices */
>  	ata_for_each_link(link, ap, HOST_FIRST) {
>  		ata_for_each_dev(dev, link, ALL) {
> @@ -6269,10 +6278,6 @@ static void ata_port_detach(struct ata_port *ap)
>  		}
>  	}
>  
> -	/* Make sure the deferred qc work finished. */
> -	cancel_work_sync(&ap->deferred_qc_work);
> -	WARN_ON(ap->deferred_qc);
> -
>  	/* Tell EH to disable all devices */
>  	ap->pflags |= ATA_PFLAG_UNLOADING;
>  	ata_port_schedule_eh(ap);
> -- 
> 2.53.0
> 
> 
