Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C209A1494DB
	for <linux-ide@vger.kernel.org>; Tue,  1 Apr 2025 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743530011; cv=none; b=BMgDqAuh5XMi2QmcAEymLpJYykYAhFiEbT8fVVdgFHtHOd1Z09I2qLmgPBGjCc+PJV+FN1mCNZs8mSn+udQ7yTxme0cZP/LLdgN8gJ6hb1YCyO8za+NQjZO1c5Zi3anOxXG8iK8BglnfJchpNq33id1PVYDruP3pCzC3DiYSiCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743530011; c=relaxed/simple;
	bh=wvxv/waaZRYWdWdRl8DiKQfy8QKutFbWJ30fzUtiepQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bG/vNkIWtccs7aGyQJRG/O1BrswuDs0L7dOXik7ouFs4cJNNMWMCQtkLSjf4NzA+k2wlpJA5nvz1BTF/5suNqntviWb/OdQ2q7XejhoSS2ElZh1O96C6kKhNwpQ32ien/veSNlQzaSOR/gPl/VwP3DpggLp6uE93Xnme2RtMQEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kAsIbBwJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kAsIbBwJ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2240aad70f2so25545ad.0
        for <linux-ide@vger.kernel.org>; Tue, 01 Apr 2025 10:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743530009; x=1744134809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BuKW3U5k2j2K6O9+vgWNZIMpH46cUSnt1lE5fqVAeDw=;
        b=kAsIbBwJTRyEkdg2sM29pT9iIWxVJon6Bd2hSaAl4HPR9XfhidYPy3DsRqRrG64Kup
         p3s4fYDDG+joF99Ls/CiQLeWcgvY9n4eBWRxF5o2ln8LsqDk+McM9190zeIgQlJPaZbm
         6cYovdMOPcgbMxIhxSUcjdJ6bGG3TJ5rK3C7IZn8VMPQvwb9Y50Mgov1lTjzmQ03TE+d
         Q9gE2OP+2srmYldtxmIGcBGS3p/RcKZOE9MgWAGMjzPdxaEYH8b1QR3w/eeRxakJwOdi
         WfI9QPt20xdj5AjaReaJVRXVb9vprqVVLiq+Q7WQBQdH+g+18/4TKhlwM+2HYrORtBfc
         LH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743530009; x=1744134809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuKW3U5k2j2K6O9+vgWNZIMpH46cUSnt1lE5fqVAeDw=;
        b=pYKNuEuQ5NWM9Xdhir/Ju8za5pQOE1e0djlm6O07afvBaVtJ2cXowzhQ+oKQi7In9A
         vAdn3EM8TjpOWAzH3UCP4WcGlgQKoJv3lFcaitx3MpFhtrq0qekM5TqIcxkQkLNmg0P0
         ZmO4Inf1lQt6E/02TSjf9MpcTuBCslacbE8E3ACsonbMRpAa5E0nTPj9ZJ85Y9dOsz6p
         F+YAYGJ+6K9QHfuPIS1uREDSHxZvtRgC09RAm6uA/Hoo//I8JJt9V6I7qxZn8TtD2rT/
         S2je/gFSsSAq3bybKUKoucZ7mS1sytyGm5uJiqIfbOgjxgBqc1fh5W8SkR01r/AeqeRQ
         Pjyg==
X-Forwarded-Encrypted: i=1; AJvYcCXQh/qkQ9ybfE2loBkUwBC+30WTgh3S3fU4Za8KdWdIpLky84N+6GLi5UX1YxJKKttzw1MHSJEVVrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YycrX7ie1T5BCmuOfIP3qJPvcoDsRlI7nh/GJDQC0X2hfLtB40e
	bhpGS04KFdAax0ot2Wr2dSBxHXnqfptgYM657C5LXGuMj7zJpBpAmh388yWy7Q==
