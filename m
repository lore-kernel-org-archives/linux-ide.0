Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8062745C
	for <linux-ide@vger.kernel.org>; Fri,  6 Mar 2026 00:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772756050; cv=none; b=Ism3Q0BqZZdv3nE0SFYlmy73YtAlfaIRNx0EEL1WaGlY88JDruA5mcBGRA2t1mfsN69UMa/ouMeV3CEZ3lsFPgWX39Lwpy/nHvkkvA/hqNDWZqaYMgDdZfnYg9QcNdYvOyerkBjlDOpDboPMxoQRgvZAacA6AP+htWyMd3VXfWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772756050; c=relaxed/simple;
	bh=/FsH2XOp7pZNlDnyfAwN3jZRvvSBAVopuOdTL64VhSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5pHzR3DFIUbQJD39VMiji3aA89Nr2el6moS0W3eEXE4V2ucLKtfTmVzbO2wqce3+Sv4v+s+W2Zdx/CRHHp17ICTKgwNqk++doY/BqsL8+mcKlYFAxOhzd+/0WWiT5PmW3ZWwIt039FRMrPv3wyvnY96kuPkiSTJhdFOW8btzWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPpXA/ME; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPpXA/ME"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2be3bdfda8eso1718448eec.1
        for <linux-ide@vger.kernel.org>; Thu, 05 Mar 2026 16:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772756048; x=1773360848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6zWX8yaRYJBdhwKNr6U0v0xRGoLNMvnWtRM+7V8A0pM=;
        b=nPpXA/MEW31KF00lvlcKbCggadAt+lKuNyBvLxDS8ZRuBZdzXfaFvERES5Yj6fsmpM
         TvyEHtvCSVM9ojFFkrn36odAPxvERSj+VrUBzQ99MFJ766Mbi5o+EtdNuFQKEnUQhPOn
         bhYGYonpTVh2danNSdhMa2iuVHAnJA4ToBs3T7lx6vF8PBBMuZ0Qz8MKfmQTFRewW/Gm
         lFUp4PeaNqqs3Oy8TCEuhRZsXvRK+hpYSjfqtG7FtY3bA5Iv/hVLq6juyTWQcDZe6AGN
         4iUXoZk0WMBqZAIYnwzV/CBxLs5ckO+vLGEAcxz1yVf8RdhoTlV2eGtde9ToGVfUL3w4
         CS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772756048; x=1773360848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6zWX8yaRYJBdhwKNr6U0v0xRGoLNMvnWtRM+7V8A0pM=;
        b=tj828MvOtibZl3nv1ywnY7hE9MmTy7ENhQNDb4GyD9nU7SZ/LJeh3hh/+yTwd52RxT
         IJvqAUc3qMfQ6/zXG5n+cufsKVywUSMtjD8+1hHMrObDNn74FZMBtgGhnsr9LbEWerKw
         X4jJf6e0KWQgii6JKDScEMSqCVH+VbIEze/8U/yu4Ihar7NuA3FY7qb7wL+BKWpmq1Wr
         UhgL7QEQ8p9Pk4z/gJFi3+4kWb6enakhhW6bC711ckSUBhcD3sW9Y6dNHOEppfx3QQde
         xdRBDLshgl6aR5TKvTfrT42ir8EH3B07nejUKdBh42PKFTr9v3+PyqxI2Jr7D+Ooasoo
         P2ig==
X-Forwarded-Encrypted: i=1; AJvYcCUACDb4/TF4PGROfCj7F6ivM5QBGGDaUnxmIpUtMxIPISGcV2MK1c1zIIH81jFf0iU7Cq7eYUUzL/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq8KrkUnB2zSdHvFdtjyYeK9+YfXQPKXCMDkbwaEtaPSXD9fXm
	wMkUH391KkaDnA0+USV4l8Jjfvo3clhgvUL/lk5R1p4xWukkRPRQ7HK7
