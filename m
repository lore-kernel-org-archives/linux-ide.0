Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DA84A35
	for <linux-ide@vger.kernel.org>; Fri, 18 Apr 2025 00:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744934870; cv=none; b=QTLsBfk31+lwM/+dyxtC+LC642S/q6Vf05tNq0cliSpq1cJtgSXx4JQkbgFV8IDYVcSacTG4M+ITh3VFyfAE0/optEncq9iZva+xVB6hM8l6f57bh3eSkwAplM/fZHNo5jh6Kuwn2s0dE0N1G2C4h5kL8ZYDTKSfVeg2SIhXXAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744934870; c=relaxed/simple;
	bh=2Q96KZmAfjnzBaTHv10oj8TWul8tq+SQhcX6vZnVG9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcRrxInF/vkIwi5NmPtIhyV6Twc7FoWjyOoWSW26xgUUEcbNHht8NvQRNCgBHGd6Gia4ouxhWFZTrYj5tVHUEfRb8GiDMz6/IsvpR5Nnzr8lbmtLYylOs4vTboM43wKuxybqWcLwSZAMsKNWS87IwKm2wJS4JJo+lDW0PzB0l4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wd+l0LZ/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wd+l0LZ/"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2263428c8baso92335ad.1
        for <linux-ide@vger.kernel.org>; Thu, 17 Apr 2025 17:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744934868; x=1745539668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/KrmWAJyZXfnuTABRqnhfRHchKK0MW8AbXSUHMqH/vI=;
        b=wd+l0LZ/IVA1ItK+ISgv5SaloGGZtz9fSVRhQnWPLACJxnJGon4N0z8hgB2nN+9waA
         o/nt7fSyjSDsJRsw8Y5FXRaT9rfoOAw+Z1ev9RIZnZ7O57u6DkYRGRDk51Z8aaPfGgFZ
         kRqnyyxtQCDo1yoqbQd/xw43SmYc+ztNhqSBVum5PH9JwMWkBDi+iOfrqMjo8r+hlSUD
         tKSrNMouXs0wtOUXsvOLsTNaj4brZ2R0bEXByXCBYNUMmQTGQ4G3X1yLlFPTwwx9ZDTa
         tZ2+MnKoBs77n7rS1ZAKOm1tFih4XSwEzpyJ40mvyYrszIPbfMbDQSs18JLhPYJ8euCH
         VbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744934868; x=1745539668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KrmWAJyZXfnuTABRqnhfRHchKK0MW8AbXSUHMqH/vI=;
        b=aGlI4BfwI+R8Zic6l3cjx1co69mtupS55UedD/9kt6DkRs/RZoEKa1tzOAxjZOs7GZ
         FI9CWYTEO1P+0p1JO5pXI/9xIsjQGQD9LQevNOD9Q+wWYOg2aGCA+IUjgW7gWUw0e3Dj
         K6vBOwymA2WJS5IEC0/jARi+unnAbdduDs5qZbw/1Yg/5il/6KBH6Wc1xE+awZgJkadS
         fS28g5uPUPdNbRfTcSz2XgUCUJGKyi3zo4H8F8aQVbS27X1XhS9dJnnJJDE8lmtHTgPF
         9XL+uIBtConUkkOThfGFUNnpT+bh6QwAW7C02LMXRisGKAnZoKzT8aPkFXcCgHzLtDwM
         N4CA==
X-Gm-Message-State: AOJu0YzjiM6KZK0GUykwOmLmeSr+djfKkbrGsduUBbHP6r8LxC1sl7F5
	IRW9ah4nhPHjCpttBGr51uXJdDESeCso8cbv9OmbypOdnvku2t/qOZQ7wxqGZQ==
X-Gm-Gg: ASbGncveIXbj2tzsCkaQNR8mF66GnMT8CFJ7RjF9fTipEdgbke7II0VwJaMZhUmEvay
	H0Nwux4E8B/zHuNgLpG7jK/adT5PjAk8Ufn1QrN1CZxdvrH686UpuAeQ6i9txXN+4YTfank1Cj1
	jErNFFA0/kcqpOQ4uUiStdM1GO5a0lrKd18GXcdiofuuggdKct46G86Fa3qU4e+Uu/FE5/AqQx4
	+HN7rVT6dQoMU3xuTpuD5jXz1aDZm9BL3+X41ulj+VKuwXmY503QvvgOTCLUjjCJ8hMuPwE5WTr
	t0EF3mFmo7L8pCr73HK/VwEXFKxbn2dmzKUTMEue3QkhELrEXjSEnIerKR9e9oHhkih2OEhCMDZ
	K
X-Google-Smtp-Source: AGHT+IFb3SrJqfiSFr7FAgdAYVWS2IhZLL0NjhjCGyfGFPOWK0db25W8bTlujUSvVI0gsV5qmJXIuw==
X-Received: by 2002:a17:903:4408:b0:223:7f8f:439b with SMTP id d9443c01a7336-22c54696799mr589535ad.29.1744934868332;
        Thu, 17 Apr 2025 17:07:48 -0700 (PDT)
Received: from google.com (24.21.230.35.bc.googleusercontent.com. [35.230.21.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50fdbad2sm5963025ad.226.2025.04.17.17.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 17:07:47 -0700 (PDT)
Date: Thu, 17 Apr 2025 17:07:42 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 2/3] ata: libata-scsi: Improve CDL control
Message-ID: <aAGXzmgOog1jjXSv@google.com>
References: <20250416084238.258169-1-dlemoal@kernel.org>
 <20250416084238.258169-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416084238.258169-3-dlemoal@kernel.org>

On Wed, Apr 16, 2025 at 05:42:37PM +0900, Damien Le Moal wrote:
> With ATA devices supporting the CDL feature, using CDL requires that the
> feature be enabled with a SET FEATURES command. This command is issued
> as the translated command for the MODE SELECT command issued by
> scsi_cdl_enable() when the user enables CDL through the device
> cdl_enable sysfs attribute.
> 
> Currently, ata_mselect_control_ata_feature() always translates a MODE
> SELECT command for the ATA features subpage of the control mode page to
> a SET FEATURES command to enable or disable CDL based on the cdl_ctrl
> field. However, there is no need to issue the SET FEATURES command if:
> 1) The MODE SELECT command requests disabling CDL and CDL is already
>    disabled.
> 2) The MODE SELECT command requests enabling CDL and CDL is already
>    enabled.
> 
> Fix ata_mselect_control_ata_feature() to issue the SET FEATURES command
> only when necessary. Since enabling CDL also implies a reset of the CDL
> statistics log page, avoiding useless CDL enable operations also avoids
> clearing the CDL statistics log.
> 
> Also add debug messages to clearly signal when CDL is being enabled or
> disabled using a SET FEATURES command.
> 
> Fixes: df60f9c64576 ("scsi: ata: libata: Add ATA feature control sub-page translation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Igor Pylypiv <ipylypiv@google.com>
