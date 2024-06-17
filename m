Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26140DDA6
	for <linux-ide@vger.kernel.org>; Mon, 17 Jun 2024 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718667116; cv=none; b=u5VMvR2oaBgxiDazomfio6QPI328t+WdvJcF8g973JAXMzfiqY7B198lKSbmsm9EnengB8przUpzBpxNOpECAdUmgLFFtmv7hEYrr0hYSgKgibInsOPBa5AHPbJrSM4kWXbfHQuv5U9jOuiNgv97lQZgSBTbFWa/7i/V7ssCNGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718667116; c=relaxed/simple;
	bh=7qbkRush5jqH6C4U4mHQ4zNjckTMadOjSd/ADCJT8l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSLuJmamIDuxeJnrCRUtF7GWo92M8XLeIZMCiYHyb7WRfgEHx7EsZY47UPFCYzESIGu4tOXO4uVzPjbI2lcktEGJSODHsZLiUgV2ypL7zi5hTEkzImrOi7Incwl1Q0JPVbai09iIWvhBRclRpg8gRJuE3l1l4tj17ZxBZiaR27U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pRd+vyGL; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pRd+vyGL"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-704090c11easo4022015b3a.2
        for <linux-ide@vger.kernel.org>; Mon, 17 Jun 2024 16:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718667113; x=1719271913; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3FO5nJ1Vj3EUf1P5YQy09laiFztkoKBjLr7YQiDGnGU=;
        b=pRd+vyGL0Tpi3rgrgbnc0naeost6UuElt9l4ylPCTXYNiP1wun5XwhbQx8yXqDfvM0
         Zwwkf8fKztgneWljqtW+0mpEc08MaYnRp5tvG84xmAkYs1HSMe7lHqJzF/8kpDIg75WU
         ppCZX7Zsjcw3n3RXaeDLDleleroh50qnDz2W2CPjOGDougUT1Pp+sQjVlm5y4WsJKf8Z
         5PQ3GZNoBlkYvv09g8SpBTydNnjpsbconA9zrCME+K22/twjmX9fIkzCX7DtV5VjxIjX
         FxVnXPCBowGMeBIJHG/8KnIa8i8DS+7HNuNfTQQEp7P+DOgZ/GVrKORltXjs8ek/GmTc
         Wnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718667113; x=1719271913;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3FO5nJ1Vj3EUf1P5YQy09laiFztkoKBjLr7YQiDGnGU=;
        b=j17iG6M5vLY2VO0cNkwN7qfYaqoUjuSrLyOJlhLyOOzxnbgk55ABQ/LNPV/Dp3yKmS
         BHAU747btvkTIP7sXY83V48IAYe6hHbIs5hrNvq9L0AefCvjPss/vR93t0zwG3J/+W7p
         rp39NFbqaMh0II9FwyIt1Sd20ieyHp6c7gi0D8ri4qfeUzvk/BldyXp6ndxJ64ybmmQ9
         dD9i+zd/fHj40lMNSPAT1YwGH15oa0PI8KWlz2FELrmJKOz1H3gyZWSY1DGoi6z1Zi4n
         oVqGKTyzahtcSOKLYxEEpg+wPH21XgxItmO6v70C3NmPff6TgPnyYkWLiGoHJEdY7cBO
         qVpg==
X-Forwarded-Encrypted: i=1; AJvYcCXtYBkxe8j+JXPq2ZCye56qn+yCsS8ROrkQfIw0HY/X8FOwxIVztvRBtsnB8hRahHh3BtS0++xTJfE+jrwsDzn2Aj1LHBuGV9lD
X-Gm-Message-State: AOJu0YyPRGhJAzwg2lPqUXpppeN9LOngtEYbTyI8IZO1Q6w0wAJnk9hH
	f0zsR5O1rFD6gDdKkQh0qImgDppmFl5g1pjbMwgS9L5vgMyusv3NdFopSYoprQ==
X-Google-Smtp-Source: AGHT+IFxIYRKh3R8VVqY3cVNqHd4fZRi5puptw2mVg4a461ZGXjuvBxhqJ4fvAcNUguJu+wrN+90pQ==
X-Received: by 2002:a05:6a20:a11d:b0:1b4:da55:e1ba with SMTP id adf61e73a8af0-1bae7f65a87mr11801799637.9.1718667113110;
        Mon, 17 Jun 2024 16:31:53 -0700 (PDT)
Received: from google.com (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb6b9c9sm7890966b3a.160.2024.06.17.16.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 16:31:52 -0700 (PDT)
Date: Mon, 17 Jun 2024 23:31:49 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] ata: libata-scsi: Report valid sense data for ATA
 PT if present
Message-ID: <ZnDHZWZQFtUmwtwE@google.com>
References: <20240614191835.3056153-1-ipylypiv@google.com>
 <20240614191835.3056153-4-ipylypiv@google.com>
 <ZnAUy5C-DXEuliSm@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnAUy5C-DXEuliSm@ryzen.lan>

On Mon, Jun 17, 2024 at 12:49:47PM +0200, Niklas Cassel wrote:
> On Fri, Jun 14, 2024 at 07:18:34PM +0000, Igor Pylypiv wrote:
> > Do not generate sense data from ATA status/error registers
> > if valid sense data is already present.
> > 
> > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > ---
> >  drivers/ata/libata-scsi.c | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index 79e8103ef3a9..4bfe47e7d266 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -858,12 +858,17 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
> >  	unsigned char *desc = sb + 8;
> >  	u8 sense_key, asc, ascq;
> 
> Like I suggested in the earlier patch,
> 
> can't you do a:
> 
> if (qc->flags & ATA_QCFLAG_SENSE_VALID)
> 	return;
> 
> here instead?
> 

We need to populate the "ATA Status Return sense data descriptor" as per SAT-5
"Table 209 — ATA command results". By returning early we are skipping the code
that copies ATA output fields into descriptor/fixed sense data buffer.

> 
> >  
> > -	/*
> > -	 * Use ata_to_sense_error() to map status register bits
> > -	 * onto sense key, asc & ascq.
> > -	 */
> > -	if (qc->err_mask ||
> > -	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
> > +	if (qc->flags & ATA_QCFLAG_SENSE_VALID) {
> > +		/*
> > +		 * Do not generate sense data from ATA status/error
> > +		 * registers if valid sense data is already present.
> > +		 */
> > +	} else if (qc->err_mask ||
> > +		   tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
> > +		/*
> > +		 * Use ata_to_sense_error() to map status register bits
> > +		 * onto sense key, asc & ascq.
> > +		 */
> >  		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
> >  				   &sense_key, &asc, &ascq);
> >  		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
> > -- 
> > 2.45.2.627.g7a2c4fd464-goog
> > 
