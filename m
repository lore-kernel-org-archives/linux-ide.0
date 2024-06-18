Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FC916D4F2
	for <linux-ide@vger.kernel.org>; Tue, 18 Jun 2024 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740743; cv=none; b=Qe6ViuoDgP7rfANgu4vH1yWdmWc55MhXE1sWLKmGm3YekKJhYCvwt77ytH/ZlHHJ/sVz5Czc6vlA4Zuwl6eWFWpJiA/z+FSAq5sIw9gYZM+x4OI3pEkmfVB7/1N43TbSkchWMDCCcOlQtfc+82Edar8DqGNwmkvcvD4K3EPoIbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740743; c=relaxed/simple;
	bh=DzUvNMgjfp2wSkyzXhS9hHtcy9tOJqV336Yg0S2PK1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mf1+aV5tb00qyzp+HLR/qhUKyN1CZeq999poiwLXSI7xDzRMXaeTAt39sqPOH20fD+L1Cp56qmZeaAm+l04U0Bj35UwmKjwF4yNuIjbGpWTJgfwB8H/E4TihD4+xupnRn5+HpZ0JqN/4Cod3ZHH7B5onCwyaAv5jiCqoI6ONB/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2d37N+5e; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2d37N+5e"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f70fdc9644so1545345ad.0
        for <linux-ide@vger.kernel.org>; Tue, 18 Jun 2024 12:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718740741; x=1719345541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FFHOdkZMtbgVnUKrgsjlYBo8PKQHi5OtnFCvxiR7rC8=;
        b=2d37N+5eVY/Y0ZqgYh84LUoF8b+Q4i6zmFWs/3L94kI/kmA9u4z7FLP5Mui/MpZiaC
         QhmwvxL7fLNIQ/KjpwtiGStaSdHpUnnl50Jw8GIxYRg1taP4FB02Xr4j+nXM4oWB75Gu
         ZX5I/kKNgWvogfoGYTaOfAbinQcv0PtYhly+V/fAa4uMtDKcHNJZM957K4fLmrARE3ti
         xFJXMAepSDqg01lDAy4xR19ZUGzSVc16gC1IOZFLJwySLYyuj1hUt+IfQt0X8s4kwDEs
         WPniM39Aq5y90Z6gugId+CZsNcsLys1Jv4u3CS/WpvKXqMo3YDfIXbmHXvCKowqPMXKP
         pxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740741; x=1719345541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFHOdkZMtbgVnUKrgsjlYBo8PKQHi5OtnFCvxiR7rC8=;
        b=PeJTszhCnq8DVv96ZNBSghKuTVKUCV3G6d17DIBE2qcKLZ8vmScMs27QpLaLtRraiw
         WGge/Cs9LEYpkrV+4faVze3wJwy8BCNDvRLaRmMdIAUS+5CwiW9i4Lw1TK6VA2f8dhtk
         B08LVBj8ke55qnosHVZiLEK0K91twL8WV24rkhFfooA9yPVk27JjSQJmO32lcoykIGU4
         1k+S4Ot+ATWrxhMRm5SF+UfjKasWxJGDIrF4LS+FsSGvx6kyU86u39uWBBhk6SxeYXOj
         Uxesz6jzteMYJm4VzKstKR29LeNshPnqLZipEG81xt7M0o/aBriWfGzLxqJxIKEvCbzN
         dNkg==
X-Forwarded-Encrypted: i=1; AJvYcCWTMuZowlNv94rCE4xIimQgRWyGJj/7CMAZSONswtdGE7XC11deEwiDy0RS+YugT7XqXyBfGN/XPkeTCQTeiHe0+Zoh4BH6eLyZ
X-Gm-Message-State: AOJu0Yyf0XMCqV5rOSMn8j9FfvBL/jvVA2Toor6T05Ph5zsrZonO3p0e
	yid+lPhMHDmWIhnBWoBqKn50nUfWOnxdSgwEz+T8pqI5XSY7yDNKeKT3XXlWWJ8/Stwv6TAmML8
	Cow==
X-Google-Smtp-Source: AGHT+IHos8Ko7w2LymzJi+scCR3rc7KvYmpUWTzsYJ5tsLPJalRVKanhrbNFJ9Z1kEE299imQvxT2A==
X-Received: by 2002:a17:902:f684:b0:1f6:a572:86ab with SMTP id d9443c01a7336-1f9a8d5de07mr11411455ad.15.1718740740445;
        Tue, 18 Jun 2024 12:59:00 -0700 (PDT)
