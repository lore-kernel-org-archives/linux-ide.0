Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745EF285CAA
	for <linux-ide@vger.kernel.org>; Thu,  5 Mar 2026 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772733552; cv=none; b=PYmb3prZCOZ2Ej5bz48ltvEdD1ENaQWEnpwiw9ee909I0OIVLykd38FL4wQJdB0Gim7LsrqIZttimzhNw0329iSTVmURDwHLUwZ4N82Ok4UYRuef8CI1LQa8oXAfQPcDQg9BK53j5Hh5oh6rGTD4oKFRRMdkspJFGUGDmr/EI90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772733552; c=relaxed/simple;
	bh=DjUG3i8/B/JBqTWcnF3VcPJzO+I9lOzyMCNEDYIY+nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2ZZFZZvoo+9ywyksKkiAL6UTpko/Qs91jqa600ei3JnD20RlSHq9eHK20kI+6skP8tGMmhlxED5rU/tszRPFW+BQ9PZ2muYsvo54dSbu182Uq3ao8S+OhRuIjxsOc4CgjEEBK54Ldf08RR7JdhEvlPPl4l4QIVVt9v2WTrVAYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFxtAWVP; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFxtAWVP"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so431740eec.1
        for <linux-ide@vger.kernel.org>; Thu, 05 Mar 2026 09:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772733550; x=1773338350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=etzJ+XA0rPx5CGRPawknxtAVId+rhUYdEXqjWpASI6g=;
        b=VFxtAWVPqJaBzwUMHZggGVdOfaD0a3kGFNMQboyRgx1udjwyxm6RLkSfOVec6a2Tx0
         6bmFiTf0VS+pVwhk5MDdDhU1PLu7uxff13PAm+LHJtQ3bhBxtRL9+4hd1g6ZRmo7V22h
         CS6Y7h6pQ6OuLJ1vH75IwoYVmkSH29ecEZardoViB7DgQFeRbZv9KJ8keJ7umsiqvTv2
         3RkrlkHeO46dX1VupAQneTA0WtRFH0nKDH986cPbN1gn4YWgKgZ21ft4oe8IarmuFgAX
         y8tOe8QCVKnaRynf74BO2cYbXeUsXGWl+WU0FISxDr6t+lkVdVsAqylikvII1cwfO9mC
         U6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772733550; x=1773338350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=etzJ+XA0rPx5CGRPawknxtAVId+rhUYdEXqjWpASI6g=;
        b=PEWZ+p9/t7R+yMcE/1Hen7o/93ZnRHsYAiJEJEu7YDQQuwLWlmkdZYY/7RiTnr2Kln
         9wLIHxL/Lt+eo75h02C2QCvUaRJ7jaOqO6s57yb84VLvxqw+eLamV80/qoxgasrcP51z
         lvBX3ldf/4XpFA/60x9gOPwgw6eyc6ohmB5mSbZf8MOAFzW/+PGWnq13YwtnhvTyeE3O
         P2AqzWa2tGI7gE6ML8k13WhNQUDIILqiMm4vc4/ElNslk+U9B7Mt3LDZNc/pU1rLz9UJ
         MbyYfXUuD+9I05ECFDIGGU2cSvJgE0OkFEaf+IMP/OvAO4Wt67FOO7x9Iz92WFmBWZe4
         B3DA==
X-Gm-Message-State: AOJu0YzWwkkojNBmrIW7KdhPiJN3KqxPNHR40bYluZnuP4rrjYBgkVoJ
	lLGD5paOl0muPK0HGeGfM/jZ6qfXWX5lMhvRMJ2FLKbG3P56Mwx2ZanD
X-Gm-Gg: ATEYQzzQLw4afiSSrteugjjMGhDuPJG9E1TcmOPlkhbgF//PNaL4nJ0/NgJ3fbzRl/N
	m5oL+znJzMUFMPJKA+i0RmoW58SGwIGqeklJl/HOYKwG5/r0NpmUFrdeSw5tFZjYXuxgOWe4DCf
	TxUlmCOg0caGsfOnr2UjKxh4RFNm7KmjcPncCG82kNpeIvo8hS6IXXr1Y556mAGY79FWMW56HKl
	U5NSeY3ZoE/XW4Tho4VVB0dPndC62+hIEyv1qcH7Gvysi+i+jK26LePAz/Qnfj7HhsBvsUwglnF
	hyDKlvGXnZpUZp6THZhf7mxDxc1zHE0m738/CtJfnNvm5yR1Cs2GGQ8HHzh5Mw5z20dBRO5CA4t
	e5wvGlqTR+RKyBykz010O6DRln2Cv8q1PnO2czoVmywYvCFMvmbI7OTRF0mG3eD7AnPb9DOX5tP
	fTmN4TxIqCZGDAaLfZADHn9JB7/7Kp/9So5E/y
