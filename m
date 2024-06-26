Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D587019309C
	for <linux-ide@vger.kernel.org>; Wed, 26 Jun 2024 23:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719443482; cv=none; b=MMU9H83pB/GBwFi/xmMSlR5IHPZ8MTRR3fZBBsk9L2WBXiYb689GlRa1qNo3BCtkzRosdRbJFQB9b3eH5AhhxMQGnlrQRXw0XLxw5X5umcYfaXcK0Z/jKGWJXMys8gtZZ176U4E2iJQbxq57jaTJu0/KC4DDgPrK9Ov+aOEUPCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719443482; c=relaxed/simple;
	bh=mUWhhLbgN6nl3yENs/GEivbhZRy0Wq9Dz0D1sL47sQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdGhwut4Bei3NxUz37jVHt04fS39Q7kr3DHu2jgCid6DbIwVBvV+gfwmlFY1YLj7fL7+tLZib9bbQfaMGtRd07DYKdPKhVoReW1S3KRqZwbrdCNOHL9ttnCEI6ObK/si1a1kX6rASUjwtgUUW5DCtLEXJtw736Cz61Ciog8d+E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kj7sU/ss; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kj7sU/ss"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d5611cdcb7so545818b6e.3
        for <linux-ide@vger.kernel.org>; Wed, 26 Jun 2024 16:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719443479; x=1720048279; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oF0gfjmlTTx6hmif/3dN/HOBOIoUolbTTwBRvXTw/ps=;
        b=kj7sU/ssauGG1oboQXjXy5zZzX6tfXzhcWr7xsJukiBgGwv0X6+hBDAqkvNdyAkUCK
         t859N0vqeXKBT7wERLJzGjCfIgoE8J7Qa8j7aM0LDPuqvNzRmV+b+Gx1tULoYXUGfhrv
         5kqZoi9I9bJVFQb9NZ8P9aQ5bxiSwMXg4BvAKITHIxUXyLEwvpr9jmu/7kEV8D9hHQI4
         Z7obuDk0wnR1TgElboCptkTDMyhBoSdKjBIEcIRghaE3pGj9zpBWNDpXVFtpuu6awToa
         M5OVF2BZrJ/IMN7caJAafVmOxJG1K5oPTOQpGLUN+ezG9UhzRVx7UPwDDmZdQkSw8n13
         6y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719443479; x=1720048279;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oF0gfjmlTTx6hmif/3dN/HOBOIoUolbTTwBRvXTw/ps=;
        b=EiGOtDF55PnZcE2qRRQri5nruxJJFIuChr0ZUYhr4HC+G51tNITEHIYmdZArGi0PxU
         3Frm6MQ3XFGzLefLRPVrcd4/9kDz6tgHKLPgf0K2JacTQBf2mPKnmJe+BCfc5wZyibu/
         mwSC10iwGXthOjt8Ae8OwewrJKhGmcQvLx/viPMvswbtvYhoRTxan2Y1YZ6/V/n/Q3uy
         tA8KGoik5PJcm5nPc3zWK9jHse02L76+93F+YRmEzbG9bIamPd2MSlnEXFoeYFC9s9Vm
         sZppHsG1aADHCgmxGAjC5bc/TQq0B49zMQAKowDahlHBImUn6MsmaaQN5okvF9Ez+b7X
         F1Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVYnei3NJR6KsCleNU37sJzEbjMRp5wV3PS+f0muWLzlIkvChAA0dfoJq/LT1osi71qav3k0nhRnJOAgV9Z+gkjGjrSI/anG+Tv
X-Gm-Message-State: AOJu0YxYX5JoeyUhOEHzF2nflyAoLWwFf1wJiiNKQTOuAQWKluYW9ZHw
	LH6//Dw1TZe8MesghvZwReYvt+UujxEaDAMk60kX/eGM0k6TXSQJXCmf281aTw==
X-Google-Smtp-Source: AGHT+IFSwZ4HAACuGuWBOrFcp9DWdYoYoG41UP10z6VykeGjmV/v3EVoaHY/c1qzHRonS8zQvapVXA==
X-Received: by 2002:a05:6808:f05:b0:3d2:1eb6:4894 with SMTP id 5614622812f47-3d5459639fbmr13115485b6e.19.1719443478553;
        Wed, 26 Jun 2024 16:11:18 -0700 (PDT)
