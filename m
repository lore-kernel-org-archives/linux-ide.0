Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E808978286
	for <linux-ide@vger.kernel.org>; Fri, 28 Jun 2024 23:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719617503; cv=none; b=S+NhGtS/ULMDWt2+R/RAD5FlC0mSoCCrutsgMf4agr9i+8MRKD1jQrIeeofPEobTgZhCRA/ktXnPL8+z5wKaC/Hc2wWineSaLT6znqCxP0LydmrNssM6AHbg+OKouRzItkF0V4JHyu1AssYLw1aZRpZ6S6bkAdXkxveaDk9wwU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719617503; c=relaxed/simple;
	bh=mlam/RiG8OR5yyf6oFx2Nc/aLd/1oENFLdNxy7ZrQKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnlKIuqCmCAFV7+87SSZ7KG4fqgfqY+OPKJl9SBcFRenlT/f1ueqaWBE/gMGIET86tCGkzFD8cbR2z/vOjsma4HvLyF5U7OdMQUCWDyQ7LATuyvnWkDKbCR5fAh5oJhafYFgdA0bwAefxc2UGHS20In/GdBns59MGheWQeBFoM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ApQAzdfo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ApQAzdfo"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fa55dbf2e7so7196815ad.2
        for <linux-ide@vger.kernel.org>; Fri, 28 Jun 2024 16:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719617500; x=1720222300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U8Hl707zCJA0xyGKMlIZWZ/UJ6SeiwxOy2TmrZ9BO2M=;
        b=ApQAzdfoUYk9c7coETU/0ehfJOU0Cq89hmD9q+M2JBjA7uwnBrA6U8nbi6l2tj1yQ4
         o6H1PwTJBOzYznwiz9xK5akcPNW5rQB0kLHhxuMMYsRqHs+m+KXw1r+9pLliU2pJ3ecj
         JxKt4JlmHmCvfEu5VvPeqa9dru+/VKvUNef0ySSg+RW4t80yCG8uPFNw88XzXVFWttZc
         EPsDWUXs1B1t5IfUYIAmUUDD5k+Pxyb0n9eevZhMiqy5wlvrGLWpnktYh0xQi95uQQ+I
         cmpD6MAOhTBbqX6WYdbgdEIEXF6ZWPyAzn9vik4Wz31ZVE+XXvXLxjPV4+P3XcOYGVPd
         z25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719617500; x=1720222300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8Hl707zCJA0xyGKMlIZWZ/UJ6SeiwxOy2TmrZ9BO2M=;
        b=EhAn9NNoIamrM4/ky0HA3qgV5zG3Po5vdYmDDsWcZU5hKnuR6ud0OUBKbHUj6/O8Yo
         W6QBEqXRGcJwoADJsRvTf6BGGdDDjRzMoFYYZtnAeuDldqyaKk6P02DTCw21nkrcXJE1
         RIzrXDTG8w2ZDOmOfAhNoHxB9Tdj0XZu0HxHnK0VEhxWZ4jZ0lj3x/UfPiwN4S0hOtjU
         oNc7KN9kkr0g2Bwst3LqEDVxDUoQmWXPat2a3JDlhVnK+bBTMKEriAUiuC8PUDvnE8sK
         +v8oziSMCksb/nu9iweDpWKnhLT9WbbAcY82HFfEpcoYaJ0+KyaPNz0S7fT/h1HYVybO
         8vIw==
X-Forwarded-Encrypted: i=1; AJvYcCXZlUJu6Z3uKyQqe9aWslWSv56tRzN4gzz9M1Mdx+kBsg7xg3LTzLzlG68hrT+vpR8u2dsE0tks7iLdBEaUVmUobOwCPsGx56Up
X-Gm-Message-State: AOJu0YyTvNQVsUmd+2+T1P6U8bWWxuxWSY23xfnpycVWPcWTKM4JsBHk
	yaBpwxbjAkbw8gUAu+aMoAbfSz3iH+/z/kZ1WldeMXIrttHDBbdGiRjYOWgi7A==
X-Google-Smtp-Source: AGHT+IEkBsd2z8hCx7tf9ttBNbZoREW7xh1pgF2yJLUtO/CA0CmA0+ZhNDTXd1I+IrIyBkPOtojGLQ==
X-Received: by 2002:a05:6a20:8c16:b0:1bd:2ce9:9e41 with SMTP id adf61e73a8af0-1bd2ce9a0f3mr8987294637.46.1719617499824;
        Fri, 28 Jun 2024 16:31:39 -0700 (PDT)
Received: from google.com (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10c6c40sm21015925ad.60.2024.06.28.16.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 16:31:38 -0700 (PDT)
Date: Fri, 28 Jun 2024 23:31:35 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/6] ata: libata-scsi: Do not overwrite valid sense
 data when CK_COND=1
