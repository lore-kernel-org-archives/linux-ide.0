Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4B0184524
	for <linux-ide@vger.kernel.org>; Fri,  1 Aug 2025 20:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754080095; cv=none; b=FMmsL7PhvjfsUHXPLaBmp6CcBVU+v/U/2V8leT+wkdoWxPqzpz8BjVAWWMIuECM6uu9+qKrH63PaOAiuDgpCDU9x9xWH7ExWEbUbwPsU94HWdEH3MzUigqa4DpWGyaLgEaDxRzeokyYjmvwyDQU5xFpScZF0Gkhx0cy1ZK3A0p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754080095; c=relaxed/simple;
	bh=Uz8s5vDee8LrcpmDrArHmfBBYq7kN8kd5iylwHYsfcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkSWqOJVK0tgOuHukpHvFPdprrQw+2PmJJP9vMLv35Rcy/ithG//s2Vomk/3zcHVR3lwpVsfBCFTmW7NhLfGv8Q/U+MEBoGtwDDY0e6IZmNXIUC81Nedh8xaqXDFRRrrsZi5a/tRSKFVj8R5zDsX6DZ5q0GYtysAypczumtf9uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2omL9D5o; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2omL9D5o"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24070dd87e4so38855ad.0
        for <linux-ide@vger.kernel.org>; Fri, 01 Aug 2025 13:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754080093; x=1754684893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4q3n3lIVQqpRuIVuIMdMH6dgQe/4kFt7Y0C47O5RW8U=;
        b=2omL9D5oJHPobpE7hfUuO03QNzpDH8E5E5QPNGZyGjMvmJRiuvUmKt1cT5y7KGXtUi
         pK1cm57axnyxChPa1wVGgTrlaBIDX3483pUPxkjf52mqQlw90oprcrlCe22tQnLRf5vm
         6AFco4hK8zRxGOMYig96N84Q45Lci5ftg7vCqI0BmnjM6XTPiI35XCeTxcf78G0daPGG
         vDSKd2vkIO4VB1OGPa1xcFR8CSaZoyzOp92OXhR8oGjAvT2NSF3ZAwCWL9rk7FTIOnHQ
         jEMQ3ghIKCtUGk6s+ZgBvA5telJXT06ozzYZMAzkXJjTGLqXPlfAXiUL8fLViEzgv3CA
         FYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754080093; x=1754684893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4q3n3lIVQqpRuIVuIMdMH6dgQe/4kFt7Y0C47O5RW8U=;
        b=v3hwG8WeyfJanMUFPqDJlBENUXSj9/vQHtlwROJILayTcD1iD/WxYjCtmss+0KgDei
         H6ujXyewGGe2RKKLFbLY98yJqJsAsh10YhG94hhCq4AFwXA5UFx+YM/YM9hZA3fRFBQO
         Yjv2C7wD1hkMt4FL14RdyaBvAJlxjg82pnyWeNyy8gWl/72CaqGieI+B6l/DAJ3nKJOk
         bsVfi9k7HlluhbOdH82D7dITbpg8Fp6OnUqL32tn+tEQRlpDfd9bTbn8zG8lvi3sWpRP
         kMWEarF+cs/MeV5uRV6h6LGquqM1/OVrX3ciWGvQ52a8D2ipLHE3fJQ8Fw7cNGLXLMJu
         mYoQ==
X-Gm-Message-State: AOJu0YzUJiwujK6/L8xpp5S9/GClu45diVgyMQPTvP0l/D0E4p+6eLqV
	VjwcKRrcslHyIsNpVWQpmgTUX0fXjrKReWpybGVc2aJpsAv8xhDjko2a66SE9ed9Hw==
X-Gm-Gg: ASbGnctx57R5yAGOblKz3IVUeLCb+HR2d9zoLzvuGWzQ0O4mCfurOmhQuP+huovsdsW
	ygioRMzW1vsXbl129etz7dNCo0Asy4kE22YWUwm7vNfxYR5AWbnUuc/zQvaeUIUI+Y2EnWTqn1K
	/T9Kocp0rji67sW9QzpY0PRbMVvF1MEQsbqfPyfN7Pm9gwK9KZ6k+dLgdmQtT73SM6qXtWjoDcF
	xcgMvhAVdmLTB9MC/U+G5nFTI3/fruWYR5ffXO7p1CWlk+JDtLqcZtFF7a/jDz1Uk0L6rESdqYs
	HTjei1vGSGX6v65mrnIQas4sGyKLiJFRg8yQxmEsyQLnA1IJEKtZZIIyjE45mJAsbMiD4TKnl/V
	lUlihZLtTGB5BBAjwtNZJ8e8+29aK7J2CJQiFnzCOux1zs0GC8NBB6at4tw==