X-Gm-Gg: ASbGncuobBgG0dSaB8rPHRdDC8uO6xGHEuWzbKAKPBD1K5cWAWWTuyEho6BRbfdaqIU
	k+y0B3yU1T+EcFRiXk1oZ6h/rniULLorvnyojfozI6tBPdeyVfDY2GEK7ZhxX+IvMpfv8ClXRH5
	MaxnY7dtR1yn7VqF6VUePXZXQhc+zxzR2Tz+KGNQ+6JeJ8mqvc2qVESayQt5cMfu7v6FLr4TYFX
	EzzZ5aVMui42Ay4fxdmIcCN55AygffIsxgK4J+EoMtXTxQqdw0xxoRrvm0AhvwSRlWwxo9aWLyS
	V+BpdhCU12bEjcE/nXzzJCeMUbimMdwq9PhmH/1hQaCXXpuDHAQ/xjNTam4Tz09/tRHGJtNdapx
	Kj9kS
X-Google-Smtp-Source: AGHT+IEVr+rrpkDgaLR90xqnLOJyMtMDGV16JBYFAjbEnnQcc00GqpDLdvHapwtSIKNOP+NTkIDzrw==
X-Received: by 2002:a17:902:ab87:b0:21f:465d:c588 with SMTP id d9443c01a7336-22969e0ca96mr152925ad.14.1743530008725;
        Tue, 01 Apr 2025 10:53:28 -0700 (PDT)
