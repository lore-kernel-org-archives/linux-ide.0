Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A4B80038
	for <linux-ide@vger.kernel.org>; Fri, 28 Jun 2024 23:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719616100; cv=none; b=b2oK21MgsuJkSYEH4plsPX8sWCtcGBE2KI+i49yg4WzxKXswP0PUBKAody4cSVkqwsdbql+3qkDQTPlq3bYS0B0ZVgRr9grXkpqXBw0Hl6gOYf0O3FavoXF444dns1hkDcWLN0M3PppgCmK5hoV7XXP/XJ7xI3C9aVf8iZB4gyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719616100; c=relaxed/simple;
	bh=NtbVjSdP8d+VGj0ri6OFhKzJIsrRyEWIHSNNTsCFn1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+CgQu/Bx38QMM8cDNMycAhLymMIvAjxmeHn6tIdUri/o6aRy9Y0voDWAFK8LmguBqSEv1F5ixCobfAhtfXXecTvOjvI1no62UN85yVPYGziy4cPoeVeD21U4RUWA90lur/R8ZMpNgOP2wZUE7yJVSfh1QVxWcsMkg2XHD+EPGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i+b+CIvq; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i+b+CIvq"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f9b364faddso8006015ad.3
        for <linux-ide@vger.kernel.org>; Fri, 28 Jun 2024 16:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719616098; x=1720220898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jD9fY0cEwd49BrRewlF88rHZA1K4FTXJg9jWSvOMwnw=;
        b=i+b+CIvqmpETAvpiaICO428rfOlHGT2jHzcs2LWOoTIbCGBcAtpN1wHCuJiavPjRIM
         lpcp4si0ftOHqg5OKhrKieo9KZyw9wqRLh7Mvy0JIcY7GGsKzMNjVm3rIDkzSYr9CLsR
         a0SSgYcqUQJpYDE8jLJXzo66MhNEVwuTySnMYj9lg1eXjS390sp8eDghZr/byrqZ1o15
         TP67qL1ZrEvPJi5OyiIoj6fLGNI7pZthb9Q8iqCVWWw3PuN6XXOhqo1xnZrJ11tXd2Yv
         LRiAcouUAEYRj+5w+H2J8jNirrfCo+q63q4yb4kFcHM/Em388UFavB9lnXBC3N4FJtre
         f6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719616098; x=1720220898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jD9fY0cEwd49BrRewlF88rHZA1K4FTXJg9jWSvOMwnw=;
        b=IKyvP/DGLc9JWrKFnQIEk+K95bJcJ3dN/0EbA4FOALBySVNhShYjR2ikcNAwMYLWma
         NjhPbpfQD/VBvCbUllma747VXAPhktxONb1fr6gqx8JWu5gBDQPN0IGyq1IUQFjBnqWF
         tZ4ARF+uvyZ4wn7SVUZDUBMM8sOqZAxYKZqodEnNo1SioE4LADO30YCk7DKn3naY5y+B
         inb0knG2hRnzOrKg8kYyDgl0/EjhejJYCB3pK2WCEU2vJVLxFaynRNZ9LBVngBvghAYJ
         3luYEfi+PIZ1x3ZvhGN3h5LD8LhKna7R5DCudb5jIkDLoSmrdefpOQh8oe3zW1peYIWP
         U+Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ+WEZJ7QdQONV+59OGAlUSL9+PiEQbH9f/TQhCmZlTRgLOJyq/ybhpTlT0SDkKyvB2YCsZti/FOIKZOQfJahbZ+oerRlHSA2I
X-Gm-Message-State: AOJu0YxVHecAggeME0uDKwFTmi7UrLNMsc9OmFQGF5jivf6GeMuNz0yA
	RZQa/6N8yiBeRSSYgYkdI7/WiVapBjgVW9V0D64T+T25f6rGfOHmJb2Nop453g==
X-Google-Smtp-Source: AGHT+IHjekMXh02l0Ycz2rjYtlbdVH4UamFXyViW/QcLiWsUWCu1Vrnw+AQiFre0Cv3NqpjXzsWYhw==
X-Received: by 2002:a17:903:18d:b0:1fa:1f31:e78a with SMTP id d9443c01a7336-1fa23f07182mr185772005ad.6.1719616097509;
        Fri, 28 Jun 2024 16:08:17 -0700 (PDT)
Received: from google.com (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10c8f81sm20752945ad.28.2024.06.28.16.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 16:08:16 -0700 (PDT)
Date: Fri, 28 Jun 2024 23:08:13 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] ata: libata: Set ATA_QCFLAG_RTF_FILLED in
 fill_result_tf()
Message-ID: <Zn9CXRMWFczmG_P3@google.com>
References: <20240626230411.3471543-1-ipylypiv@google.com>
 <20240626230411.3471543-6-ipylypiv@google.com>
 <Zn8ZIxQRimgVZ2S3@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn8ZIxQRimgVZ2S3@ryzen.lan>

