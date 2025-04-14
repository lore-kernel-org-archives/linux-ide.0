Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CE5288CAC
	for <linux-ide@vger.kernel.org>; Mon, 14 Apr 2025 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744653489; cv=none; b=Ubqilvg40F2xQmcKLZ54gzw1r4kUis21k8DFBNClfUzyTYRKE2kw7QbiGFG4HS1QHy7QOh5473sIvKnGOZnPLRCnEHbVavIO/Y7bmFxFEW2eZeiQLIVHW8bKF5vwvUF2abEBfnwJ3DAiy3SWwlADdGyOf/oWUqQ2anVjZ16rUUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744653489; c=relaxed/simple;
	bh=6T+Texcbbf1PRVyECgK7tMxVI2qn7WP9BIv/bH3/rR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0Bg0J4w+Lul2fERqKORQkmZBuDFrGtq2i4EVOlc7aAtzNwfYOd666KzVCv2UXBaBa4D/gIEJPyVsmMoP6WQfWRmCcy23uAtHVVtIH8yDVxjbKl8wD/kwJobTGgC0FFgqilxzrL9evSMEZPZMzPujVoWZCdb1fG7iRTIDAe7MfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hSaACfOk; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hSaACfOk"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2240aad70f2so29365ad.0
        for <linux-ide@vger.kernel.org>; Mon, 14 Apr 2025 10:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744653487; x=1745258287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qNp0FsWPmUo/n9z7+lvZXBT16duroolxulzTUPH/Llw=;
        b=hSaACfOkItuHumMWJWcSvgu3JukzPqOva9rMLxDRfznjk4Q0nsaqx8HMrXS1Ood2Vb
         Gc+TAnmMbet1cWAm5pRDrN3aao9582sCE5Tzua7Ba/Y/iMjwl7ist/shAWFR4lhjDIiD
         LXzYuZVOmqyZaJ1gzYfIUptzoEHVZrR6/vA7iFU/MbuR4Cr35sOSLxgySXT33hLOf2bY
         d9ww38BziRX18ZHcAFmX8XMFYuSf1++52AS8D47qbWLnA0ULQRMAeLVKJ31S9XqP101f
         XCz9/zARLwmiCztISIeoktHyhGGziJEVnIYZBZ1f9D1ACoOM3ptErYdGf5erd7FgkprV
         7ZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744653487; x=1745258287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNp0FsWPmUo/n9z7+lvZXBT16duroolxulzTUPH/Llw=;
        b=W40KXOViS/iVDxZzHTQZcyNEoR3hkPCtegWIOoEnvomxI176nz4bUaonItfmXLrthL
         x72zb29GW20GrzxnMFi4m6zlCiVUzLJmViUscGcFg6HKu84oXsQRlzsuvyWh4kEK/MTd
         xRiHUb1dvlghqkESE1ZRZT6SgNF/yfxKOZN3YMnvwNboLJVsC9zEhM6iLjI/ZQxUi4Kj
         gcbmTI02/EBIZub92+Wvhfzhscr9F9L0IIlG7rrFJlwEXaHcQlrSEAL2tDyDWndnKgOW
         EhOGuO6obWxwOdUdCPeT8fc+jMopTh5zd3huaf19McEl3duUA8VA6MmAuvtRDIolMkeo
         V8yw==
X-Forwarded-Encrypted: i=1; AJvYcCWySIwlhaTLpUiV5Zn8PAu0lJMFLSw9/itDnB1+MXE8V3NoWcSCAl96R6oc8rneayqYoZ7JmUqRBn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwReaxEqyVf5JFdyTWmCyGpJV2rVh3qqpZNe4Pc4L6vWl703AfY
	AQs/SE9COjzd49dwxCLMn3jWucUsG6iO73ZaEwV8h73M0d1b9IqyVQYdR+7ukGSEuOT93czQwF8
	hfQ==
X-Gm-Gg: ASbGncsoKDfB+qgd6oEgGn9DRCVJD8K+Yx/9qA0Dgdv9YwvDXLILMbZTnv6E7GjmHXZ
	uzUnb6RGrh/7Z4Bxrlosri5rYvMhVOALSW9sPrwtdz5XaUWO24IrM7PRB1+XuYwAZGcgDSI40m0
	gKxv3aMBp4820CnOds3EgzIcWwycR3DtT6ljpSrFqz3jJSbWWJhD9Jph16XYN/RpfGjh82Swn55
	8m7/Vj+W672gUi6JYkIRzeYuXzoNQc+O2DMn9eBDEJ2jlx8wVu7I2VXBGuWZe231fk4+OuHbhaO
	6ykKs5iuVWWvnrjEZmquGNBw3eef4EW6BizmX9h8UENixFmmmcT3D2jkFI2G/mVtPYPPEtgBGNN
	2
X-Google-Smtp-Source: AGHT+IHgJkCeg2HkT6wVVRWrs2WVaf/QGJPsYAoLp/n4VZpk1aS9HinfRNASg+cRCXYIMh4yHnMHiQ==
X-Received: by 2002:a17:902:eb8a:b0:215:7ced:9d67 with SMTP id d9443c01a7336-22c2521539cmr153235ad.24.1744653486498;
        Mon, 14 Apr 2025 10:58:06 -0700 (PDT)
Received: from google.com (24.21.230.35.bc.googleusercontent.com. [35.230.21.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd219f91fsm6897450b3a.6.2025.04.14.10.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 10:58:05 -0700 (PDT)
Date: Mon, 14 Apr 2025 10:58:01 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH 2/2] ata: libata-sata: Simplify sense_valid fetching
Message-ID: <Z_1Mqa8u96T2yzpf@google.com>
References: <20250411132522.126316-3-cassel@kernel.org>
 <20250411132522.126316-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411132522.126316-4-cassel@kernel.org>

On Fri, Apr 11, 2025 at 03:25:24PM +0200, Niklas Cassel wrote:
> While the sense_valid field is 47 bits according to the specification,
> we are currently only fetching 32 bits, because these are the only
> bits that represent the tags (0-31), which is all we care about.
> 
> Thus, replace the existing logic with a simple get_unaligned_le32().
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/libata-sata.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 2e4463d3a356..5ba79a1053ea 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -1529,8 +1529,7 @@ int ata_eh_get_ncq_success_sense(struct ata_link *link)
>  		return -EIO;
>  	}
>  
> -	sense_valid = (u64)buf[8] | ((u64)buf[9] << 8) |
> -		((u64)buf[10] << 16) | ((u64)buf[11] << 24);
> +	sense_valid = get_unaligned_le32(&buf[8]);

sense_valid is u64, should we update it to u32? We can also simplify
the sense_valid bit check to use the BIT() macro.

>  	extended_sense = get_unaligned_le16(&buf[14]);
>  	aux_icc_valid = extended_sense & BIT(15);
>  
> -- 
> 2.49.0
>

Thanks,
Igor
