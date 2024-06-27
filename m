Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C19C19FA7B
	for <linux-ide@vger.kernel.org>; Thu, 27 Jun 2024 22:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719525813; cv=none; b=r0W7kaaQD8BMXZEDXgul4xzh5Y4j6SQVzidSG9UApJN4fUddep2X5ADy+rK+CU9cbm6+GH8e1y/St0MMECGqzDh8TqGh3qJxoOaca1cQVvXuUxYckuVhrYEV2dGklFlNDExTBztYK8IifGIUw32vm5BEKVVVoL1qfGVv7efZq28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719525813; c=relaxed/simple;
	bh=ruVGYcvYTiFY7ob3kFKyWPd5pTS6/tfHCvKSvwJN6o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVZEz9Hx3qw7lS+jCg2LEkDHfBuXebIT1y9lHjBLLKFqrZqWBgJmJ/s93cllNyec8c4JYGYACj6WQKYplBHswHAmBlnjFlL7M3OLGPP7noY0CjzcmzcqmmuLOcgSxu18CFc6HP+OrNl7PTUedjxTLBBIIocDBlyDscuEMinVdlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OrZgkI3V; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OrZgkI3V"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7180308e90bso4618810a12.1
        for <linux-ide@vger.kernel.org>; Thu, 27 Jun 2024 15:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719525811; x=1720130611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vhvq8eSOHACbnB6DnMnFlIUUAp+10Kb7/uut0w6GZhk=;
        b=OrZgkI3Vx8YLlcDRNAMszykWdqgrWRh8RM28KWsVhqTMKd6h7zhw9skRigNwmkEa6z
         wYSN/jbBuDlwJoekdF4ReMuYX5gj3G1SnsjWXASsat4j2602iMcW/gKdIfSmf5zCTXtL
         TCVP97cYRbjOFdGJuIAHtwbuxXSTOTkGTo26ytR/raeyBMtLJcN36yWGoXE9dZEnQ8bQ
         dBIKvxwQ/kKdTgxzfNcdKWxy6+3NCNkP25EVRixhgZ9mxNXbaeNCyADl5t1FLu40Ofwi
         gQODmt6II+QamVIK3HfrLlvEErkrEgbITS8ZzgJF878qRTA51I4aTxAtGKAEbqQ0iKAG
         GmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719525811; x=1720130611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhvq8eSOHACbnB6DnMnFlIUUAp+10Kb7/uut0w6GZhk=;
        b=dC4ApMguRb1HwpSr7iINGsnDh6PiA5UX13s8QDPlFfeT/weDWeik0uNgG4Q0FAIulR
         WRh6FBfs5BP87b8noSkNufBGxvqqZdddwYyF8ubs/6js3/SYegN2lPZ6LNuH+UwaF28Y
         NGqHLDTwirx1QpvxS8mb8WWaQYkhjR0C6Ue1YF474+QIlLUnK6beK6+V/6yzb2+jkl5h
         haw6amnJLB8M+JHraX/AqXmWKhWqVGun9XemRoLPuIwe96JPESE1wjIzXgtuNLh231IU
         mftio6on9SU43SpNZ47fYeN1D6rjN01d6BQcW9jxpWEUOxH/8bDyZbTNOtlXsbde+d7D
         UoDA==
X-Forwarded-Encrypted: i=1; AJvYcCXZpeHZFwc2JLsnJrVyozxaGEW2A7DXQTyIV8YvwdmBU697OkFSbfCF2VQ0gNTAu+QNCUean68A1URVrCWJpd0i9bX0gfYpfKIk
X-Gm-Message-State: AOJu0YxG8TUBpuOjsANPuBQSeMh68I4eOJqMxzxAUnPZTiawM0TfQgDn
	VkJTqDONsW8Y7OE9HMNY3sWyskIEca8dHCaWSOczDU14dNnuTR3CVY8dz1pRlA==
