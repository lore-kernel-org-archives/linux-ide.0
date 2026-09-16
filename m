Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D2E5013B7
	for <linux-ide@vger.kernel.org>; Wed, 16 Sep 2026 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566437; cv=none; b=N2pc7/+T892W45vhtfUuIUmqsQUyy53FlF+QAKHssU0PeGVTt4WpOcS9nGDO2kZzjdbl5PgXEg2fMnPcjeEmOBbvHzK7q3iIbOF1dg4eq5VCzogBc8nw8iBsE+LQZn2Po8hlAqKJKzGIZtmgSe9uhQr+Od/qUVoJNDDo87nDa9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566437; c=relaxed/simple;
	bh=wyG4mFrZzanZ51rPx4T8zNvYkaS6fjqxy4C1wHaU6Fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sjgjig6R6CMI2T6zwTCF3ck20sHzgabKJVO3vzoVHdiFu/YA+4A52Fy9hOTHmMhu9Q3mnFWeot/aNm8nlGHUnBp8Bb3bFXcyr8L9iTjl8iJ/CPNpjqh4cb1DBcHMnXWxk8jn9N2P2gPh1z79g9j8uYM8/RF+n0F+uBZfMrg+A1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cMu4U30C; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MweTeQ5C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cMu4U30C";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MweTeQ5C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789566431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xzOhbTS+gwwUFkFmdtpX4xmPsS/JHI1ZomYHVEAU5TQ=;
	b=cMu4U30CXhOkC5S8I6GxqKh7yYvqR46pZD76aCS0FmwW+jNVL+pTA58X/QS2/3kzIya2Eb
	w0Tvb8vY7PkRBcB/mjaaEM+nMm+/iX+kE9q24NTkw/jThipxJZdLZyK3QtBEgfG1yqCKna
	psyWmwoAeCnjn/ubrwzaa+ihaci8Jto=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-_y2sZJ1fOsOy2PM9yQ2jlQ-1; Wed, 16 Sep 2026 09:47:10 -0400
X-MC-Unique: _y2sZJ1fOsOy2PM9yQ2jlQ-1
X-Mimecast-MFC-AGG-ID: _y2sZJ1fOsOy2PM9yQ2jlQ_1789566428
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-486f3c0d896so2869011f8f.3
        for <linux-ide@vger.kernel.org>; Wed, 16 Sep 2026 06:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789566428; x=1790171228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xzOhbTS+gwwUFkFmdtpX4xmPsS/JHI1ZomYHVEAU5TQ=;
        b=MweTeQ5CIM1TuGheE4vfgEBg4RUMCzuar4DTy+rroRjaDLNAMnb1jh0ggqkYl1f04i
         9CG5BZNcLE7RaWH+dVdQn18wOgbosCM5y2tusmiGbAtbUC8PObdQNQoa4TZeGZcGrVxW
         acaPeypKAsvCCUp/HvWR4zE8dipWSR4kIhgBF3k+LR2S7dkWhidMOoJO8aeZR/VZoDrf
         PgFMXA7JhLQqMD7eNnyfASGDofcBj6k+JLLv53W3FCwjJIMmrxW+T3ZQD5Z/8t2sVcGu
         5fhLV7fQOn+Q4H41jJSnVvDkpIybs8rSV6pkVAeMJ3uzyCeXxYLKAMBYKG/LaTWZY4Gd
         j5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789566428; x=1790171228;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xzOhbTS+gwwUFkFmdtpX4xmPsS/JHI1ZomYHVEAU5TQ=;
        b=QozlMkEAfDCxsvNFtL/oox2sJnlaMWXKBbgiWD+ktHaQrOfmmhQeOJiAMZRDm8BhMU
         6/a8L23QvH46tz7nglXejCi8nI/g85+T5t7aa0F4PzbkXRSDuB5bKwGW5ZZTi1AarOGV
         kroQZFjbDpvDO8uwqRJ52FhaUzRsySjmak65KmFxOlASupNrYUdynt4nwvCCy9sOmsh6
         HlwoVqJHX3OTaEQ/vtHGQ5QkCjS2ArGwPflezfHGhN5Jbqmi9wEwWvZe5UWY4I7LpYFJ
         SAiCIDM5sJ8owdTIThRc3XJA5fOxLgfBRgpNvrDJjbTyv0OBZR0BMzFF8q+fuxmuTS43
         Pv7A==
