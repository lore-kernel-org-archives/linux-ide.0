Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E112DDF71
	for <linux-ide@vger.kernel.org>; Fri,  1 Aug 2025 20:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754078683; cv=none; b=aahEurP6VXo6ZGH/IjzWUYKJLNs9i7vWO3FOXir3k4oJOEE0qtxcz+CiZ0MRo0ltwKMqM0qJnvjl15g/xhJlm1JVNkklTyOssWJkjmrjlXjeqQK30CeNh5CtXt8w8tWUnmgiwSa9MCu+2Rt6H/dEVoKEhR8xK/Bd1bzSybcxxrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754078683; c=relaxed/simple;
	bh=PxfVCHqPR5DygB6zcQj88oBRf2KVXR70HuT50cdF0OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esjYin8gkxULlq6L+mCYWK0HHMwHAMCk4tHK1KKux1UoMi0xNTXXocaAj4H46pPl+VIL7nN71aDsuzXx8LKht6WjwSRwSZdWhKOgj6q4zOkWT5Z06BOSJ3mA/GCK2yHup9ZxpYu9TLx6iGHKRso7w7dTpRcLONj+79CvfjiDesk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FRWh16gM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FRWh16gM"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24070dd87e4so34625ad.0
        for <linux-ide@vger.kernel.org>; Fri, 01 Aug 2025 13:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754078681; x=1754683481; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JuYBOVssjviyGqSz+DYG1B4gqZ8lZdGrWEeQxxMQpn4=;
        b=FRWh16gMGEPzi9JYR5UORgnmBsrKqsy9qJospVzKWKTuAC3YJ+MndsCN+44hSOSOMY
         ZMfNZXsYEA60oLs/w2/JJe0aL2btcF0sLPXAcN3cNcEYNDzKtLhSHIPiAcQKIB7JXbwJ
         Zd5gG7qKhBuok3dv7vGWmxQ8hx8WFOIR3UPdgIH4AX4N3ZWeVWr4lW6DjxR5bqe8CpqO
         lkdqSjSQJKD153km3LvnjvuclSZje0RKQrVofk/EQ+yX2yRPckxgCtxeFBlc5lQrYmHS
         VDTH5zOS1ygTMbp31C7yG8vkGwDuz5e9HOwEJ7c4ffMuD+NjfJPPVsveBmmgCa3mCaEz
         v5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754078681; x=1754683481;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JuYBOVssjviyGqSz+DYG1B4gqZ8lZdGrWEeQxxMQpn4=;
        b=ESGwQBeZpv+nPBkwcQ4zu+Pba12qxSFGjk3wo6l3CvXCWMaMBznbLpwaMa8GJvz4Xz
         AuVVQ7bUg1Xxm62JeSFj4R3VrLGXFrT68U65rpI0f6wDZdXeo095NPK0MJpy13/nVvE6
         N70DWqDkb69kKBnPaUYjaeOboQyMVuMpDRezasnAhyXf+6RoCi5ePy7TdkQFwVM/HVKw
         VmVEbYCHI+PA8ITVrogXayz6yPT/FsMs4DNPDhT/LdYmnLiR+qpSBS5EmxNPuMCSGPBh
         /pwMaI2osI4NGj3KsRUCSRjqNPKdMVElkU2kP+lEf3nAwzuqyBUL/QlCsI8VF5zOey/g
         asew==
X-Gm-Message-State: AOJu0Yy+5dKQHR4s94hJQRZJTs6nHua40hHg34Panh+Btk/A0vnrRKq7
	SRkc1VNgY+5Ij6SX++vF3LLjhH+7gYaIn/XiYGLizY1kCxnAedfrf9HnJa+FxU4mPMSCFdcUb2u
	DUiUrCA==
X-Gm-Gg: ASbGncsN20pHSUQBnKZlzXwmw2ON3eE7MPMpZJEl7j5I12WTcI4amNAY/1GbT69XbaH
	C7cgl9M1BLAws827JUz5YknCj8nVp6P5nCRWoY3oETKGC3Fu8Ub9V9p8qF+Ef/NvwhQkZFY3B2h
	9MymMnIgkHAX3ahk/RPBk9dA+kNbuA+DqIhlKh7TBwHzkSqbaVueRTgNyoTjyIllPke1WMOqlDR
	71ZE+3y6LX0zpGwJva8YflKIU9IGfpr+2Msh2FZscH4ANUCXs4+dVMNcHxRakwXoFpugTeShvRV
	uqelqwdMiZNFFn/N4MZ1EMOd6v0bcKP4VIK9Wbo4TXvNmRicDAX3QgvGlo4ouUF/gbf9OxTtL+Q
	D7N9GkI7GUkvd0DaApOIcZWZd6sLNnuzf5GjcX9IaIFSuADvKz2bUWa0UcqZCe86CZ+pq
X-Google-Smtp-Source: AGHT+IFP+CqjTyNes1415o6kgFj3JDYVtlassTmENiRnkIQP9z1ZrATFR57+wjtRLtem0VAE9gqjfA==
X-Received: by 2002:a17:902:db0f:b0:223:2630:6b86 with SMTP id d9443c01a7336-24248b56739mr488295ad.7.1754078680669;
        Fri, 01 Aug 2025 13:04:40 -0700 (PDT)
