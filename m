Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530621A01AE
	for <linux-ide@vger.kernel.org>; Thu, 27 Jun 2024 20:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719521764; cv=none; b=kVsbAbG/t75RkcCACvvoMyQN5TQZkVDL4CzXOcL7tZ9LMwqnIOwlucq1WHe+ImW47U1hulkluZFBlhKGzHlEUpMkBVs4CD7MmpZDKnEmdDZRlYlVqcc7qAY94v1Dh6vnkEAtgEDDI8+0WoqtoxdAondDDCqK9xYeEQk7DjNw6mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719521764; c=relaxed/simple;
	bh=h/gokKA/eL9d3uvQ86iiXmtz9Do5OKwAUovd4O2lEvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBepie/Xpx31T7U+JRIAUqSxaYO2wsbGmFCm1kzam8dlmNQQvqFNYHC7j13OEtLyxGBVt7e5ftAtPKFmW0060tBPAiv1sypDECqC2WjUMm4xqFuGMPPUhYhrzWdjn+vdN4f7p3kohXohLarZgVD2oPhLyW8ZkbC5r+1YT8EqG20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gRGXa/+0; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gRGXa/+0"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c8dccd0fa9so1742374a91.2
        for <linux-ide@vger.kernel.org>; Thu, 27 Jun 2024 13:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719521762; x=1720126562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cco6EZF2j8OQE92+f3MjOu4YjycnA9o3NZCPpc89uj0=;
        b=gRGXa/+0aR1gF89enX3KWKGCqIbDrPobmugyQEvZup5PAzfcJ2SIuRuRTPqtciNEUE
         MAxK2k8601X4g1lBheNge7Qnl+r3YaD6cRbJZSL/cJsvbUON15syAykt4kZJO6+C1ymE
         s/uqegLwJwCtW1yphJWyJsxsVmKTiZXCXQPwc1GvgFTSoitj9in6xYPH6/FRe3EguHEZ
         6BcyPQuEg1AjgVcy3qfS9AWC+AzvOH5b40R3DUUCJFVqKfaRhZp6Y1HOhK+VoikV0SwE
         UdVE/10LYYS8Oe2XZ7UMmz6Jw9UYMpJF/e3GekE0TCEv5lMT/Arzt776eWY+R0En5EJZ
         4EvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719521762; x=1720126562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cco6EZF2j8OQE92+f3MjOu4YjycnA9o3NZCPpc89uj0=;
        b=xVMNVKssCv0WqHOjxrcT1LFjKjpjBPxxqb5IX8HssYhle094p1rQzy+M5omRa/w6p7
         ks7kxWKZ0eS0hbaI9jQVh3PsJL5U4n+xRlTt3ogSY4dyj+nAgDHvlZrF9ykUsxiFufOS
         RdYiZJ02mVAwSPDjseUDNVcTXcdl5K+zWCMea/3GDc53zbyrLitaHz87vvwVpAj3cNmA
         +vuHSQhkYXTl1q+BafYK8YggsROOXR1iQQnz5w4eAS9dGi3VxQqrQxke4sqnNoR1Cy3h
         A7zdglnAnSxGrvcsq9GFIkW7bIvf5604vBjybBFBLfL0iO4q3aCcIYa1S0o5xdG8EMto
         z9DA==
X-Forwarded-Encrypted: i=1; AJvYcCW7P2RA58ybwjAFLRrxg1YXszhjpDCRjRNeYUkObCNUR0+i1gFEVwPALiYmlK/torwcAcWmawpGxYj6bP9mWE2/cWofhfUEkdz9
X-Gm-Message-State: AOJu0Yy3obnmjbYJMA/9bZtiwZY/TjQ7aVPXQpZDxh3PTbKQ9JnxHved
	ny2p/uvhuFEQnIZC0871ASriIUekKfOCL5RriNYFF5K8Z78rDzbB4MlSOYGVaw==
