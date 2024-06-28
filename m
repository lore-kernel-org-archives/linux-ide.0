Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B6B61FCF
	for <linux-ide@vger.kernel.org>; Fri, 28 Jun 2024 23:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719616552; cv=none; b=t33uW2x6ptkp1WyjSR+/+LYOQwz+UrNZhyC7xqO/zLvJUhJoAmd0o5hzE0ggvFNe4Yq8SjrG9UbjOfhu4CCOStGY3V0aX63w83YZrBk98xxE7YL88+Y9ELo6THms93bifTy508vkUZm3pKvIOwGP8gjVu9aay4laW+JomcMm5tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719616552; c=relaxed/simple;
	bh=GXCnN6Gc6mHQhyMlcVl4JuiW37l2AbPh/yqkCVqQk8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDx/TjiRv47vuhif9gmL+4NxHIRyXDyyMadyILHovA3O6B+7gwWU3wHe+RfMOjIqmL+v7cRTlM+NpkmiaF6i6QO0FN1hLH1yZTt2NG1n2NxhL1njcICBUdDby6rIvsj3LEguTVevxZe5KIMJtSaUnGsG+gz+GtLWc89MqjsivIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YCBVU8b3; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YCBVU8b3"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-706b14044cbso973104b3a.2
        for <linux-ide@vger.kernel.org>; Fri, 28 Jun 2024 16:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719616551; x=1720221351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EbSDBkYJnCYPN13RI6gAGzcjnqgBMJXiLfp/idvdK+U=;
        b=YCBVU8b3GUlIMezK9RRl5Zq/kwsBO1KM4vhCf49tkfC04nn7OEzCspJiQ7/XYh8k26
         AxpVb+CLnyLve7HtbWsJOR3uahpsAHz8PvH7J8HpBBTTnqGrVpwHvn4AM0wTRYMAePh7
         sv84gdZ/liFe7PgA1NUCLDebFuMqCF5Z8ReAmCF9nkvoNZCYOqnb0GxczATuT7oNFL/N
         awFkSuwk1/zmbULvVvMLVNGNgD/zrW/qXX/I3jeF3tlJCsK0fJcgOpzbFnvukCz0nn7j
         z127GQkFYwUej53HikLAgQtD9pogIAi3sa7A0L2j9KGHq8uqBhsJTxzHF+7V8ozRjx3M
         6lAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719616551; x=1720221351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbSDBkYJnCYPN13RI6gAGzcjnqgBMJXiLfp/idvdK+U=;
        b=cmpuP1Xrc4Y/s+aYT33j32g40OxMtzQAiPYj8N2axKV9Gq+q5TGbnr8ncM+oPn5eSz
         zf89aZJfW5/ykLYTMrgAyaoIjHWFTLAFVpBxAxDJlUZigI/w91rkt5Jj/kcSKWuDMyQg
         Y8a9j+g1EyJ8JGifnxvyu3eZ379yCL2cKZPSSJ13+BFzDSBVcsqN+vJI3HTrz2VUy+Ak
         ePFXX1xm57O5cOIoi3HK7MDZ4xkAg/X2mVtcFpxQ+uCXQAZ0hJXHcyZfDxFprVvXkf7h
         Dfa1GxmZRDazkNJj4u47aNXTF6ztqLs8eUVHr2UjYQ3GjStOilgmAWdhxZMuq9e6e+k0
         gwgg==
X-Forwarded-Encrypted: i=1; AJvYcCWhqEicUxkuqGcDQjJxD5gdpFND8W1MOFxHilFKzOuQA789VA/1tGHj6X8q+jj4y88+nzzc2xxDo4m4JMPJSwoyHIn+hsr7v5U5
X-Gm-Message-State: AOJu0YxClbZ/mMBBqYO6HFQ/0KDUpOEP3nLT8pguMihsl4EOCFJztOHh
	5h3uqyPEl0VQ7b55BOll9C3VaoeR3DQmQsw0wOoWq/y7QMEoNSj8p0bIM8foXg==
X-Google-Smtp-Source: AGHT+IFUomxsPWf+KjDHq84WqaX003xsKucWIPaupPEaqwSpB3gujhuAtSkVM24DWrgFburemNGz5A==
X-Received: by 2002:a05:6a20:b2a5:b0:1bd:2782:3cda with SMTP id adf61e73a8af0-1bd27823dd1mr10126427637.35.1719616550480;
        Fri, 28 Jun 2024 16:15:50 -0700 (PDT)
Received: from google.com (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e38a9sm21189685ad.76.2024.06.28.16.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 16:15:49 -0700 (PDT)
Date: Fri, 28 Jun 2024 23:15:46 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED
 before using result_tf
Message-ID: <Zn9EIs5BqeFTQD9z@google.com>
References: <20240626230411.3471543-1-ipylypiv@google.com>
 <20240626230411.3471543-7-ipylypiv@google.com>
 <Zn8SPZG4y4wvSH-g@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn8SPZG4y4wvSH-g@ryzen.lan>

On Fri, Jun 28, 2024 at 09:42:53PM +0200, Niklas Cassel wrote:
> On Wed, Jun 26, 2024 at 11:04:11PM +0000, Igor Pylypiv wrote:
> > qc->result_tf contents are only valid when the ATA_QCFLAG_RTF_FILLED flag
> > is set. The ATA_QCFLAG_RTF_FILLED flag should be always set for commands
> > that failed or for commands that have the ATA_QCFLAG_RESULT_TF flag set.
> > 
> > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
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
> > -- 
> > 2.45.2.803.g4e1b14247a-goog
> > 
> 
> In order to be more consistent with existing prints in this file,
> please do not capitalize the first letter, and remove the punctuation.

Thanks! I'll remove periods and will keep the colons.

> 
> 
> Kind regards,
> Niklas