X-Google-Smtp-Source: AGHT+IHM9VbadvBJLyDu+gXfd0mWCxdOKTZ75sKm6gX2WpA45X1auQI2bG7XNhYZ2syqECiudC7nMQ==
X-Received: by 2002:a17:902:d50a:b0:240:b3dd:9ee4 with SMTP id d9443c01a7336-2424a8aed37mr26915ad.11.1754080092427;
        Fri, 01 Aug 2025 13:28:12 -0700 (PDT)
Received: from google.com (166.68.83.34.bc.googleusercontent.com. [34.83.68.166])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b4adsm50506225ad.132.2025.08.01.13.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 13:28:11 -0700 (PDT)
Date: Fri, 1 Aug 2025 13:28:07 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
	Hannes Reinecke <hare@suse.de>, Lorenz Brun <lorenz@brun.one>,
	Brandon Schwartz <Brandon.Schwartz@wdc.com>
Subject: Re: [PATCH 2/2] ata: libata-scsi: Return aborted command when
 missing sense and result TF
Message-ID: <aI0jVxj7GoHMkncK@google.com>
References: <20250730002441.332816-1-dlemoal@kernel.org>
 <20250730002441.332816-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730002441.332816-3-dlemoal@kernel.org>

On Wed, Jul 30, 2025 at 09:24:41AM +0900, Damien Le Moal wrote:
> ata_gen_ata_sense() is always called for a failed qc missing sense data
> so that a sense key, code and code qualifier can be generated using
> ata_to_sense_error() from the qc status and error fields of its result
> task file. However, if the qc does not have its result task file filled,
> ata_gen_ata_sense() returns early without setting a sense key.
> 
> Improve this by defaulting to returning ABORTED COMMAND without any
> additional sense code, since we do not know the reason for the failure.
> The same fix is also applied in ata_gen_passthru_sense() with the
> additional check that the qc failed (qc->err_mask is set).
> 
> Fixes: 816be86c7993 ("ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED before using result_tf")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/libata-scsi.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 9b16c0f553e0..57f674f51b0c 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -938,6 +938,8 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
>  	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
>  		ata_dev_dbg(dev,
>  			    "missing result TF: can't generate ATA PT sense data\n");
> +		if (qc->err_mask)
> +			ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0, 0);
>  		return;
>  	}
>  
> @@ -992,8 +994,8 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
>  
>  	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
>  		ata_dev_dbg(dev,
> -			    "missing result TF: can't generate sense data\n");
> -		return;
> +			    "Missing result TF: reporting aborted command\n");
> +		goto aborted;
>  	}
>  
>  	/* Use ata_to_sense_error() to map status register bits
> @@ -1004,13 +1006,15 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)

There is a redundant check in ata_gen_ata_sense(). qc->err_mask (is_error) is
already checked in ata_scsi_qc_complete() before it calls ata_gen_ata_sense().
 
	if (qc->err_mask ||
	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {

The function will be much cleaner once we remove this check. 

>  		ata_to_sense_error(tf->status, tf->error,
>  				   &sense_key, &asc, &ascq);
>  		ata_scsi_set_sense(dev, cmd, sense_key, asc, ascq);
> -	} else {
> -		/* Could not decode error */
> -		ata_dev_warn(dev, "could not decode error status 0x%x err_mask 0x%x\n",
> -			     tf->status, qc->err_mask);
> -		ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0, 0);
>  		return;
>  	}
> +
> +	/* Could not decode error */
> +	ata_dev_warn(dev,
> +		"Could not decode error 0x%x, status 0x%x (err_mask=0x%x)\n",
> +		tf->error, tf->status, qc->err_mask);
> +aborted:
> +	ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0, 0);
>  }
>  
>  void ata_scsi_sdev_config(struct scsi_device *sdev)
> -- 
> 2.50.1
> 
> 