Received: from google.com (24.21.230.35.bc.googleusercontent.com. [35.230.21.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e29342sm9532445b3a.64.2025.04.01.10.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 10:53:27 -0700 (PDT)
Date: Tue, 1 Apr 2025 10:53:23 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: libata-scsi: Set INFORMATION sense data field
 consistently
Message-ID: <Z-woE4LfU4qlFmez@google.com>
References: <20250328183047.2132370-1-ipylypiv@google.com>
 <93ec66ce-4fa3-4913-a0b5-9debe47ef8b0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93ec66ce-4fa3-4913-a0b5-9debe47ef8b0@kernel.org>

On Tue, Apr 01, 2025 at 04:33:55PM +0900, Damien Le Moal wrote:
> On 3/29/25 03:30, Igor Pylypiv wrote:
> > Populate the INFORMATION field with ATA LBA when sense data is obtained
> > by the ata_eh_request_sense(). Kernel already populates the INFORMATION
> 
> s/by the/with
> s/Kernel/The kernel or s/Kernel/libata-eh
> 
> > field when sense data is reported via autosense or when it is generated
> > by the ata_gen_ata_sense().
> > 
> > ATA PASS-THROUGH commands, unlike regular ATA commands, populate
> > the INFORMATION field with ATA ERROR, STATUS, DEVICE, and COUNT(7:0)
> > fields thus setting ATA LBA into the INFORMATION field is incorrect.
> 
> Could you rephrase all of this is a manner that is clearer ? That is, describe
> the problem first and then how you fix it. As-is, this is hard to understand.

Thanks, Damien. I'll rephrase it in v2.

> 
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index 2796c0da8257..7e93581439b2 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -216,17 +216,30 @@ void ata_scsi_set_sense(struct ata_device *dev, struct scsi_cmnd *cmd,
> >  	scsi_build_sense(cmd, d_sense, sk, asc, ascq);
> >  }
> >  
> > -void ata_scsi_set_sense_information(struct ata_device *dev,
> > -				    struct scsi_cmnd *cmd,
> > -				    const struct ata_taskfile *tf)
> > +/**
> > + *	ata_scsi_set_sense_information - Populate INFORMATION field
> > + *	@qc: ATA command
> > + *
> > + *	Populates the INFORMATION field with ATA LBA.
> > + *
> > + *	LOCKING:
> > + *	None.
> > + */
> 
> The function name is clear enough. We do not need this kdoc block to clarify it
> and this is a static function anyway.
> 
> > +static void ata_scsi_set_sense_information(struct ata_queued_cmd *qc)
> >  {
> >  	u64 information;
> >  
> > -	information = ata_tf_read_block(tf, dev);
> > +	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
> > +		ata_dev_dbg(qc->dev,
> > +			    "missing result TF: can't set INFORMATION sense field\n");
> 
> Why ata_dev_dbg() ? This should be ata_dev_err(), no ? With your change, this is
> not supposed to be called without the rtf filled...

I used ata_dev_dbg() to match ata_scsi_set_passthru_sense_fields(),
ata_gen_passthru_sense(), and ata_gen_ata_sense().

Last year we settled on using the ata_dev_dbg() to avoid a potential log spam:
https://lore.kernel.org/lkml/ab9f6564-3df1-4061-93e7-32a59aacb205@kernel.org/

Thanks,
Igor
 
> > +		return;
> > +	}
> > +
> > +	information = ata_tf_read_block(&qc->result_tf, qc->dev);
> >  	if (information == U64_MAX)
> >  		return;
> >  
> > -	scsi_set_sense_information(cmd->sense_buffer,
> > +	scsi_set_sense_information(qc->scsicmd->sense_buffer,
> >  				   SCSI_SENSE_BUFFERSIZE, information);
> >  }
> >  
> > @@ -971,8 +984,7 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
> >   *	ata_gen_ata_sense - generate a SCSI fixed sense block
> >   *	@qc: Command that we are erroring out
> >   *
> > - *	Generate sense block for a failed ATA command @qc.  Descriptor
> > - *	format is used to accommodate LBA48 block address.
> > + *	Generate sense block for a failed ATA command @qc.
> >   *
> >   *	LOCKING:
> >   *	None.
> > @@ -982,8 +994,6 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
> >  	struct ata_device *dev = qc->dev;
> >  	struct scsi_cmnd *cmd = qc->scsicmd;
> >  	struct ata_taskfile *tf = &qc->result_tf;
> > -	unsigned char *sb = cmd->sense_buffer;
> > -	u64 block;
> >  	u8 sense_key, asc, ascq;
> >  
> >  	if (ata_dev_disabled(dev)) {
> > @@ -1014,12 +1024,6 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
> >  		ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0, 0);
> >  		return;
> >  	}
> > -
> > -	block = ata_tf_read_block(&qc->result_tf, dev);
> > -	if (block == U64_MAX)
> > -		return;
> > -
> > -	scsi_set_sense_information(sb, SCSI_SENSE_BUFFERSIZE, block);
> >  }
> >  
> >  void ata_scsi_sdev_config(struct scsi_device *sdev)
> > @@ -1679,8 +1683,10 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
> >  		ata_scsi_set_passthru_sense_fields(qc);
> >  		if (is_ck_cond_request)
> >  			set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);
> > -	} else if (is_error && !have_sense) {
> > -		ata_gen_ata_sense(qc);
> > +	} else if (is_error) {
> > +		if (!have_sense)
> > +			ata_gen_ata_sense(qc);
> > +		ata_scsi_set_sense_information(qc);
> >  	}
> >  
> >  	ata_qc_done(qc);
> > diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
> > index 0337be4faec7..ce5c628fa6fd 100644
> > --- a/drivers/ata/libata.h
> > +++ b/drivers/ata/libata.h
> > @@ -141,9 +141,6 @@ extern int ata_scsi_offline_dev(struct ata_device *dev);
> >  extern bool ata_scsi_sense_is_valid(u8 sk, u8 asc, u8 ascq);
> >  extern void ata_scsi_set_sense(struct ata_device *dev,
> >  			       struct scsi_cmnd *cmd, u8 sk, u8 asc, u8 ascq);
> > -extern void ata_scsi_set_sense_information(struct ata_device *dev,
> > -					   struct scsi_cmnd *cmd,
> > -					   const struct ata_taskfile *tf);
> >  extern void ata_scsi_media_change_notify(struct ata_device *dev);
> >  extern void ata_scsi_hotplug(struct work_struct *work);
> >  extern void ata_scsi_dev_rescan(struct work_struct *work);
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