X-Google-Smtp-Source: AGHT+IHuylOPpfQrS8FFXZXu4vWvJgTlwjrp3ySkFGvDcPmmxbmb1NWqcNURsPWRzP4vQLioXX96aQ==
X-Received: by 2002:a05:6a20:bf08:b0:1bd:22fe:fca2 with SMTP id adf61e73a8af0-1bd22fefd92mr8274941637.18.1719525810345;
        Thu, 27 Jun 2024 15:03:30 -0700 (PDT)
Received: from google.com (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91c7df8b0sm308591a91.0.2024.06.27.15.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 15:03:29 -0700 (PDT)
Date: Thu, 27 Jun 2024 22:03:26 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED
 before using result_tf
Message-ID: <Zn3hrlF2VW3dWH1f@google.com>
References: <20240626230411.3471543-1-ipylypiv@google.com>
 <20240626230411.3471543-7-ipylypiv@google.com>
 <9c8d751c-8d38-40f4-a88d-cfc39c7b6967@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c8d751c-8d38-40f4-a88d-cfc39c7b6967@kernel.org>

On Thu, Jun 27, 2024 at 09:19:17AM +0900, Damien Le Moal wrote:
> On 6/27/24 08:04, Igor Pylypiv wrote:
> > qc->result_tf contents are only valid when the ATA_QCFLAG_RTF_FILLED flag
> > is set. The ATA_QCFLAG_RTF_FILLED flag should be always set for commands
> > that failed or for commands that have the ATA_QCFLAG_RESULT_TF flag set.
> > 
> > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> 
> Please change "RTF" to "result TF" in the messages below, to be clear (RTF is
> not). Feel free to split the ata_dev_dbg() lines after "dev," to avoid long lines.

Thanks Damien! I wrote "result taskfile" first, then changed it to "result TF",
and then to "RTF" to shorten the lines :)

I'll change it to "result TF" with the line split in v3.

> 
> With that:
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> 
> > ---
> >  drivers/ata/libata-scsi.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index 02af4d5d5799..d5874d4b9253 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -242,10 +242,16 @@ void ata_scsi_set_sense_information(struct ata_device *dev,
> >   */
> >  static void ata_scsi_set_passthru_sense_fields(struct ata_queued_cmd *qc)
> >  {
> > +	struct ata_device *dev = qc->dev;
> >  	struct scsi_cmnd *cmd = qc->scsicmd;
> >  	struct ata_taskfile *tf = &qc->result_tf;
> >  	unsigned char *sb = cmd->sense_buffer;
> >  
> > +	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
> > +		ata_dev_dbg(dev, "Missing RTF: cannot set ATA PT sense fields.\n");
> > +		return;
> > +	}
> > +
> >  	if ((sb[0] & 0x7f) >= 0x72) {
> >  		unsigned char *desc;
> >  		u8 len;
> > @@ -923,10 +929,16 @@ static void ata_to_sense_error(u8 drv_stat, u8 drv_err, u8 *sk, u8 *asc,
> >   */
> >  static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
> >  {
> > +	struct ata_device *dev = qc->dev;
> >  	struct scsi_cmnd *cmd = qc->scsicmd;
> >  	struct ata_taskfile *tf = &qc->result_tf;
> >  	u8 sense_key, asc, ascq;
> >  
> > +	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
> > +		ata_dev_dbg(dev, "Missing RTF: cannot generate ATA PT sense data.\n");
> > +		return;
> > +	}
> > +
> >  	/*
> >  	 * Use ata_to_sense_error() to map status register bits
> >  	 * onto sense key, asc & ascq.
> > @@ -970,6 +982,12 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
> >  		ata_scsi_set_sense(dev, cmd, NOT_READY, 0x04, 0x21);
> >  		return;
> >  	}
> > +
> > +	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
> > +		ata_dev_dbg(dev, "Missing RTF: cannot generate sense data.\n");
> > +		return;
> > +	}
> > +
> >  	/* Use ata_to_sense_error() to map status register bits
> >  	 * onto sense key, asc & ascq.
> >  	 */
> 
> -- 
> Damien Le Moal
> Western Digital Research
> 
Thanks,
Igor