Received: from google.com (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e6dfb7sm101248115ad.64.2024.06.18.12.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 12:58:59 -0700 (PDT)
Date: Tue, 18 Jun 2024 19:58:56 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] ata: libata: Remove redundant sense_buffer memsets
Message-ID: <ZnHnACszbExFJSuY@google.com>
References: <20240614191835.3056153-1-ipylypiv@google.com>
 <20240614191835.3056153-2-ipylypiv@google.com>
 <ZnAS1nux75l7QlqF@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnAS1nux75l7QlqF@ryzen.lan>

On Mon, Jun 17, 2024 at 12:41:26PM +0200, Niklas Cassel wrote:
> On Fri, Jun 14, 2024 at 07:18:32PM +0000, Igor Pylypiv wrote:
> > scsi_queue_rq() memsets sense_buffer before a command is dispatched.
> > 
> > Libata is not memsetting sense_buffer before setting sense data that
> > was obtained from a disk so there should be no reason to do a memset
> > for ATA PASS-THROUGH / ATAPI.
> > 
> > Memsetting the sense_buffer in ata_gen_passthru_sense() is erasing valid
> > sense data that was previously obtained from a disk. A follow-up patch
> > will modify ata_gen_passthru_sense() to stop generating sense data based
> > on ATA status register bits if a valid sense data is already present.
> > 
> > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > ---
> >  drivers/ata/libata-eh.c   | 2 --
> >  drivers/ata/libata-scsi.c | 4 ----
> >  2 files changed, 6 deletions(-)
> > 
> > diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> > index 214b935c2ced..b5e05efe73f6 100644
> > --- a/drivers/ata/libata-eh.c
> > +++ b/drivers/ata/libata-eh.c
> > @@ -1479,8 +1479,6 @@ unsigned int atapi_eh_request_sense(struct ata_device *dev,
> >  	struct ata_port *ap = dev->link->ap;
> >  	struct ata_taskfile tf;
> >  
> > -	memset(sense_buf, 0, SCSI_SENSE_BUFFERSIZE);
> > -
> 
> Are you sure that this is safe?
> 
> atapi_eh_request_sense() is called both by:
> ata_eh_analyze_tf():
> tmp = atapi_eh_request_sense(.., qc->scsicmd->sense_buffer, ..)
> 
> and by:
> atapi_eh_clear_ua():
> atapi_eh_request_sense(.., sense_buffer, ..);
> where sense_buffer is dev->link->ap->sector_buf.
> 

Thanks for pointing this out, Niklas!

ata_eh_analyze_tf() case is safe because qc->scsicmd->sense_buffer is cleared
by scsi_queue_rq().

atapi_eh_clear_ua() case is safe right now because the sense buffer contents
are not being used. However, someone might start using the sense data in
the future so it is not safe to leave it as-is.

There's one more place where this function is being called:

zpready():
atapi_eh_request_sense(..., sense_buf, ...);
where sense_buffer is dev->link->ap->sector_buf.

This one is actually using the obtained sense buffer so it would be
a nasty bug if we don't do a memset().

I think we should explicitly memset buffers before passing them to
atapi_eh_request_sense() in atapi_eh_clear_ua() and zpready() so that
atapi_eh_request_sense() can have the same behavior as ata_eh_request_sense()
with regards to sense buffer expectations i.e. both functions will expect
buffers that are already memeset to zero.

> 
> Wouldn't a better fix be for ata_gen_* functions to return early if
> ATA_QCFLAG_SENSE_VALID is set?
> 

It would be possible to return early if ATA_QCFLAG_SENSE_VALID is set once
we factor out "ATA Status Return sense data descriptor" population out of
ata_gen_passthru_sense() into a separate function. I'll factor out the
descriptor population code in v2.

I think that it is still benefitial to remove the redundant memset() from
the ata_eh_analyze_tf() -> atapi_eh_request_sense() path?

> 
> >  	/* initialize sense_buf with the error register,
> >  	 * for the case where they are -not- overwritten
> >  	 */
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index cdf29b178ddc..032cf11d0bcc 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -858,8 +858,6 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
> >  	unsigned char *desc = sb + 8;
> >  	u8 sense_key, asc, ascq;
> >  
> > -	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
> > -
> >  	/*
> >  	 * Use ata_to_sense_error() to map status register bits
> >  	 * onto sense key, asc & ascq.
> > @@ -953,8 +951,6 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
> >  	u64 block;
> >  	u8 sense_key, asc, ascq;
> >  
> > -	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
> > -
> >  	if (ata_dev_disabled(dev)) {
> >  		/* Device disabled after error recovery */
> >  		/* LOGICAL UNIT NOT READY, HARD RESET REQUIRED */
> > -- 
> > 2.45.2.627.g7a2c4fd464-goog
> >

Thank you,
Igor 