X-Gm-Message-State: AFuF++npIeVeUe44ffnBkkTKM3Ozb82V1ev69/08aeKKONurinRbqVhy
	WGr2C1bNQw8oPgIAYvP813H5UNSYFiRIHt3wA0r5julymF3zzWri1P+PZD2Rkp5amKkHlawS5Eh
	BGCZPhRpPUrYmji6XoX6ohABc0EJxeURMcjM4cR7wV8PTnXmEuYlqP1IqfXyhvw==
X-Gm-Gg: AYBFou3sPwWPNakvwWrGuBI0+lZnlEw8WV1H7AX/tveYQ3MO2NsGNIQMd+YUb/CgKL1
	nCGSdd34EUsOb+IZpLl8p1qmqRZH1yE15U1ypuSas2pzmdT49iTA4ApdswDcxkCaSDRgx3ZRgAv
	DZ+G81fQ/u+3C/ZIm3cWRdSHtAABDRZ8eYQbYiXceYTW3lDBr3d420gwXJHTwTJtPbrwPnXlSd0
	4zECYHqXC0fYUi2J2T1esTdtl8c+Wk60o/1E5xnsVQiESwPmwtWJ2jDpKzMaqO8/k4+99AJMIdO
	Y9QMspKahRFUQswK6P/8FksG7uWt0nKWYCG3YWp9O8NF3cgpWCWVgAdl8fwHsz7Y3EZ12irYR7c
	34+eaJUBeSmGcM1s21zU7A29TdG1l
X-Received: by 2002:a05:6000:1a85:b0:487:57d:18e4 with SMTP id ffacd0b85a97d-4870d16bb1fmr4077759f8f.41.1789566428401;
        Wed, 16 Sep 2026 06:47:08 -0700 (PDT)
X-Received: by 2002:a05:6000:1a85:b0:487:57d:18e4 with SMTP id ffacd0b85a97d-4870d16bb1fmr4077708f8f.41.1789566427854;
        Wed, 16 Sep 2026 06:47:07 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-41-176-3.web.vodafone.de. [109.41.176.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf342a0sm7143032f8f.24.2026.09.16.06.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 06:47:07 -0700 (PDT)
Message-ID: <ce3873c6-cef6-4e6a-87c1-a175e3afadc2@redhat.com>
Date: Wed, 16 Sep 2026 15:47:06 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-scsi: fix ata_dsm_trim_pages() kernel-doc
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Hannes Reinecke <hare@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20260916130031.29990-2-cassel@kernel.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260916130031.29990-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/09/2026 15.00, Niklas Cassel wrote:
> make htmldocs fails with:
> 
>    Documentation/driver-api/libata:604: ./drivers/ata/libata-scsi.c:2301:
>    ERROR: Unexpected indentation. [docutils]
> 
> The Return: section of ata_dsm_trim_pages() ends its first sentence with
> a colon and continues with an indented bullet list. reStructuredText
> requires a blank line before an indented block, so docutils chokes on
> the list.
> 
> Simply adding the missing blank line does not work either: Return: is a
> kernel-doc "special section", which is terminated by the first blank
> line, so the bullet list would end up in the Description section,
> detached from the sentence introducing it.
> 
> Spell the two bounds out as prose instead, so that the Return: section
> stays self-contained. Documentation-only change.
> 
> Fixes: e64e6b5dc867 ("ata: libata-scsi: scale DSM TRIM payload by MAX PAGES PER DSM COMMAND")
> Reported-by: Thomas Huth <thuth@redhat.com>
> Closes: https://lore.kernel.org/linux-ide/b0a0b8e8-cc4f-4c7b-8bc5-fee0712d405a@redhat.com/
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index b3666519b648..7e22bbc38238 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2297,10 +2297,9 @@ static unsigned int ata_scsiop_inq_89(struct ata_device *dev,
>    * logical block, so it can hold at most sector_size / 512 pages.
>    *
>    * Return: the maximum number of 512-byte pages a single translated WRITE SAME
> - * command may send to @dev (never less than one), that is the smaller of:
> - *   - MAX PAGES PER DSM COMMAND (IDENTIFY DEVICE word 105), when the device
> - *     reports a non-zero limit; and
> - *   - the logical sector size expressed in 512-byte pages (see above).
> + * command may send to @dev, that is the smaller of MAX PAGES PER DSM COMMAND
> + * (IDENTIFY DEVICE word 105, when the device reports a non-zero limit) and
> + * the logical sector size expressed in 512-byte pages; never less than one.
>    */
>   static unsigned int ata_dsm_trim_pages(struct ata_device *dev)
>   {

Thanks for the speedy fix!

Reviewed-by: Thomas Huth <thuth@redhat.com>

