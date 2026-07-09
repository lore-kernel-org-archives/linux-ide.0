Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D0B2D781B
	for <linux-ide@vger.kernel.org>; Thu,  9 Jul 2026 04:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783571799; cv=none; b=T1qaI+BcS6Wqd+9/J1ReC8DxP0IJqEHqYtdEmKjb7sfEoZlXFrPZm8qvpvCILG6RQjXFlldajFYGDYpWFagk4WDqgu1514iAxoBfupCPSRvP+jrby/DXmDhmeovoOyigAK8W46D8sjQkStYUd5xAQtLqq1bRFqB2q8i5pk2XQuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783571799; c=relaxed/simple;
	bh=cJNH2LoCno3RyHaKnKxAQk3XlUBLXJUiRCkfFBryEqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqQbDeRTLH9j6SqkO6GU83kZRBayg/w1d6FgerJTuO4Xt+pj4imXbrO2xABR3sYZeLVe47ZJQS3ZxrR2xD31j0wx2mL8BMvy9YdelCuSGMgoj4OxdUz4gCP1tDBHf47TK6dTRc/UpElBjnpwxqxA8NrG21jz1Og7BXdnhqjkDkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oX0QjfET; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oX0QjfET"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ccdf36f63dso72125ad.0
        for <linux-ide@vger.kernel.org>; Wed, 08 Jul 2026 21:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783571798; x=1784176598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C/e9zeofXY3+pcFO6xjlYgqQd30GeoO2uMIiITsRZ4I=;
        b=oX0QjfETtMhw56AuICasNbDJ8nj6qHGbYHKEBFhbbxHXaY2LOqmgok7f/grVBWz8OC
         nhBwIlwho3qTJuYcX1EsvroZgMQdKfacwiOxkExQhDL/3pefllTW7j0rRngP0A3B9Iq1
         B0kebqOmLxiNfvz4sAUUXjKGt7H2LhuL7ukh4ROclpBideNzUtVibyrH/Ld3LzpRsPPR
         FRs95loiTFQ10SOJJpHVKlRfpvygb7DNqZCCxPSwnX5Tqmb2CQIE7s3eYrUqHpGwanZp
         XhGG5o4UGhj1P03mNzE6FGr42PDRlDfyayQ97+fb91tt7vQewh4cAIcfdYujVYIUWZwQ
         Zpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783571798; x=1784176598;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C/e9zeofXY3+pcFO6xjlYgqQd30GeoO2uMIiITsRZ4I=;
        b=BKMKgtgWoz676OtpssQcTiFGeW1W2xH/GoB+Rm88U6G5uMx23TdqUdM6qTOtFgvTXJ
         nZPDMjD3tld0nqmiW9CR7HtnrvBRhiVEgcYDaEpX7KlTqea9YoRTfpSeaOIV0Jy5W2Kp
         pwLyDKRFAraiGj/rUn/XCW1uv9DbRS9Z3lPS/RXuA+WCSwiuClPQle4Xlhv/f8XM4b7d
         38c1YQ+DJ+4C/L26QsORNWmS+x+j9CNHw+/TIfGh0iqpOWxwLvboY3ROmSZgWh1Ir1kx
         SdWg1eaOgO/btbdY8WL0gpxkDlsjPg3oj+P8EvixRyENz/77vhb4zj/hPABwRyCeHSB5
         LsLg==
X-Forwarded-Encrypted: i=1; AHgh+RpmCcuy7GbPpOEG2SyI+bvVv1hkwyotRi+oU4bpoKclvHvC55ePiURU3KyQysCQu4c2/E5iVXejiTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMXkW4Iyha1+em27HIoxRdtu6QPw9/+74nfIarfbdpD5IXKTYC
	dDBNlhZcd/ix8ZEClpqfpo8kpH/1+ItUWB4RtwIPcrEVdQ/0anvUMKBizHMl+gRZnQ==
X-Gm-Gg: AfdE7clnH6LEWkxKFvaCmeJnQdLuwlGWwh8lJBMqMyg0kyjERxmBIOGHcobV++3NOWd
	vHzv7AP/zvtbBzOs4mXdt0BSfzeRV5VE7S3SFQzno2jvBOJA5KibE5mFmaWAsy0sTXFnZjcKWjK
	9fsvfX71pVJdflsbirAeVpVCC4kPtDgVsnfwggGBRHnLldo0g8XXiOt8vOG5HaS8KTA0nr52Xih
	Hgsu8CpL1JOYo0G+xtZbwSX95auRpRR5W/5+4tlW8HrkdMl0Kt40+o1oZp3jAkbwwRo2474w3LK
	65LYis/urdHbzgaRVh2dVN7TM0U405VO3qfdHe737KhzretLy/m/nUckZ++rKOweGRehXUIlc9L
	9rcmv6n06q5RIWeYik1HdSM/L2lAAuoyctL2UWtUybF0z3viHebqyzTOoADNMBYgCG5wRoPtpZh
	cgkn/T2ayMBUzTtAecP5ZTdwt5DnZR6WRqliPGlFEWKv7/WcVwGWk=
