Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547BD276055
	for <linux-ide@vger.kernel.org>; Wed,  9 Apr 2025 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744219806; cv=none; b=W7Lv3+7FotVGNxDnvrKyIombrJFAq+km+BhKpP786TA4JzjyV+afMcrSyXPKn+qtNPBdfeB1XokDm0F0VuLCIBT7i9vZyA33OlZvWZOdtIbCnXmDLv2ssRvGFs7BJpo1e9SGc7KidVQGpCIllTBsNQ+aHFOz9uWBqgYgMF7Dshs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744219806; c=relaxed/simple;
	bh=f8XhRixz1+4ioTLwiFBQaTBADvLbTukFWsQO/w35YUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuSaX1+TuFbqQLM7FpLSsaJgvnl48Pk3My366GFcFd3NyGrEmArZfrU/kUbDGRvLcC5jZ1GMHM3hfzPAaqRsF0ZgiOIYqHss2rSm4gmF45J5QcPSIJnR3zPOxsbPl8exm5L1Eevhrpn7o1ZidHk71mbfjPGDP6lwq/9L/KgN8Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JnQb86tw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JnQb86tw"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2263428c8baso13035ad.1
        for <linux-ide@vger.kernel.org>; Wed, 09 Apr 2025 10:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744219804; x=1744824604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bA6nfxlqHyTKgFTzGsjaExKbEy/PWX/YOg0goQL4lYQ=;
        b=JnQb86twdH5Bp7XWUjtaj7qXA8rbwbbVza2e0jTqiP/5ZM6M1yo1ytn5OJVjZejm6H
         qnArfr7hwKYBQZTvTX53LwGi87O7yP+plc1EyRaGLOzsRpTKjLQ7/H7qHxBjg9l3LPEp
         G+tusIr82BCc1jZYER6bhSEhyjFE4rfsHK98/uavB1slAicRrrIVEQIWfOmO9CpIAYwN
         XMnk6S2V7i0lhY/E3SBB1hBXZPk1Z6DjGq0LzJeUIabxuQt0ZZeoiAZGQwc6KljVp2bd
         fn8RpsNGyw+5zNJrBtcIAeVdjzMtOTk5CJJZAFIK3Vs7SpV7GSLrye6NdKxxeG1JdjoW
         dgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744219804; x=1744824604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bA6nfxlqHyTKgFTzGsjaExKbEy/PWX/YOg0goQL4lYQ=;
        b=Qz/wG+fqG/X+JH8hNV8Qzi6s4YO0UNPYGGYPEwKqbMbZH/ZrIwcveNll09aEMD/KFP
         QLbE4jgGIQgv7op6iBCs0osZeEnba/+yu0BljujLHkcRjiI7ztNA7+Vb/vViky8qBzaV
         pa+e0sdAKAT2Y/OUFPeAZ/nw8PmJLqYFUj2Ru7ZQk4dZBwflcywQPS5sd+uXjKm10eP5
         XCEfS3U2Y+YE0K0N480zpz3hCoSFFpAJKWR0qzkAmpyEYpqpchl25/vP0HWupp3G7kvA
         wJgNiP8+VDivxyLDNol2kTC76kzildKJEa5X5F+ipRUeFbbGpczxvgvbk6WHj7QyKMKG
         2Ekw==
X-Forwarded-Encrypted: i=1; AJvYcCWy//uErQB03l+sWRmVxAnC2s8HTATp28TuRv5vQfbKF5TvJxzYrqZ0qmR6qp+iltHmGO5UnBwE7gU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBjAI65jFtA8iVbVxEIZc/nEXfPt4jU27f78CU/Sjz5J/sLVMj
	zjOQvG3aZau/jKWTylFW78FMHMSo0TLWPJlqqWPjNOo+28tvssto9fjiozb5FbVroDWm9nYSXAq
	Ocw==