X-Gm-Gg: ATEYQzyEWpIw4oT4FhYkXiB7JOzcMma/3iysEmf2+7cHm8UmnSLhspPJxJV7Ax4PRwu
	WbRs71i2mOKz8kAB7vyuXdMtjpsv7hpmejYL2kGHPDXaYrQ3jRIDDH+eI2sU5r4wmRt/3/K5Gsk
	xc6mJOSslGCI8KlqL/FJ1Iji2xVteWVQ5AJrBsgs23JV1fob94EAvznLPeLS8O0gfJPLxTCQBaX
	NCylGagV9SZNoR/3Iqomk7BCqLQl9jiOTrEobER5MKwkyp6ZIRKILqtDf5Lv/gKCqss4LT7zQ0V
	ycFXdFTu2OEGJPLIgdhIfZHk355zP/+Fp+/qCcN8Wu+1h156tzdaDMZo/0zuHmFVYnom4XzHquI
	93NgGsW/tKHufK4qvEwJy5BFEdT5dcnIYCdG9vnKZkXd3NjE22UwJETaKL9d3RF98aGPvpkMDws
	Lj7L2DtRxSv4uXRAITt0lRwrI84HpUtX15kliy
X-Received: by 2002:a05:693c:2b0a:b0:2ba:6854:8d4d with SMTP id 5a478bee46e88-2be4e02748bmr136570eec.20.1772756047512;
        Thu, 05 Mar 2026 16:14:07 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be03fc6fcesm11923047eec.1.2026.03.05.16.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:14:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 5 Mar 2026 16:14:04 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ata: libata-eh: correctly handle deferred qc
 timeouts
Message-ID: <81f2f823-8e66-48d8-bf1c-07b0aa7d49c7@roeck-us.net>
References: <20260220221439.533771-1-dlemoal@kernel.org>
 <20260220221439.533771-2-dlemoal@kernel.org>
 <ea6cdec5-cbd6-4387-9995-cbbfda978155@roeck-us.net>
 <CFD23A2E-145E-4901-9160-72A91A5C3A9E@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CFD23A2E-145E-4901-9160-72A91A5C3A9E@kernel.org>

