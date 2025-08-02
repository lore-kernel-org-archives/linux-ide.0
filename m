Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7631607AB
	for <linux-ide@vger.kernel.org>; Sat,  2 Aug 2025 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754159290; cv=none; b=cPlfoTvdbLHtKeopCS8NIkyFfd3zov6U8kP0KYz6NAzPq9dJfZZLcqGojAoYYRiSjGk0fr2Yu1adTEtO4QTvksUWCimqvHymCiRU77G94XvArVNwszudrg6/mhCx3VW0D/exVprxcFb548vldyiKDkp4pO6Ezwab+WJdKk33rSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754159290; c=relaxed/simple;
	bh=PxkhrvpqPyssTpgvis/mudnDlEKpzDyuPQ1sPi6+i2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKSYRlfgKAcT1/1blRN3Txhvy9g8O8SgiuPXL/ym275U2eQ1+ugBujDv1iUpCaHfNrkP/mDdz/3trM9J6dWoKLc5JwmzFuhRBMD+Y80EXibGvsoP/WfbSdVo0R0RCJBwt5BymDHeKN9Q5BZuhA2Jhr8FDdxRO+nGjbfUZAFuUxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y+29bdVP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y+29bdVP"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24070dd87e4so140915ad.0
        for <linux-ide@vger.kernel.org>; Sat, 02 Aug 2025 11:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754159288; x=1754764088; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lTeewzCCOHL2yQOVuZUf3P6aBx3QaJ/MQSfwFhmZgK4=;
        b=Y+29bdVP2XFLQxvEiF5M2VUGV7FY5aVkE3TN/C2EgrACNJTwaxHj1JRQi+u0bfR3Bb
         oBDIUb3WoSORqLq+23Idu6mQLEhxoNcfWOCe4W3DJkc6/MXVYipZvjJllLWM6ty3yja5
         sH6scLm1NkshkrvIFlxaBBMpk+ncgQ4gIEpyQ34NQSx+s8HN646oqJuplVb4JAYBpKjN
         pnxMR2+eXgaNSBhGE5+nvDYOnsYZCWkibP/3gZt/l8CzWy4ZDB5ufSzLWwTXAosuo6t3
         xHad6oFYhWzRKB3KT0nBxTg2/K8p15j3OR3nOSIsg24BOo2pwe9HswGTcEWtBexKwN1Z
         +b9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754159288; x=1754764088;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lTeewzCCOHL2yQOVuZUf3P6aBx3QaJ/MQSfwFhmZgK4=;
        b=Txe8QNVQ4Y5gUcv/kuKuk99gGw4mSPfDw2EowBhbLYCLmz4L1rHOUQXa2g0IKYqDhz
         Iymum8Uk4cJ1oYmh4GxYn3WjxmY/LFmzyAwCYaYl7ienEO87KljugncxvhrsDo9g2b73
         Ti8ykyqgS04bfOKgwHvFaVDsUGs9SpnBPtX0DKguDCrCS4xfKeXL/udTPWJPAvqfQ1BH
         BDEj8otQQok591Fie3DNZmmcf1rHvSwXjSUZeixyXfCxDDcfS3WWK+Nn+4GzutNspt6K
         Vk6WtqSTDofZNcwDoqUZqdtNi5gJhYhwdRqgPbCWhZShLLPrtld67zmXrIYRwMcWX6WP
         011Q==
X-Gm-Message-State: AOJu0Yx1QkJlvhoh3DwnJ/1t69WlJI+pelTj8/QUQ1zf91960IFeRVpQ
	SpHloHHd0SIzaxOlZ0ojJXqFECWyCicsNuvfF3LB+Avkqyskf4cU1c2Zps9Hb+ZcfA==
X-Gm-Gg: ASbGncutg/g0d/Xt2yLzlsftEHQebezCRrQnl+NcZC47L65GuvbVfbtcjx5OSYUCzlh
	eOqZJJVFtT9d4hkLKqRn7Xl2e2XqX9ZpcAqDVOCLoe/OYH9EoBLZcbPU2/FlcOjke5eRHmV5a1W
	wq6la/0l4eeCkguCa+pTn8HvaCJd7vdbeqihlL/95P8wPDgkZF/1dVf8xg5wpk8gRfiWgztfcsM
	qEzn/d/4kCJ21V78WjAf4LYIavtyTkAGFIoKPqlp81sfEpXn0tvbpehmQ+lloX6sNoF3COHeeJD
	/qY6pr5eP1OcIoi+fd4pEGeKPefRU6UFp+EqZW8aq5k2rEH5t9yJhz+gALOFVf0iFUVp9SiE0Lu
	I4xpnKNi6Cq+13Ec+Abju7QlnxBQqic7ROvUyBLpXdPPxrUK/UyMcFcHl0w==