Received: from google.com (166.68.83.34.bc.googleusercontent.com. [34.83.68.166])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8ac8cb6sm50343985ad.192.2025.08.01.13.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 13:04:40 -0700 (PDT)
Date: Fri, 1 Aug 2025 13:04:35 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
	Hannes Reinecke <hare@suse.de>, Lorenz Brun <lorenz@brun.one>,
	Brandon Schwartz <Brandon.Schwartz@wdc.com>
Subject: Re: [PATCH 1/2] ata: libata-scsi: Fix ata_to_sense_error() status
 handling
Message-ID: <aI0d06Z1crjpA2-X@google.com>
References: <20250730002441.332816-1-dlemoal@kernel.org>
 <20250730002441.332816-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250730002441.332816-2-dlemoal@kernel.org>

On Wed, Jul 30, 2025 at 09:24:40AM +0900, Damien Le Moal wrote:
> Commit 8ae720449fca ("libata: whitespace fixes in ata_to_sense_error()")
> inadvertantly added the entry 0x40 (ATA_DRDY) to the stat_table array in
> the function ata_to_sense_error(). This entry ties a failed qc which has
> a status filed equal to ATA_DRDY to the sense key ILLEGAL REQUEST with
> the additional sense code UNALIGNED WRITE COMMAND. This entry will be
> used to generate a failed qc sense key and sense code when the qc is
> missing sense data and there is no match for the qc error field in the
> sense_table array of ata_to_sense_error().
> 
> As a result, for a failed qc for which we failed to get sense data (e.g.
> read log 10h failed if qc is an NCQ command, or REQUEST SENSE EXT
> command failed for the non-ncq case, the user very often end up seeing
> the completely misleading "unaligned write command" error, even if qc
> was not a write command. E.g.:
> 
> sd 0:0:0:0: [sda] tag#12 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
> sd 0:0:0:0: [sda] tag#12 Sense Key : Illegal Request [current]
> sd 0:0:0:0: [sda] tag#12 Add. Sense: Unaligned write command
> sd 0:0:0:0: [sda] tag#12 CDB: Read(10) 28 00 00 00 10 00 00 00 08 00
> I/O error, dev sda, sector 4096 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> 
> Fix this by removing the ATA_DRDY entry from the stat_table array so
> that we default to always returning ABORTED COMMAND without any
> additional sense code, since we do not know any better. The entry 0x08
> (ATA_DRQ) is also removed since signaling ABORTED COMMAND with a parity
> error is also misleading (as a parity error would likely be signaled
> through a bus error). So for this case, also default to returning
> ABORTED COMMAND without any additional sense code. With this, the
> previous example error case becomes:
> 
> sd 0:0:0:0: [sda] tag#17 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
> sd 0:0:0:0: [sda] tag#17 Sense Key : Aborted Command [current]
> sd 0:0:0:0: [sda] tag#17 Add. Sense: No additional sense information
> sd 0:0:0:0: [sda] tag#17 CDB: Read(10) 28 00 00 00 10 00 00 00 08 00
> I/O error, dev sda, sector 4096 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> 
> Together with these fixes, refactor stat_table to make it more readable
> by putting the entries comments in front of the entries and using the
> defined status bits macros instead of hardcoded values.
> 
> Reported-by: Lorenz Brun <lorenz@brun.one>
> Reported-by: Brandon Schwartz <Brandon.Schwartz@wdc.com>
> Fixes: 8ae720449fca ("libata: whitespace fixes in ata_to_sense_error()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/libata-scsi.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 27b15176db56..9b16c0f553e0 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -859,18 +859,14 @@ static void ata_to_sense_error(u8 drv_stat, u8 drv_err, u8 *sk, u8 *asc,
>  		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark
>  	};
>  	static const unsigned char stat_table[][4] = {
> -		/* Must be first because BUSY means no other bits valid */
> -		{0x80,		ABORTED_COMMAND, 0x47, 0x00},
> -		// Busy, fake parity for now
> -		{0x40,		ILLEGAL_REQUEST, 0x21, 0x04},
> -		// Device ready, unaligned write command
> -		{0x20,		HARDWARE_ERROR,  0x44, 0x00},
> -		// Device fault, internal target failure
> -		{0x08,		ABORTED_COMMAND, 0x47, 0x00},
> -		// Timed out in xfer, fake parity for now
> -		{0x04,		RECOVERED_ERROR, 0x11, 0x00},
> -		// Recovered ECC error	  Medium error, recovered
> -		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark
> +		/* Busy: must be first because BUSY means no other bits valid */
> +		{ ATA_BUSY,	ABORTED_COMMAND, 0x00, 0x00 },

Hi Damien,

ata_to_sense_error() already has a check for ATA_BUSY. Perhaps we could add
a goto statement and fill ABORTED_COMMAND without looking up the same data in
the stat_table?

> +		/* Device fault: INTERNAL TARGET FAILURE */
> +		{ ATA_DF,	HARDWARE_ERROR,  0x44, 0x00 },
> +		/* Corrected data error */
> +		{ ATA_CORR,	RECOVERED_ERROR, 0x00, 0x00 },

I'm trying to understand what this "Corrected data error" is. ACS-6 does not
seem to have any references to such corrected errors. BIT(2) of STATUS field
is defined as "N/A or ALIGNMENT ERROR bit – See 6.2.2". Does it make sense
to translate this bit to "unaligned write command" instead?

Thanks,
Igor

> +
> +		{ 0xFF, 0xFF, 0xFF, 0xFF }, /* END mark */
>  	};
>  
>  	/*
> -- 
> 2.50.1
> 
> 