On Fri, Mar 06, 2026 at 12:27:34AM +0100, Niklas Cassel wrote:
> On 5 March 2026 18:59:08 CET, Guenter Roeck <linux@roeck-us.net> wrote:
> >Hi,
> >
> >On Sat, Feb 21, 2026 at 07:14:38AM +0900, Damien Le Moal wrote:
> >> A deferred qc may timeout while waiting for the device queue to drain
> >> to be submitted. In such case, since the qc is not active,
> >> ata_scsi_cmd_error_handler() ends up calling scsi_eh_finish_cmd(),
> >> which frees the qc. But as the port deferred_qc field still references
> >> this finished/freed qc, the deferred qc work may eventually attempt to
> >> call ata_qc_issue() against this invalid qc, leading to errors such as
> >> reported by UBSAN (syzbot run):
> >> 
> >> UBSAN: shift-out-of-bounds in drivers/ata/libata-core.c:5166:24
> >> shift exponent 4210818301 is too large for 64-bit type 'long long unsigned int'
> >> ...
> >> Call Trace:
> >>  <TASK>
> >>  __dump_stack lib/dump_stack.c:94 [inline]
> >>  dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
> >>  ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
> >>  __ubsan_handle_shift_out_of_bounds+0x279/0x2a0 lib/ubsan.c:494
> >>  ata_qc_issue.cold+0x38/0x9f drivers/ata/libata-core.c:5166
> >>  ata_scsi_deferred_qc_work+0x154/0x1f0 drivers/ata/libata-scsi.c:1679
> >>  process_one_work+0x9d7/0x1920 kernel/workqueue.c:3275
> >>  process_scheduled_works kernel/workqueue.c:3358 [inline]
> >>  worker_thread+0x5da/0xe40 kernel/workqueue.c:3439
> >>  kthread+0x370/0x450 kernel/kthread.c:467
> >>  ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
> >>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >>  </TASK>
> >> 
> >> Fix this by checking if the qc of a timed out SCSI command is a deferred
> >> one, and in such case, clear the port deferred_qc field and finish the
> >> SCSI command with DID_TIME_OUT.
> >> 
> >> Reported-by: syzbot+1f77b8ca15336fff21ff@syzkaller.appspotmail.com
> >> Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
> >> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> >> Reviewed-by: Hannes Reinecke <hare@suse.de>
> >> Reviewed-by: Igor Pylypiv <ipylypiv@google.com>
> >> ---
> >>  drivers/ata/libata-eh.c | 22 +++++++++++++++++++---
> >>  1 file changed, 19 insertions(+), 3 deletions(-)
> >> 
> >> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> >> index 72a22b6c9682..b373cceb95d2 100644
> >> --- a/drivers/ata/libata-eh.c
> >> +++ b/drivers/ata/libata-eh.c
> >> @@ -640,12 +640,28 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
> >>  		set_host_byte(scmd, DID_OK);
> >>  
> >>  		ata_qc_for_each_raw(ap, qc, i) {
> >> -			if (qc->flags & ATA_QCFLAG_ACTIVE &&
> >> -			    qc->scsicmd == scmd)
> >> +			if (qc->scsicmd != scmd)
> >> +				continue;
> >> +			if ((qc->flags & ATA_QCFLAG_ACTIVE) ||
> >> +			    qc == ap->deferred_qc)
> >>  				break;
> >>  		}
> >>  
> >> -		if (i < ATA_MAX_QUEUE) {
> >> +		if (qc == ap->deferred_qc) {
> >
> >An experimental AI code review agent tagged this patch with the following
> >comment.
> >
> >  If the `ata_qc_for_each_raw()` loop finishes without finding a matching `scmd`,
> >  `qc` will hold a pointer to the last element examined (`i == ATA_MAX_QUEUE`).
> 
> I think the AI is wrong here.
> 
> That last element assigned to QC will be ATA_MAX_QUEUE - 1.
> 

I think that is what it means with "`qc` will hold a pointer to the
last element examined". The "(`i == ATA_MAX_QUEUE`) part is a bit
confusing.

I think what it is trying to say is that if i == ATA_MAX_QUEUE,
qc would point to the last examined element, which would not
have ATA_QCFLAG_ACTIVE set because otherwise it would have
exited the loop. Yet, ap->deferred_qc could be set, and the
if statement would be true even though i == ATA_MAX_QUEUE
and there was no qc match.

> 
> >  If this last element happens to be `ap->deferred_qc`, the condition
> >  `qc == ap->deferred_qc` evaluates to true despite the loop not breaking on a
> >  match.
> >

That is pretty much much repeating what I said above, without
the confusing "(`i == ATA_MAX_QUEUE`)" part.

> >  Could this mistakenly intercept a command that completed normally after a SCSI
> >  timeout, returning a timeout error instead of success? Would this also
> >  incorrectly clear `ap->deferred_qc`, dropping the deferred command?
> 

This part is beyond my understanding, primarily because I don't know
what "qc->deferred" actually refers to.

> I think the AI is partially wrong here.
> 
> If you read the comment below it if (), we know that ap->deferred_qc is only set until that command has been issued. So if it is set, that qc has not been issued, so it can't have successfully completed.
> 
> But... Since we don't verify that i < ATA_MAX_QUEUE, we might end up completing the deferred QC as a failed command, even though it did not time out...
> 
> On NCQ error, we complete the deferred QC as a failed command.
> 
> However, if there was a timeout of a command, which was not the deferred QC, but the deferred QC did not timeout, I think it is wrong to complete the deferred QC as a failed command.
> 
> So... I actually think that the change suggested by the AI is something we want.
> (Especially after Damien commit queued in for-next where we will not invoke error_handler() if there were no timed out commands.)
> 

So should I send a patch, or do you want to handle it ?
It might be better if you handle it since I don't know
how to exactly describe the problem differently than the AI.

Thanks,
Guenter