X-Received: by 2002:a17:903:22c5:b0:2ca:be81:b469 with SMTP id d9443c01a7336-2cd218eaee3mr1641105ad.0.1783571797237;
        Wed, 08 Jul 2026 21:36:37 -0700 (PDT)
Received: from google.com (98.144.168.34.bc.googleusercontent.com. [34.168.144.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a57dc53a0sm456618a91.9.2026.07.08.21.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 21:36:36 -0700 (PDT)
Date: Wed, 8 Jul 2026 21:36:33 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: SCSI EH wakeup deadlock from deferred_qc
Message-ID: <ak8lUXgBZPsQDcuY@google.com>
References: <20260708193644.671852-1-ipylypiv@google.com>
 <4a1b8987-7c76-41e2-baf9-6c176950593b@kernel.org>
 <26dbfbdd-4f9d-4a5f-8f61-a3bb7c457f50@kernel.org>
 <ak8GcZ2k0AIkpMCe@google.com>
 <2c0de926-25fa-4bd3-9a79-44fce94e6c2d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c0de926-25fa-4bd3-9a79-44fce94e6c2d@kernel.org>

On Thu, Jul 09, 2026 at 12:37:07PM +0900, Damien Le Moal wrote:
> On 7/9/26 11:24, Igor Pylypiv wrote:
> > On Thu, Jul 09, 2026 at 10:01:11AM +0900, Damien Le Moal wrote:
> >> On 7/9/26 08:44, Damien Le Moal wrote:
> >>> On 7/9/26 04:36, Igor Pylypiv wrote:
> >>>> Hi Damien,
> >>>>
> >>>> I've stumbled upon an issue where SCSI EH didn't run upon command timeout
> >>>> but ran ~10 or so seconds later. It seems like a recent regression from
> >>>> the introduction of deffered_qc.
> >>>>
> >>>> When an active command times out while a non-NCQ command is waiting in
> >>>> deferred_qc, SCSI EH fails to wake up. Recovery stalls until the deferred
> >>>> command's own timer expires.
> >>>>
> >>>> When an NCQ command times out, scsi_timeout() calls scsi_eh_scmd_add(),
> >>>> incrementing shost->host_failed (1). However, when scsi_eh_wakeup() checks
> >>>> whether to wake the EH thread, scsi_host_busy(shost) counts 2 active
> >>>> commands (1 timed-out + 1 in deferred_qc).
> >>>>
> >>>> Because busy (2) != host_failed (1), scsi_eh_wakeup() refuses to wake
> >>>> the EH thread, deadlocking error recovery until the deferred command
> >>>> times out on its own.
> >>>
> >>> Igor,
> >>>
> >>> Can you try the attached diff ?
> >>> I will test on my end, but I need to hack something to trigger a timeout :)
> >>
> >> Hacking libahci to trigger a timeout for a particular LBA read, I tested the
> >> attached v2 and I see the deferred QC running right after the read command
> >> timeout. So this looks like a good fix to me. Can you test please ?
> > 
> > Thank you for coming up with a fix so quickly, Damien!
> > The fix works for the issue I'm seeing!
> > 
> > Note: I tested on a 6.18 based kernel with your changes ported to libsas
> > to fix the issue for the pm80xx driver. Attached libsas diff for reference.
> 
> Thanks for the diff. I will add it to the patch, and if that's OK with you, also
> add a co-developed-by tag ?

Of course! Thanks again for fixing this quickly, Damien!

Best,
Igor

> 
> > 
> > Thank you!
> > Igor
> > 
> >>
> >> -- 
> >> Damien Le Moal
> >> Western Digital Research
> > 
> >> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> >> index 5868526301a2..5221d7004c0e 100644
> >> --- a/drivers/ata/libata-scsi.c
> >> +++ b/drivers/ata/libata-scsi.c
> >> @@ -1685,7 +1685,8 @@ void ata_scsi_deferred_qc_work(struct work_struct *work)
> >>  	spin_unlock_irqrestore(ap->lock, flags);
> >>  }
> >>  
> >> -void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
> >> +static void ata_scsi_do_requeue_deferred_qc(struct ata_port *ap,
> >> +					    struct scsi_cmnd *timed_out_scmd)
> >>  {
> >>  	struct ata_link *link;
> >>  
> >> @@ -1698,15 +1699,27 @@ void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
> >>  	 */
> >>  	ata_for_each_link(link, ap, PMP_FIRST) {
> >>  		struct ata_queued_cmd *qc = link->deferred_qc;
> >> +		u32 host_byte;
> >>  
> >> -		if (qc) {
> >> -			link->deferred_qc = NULL;
> >> -			cancel_work(&link->deferred_qc_work);
> >> -			ata_scsi_qc_done(qc, true, DID_REQUEUE << 16);
> >> -		}
> >> +		if (!qc)
> >> +			continue;
> >> +
> >> +		link->deferred_qc = NULL;
> >> +		cancel_work(&link->deferred_qc_work);
> >> +
> >> +		if (qc->scsicmd == timed_out_scmd)
> >> +			host_byte = DID_TIME_OUT;
> >> +		else
> >> +			host_byte = DID_REQUEUE;
> >> +		ata_scsi_qc_done(qc, true, host_byte << 16);
> >>  	}
> >>  }
> >>  
> >> +void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
> >> +{
> >> +	ata_scsi_do_requeue_deferred_qc(ap, NULL);
> >> +}
> >> +
> >>  static void ata_scsi_schedule_deferred_qc(struct ata_link *link)
> >>  {
> >>  	struct ata_queued_cmd *qc = link->deferred_qc;
> >> @@ -1730,6 +1743,28 @@ static void ata_scsi_schedule_deferred_qc(struct ata_link *link)
> >>  		queue_work(system_highpri_wq, &link->deferred_qc_work);
> >>  }
> >>  
> >> +enum scsi_timeout_action ata_scsi_eh_timed_out(struct scsi_cmnd *scmd)
> >> +{
> >> +	struct ata_port *ap = ata_shost_to_port(scmd->device->host);
> >> +	unsigned long flags;
> >> +
> >> +	/*
> >> +	 * We had a timeout, either for an NCQ command or for one deferred
> >> +	 * queued command. Either way, we must release all deferred queued
> >> +	 * command so that scsi EH can trigger.
> >> +	 */
> >> +	spin_lock_irqsave(ap->lock, flags);
> >> +	ata_scsi_do_requeue_deferred_qc(ap, scmd);
> >> +	spin_unlock_irqrestore(ap->lock, flags);
> >> +
> >> +	/*
> >> +	 * Let scsi_timeout() know that it must continue with handling the
> >> +	 * timeout as we in fact did not do much here.
> >> +	 */
> >> +	return SCSI_EH_NOT_HANDLED;
> >> +}
> >> +EXPORT_SYMBOL_GPL(ata_scsi_eh_timed_out);
> >> +
> >>  static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
> >>  {
> >>  	struct ata_link *link = qc->dev->link;
> >> diff --git a/include/linux/libata.h b/include/linux/libata.h
> >> index 96e626d6a7ca..327da43d7496 100644
> >> --- a/include/linux/libata.h
> >> +++ b/include/linux/libata.h
> >> @@ -1153,6 +1153,7 @@ extern int ata_scsi_ioctl(struct scsi_device *dev, unsigned int cmd,
> >>  #endif
> >>  extern enum scsi_qc_status ata_scsi_queuecmd(struct Scsi_Host *h,
> >>  					     struct scsi_cmnd *cmd);
> >> +enum scsi_timeout_action ata_scsi_eh_timed_out(struct scsi_cmnd *cmd);
> >>  #if IS_REACHABLE(CONFIG_ATA)
> >>  bool ata_scsi_dma_need_drain(struct request *rq);
> >>  #else
> >> @@ -1464,6 +1465,7 @@ extern const struct attribute_group *ata_common_sdev_groups[];
> >>  	.ioctl			= ata_scsi_ioctl,		\
> >>  	ATA_SCSI_COMPAT_IOCTL					\
> >>  	.queuecommand		= ata_scsi_queuecmd,		\
> >> +	.eh_timed_out		= ata_scsi_eh_timed_out,	\
> >>  	.dma_need_drain		= ata_scsi_dma_need_drain,	\
> >>  	.this_id		= ATA_SHT_THIS_ID,		\
> >>  	.emulated		= ATA_SHT_EMULATED,		\
> > 
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
