Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4569C1A0731
	for <linux-ide@vger.kernel.org>; Thu, 27 Jun 2024 21:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719523340; cv=none; b=O3Q4F7+7dSaDXhmVwfr4nL0prQR57vA7BDTt4B7UswK2cAIxRBenowuTz9r4AUkvf01padEqFPnI2LKJ09QAIFgBTeK09FodIwuisFeyTp64X9/RoyYNTCssPRG1KIfTk11qPIaFy6Oulb1oIBLNguly6N6j6cOrLFsl7hn1OJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719523340; c=relaxed/simple;
	bh=whfQVJTqJ7KJ0VxOyRfPiNhfqsaunBsnGeFsXvTkJBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sr3I6/q2ecsgAhci34BsmwIewXmuTfgiZvTRFhKxayCuNLPBFhaohc/P9oPXxF2QLnM3iRktDugykmdbLT0jYPDBmNw7d0yTAEb4Xu5Ag25Dtg0HifE3bgMLEdugYKLqXRQ5ecTeVfCQcVhXcbr6C4ZvSSJaBUWu4KFYGlKKmT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QGzIUFz+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QGzIUFz+"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f9b52ef481so66924425ad.1
        for <linux-ide@vger.kernel.org>; Thu, 27 Jun 2024 14:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719523338; x=1720128138; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5jKJZjz46n85iPjR+qb7a7teMFGLnU0s6sJD+tdHoMs=;
        b=QGzIUFz+r8AnxI0mihiLNaLu5gxeNPtN6rIR7imxH/JI7sbgRTiFNY0QZ3l2Zv3IbT
         pJcC5s5qFCyMaFWMXbCNfCPd9k+Lne905Xc9KUMHwPUZ/739JNAjuNHR8FrbewgOHKHZ
         HKGlF9b+4MTilInYAPx35/3aPXCcRcCoIGmNzarA6fNtunUOTvpOcNrkmX4WSAnoZaa5
         BaV7jInhKLOFzDfjLK9ONnbrsczuAV7JlPy4kcm7iuNOokqib+FmbIznxDEWqtjoz8fR
         DP2t6o6gzUSa5YMkx2WnlIHhj0FtXxUEYnPIpSflsCRZNjo5ZvU9TMNycnqxjCNXIjrp
         AkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719523338; x=1720128138;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jKJZjz46n85iPjR+qb7a7teMFGLnU0s6sJD+tdHoMs=;
        b=fkJ3cnx7AY94MQmrv8+MbN3G8BVJnaEd2r+mgJXZK1BrPiEdaM+P1AFNeUoNnGC7Gm
         y0HM1AJhioFy+cUADpVLL/+rgkBARq+T1+v6SpnFI6gk0D7Zdw3qFbYk3mCpHwJ68bsq
         Hcuv6NUndgBlL0AnXKmud6xxJodIjwd9+w+OtiwpCmsb6GQxbzH0z8IGY0resspSlsuw
         b6Abvs6sVvuxZOKo3FoEYV85CyePj/a7EC82xDYMY5tIn0ANVHoL7pJvIe2bDc8bdEP5
         zXHAk3Q4m+h6YNQxPRXZs9c6RU+O8hDPYiaiYANZhRQWeIfbmCh0szC/JccyF3l1k5ki
         0yzg==
X-Forwarded-Encrypted: i=1; AJvYcCWYdieVN0a3X7iAUrI8vFYuoOniDYJ/Z5/6h5KRMcusnVY22Nm3J8DUObMYb095d5xZt4b/PLFdsOy0+mDj+1Rj7q0Jxm4RhPE8
X-Gm-Message-State: AOJu0YwzZDA0g85P+GeEFlPp1Jv5qMZzBba7wcDm6dhMxsxiXIX5h98e
	P+TH2GELceSM8Ota+tmu3h2L3fS5jIde0w9tD+XtPrSOH1pPjRT80vQaVnT5rA==
X-Google-Smtp-Source: AGHT+IHdFTZQRvPcLE1anzbbYiFhhHX5sG6m2LXtCjq4LlIivm5yWh/1UvEWWWYm08Rds2iX75LE4w==
X-Received: by 2002:a17:902:d2c8:b0:1fa:428e:3179 with SMTP id d9443c01a7336-1fa428e332emr144335795ad.45.1719523338255;
        Thu, 27 Jun 2024 14:22:18 -0700 (PDT)
Received: from google.com (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac155c32esm2140625ad.185.2024.06.27.14.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 14:21:56 -0700 (PDT)
Date: Thu, 27 Jun 2024 21:21:11 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Akshat Jain <akshatzen@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/6] ata: libata-scsi: Fix offsets for the fixed
 format sense data
Message-ID: <Zn3Xx11UIbbJkbxq@google.com>
References: <20240626230411.3471543-1-ipylypiv@google.com>
 <20240626230411.3471543-2-ipylypiv@google.com>
 <Zn1WUhmLglM4iais@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zn1WUhmLglM4iais@ryzen.lan>

On Thu, Jun 27, 2024 at 02:08:50PM +0200, Niklas Cassel wrote:
> Hello Igor, Hannes,
> 
> The changes in this patch looks good, however, there is still one thing that
> bothers me:
> https://github.com/torvalds/linux/blob/v6.10-rc5/drivers/ata/libata-scsi.c#L873-L877
> 
> Specifically the code in the else statement below:
> 
> 	if (qc->err_mask ||
> 	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
> 		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
> 				   &sense_key, &asc, &ascq);
> 		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
> 	} else {
> 		/*
> 		 * ATA PASS-THROUGH INFORMATION AVAILABLE
> 		 * Always in descriptor format sense.
> 		 */
> 		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
> 	}
> 
> Looking at sat6r01, I see that this is table:
> Table 217 — ATA command results
> 
> And this text:
> No error, successful completion or command in progress. The SATL
> shall terminate the command with CHECK CONDITION status with
> the sense key set to RECOVERED ERROR with the additional
> sense code set to ATA PASS-THROUGH INFORMATION
> AVAILABLE (see SPC-5). Descriptor format sense data shall include
> the ATA Status Return sense data descriptor (see 12.2.2.7).
> 
> However, I don't see anything in this text that says that the
> sense key should always be in descriptor format sense.
> 
> In fact, what will happen if the user has not set the D_SENSE bit
> (libata will default not set it), is that:
> 
> The else statement above will be executed, filling in sense key in
> descriptor format, after this if/else, we will continue checking
> if the sense buffer is in descriptor format, or fixed format.
> 
> Since the scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
> is called with (..., 1, ..., ..., ...) it will always generate
> the sense data in descriptor format, regardless of
> dev->flags ATA_DFLAG_D_SENSE being set or not.
> 
> Should perhaps the code in the else statement be:
> 
> } else {
> 	ata_scsi_set_sense(qc->dev, cmd, RECOVERED_ERROR, 0, 0x1D);
> }
> 
> So that we actually respect the D_SENSE bit?
> 
> (We currently respect if when filling the sense data buffer with
> sense data from REQUEST SENSE EXT, so I'm not sure why we shouldn't
> respect it for successful ATA PASS-THROUGH commands.)
> 

Thanks for pointing this out, Niklas! I agree, it seems like there is no
reason to ignore the D_SENSE bit.

Interestingly, the code was using ata_scsi_set_sense() before.
Commit 11093cb1ef56 ("libata-scsi: generate correct ATA pass-through sense)"
changed it to always be in the descriptor format.

> 
> Kind regards,
> Niklas

Thanks,
Igor