X-Google-Smtp-Source: AGHT+IFyz4ki9aGX3jIOrnOMaNPh+xuHBl7iGaMrFplV07Nj7dERB0ologZJCqMGgVX9qvWYMslwrg==
X-Received: by 2002:a17:90a:348b:b0:2c4:aae7:e27 with SMTP id 98e67ed59e1d1-2c8612dbde6mr13756693a91.23.1719521761469;
        Thu, 27 Jun 2024 13:56:01 -0700 (PDT)
Received: from google.com (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3bc525sm228563a91.45.2024.06.27.13.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 13:56:00 -0700 (PDT)
Date: Thu, 27 Jun 2024 20:55:57 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/6] ata: libata-scsi: Do not overwrite valid sense
 data when CK_COND=1
Message-ID: <Zn3R3R_xJFvyNJU-@google.com>
References: <20240626230411.3471543-1-ipylypiv@google.com>
 <20240626230411.3471543-3-ipylypiv@google.com>
 <785a0460-36d5-4e4a-99ea-114081c55bc7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <785a0460-36d5-4e4a-99ea-114081c55bc7@kernel.org>

On Thu, Jun 27, 2024 at 09:16:09AM +0900, Damien Le Moal wrote:
> On 6/27/24 08:04, Igor Pylypiv wrote:
> > Current ata_gen_passthru_sense() code performs two actions:
> > 1. Generates sense data based on the ATA 'status' and ATA 'error' fields.
> > 2. Populates "ATA Status Return sense data descriptor" / "Fixed format
> >    sense data" with ATA taskfile fields.
> > 
> > The problem is that #1 generates sense data even when a valid sense data
> > is already present (ATA_QCFLAG_SENSE_VALID is set). Factoring out #2 into
> > a separate function allows us to generate sense data only when there is
> > no valid sense data (ATA_QCFLAG_SENSE_VALID is not set).
> > 
> > As a bonus, we can now delete a FIXME comment in atapi_qc_complete()
> > which states that we don't want to translate taskfile registers into
> > sense descriptors for ATAPI.
> > 
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> 
> I wonder if we can find the patch that introduced the bug in the first place so
> that we can add a Fixes tag. I have not checked. This may have been wrong since
> a long time ago...