X-Gm-Gg: ASbGncv5IOk7sYAyjzf1G8JiGtw6gYKwkZ1XC0Xeu0n28jC7QFMxxIp0rnqVWwLTeFC
	EXnteiX0U3tpJLUL1uu4cbz0YQkAhyjAopx0N0w/SU0/N+w2UAqicbbhmupXy9if+s3Gt0FISrn
	huLQQQ7Q43MeUeboYlhHaffXSE3h4zuW0KHdv2BTzJjOI/M+HFMc5nsPynHy7NepPBcMRmTGxV4
	w2+jB7rpvDGMI7a3Oa60wD8xG/SD4336mc3xWyix+dfK9DnS03r7EqlZgVYCLx6NI5ALldT8O8t
	KWZUElQ8fECVEkTyC7/uYWyAOWef0YT5WuQEOcIZQurDZgZ7jcmb27jBkJhzjf2X4U7PL/+yO28
	0
X-Google-Smtp-Source: AGHT+IEpGRD1ONIbVAdkjntGAmmePDjpT7WNkrKpQapjx5pYgVlDdfDiUxZG6kIOmBDDnSjOp7HDWg==
X-Received: by 2002:a17:903:3c67:b0:223:fd7e:84ab with SMTP id d9443c01a7336-22ac30d76aamr4606545ad.24.1744219804237;
        Wed, 09 Apr 2025 10:30:04 -0700 (PDT)
Received: from google.com (24.21.230.35.bc.googleusercontent.com. [35.230.21.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb534csm14771875ad.180.2025.04.09.10.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 10:30:03 -0700 (PDT)
Date: Wed, 9 Apr 2025 10:29:59 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2] ata: libata-sata: Use LBA from sense data descriptor
Message-ID: <Z_aul100eqb2-naM@google.com>
References: <20250409084546.121694-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409084546.121694-2-cassel@kernel.org>

On Wed, Apr 09, 2025 at 10:45:47AM +0200, Niklas Cassel wrote:
> The definition of the LBA field in the sense data descriptor is:
> 
> "If definition of the sense data to be returned when a command completes
> without an error includes an LBA value, then the LBA field contains the
> defined value. Otherwise, the LBA field contains a copy of the LBA field
> in the command inputs for the command that completed without an error
> and returned sense data."
> 
> Thus, the LBA field in the sense data descriptor can contain a LBA value
> that is different from the LBA field in the command input.
> 
> Therefore, just like how ata_eh_read_log_10h() overrides qc->result_tf
> with the LBA in the NCQ Command Error log, override qc->result_tf with
> the LBA in the Successful NCQ Commands log.

Hi Niklas,

Should we also override other fields e.g. COMMAND, FEATURE, COUNT, AUXILIARY?
I understand that per current SAT spec those fields contain data from command
inputs so we can get the same data directly from qc->tf and technically don't
need to fill qc->result_tf with the same.

If I understand correctly, qc->result_tf contains data filled from a shared
FIS so it is likely that it contains data that belongs to some other command,
is that true? If that's true, should we clear the qc->result_tf before filling
the fields with data from the Successful NCQ Commands log?

Thanks,
Igor

> 
> Fixes: 18bd7718b5c4 ("scsi: ata: libata: Handle completion of CDL commands using policy 0xD")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/libata-sata.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index ba300cc0a3a3..c21fdacd0777 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -1556,6 +1556,14 @@ int ata_eh_get_ncq_success_sense(struct ata_link *link)
>  			continue;
>  		}
>  
> +		/* LBA in sense data desc can be different from LBA in qc->tf */
> +		qc->result_tf.lbal = sense[8];
> +		qc->result_tf.lbam = sense[9];
> +		qc->result_tf.lbah = sense[10];
> +		qc->result_tf.hob_lbal = sense[11];
> +		qc->result_tf.hob_lbam = sense[12];
> +		qc->result_tf.hob_lbah = sense[13];
> +
>  		/* Set sense without also setting scsicmd->result */
>  		scsi_build_sense_buffer(dev->flags & ATA_DFLAG_D_SENSE,
>  					qc->scsicmd->sense_buffer, sk,
> -- 
> 2.49.0
> 