X-Google-Smtp-Source: AGHT+IFoz4ihNVWzV7UM2DTdsQlFJ3ec4Fj4lW4xXZKvGq6W6K8+KYbZ6XHxV4RY+A6IqQDznQN8/A==
X-Received: by 2002:a17:903:32ce:b0:23d:eb0f:f49 with SMTP id d9443c01a7336-2424893ca92mr2889815ad.14.1754159287296;
        Sat, 02 Aug 2025 11:28:07 -0700 (PDT)
Received: from google.com (166.68.83.34.bc.googleusercontent.com. [34.83.68.166])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bac0d14sm6043321a12.41.2025.08.02.11.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 11:28:06 -0700 (PDT)
Date: Sat, 2 Aug 2025 11:28:02 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
	Hannes Reinecke <hare@suse.de>, Lorenz Brun <lorenz@brun.one>,
	Brandon Schwartz <Brandon.Schwartz@wdc.com>
Subject: Re: [PATCH 1/2] ata: libata-scsi: Fix ata_to_sense_error() status
 handling
Message-ID: <aI5Ysnqw98F3f1TY@google.com>
References: <20250730002441.332816-1-dlemoal@kernel.org>
 <20250730002441.332816-2-dlemoal@kernel.org>
 <aI0d06Z1crjpA2-X@google.com>
 <c375b4b4-5762-42d6-aae5-be1f64e7c720@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c375b4b4-5762-42d6-aae5-be1f64e7c720@kernel.org>

