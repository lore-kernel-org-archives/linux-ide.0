Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100743382F3
	for <linux-ide@vger.kernel.org>; Thu,  2 Apr 2026 03:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775098815; cv=none; b=SB1zs5XgtMW/wd3qMDXvjNjRh6SC6Z4z7x00EB0cO72LNSaqFAtQ1/Q692zyyB5VmJIw5FKdrCoqAesTICN2taw7SWVw+NHMmUUWopY27Xo2k3yxIQNBbrC4Q+PBjvulQ41o++guOodAhONEmevMsdYbIfvo8mdc1Kx8W+j1x0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775098815; c=relaxed/simple;
	bh=pRgqN80Qg5HbpNQnNw1QEu8s6Fv3UVbf8F4qzdlj08s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzS00Qw0IIIS4WuHlp9TJs3Q+2SvzVLap+7Nta+wRMSgMmohn6XdTd/YM5RDfOWgkOLhpKTJKVDZgtmTl+XgTUGzBnZ3Pf+6oZXFm7OLM7HC6hBQJeYHuvlu+VvuPlS26Spq1jamYa683qAGOzwFU3vWAXCssrrY+ZvGjGbhYYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uwpD8ZZZ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uwpD8ZZZ"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35d99031e4eso180039a91.1
        for <linux-ide@vger.kernel.org>; Wed, 01 Apr 2026 20:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775098813; x=1775703613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QMFR3RQLzo5uhKgwhOk/cIZfbUr1nA8Y5LEqBHbFc5A=;
        b=uwpD8ZZZi9W407DLBsN8H2MMK8JO95ddyTUZ5yX6nmhpMKZykxgILVfb7tsNBBd7rf
         LZ3d+tlRiPiJIn5CDMFC6rhPUfn7u53+sLpF3TcTEb249Y74jSFVj1h7c3ZlizUSCdnj
         SXZ8pNAhrXNBH/DaVWVVMlEXDQrdeZxMOiCls8eJTFmZ7I8ZdggK3OnCo4S5tQWYJhzg
         UsRlbbDr4YaO2U2riqantS9/mHr0h4m0OVESQSdHPq6ht3M5glfpauuB7OnSSBnxYspX
         WUQivUt2WC3UV1mcWWRitIj+fw7jnPoGnU4CU71kp1bRtgZRXqO2AFo7rFIZ6reohzjF
         J4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775098813; x=1775703613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMFR3RQLzo5uhKgwhOk/cIZfbUr1nA8Y5LEqBHbFc5A=;
        b=ZIwDK3LOmm7V4LlNhqwYgvUV2Bt/tFuyTQ9OJSxm3FRnbKGcJXaCs9TxFt7pCOm8j2
         av+z+mjlBg3pQ7fFcz1Nm1w/FnBaeNoWvq9Haf85957F/YIvrrrlFy2oxPFFdBG5xFxj
         s1CuSJ3MVOhg8sjcFEyac9N5Qvsax9qV7Z6hVrf7KMrsPvCRHIwSlDlWSsFMlgEcSNct
         z5n0W76rN5JfwT6gJc5WVKp1VdNnWm20f+woUdkL2O2FXr1gc1Q0YnSasvzepki6PuRY
         O5B3pnVLnipxEAHCPZum9jlEzZoLKqx/iJRi+msZz+6btnOOLJmi30izoiANQgQztKyO
         xXZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbYJ7hSo0PmCUZhaX0lHARWB0taxzRuA+6Zos/+1eetlAX629S3gAsyjquOb6cYk53PFK0U2bGysw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO9XslrC0TBf4aMG9rKcA4qoJtFqHk8ykw2+Sy0DklZiW67z9l
	849/E0cDyGQbVjRQ1GIuC7Ew1N8Imij6tFMSq1EuaWL5/VGIzv/8cjwG0gNG0PoHUZQ=
X-Gm-Gg: ATEYQzznbDUJfFtIvx6XI5SL7C2VZhHiwixQ8Xl2WHW7LfQb4WtFx3nsczrM6YKEo5r
	MDsNKgPTbf++OJaK1vdIKc7zUeaA9AigYJ8kaMOV13Pu5baEwvCfyUMmu81RubskAdyY2BHlim5
	ZzZGWxKjulj77OvTkwChPE+IKHczKh4LrfPTqeu4rVjX29YMqzeM6t/7sMQGHrZapomV/oeUn1m
	Cvo5sYKZpEWCo5EaPrEPeIkVqJD8mY3zy1vxC/XCgyIQdQHmF2Qq8CL5gbqKEKcpENuCHYpZYLG
	9QfgLEhTAWMbX5OIHt6SMLnpYib+yEddkWdl/iiM/7FLf3IpRDbQl9S+jgI3ZeDGoecF3kPsbRq
	PMZW8WDlpKiDkuefUQxXxua9+n9F7wbfLBwXOjLJF0VHPejtN7J74sEpd2/wOP+JnTaEe5UsYHd
	amBXeJM6zWwlApAguxxwwehWox
X-Received: by 2002:a17:90b:3a85:b0:35b:e4f8:7cb0 with SMTP id 98e67ed59e1d1-35dc6fb5e86mr5279512a91.21.1775098812567;
        Wed, 01 Apr 2026 20:00:12 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe5e1b9esm6500518a91.3.2026.04.01.20.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 20:00:11 -0700 (PDT)
Date: Thu, 2 Apr 2026 08:30:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Haoyu Lu <hechushiguitu666@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: pata_arasan_cf: fix missing newline in dev_err
 messages
Message-ID: <vqnmi7e7wfsqjqbtnar5zpwwrzflwjz6up7dn736hinbppam4i@3ynk7wxbjuoz>
References: <20260402021027.56-1-hechushiguitu666@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402021027.56-1-hechushiguitu666@gmail.com>

On 02-04-26, 10:10, Haoyu Lu wrote:
> Add missing trailing newlines to dev_err() messages in pata_arasan_cf.c.
> 
> This keeps the error output as properly terminated log lines.
> 
> Signed-off-by: Haoyu Lu <hechushiguitu666@gmail.com>
> ---
>  drivers/ata/pata_arasan_cf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
> index 514d549286b5..abcdef123456 100644
> --- a/drivers/ata/pata_arasan_cf.c
> +++ b/drivers/ata/pata_arasan_cf.c
> @@ -380,7 +380,7 @@ static int arasan_cf_xfer(struct arasan_cf_dev *acdev, struct ata_queued_cmd *qc
>  	if (!wait_for_completion_timeout(&acdev->cf_completion, TIMEOUT)) {
>  		u32 rw = acdev->qc->tf.flags & ATA_TFLAG_WRITE;
> 
> -		dev_err(acdev->host->dev, "%s TimeOut", rw ? "write" : "read");
> +		dev_err(acdev->host->dev, "%s TimeOut\n", rw ? "write" : "read");
>  		return -ETIMEDOUT;
>  	}
> 
> @@ -474,7 +474,7 @@ static int arasan_cf_xfer(struct arasan_cf_dev *acdev, struct ata_queued_cmd *qc
>  			dma_len = min(xfer_cnt, FIFO_SIZE);
>  			ret = dma_xfer(acdev, src, dest, dma_len);
>  			if (ret) {
> -				dev_err(acdev->host->dev, "dma failed");
> +				dev_err(acdev->host->dev, "dma failed\n");
>  				goto fail;
>  			}
> 

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