This code was first introduced in 2005 in commit b095518ef51c3 ("[libata]
ATA passthru (arbitrary ATA command execution)").

ATA_QCFLAG_SENSE_VALID was introduced a year later in commit 9ec957f2002b
("[PATCH] libata-eh-fw: add flags and operations for new EH").

IIUC, ATA_QCFLAG_SENSE_VALID has not been set for ATA drives until 2016
when the support for fetching the sense data was added in 5b01e4b9efa0
("libata: Implement NCQ autosense") and commit e87fd28cf9a2d ("libata:
Implement support for sense data reporting").

To me none of the commits looks like a good candidate for the Fixes tag.
What are your thoughts on this?

> 
> > ---
> >  drivers/ata/libata-scsi.c | 158 +++++++++++++++++++++-----------------
> >  1 file changed, 86 insertions(+), 72 deletions(-)
> > 
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index a9e44ad4c2de..26b1263f5c7c 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -230,6 +230,80 @@ void ata_scsi_set_sense_information(struct ata_device *dev,
> >  				   SCSI_SENSE_BUFFERSIZE, information);
> >  }
> >  
> > +/**
> > + *	ata_scsi_set_passthru_sense_fields - Set ATA fields in sense buffer
> > + *	@qc: ATA PASS-THROUGH command.
> > + *
> > + *	Populates "ATA Status Return sense data descriptor" / "Fixed format
> > + *	sense data" with ATA taskfile fields.
> > + *
> > + *	LOCKING:
> > + *	None.
> > + */
> > +static void ata_scsi_set_passthru_sense_fields(struct ata_queued_cmd *qc)
> > +{
> > +	struct scsi_cmnd *cmd = qc->scsicmd;
> > +	struct ata_taskfile *tf = &qc->result_tf;
> > +	unsigned char *sb = cmd->sense_buffer;
> > +
> > +	if ((sb[0] & 0x7f) >= 0x72) {
> > +		unsigned char *desc;
> > +		u8 len;
> > +
> > +		/* descriptor format */
> > +		len = sb[7];
> > +		desc = (char *)scsi_sense_desc_find(sb, len + 8, 9);
> > +		if (!desc) {
> > +			if (SCSI_SENSE_BUFFERSIZE < len + 14)
> > +				return;
> > +			sb[7] = len + 14;
> > +			desc = sb + 8 + len;
> > +		}
> > +		desc[0] = 9;
> > +		desc[1] = 12;
> > +		/*
> > +		 * Copy registers into sense buffer.
> > +		 */
> > +		desc[2] = 0x00;
> > +		desc[3] = tf->error;
> > +		desc[5] = tf->nsect;
> > +		desc[7] = tf->lbal;
> > +		desc[9] = tf->lbam;
> > +		desc[11] = tf->lbah;
> > +		desc[12] = tf->device;
> > +		desc[13] = tf->status;
> > +
> > +		/*
> > +		 * Fill in Extend bit, and the high order bytes
> > +		 * if applicable.
> > +		 */
> > +		if (tf->flags & ATA_TFLAG_LBA48) {
> > +			desc[2] |= 0x01;
> > +			desc[4] = tf->hob_nsect;
> > +			desc[6] = tf->hob_lbal;
> > +			desc[8] = tf->hob_lbam;
> > +			desc[10] = tf->hob_lbah;
> > +		}
> > +	} else {
> > +		/* Fixed sense format */
> > +		sb[0] |= 0x80;
> > +		sb[3] = tf->error;
> > +		sb[4] = tf->status;
> > +		sb[5] = tf->device;
> > +		sb[6] = tf->nsect;
> > +		if (tf->flags & ATA_TFLAG_LBA48)  {
> > +			sb[8] |= 0x80;
> > +			if (tf->hob_nsect)
> > +				sb[8] |= 0x40;
> > +			if (tf->hob_lbal || tf->hob_lbam || tf->hob_lbah)
> > +				sb[8] |= 0x20;
> > +		}
> > +		sb[9] = tf->lbal;
> > +		sb[10] = tf->lbam;
> > +		sb[11] = tf->lbah;
> > +	}
> > +}
> > +
> >  static void ata_scsi_set_invalid_field(struct ata_device *dev,
> >  				       struct scsi_cmnd *cmd, u16 field, u8 bit)
> >  {
> > @@ -837,10 +911,8 @@ static void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk,
> >   *	ata_gen_passthru_sense - Generate check condition sense block.
> >   *	@qc: Command that completed.
> >   *
> > - *	This function is specific to the ATA descriptor format sense
> > - *	block specified for the ATA pass through commands.  Regardless
> > - *	of whether the command errored or not, return a sense
> > - *	block. Copy all controller registers into the sense
> > + *	This function is specific to the ATA pass through commands.
> > + *	Regardless of whether the command errored or not, return a sense
> >   *	block. If there was no error, we get the request from an ATA
> >   *	passthrough command, so we use the following sense data:
> >   *	sk = RECOVERED ERROR
> > @@ -875,63 +947,6 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
> >  		 */
> >  		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
> >  	}
> > -
> > -	if ((sb[0] & 0x7f) >= 0x72) {
> > -		unsigned char *desc;
> > -		u8 len;
> > -
> > -		/* descriptor format */
> > -		len = sb[7];
> > -		desc = (char *)scsi_sense_desc_find(sb, len + 8, 9);
> > -		if (!desc) {
> > -			if (SCSI_SENSE_BUFFERSIZE < len + 14)
> > -				return;
> > -			sb[7] = len + 14;
> > -			desc = sb + 8 + len;
> > -		}
> > -		desc[0] = 9;
> > -		desc[1] = 12;
> > -		/*
> > -		 * Copy registers into sense buffer.
> > -		 */
> > -		desc[2] = 0x00;
> > -		desc[3] = tf->error;
> > -		desc[5] = tf->nsect;
> > -		desc[7] = tf->lbal;
> > -		desc[9] = tf->lbam;
> > -		desc[11] = tf->lbah;
> > -		desc[12] = tf->device;
> > -		desc[13] = tf->status;
> > -
> > -		/*
> > -		 * Fill in Extend bit, and the high order bytes
> > -		 * if applicable.
> > -		 */
> > -		if (tf->flags & ATA_TFLAG_LBA48) {
> > -			desc[2] |= 0x01;
> > -			desc[4] = tf->hob_nsect;
> > -			desc[6] = tf->hob_lbal;
> > -			desc[8] = tf->hob_lbam;
> > -			desc[10] = tf->hob_lbah;
> > -		}
> > -	} else {
> > -		/* Fixed sense format */
> > -		sb[0] |= 0x80;
> > -		sb[3] = tf->error;
> > -		sb[4] = tf->status;
> > -		sb[5] = tf->device;
> > -		sb[6] = tf->nsect;
> > -		if (tf->flags & ATA_TFLAG_LBA48)  {
> > -			sb[8] |= 0x80;
> > -			if (tf->hob_nsect)
> > -				sb[8] |= 0x40;
> > -			if (tf->hob_lbal || tf->hob_lbam || tf->hob_lbah)
> > -				sb[8] |= 0x20;
> > -		}
> > -		sb[9] = tf->lbal;
> > -		sb[10] = tf->lbam;
> > -		sb[11] = tf->lbah;
> > -	}
> >  }
> >  
> >  /**
> > @@ -1634,6 +1649,8 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
> >  	u8 *cdb = cmd->cmnd;
> >  	int need_sense = (qc->err_mask != 0) &&
> >  		!(qc->flags & ATA_QCFLAG_SENSE_VALID);
> > +	int need_passthru_sense = (qc->err_mask != 0) ||
> > +		(qc->flags & ATA_QCFLAG_SENSE_VALID);
> >  
> >  	/* For ATA pass thru (SAT) commands, generate a sense block if
> >  	 * user mandated it or if there's an error.  Note that if we
> > @@ -1645,13 +1662,16 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
> >  	 * asc,ascq = ATA PASS-THROUGH INFORMATION AVAILABLE
> >  	 */
> >  	if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
> > -	    ((cdb[2] & 0x20) || need_sense))
> > -		ata_gen_passthru_sense(qc);
> > -	else if (need_sense)
> > +	    ((cdb[2] & 0x20) || need_passthru_sense)) {
> > +		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID))
> > +			ata_gen_passthru_sense(qc);
> > +		ata_scsi_set_passthru_sense_fields(qc);
> > +	} else if (need_sense) {
> >  		ata_gen_ata_sense(qc);
> > -	else
> > +	} else {
> >  		/* Keep the SCSI ML and status byte, clear host byte. */
> >  		cmd->result &= 0x0000ffff;
> > +	}
> >  
> >  	ata_qc_done(qc);
> >  }
> > @@ -2590,14 +2610,8 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
> >  	/* handle completion from EH */
> >  	if (unlikely(err_mask || qc->flags & ATA_QCFLAG_SENSE_VALID)) {
> >  
> > -		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID)) {
> > -			/* FIXME: not quite right; we don't want the
> > -			 * translation of taskfile registers into a
> > -			 * sense descriptors, since that's only
> > -			 * correct for ATA, not ATAPI
> > -			 */
> > +		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID))
> >  			ata_gen_passthru_sense(qc);
> > -		}
> >  
> >  		/* SCSI EH automatically locks door if sdev->locked is
> >  		 * set.  Sometimes door lock request continues to
> 
> -- 
> Damien Le Moal
> Western Digital Research
> 
Thanks,
Igor