On Sat, Aug 02, 2025 at 12:31:31PM +0900, Damien Le Moal wrote:
> On 8/2/25 05:04, Igor Pylypiv wrote:
> > On Wed, Jul 30, 2025 at 09:24:40AM +0900, Damien Le Moal wrote:
> >> Commit 8ae720449fca ("libata: whitespace fixes in ata_to_sense_error()")
> >> inadvertantly added the entry 0x40 (ATA_DRDY) to the stat_table array in
> >> the function ata_to_sense_error(). This entry ties a failed qc which has
> >> a status filed equal to ATA_DRDY to the sense key ILLEGAL REQUEST with
> >> the additional sense code UNALIGNED WRITE COMMAND. This entry will be
> >> used to generate a failed qc sense key and sense code when the qc is
> >> missing sense data and there is no match for the qc error field in the
> >> sense_table array of ata_to_sense_error().
> >>
> >> As a result, for a failed qc for which we failed to get sense data (e.g.
> >> read log 10h failed if qc is an NCQ command, or REQUEST SENSE EXT
> >> command failed for the non-ncq case, the user very often end up seeing
> >> the completely misleading "unaligned write command" error, even if qc
> >> was not a write command. E.g.:
> >>
> >> sd 0:0:0:0: [sda] tag#12 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
> >> sd 0:0:0:0: [sda] tag#12 Sense Key : Illegal Request [current]
> >> sd 0:0:0:0: [sda] tag#12 Add. Sense: Unaligned write command
> >> sd 0:0:0:0: [sda] tag#12 CDB: Read(10) 28 00 00 00 10 00 00 00 08 00
> >> I/O error, dev sda, sector 4096 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> >>
> >> Fix this by removing the ATA_DRDY entry from the stat_table array so
> >> that we default to always returning ABORTED COMMAND without any
> >> additional sense code, since we do not know any better. The entry 0x08
> >> (ATA_DRQ) is also removed since signaling ABORTED COMMAND with a parity
> >> error is also misleading (as a parity error would likely be signaled
> >> through a bus error). So for this case, also default to returning
> >> ABORTED COMMAND without any additional sense code. With this, the
> >> previous example error case becomes:
> >>
> >> sd 0:0:0:0: [sda] tag#17 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
> >> sd 0:0:0:0: [sda] tag#17 Sense Key : Aborted Command [current]
> >> sd 0:0:0:0: [sda] tag#17 Add. Sense: No additional sense information
> >> sd 0:0:0:0: [sda] tag#17 CDB: Read(10) 28 00 00 00 10 00 00 00 08 00
> >> I/O error, dev sda, sector 4096 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> >>
> >> Together with these fixes, refactor stat_table to make it more readable
> >> by putting the entries comments in front of the entries and using the
> >> defined status bits macros instead of hardcoded values.
> >>
> >> Reported-by: Lorenz Brun <lorenz@brun.one>
> >> Reported-by: Brandon Schwartz <Brandon.Schwartz@wdc.com>
> >> Fixes: 8ae720449fca ("libata: whitespace fixes in ata_to_sense_error()")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> >> ---
> >>  drivers/ata/libata-scsi.c | 20 ++++++++------------
> >>  1 file changed, 8 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> >> index 27b15176db56..9b16c0f553e0 100644
> >> --- a/drivers/ata/libata-scsi.c
> >> +++ b/drivers/ata/libata-scsi.c
> >> @@ -859,18 +859,14 @@ static void ata_to_sense_error(u8 drv_stat, u8 drv_err, u8 *sk, u8 *asc,
> >>  		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark
> >>  	};
> >>  	static const unsigned char stat_table[][4] = {
> >> -		/* Must be first because BUSY means no other bits valid */
> >> -		{0x80,		ABORTED_COMMAND, 0x47, 0x00},
> >> -		// Busy, fake parity for now
> >> -		{0x40,		ILLEGAL_REQUEST, 0x21, 0x04},
> >> -		// Device ready, unaligned write command
> >> -		{0x20,		HARDWARE_ERROR,  0x44, 0x00},
> >> -		// Device fault, internal target failure
> >> -		{0x08,		ABORTED_COMMAND, 0x47, 0x00},
> >> -		// Timed out in xfer, fake parity for now
> >> -		{0x04,		RECOVERED_ERROR, 0x11, 0x00},
> >> -		// Recovered ECC error	  Medium error, recovered
> >> -		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark
> >> +		/* Busy: must be first because BUSY means no other bits valid */
> >> +		{ ATA_BUSY,	ABORTED_COMMAND, 0x00, 0x00 },
> > 
> > Hi Damien,
> > 
> > ata_to_sense_error() already has a check for ATA_BUSY. Perhaps we could add
> > a goto statement and fill ABORTED_COMMAND without looking up the same data in
> > the stat_table?
> 
> Yes, we could do that. I minimized the changes here since this is a bug fix.
> 
> >> +		/* Device fault: INTERNAL TARGET FAILURE */
> >> +		{ ATA_DF,	HARDWARE_ERROR,  0x44, 0x00 },
> >> +		/* Corrected data error */
> >> +		{ ATA_CORR,	RECOVERED_ERROR, 0x00, 0x00 },
> > 
> > I'm trying to understand what this "Corrected data error" is. ACS-6 does not
> > seem to have any references to such corrected errors. BIT(2) of STATUS field
> > is defined as "N/A or ALIGNMENT ERROR bit – See 6.2.2". Does it make sense
> > to translate this bit to "unaligned write command" instead?
> 
> This is an odd one. Indeed, ACS defines it as N/A or alignment error, but up to
> SAT-3, its translation to sense data says "This condition is not considered an
> error". The libata-scsi code has this defined as a recovered error since
> forever, so I did not change it. SAT4 onward do not even define a translation
> for this at all.
> 
> For modern drives, this is all almost completely irrelevant anyway as we get
> sense data, unless there is a big issue with the drive preventing that, which is
> the case this patch is for so that we do not get the non-sensical "unaligned error".
> 
> If you have a look at SAT specifications, you'll see that most of the error bits
> translation in this function are "completely made up", or rather, as the SAT
> specs allows, based on the 3ware driver translation (as noted in the comment for
> the error table).
> 
> I do not want to hit regressions with excessive cleaning of this code, so I just
> let it be.

Thank you for the details, Damien!

Reviewed-by: Igor Pylypiv <ipylypiv@google.com>

> 
> -- 
> Damien Le Moal
> Western Digital Research