Message-ID: <Zn9H17FoDDg9hpUr@google.com>
References: <20240626230411.3471543-1-ipylypiv@google.com>
 <20240626230411.3471543-3-ipylypiv@google.com>
 <Zn1zsaTLE3hYbSsK@ryzen.lan>
 <Zn3ffnqsN4pVZA4m@google.com>
 <Zn8EmT1fefVzgy0F@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn8EmT1fefVzgy0F@ryzen.lan>

On Fri, Jun 28, 2024 at 08:44:41PM +0200, Niklas Cassel wrote:
> On Thu, Jun 27, 2024 at 09:54:06PM +0000, Igor Pylypiv wrote:
> > 
> > Thank you, Niklas! I agree that this code is too complicated and should be
> > simplified. I don't think we should change the code too much in this patch
> > since it is going to be backported to stable releases.
> > 
> > Would you mind sending a patch for the proposed simplifications following
> > this patch series?
> > 
> 
> I would prefer if we changed it as part of this commit to be honest.
> 
> 
> I also re-read the SAT spec, and found that it says that:
> """
> If the CK_COND bit is set to:
> a) one, then the SATL shall return a status of CHECK CONDITION upon ATA command completion,
> without interpreting the contents of the STATUS field and returning the ATA fields from the request
> completion in the sense data as specified in table 209; and
> b) zero, then the SATL shall terminate the command with CHECK CONDITION status only if an error
> occurs in processing the command. See clause 11 for a description of ATA error conditions.
> """
> 
> So it seems quite clear that if CK_COND == 1, we should set CHECK CONDITION,
> so that answers the question/uncertainty I asked/expressed in earlier emails.
> 
> 
> I think this patch (which should be applied on top of your v3 series),
> makes the code way easier to read/understand:
> 

Agree, having self-explanatory variable names makes the code much more
readable. I'll add the patch in v4.

Do you mind if I set you as the author of the patch with the corresponding
Signed-off-by tag?

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index d5874d4b9253..5b211551ac10 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1659,26 +1656,27 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>  {
>         struct scsi_cmnd *cmd = qc->scsicmd;
>         u8 *cdb = cmd->cmnd;
> -       int need_sense = (qc->err_mask != 0) &&
> -               !(qc->flags & ATA_QCFLAG_SENSE_VALID);
> -       int need_passthru_sense = (qc->err_mask != 0) ||
> -               (qc->flags & ATA_QCFLAG_SENSE_VALID);
> +       bool have_sense = qc->flags & ATA_QCFLAG_SENSE_VALID;
> +       bool is_ata_passthru = cdb[0] == ATA_16 || cdb[0] == ATA_12;
> +       bool is_ck_cond_request = cdb[2] & 0x20;
> +       bool is_error = qc->err_mask != 0;
>  
>         /* For ATA pass thru (SAT) commands, generate a sense block if
>          * user mandated it or if there's an error.  Note that if we
> -        * generate because the user forced us to [CK_COND =1], a check
> +        * generate because the user forced us to [CK_COND=1], a check
>          * condition is generated and the ATA register values are returned
>          * whether the command completed successfully or not. If there
> -        * was no error, we use the following sense data:
> +        * was no error, and CK_COND=1, we use the following sense data:
>          * sk = RECOVERED ERROR
>          * asc,ascq = ATA PASS-THROUGH INFORMATION AVAILABLE
>          */
> -       if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
> -           ((cdb[2] & 0x20) || need_passthru_sense)) {
> -               if (!(qc->flags & ATA_QCFLAG_SENSE_VALID))
> +       if (is_ata_passthru && (is_ck_cond_request || is_error || have_sense)) {
> +               if (!have_sense)
>                         ata_gen_passthru_sense(qc);
>                 ata_scsi_set_passthru_sense_fields(qc);
> -       } else if (need_sense) {
> +               if (is_ck_cond_request)
> +                       set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);

SAM_STAT_CHECK_CONDITION will be set by ata_gen_passthru_sense(). Perhaps we
can move the SAM_STAT_CHECK_CONDITION setting into else if?

        if (is_ata_passthru && (is_ck_cond_request || is_error || have_sense)) {
               if (!have_sense)
                       ata_gen_passthru_sense(qc);
               else if (is_ck_cond_request)
                       set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);
               ata_scsi_set_passthru_sense_fields(qc);
        } else if (is_error && !have_sense) {


> +       } else if (is_error && !have_sense) {
>                 ata_gen_ata_sense(qc);
>         } else {
>                 /* Keep the SCSI ML and status byte, clear host byte. */

Thanks,
Igor