Received: from google.com (148.98.83.34.bc.googleusercontent.com. [34.83.98.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b491026esm34000b3a.55.2024.06.26.16.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 16:11:17 -0700 (PDT)
Date: Wed, 26 Jun 2024 23:11:14 +0000
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Niklas Cassel <cassel@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jason Yan <yanaijie@huawei.com>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED
 before using result_tf
Message-ID: <ZnygEoFkgUlorAc9@google.com>
References: <20240624221211.2593736-1-ipylypiv@google.com>
 <20240624221211.2593736-7-ipylypiv@google.com>
 <7d085940-2ad1-4f44-83bb-33d852e80da0@suse.de>
 <ZnthK-NjkSgIiGiE@google.com>
 <ab9f6564-3df1-4061-93e7-32a59aacb205@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab9f6564-3df1-4061-93e7-32a59aacb205@kernel.org>

On Wed, Jun 26, 2024 at 03:21:58PM +0900, Damien Le Moal wrote:
> On 6/26/24 09:30, Igor Pylypiv wrote:
> > On Tue, Jun 25, 2024 at 08:26:59AM +0200, Hannes Reinecke wrote:
> >> On 6/25/24 00:12, Igor Pylypiv wrote:
> >>> qc->result_tf contents are only valid when the ATA_QCFLAG_RTF_FILLED flag
> >>> is set. The ATA_QCFLAG_RTF_FILLED flag should be always set for commands
> >>> that failed or for commands that have the ATA_QCFLAG_RESULT_TF flag set.
> >>>
> >>> For ATA errors and ATA PASS-THROUGH commands the ATA_QCFLAG_RTF_FILLED
> >>> flag should be always set. Added WARN_ON_ONCE() checks to generate
> >>> a warning when ATA_QCFLAG_RTF_FILLED is not set and libata needs to
> >>> generate sense data.
> >>>
> >>> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> >>> ---
> >>>   drivers/ata/libata-scsi.c | 10 ++++++++++
> >>>   1 file changed, 10 insertions(+)
> >>>
> >>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> >>> index e5669a296d81..7a8a08692ce9 100644
> >>> --- a/drivers/ata/libata-scsi.c
> >>> +++ b/drivers/ata/libata-scsi.c
> >>> @@ -246,6 +246,9 @@ static void ata_scsi_set_passthru_sense_fields(struct ata_queued_cmd *qc)
> >>>   	struct ata_taskfile *tf = &qc->result_tf;
> >>>   	unsigned char *sb = cmd->sense_buffer;
> >>>
> >>> +	if (WARN_ON_ONCE(!(qc->flags & ATA_QCFLAG_RTF_FILLED)))
> >>> +		return;
> >>> +
> >>>   	if ((sb[0] & 0x7f) >= 0x72) {
> >>>   		unsigned char *desc;
> >>>   		u8 len;
> >>> @@ -928,6 +931,9 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
> >>>   	unsigned char *sb = cmd->sense_buffer;
> >>>   	u8 sense_key, asc, ascq;
> >>> +	if (WARN_ON_ONCE(!(qc->flags & ATA_QCFLAG_RTF_FILLED)))
> >>> +		return;
> >>> +
> >>>   	/*
> >>>   	 * Use ata_to_sense_error() to map status register bits
> >>>   	 * onto sense key, asc & ascq.
> >>> @@ -971,6 +977,10 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
> >>>   		ata_scsi_set_sense(dev, cmd, NOT_READY, 0x04, 0x21);
> >>>   		return;
> >>>   	}
> >>> +
> >>> +	if (WARN_ON_ONCE(!(qc->flags & ATA_QCFLAG_RTF_FILLED)))
> >>> +		return;
> >>> +
> >>>   	/* Use ata_to_sense_error() to map status register bits
> >>>   	 * onto sense key, asc & ascq.
> >>>   	 */
> >>
> >> Hmm. Not sure if we really need the WARN_ON() here or whether a simple
> >> logging message wouldn't be sufficient; after all, we continue fine here.
> >>
> > 
> > My worry about adding a simple log statement is that it might cause a log
> > spam if things go wrong for some reason.
> > 
> > This code is more like a "this should never happen" comment and we always
> > expect ATA_QCFLAG_RTF_FILLED to be present when generating sense data
> > based on ATA registers.
> > 
> > If WARN_ON_ONCE() is too much for this case I guess we can just remove it
> > and silently return?
> 
> what about ata_dev_dbg() or ata_port_dbg() ?
> No message spamming by default and if problems are detected, they can be turned
> on to figure out what is going on.

ata_dev_dbg() should work. Updated the patch in v3.

Thank you!
Igor
> 
> > 
> > Damien, Niklas, what are your thoughts on this?
> > 
> > Thanks,
> > Igor
> > 
> >> Cheers,
> >>
> >> Hannes
> >> -- 
> >> Dr. Hannes Reinecke                  Kernel Storage Architect
> >> hare@suse.de                                +49 911 74053 688
> >> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> >> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
> >>
> 
> -- 
> Damien Le Moal
> Western Digital Research
> 