X-Received: by 2002:a05:7301:7015:b0:2be:8da:320f with SMTP id 5a478bee46e88-2be4a9fa2ffmr361137eec.10.1772733550371;
        Thu, 05 Mar 2026 09:59:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdfba0df2fsm14143290eec.7.2026.03.05.09.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 09:59:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 5 Mar 2026 09:59:08 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v2 1/2] ata: libata-eh: correctly handle deferred qc
 timeouts
Message-ID: <ea6cdec5-cbd6-4387-9995-cbbfda978155@roeck-us.net>
References: <20260220221439.533771-1-dlemoal@kernel.org>
 <20260220221439.533771-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220221439.533771-2-dlemoal@kernel.org>

Hi,

On Sat, Feb 21, 2026 at 07:14:38AM +0900, Damien Le Moal wrote:
> A deferred qc may timeout while waiting for the device queue to drain
> to be submitted. In such case, since the qc is not active,
> ata_scsi_cmd_error_handler() ends up calling scsi_eh_finish_cmd(),
> which frees the qc. But as the port deferred_qc field still references
> this finished/freed qc, the deferred qc work may eventually attempt to
> call ata_qc_issue() against this invalid qc, leading to errors such as
> reported by UBSAN (syzbot run):
> 
> UBSAN: shift-out-of-bounds in drivers/ata/libata-core.c:5166:24
> shift exponent 4210818301 is too large for 64-bit type 'long long unsigned int'
> ...
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
>  ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
>  __ubsan_handle_shift_out_of_bounds+0x279/0x2a0 lib/ubsan.c:494
>  ata_qc_issue.cold+0x38/0x9f drivers/ata/libata-core.c:5166
>  ata_scsi_deferred_qc_work+0x154/0x1f0 drivers/ata/libata-scsi.c:1679
>  process_one_work+0x9d7/0x1920 kernel/workqueue.c:3275
>  process_scheduled_works kernel/workqueue.c:3358 [inline]
>  worker_thread+0x5da/0xe40 kernel/workqueue.c:3439
>  kthread+0x370/0x450 kernel/kthread.c:467
>  ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> 
> Fix this by checking if the qc of a timed out SCSI command is a deferred
> one, and in such case, clear the port deferred_qc field and finish the
> SCSI command with DID_TIME_OUT.
> 
> Reported-by: syzbot+1f77b8ca15336fff21ff@syzkaller.appspotmail.com
> Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/ata/libata-eh.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 72a22b6c9682..b373cceb95d2 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -640,12 +640,28 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
>  		set_host_byte(scmd, DID_OK);
>  
>  		ata_qc_for_each_raw(ap, qc, i) {
> -			if (qc->flags & ATA_QCFLAG_ACTIVE &&
> -			    qc->scsicmd == scmd)
> +			if (qc->scsicmd != scmd)
> +				continue;
> +			if ((qc->flags & ATA_QCFLAG_ACTIVE) ||
> +			    qc == ap->deferred_qc)
>  				break;
>  		}
>  
> -		if (i < ATA_MAX_QUEUE) {
> +		if (qc == ap->deferred_qc) {

An experimental AI code review agent tagged this patch with the following
comment.

  If the `ata_qc_for_each_raw()` loop finishes without finding a matching `scmd`,
  `qc` will hold a pointer to the last element examined (`i == ATA_MAX_QUEUE`).
  If this last element happens to be `ap->deferred_qc`, the condition
  `qc == ap->deferred_qc` evaluates to true despite the loop not breaking on a
  match.

  Could this mistakenly intercept a command that completed normally after a SCSI
  timeout, returning a timeout error instead of success? Would this also
  incorrectly clear `ap->deferred_qc`, dropping the deferred command?
  Should we verify that the loop actually found a match, for instance by checking
  `if (i < ATA_MAX_QUEUE && qc == ap->deferred_qc)`?

It does seem to be a real problem to me, but I don't know the code well
enough to be sure. Please take a look and let me know if the problem is
real. If so, I'll be happy to submit a patch to fix it. If not, please let
me know what the agent is missing.

Thanks,
Guenter