On Fri, Jun 28, 2024 at 10:12:19PM +0200, Niklas Cassel wrote:
> On Wed, Jun 26, 2024 at 11:04:10PM +0000, Igor Pylypiv wrote:
> > ATA_QCFLAG_RTF_FILLED is not specific to ahci and can be used generally
> > to check if qc->result_tf contains valid data.
> > 
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > ---
> >  drivers/ata/libahci.c     | 10 ----------
> >  drivers/ata/libata-core.c |  8 ++++++++
> >  2 files changed, 8 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> > index 83431aae74d8..0728d445e531 100644
> > --- a/drivers/ata/libahci.c
> > +++ b/drivers/ata/libahci.c
> > @@ -2075,13 +2075,6 @@ static void ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
> >  	struct ahci_port_priv *pp = qc->ap->private_data;
> >  	u8 *rx_fis = pp->rx_fis;
> >  
> > -	/*
> > -	 * rtf may already be filled (e.g. for successful NCQ commands).
> > -	 * If that is the case, we have nothing to do.
> > -	 */
> > -	if (qc->flags & ATA_QCFLAG_RTF_FILLED)
> > -		return;
> > -
> >  	if (pp->fbs_enabled)
> >  		rx_fis += qc->dev->link->pmp * AHCI_RX_FIS_SZ;
> >  
> > @@ -2095,7 +2088,6 @@ static void ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
> >  	    !(qc->flags & ATA_QCFLAG_EH)) {
> >  		ata_tf_from_fis(rx_fis + RX_FIS_PIO_SETUP, &qc->result_tf);
> >  		qc->result_tf.status = (rx_fis + RX_FIS_PIO_SETUP)[15];
> > -		qc->flags |= ATA_QCFLAG_RTF_FILLED;
> >  		return;
> >  	}
> >  
> > @@ -2118,12 +2110,10 @@ static void ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
> >  		 */
> >  		qc->result_tf.status = fis[2];
> >  		qc->result_tf.error = fis[3];
> > -		qc->flags |= ATA_QCFLAG_RTF_FILLED;
> >  		return;
> >  	}
> >  
> >  	ata_tf_from_fis(rx_fis + RX_FIS_D2H_REG, &qc->result_tf);
> > -	qc->flags |= ATA_QCFLAG_RTF_FILLED;
> >  }
> >  
> >  static void ahci_qc_ncq_fill_rtf(struct ata_port *ap, u64 done_mask)
> > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > index e1bf8a19b3c8..a9fc3ec9300f 100644
> > --- a/drivers/ata/libata-core.c
> > +++ b/drivers/ata/libata-core.c
> > @@ -4801,8 +4801,16 @@ static void fill_result_tf(struct ata_queued_cmd *qc)
> >  {
> >  	struct ata_port *ap = qc->ap;
> >  
> > +	/*
> > +	 * rtf may already be filled (e.g. for successful NCQ commands).
> > +	 * If that is the case, we have nothing to do.
> > +	 */
> > +	if (qc->flags & ATA_QCFLAG_RTF_FILLED)
> > +		return;
> > +
> >  	qc->result_tf.flags = qc->tf.flags;
> 
> One functional change that I can see from this is that after this commit,
> we will no longer do: qc->result_tf.flags = qc->tf.flags;
> if ATA_QCFLAG_RTF_FILLED was set.

Nice catch, Niklas! I'll fix it in v4. Thank you!

> 
> e.g. ata_scsi_set_passthru_sense_fields() and ata_gen_ata_sense()
> makes use of result_tf->flags, so we probably still want to do this.
> 
> 
> Perhaps keep this function as you have it and simply do:
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 0728d445e531..fdfa7b266218 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -2148,6 +2148,7 @@ static void ahci_qc_ncq_fill_rtf(struct ata_port *ap, u64 done_mask)
>                         if (qc && ata_is_ncq(qc->tf.protocol)) {
>                                 qc->result_tf.status = status;
>                                 qc->result_tf.error = error;
> +                               qc->result_tf.flags = qc->tf.flags;
>                                 qc->flags |= ATA_QCFLAG_RTF_FILLED;
>                         }
>                         done_mask &= ~(1ULL << tag);
> @@ -2172,6 +2173,7 @@ static void ahci_qc_ncq_fill_rtf(struct ata_port *ap, u64 done_mask)
>                         fis += RX_FIS_SDB;
>                         qc->result_tf.status = fis[2];
>                         qc->result_tf.error = fis[3];
> +                       qc->result_tf.flags = qc->tf.flags;
>                         qc->flags |= ATA_QCFLAG_RTF_FILLED;
>                 }
>                 done_mask &= ~(1ULL << tag);
> 
> 
> 
> >  	ap->ops->qc_fill_rtf(qc);
> > +	qc->flags |= ATA_QCFLAG_RTF_FILLED;
> >  }
> >  
> >  static void ata_verify_xfer(struct ata_queued_cmd *qc)
> > -- 
> > 2.45.2.803.g4e1b14247a-goog
> > 
