Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427BE2D7DEE
	for <linux-ide@vger.kernel.org>; Fri,  6 Mar 2026 00:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772757713; cv=none; b=S2snYB6Tj/bT5cA45t/33Txmq8rusJ2HEhIs506/vey5fpZkg/Q4IZnUFV2yYCyMU+j++89vBLCJggDDdFylPWu9ud8OR2xlHgmgLCl0iDN98d4Z2c6VvtyYw/8h6dm195cSSIc+Fdk/Wg+BVeGqGxNTta0yXnnwJnEi46FARrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772757713; c=relaxed/simple;
	bh=8V9tLFEQSTEpaZwLmdevdM9z4YPIRgsPQqjT8ZL18zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euDAJofzimCEZYkyKRwHA4AIb5SVejZQ65tNjhWZg8HjQ2F2ojARVlhFuGoZWySLjbTTtCYrLwOk4pd8tSJj9kaBS+KATqtVPe8l2wEYT/MjnlhcMlktI8e6MJEu/wGWfA0vxx86+/HT+oltviovNQNcTVzZAf1SVZV3Vtzsvbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayisqPO1; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayisqPO1"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-127423bea4bso4847861c88.0
        for <linux-ide@vger.kernel.org>; Thu, 05 Mar 2026 16:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772757711; x=1773362511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YBvKrsZ7frGk1pAP9Ny016oFqjVWY72jQm3H2ZJbACI=;
        b=ayisqPO16BxBuz1fUFYinv7Yj3i5ADhFaqKdDbFRBBpuhTCKniFnL0Jv/WokAfRg6C
         cUFPpyWUamlSgLFszXg6bCfuzZQETVe5V30N/jG0o3M4BeuWoOJsuSiEzQbddf2A2gPy
         zPhZju7qlZB+FTCtFHoByHT82SUuHy1XLH+GaAV+P3xlJh3IuOjaUyQQHkZi8pLNP7g+
         LIhiQDDbdQnTHfo18enYmObjE3Szm/jOwY5QCOGU5bsoIqPJgg9J5xeeUorUi1fShz9b
         +Ss0UEaX2gdNVzPm5JdMXoJM+HBcucWrktao1hv8GpPtg6w/wEkttdC/SCKQfTE3EuZK
         abow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772757711; x=1773362511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YBvKrsZ7frGk1pAP9Ny016oFqjVWY72jQm3H2ZJbACI=;
        b=MvkC+I7ppDH1h5P13iaNkIBvBD7deXhSDFMgmdT+zlJDTXJdwJhHxtWB7r2Jt6FNVo
         3xEVVJztdjckX0wQGCdUb7G+9wpFbsT93HdpVkRz++W1cRSs9JNnyCb6qY4mf8GUyWy1
         v/1lAgRMF12ViwMXQNUUoxJ0UbUljpqWu1rOa9+rlSsp66+9Wu2tkZ3FEvKLuLoeaoGb
         gD+3k3km/Duy26lkhfNOT1S78Bw4wk4MYu2c4ewQN+3arce0pxaKnDarO3gellalxs5X
         gBEC6PIQzcemsFduxtUDxI0M4Va+t5p9bivWLdUjfjJecw5CYMNdzXWPIJsGPhjBkrUs
         aZMA==
X-Forwarded-Encrypted: i=1; AJvYcCU0KufD9Pes0j+TRdydeUP0DJnFvRHmd7Rla3K5mqd/oXa+b85FbbwFQ0mz0z1SDabRj4eSlERfEVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAqSmFccS5I+FD77NbtL8+Q4KQrKwnKPNNd98VK3jWUkFvIIb9
	aABoZOYkfAgNWeHKjhwUiPEEedmFzbvSPW649kKuO0Q8TLCYsyFPvAs3
X-Gm-Gg: ATEYQzwGiLTIQuKGOOI6JPLzhHOwtdTCVW5s0Q7IqGrxj7jKZ7tCWrgvbG4I17Cg94V
	4Mj5cto7scqB1EylBSd2NQqN39Ge44ShV8o/wL/LFe/RBT4i/XDyunBLfdQ6+EJ2m14W2aHWiD8
	KG1ETa9apOFLwrlYetOxSRUBN7ofPmdoTmz2c3NJEz5C7LnXMeVUCNrlEcniGBLypDWRvZh1RzC
	6jI3nNjSBgL7RiPP5PfKgf32gk2rjX+7t648k16poWQh7OSxzIzcLSlkfhU9jjSRuzoN+EZqimG
	th5rpi7Rydwo0YiglZSZ0JFWaaRIoQG6UgTPfmpCeINXMBhTXI5xnqMygZ9pYYUr6zQIaMu64BQ
	xpqnu6n0bXPSb3SD9S/n2CYFAxP7dJrwDpGX8xviJtG2HlqQyOqTqKnMBmblbC5WC6GMVl/LEpX
	LvbdPLqu/qgQfVL5WrrFlOU6kuQf4UxrXksrvk
X-Received: by 2002:a05:7022:1a81:b0:123:2dd0:10bc with SMTP id a92af1059eb24-128c2d9c156mr203109c88.10.1772757711021;
        Thu, 05 Mar 2026 16:41:51 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a43a18sm28118961c88.13.2026.03.05.16.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:41:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 5 Mar 2026 16:41:48 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ata: libata-eh: correctly handle deferred qc
 timeouts
Message-ID: <6a05e6e9-4622-48a7-95f6-ac3559874b79@roeck-us.net>
References: <20260220221439.533771-1-dlemoal@kernel.org>
 <20260220221439.533771-2-dlemoal@kernel.org>
 <ea6cdec5-cbd6-4387-9995-cbbfda978155@roeck-us.net>
 <CFD23A2E-145E-4901-9160-72A91A5C3A9E@kernel.org>
 <81f2f823-8e66-48d8-bf1c-07b0aa7d49c7@roeck-us.net>
 <cbc113d1-55a1-41f5-8481-25c707f2ef86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbc113d1-55a1-41f5-8481-25c707f2ef86@kernel.org>

On Fri, Mar 06, 2026 at 09:21:26AM +0900, Damien Le Moal wrote:
> On 3/6/26 09:14, Guenter Roeck wrote:
> > On Fri, Mar 06, 2026 at 12:27:34AM +0100, Niklas Cassel wrote:
> >> On 5 March 2026 18:59:08 CET, Guenter Roeck <linux@roeck-us.net> wrote:
> >>> Hi,
> >>>
> >>> On Sat, Feb 21, 2026 at 07:14:38AM +0900, Damien Le Moal wrote:
> >>>> A deferred qc may timeout while waiting for the device queue to drain
> >>>> to be submitted. In such case, since the qc is not active,
> >>>> ata_scsi_cmd_error_handler() ends up calling scsi_eh_finish_cmd(),
> >>>> which frees the qc. But as the port deferred_qc field still references
> >>>> this finished/freed qc, the deferred qc work may eventually attempt to
> >>>> call ata_qc_issue() against this invalid qc, leading to errors such as
> >>>> reported by UBSAN (syzbot run):
> >>>>
> >>>> UBSAN: shift-out-of-bounds in drivers/ata/libata-core.c:5166:24
> >>>> shift exponent 4210818301 is too large for 64-bit type 'long long unsigned int'
> >>>> ...
> >>>> Call Trace:
> >>>>  <TASK>
> >>>>  __dump_stack lib/dump_stack.c:94 [inline]
> >>>>  dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
> >>>>  ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
> >>>>  __ubsan_handle_shift_out_of_bounds+0x279/0x2a0 lib/ubsan.c:494
> >>>>  ata_qc_issue.cold+0x38/0x9f drivers/ata/libata-core.c:5166
> >>>>  ata_scsi_deferred_qc_work+0x154/0x1f0 drivers/ata/libata-scsi.c:1679
> >>>>  process_one_work+0x9d7/0x1920 kernel/workqueue.c:3275
> >>>>  process_scheduled_works kernel/workqueue.c:3358 [inline]
> >>>>  worker_thread+0x5da/0xe40 kernel/workqueue.c:3439
> >>>>  kthread+0x370/0x450 kernel/kthread.c:467
> >>>>  ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
> >>>>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >>>>  </TASK>
> >>>>
> >>>> Fix this by checking if the qc of a timed out SCSI command is a deferred
> >>>> one, and in such case, clear the port deferred_qc field and finish the
> >>>> SCSI command with DID_TIME_OUT.
> >>>>
> >>>> Reported-by: syzbot+1f77b8ca15336fff21ff@syzkaller.appspotmail.com
> >>>> Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
> >>>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> >>>> Reviewed-by: Hannes Reinecke <hare@suse.de>
> >>>> Reviewed-by: Igor Pylypiv <ipylypiv@google.com>
> >>>> ---
> >>>>  drivers/ata/libata-eh.c | 22 +++++++++++++++++++---
> >>>>  1 file changed, 19 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> >>>> index 72a22b6c9682..b373cceb95d2 100644
> >>>> --- a/drivers/ata/libata-eh.c
> >>>> +++ b/drivers/ata/libata-eh.c
> >>>> @@ -640,12 +640,28 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
> >>>>  		set_host_byte(scmd, DID_OK);
> >>>>  
> >>>>  		ata_qc_for_each_raw(ap, qc, i) {
> >>>> -			if (qc->flags & ATA_QCFLAG_ACTIVE &&
> >>>> -			    qc->scsicmd == scmd)
> >>>> +			if (qc->scsicmd != scmd)
> >>>> +				continue;
> >>>> +			if ((qc->flags & ATA_QCFLAG_ACTIVE) ||
> >>>> +			    qc == ap->deferred_qc)
> >>>>  				break;
> >>>>  		}
> >>>>  
> >>>> -		if (i < ATA_MAX_QUEUE) {
> >>>> +		if (qc == ap->deferred_qc) {
> >>>
> >>> An experimental AI code review agent tagged this patch with the following
> >>> comment.
> >>>
> >>>  If the `ata_qc_for_each_raw()` loop finishes without finding a matching `scmd`,
> >>>  `qc` will hold a pointer to the last element examined (`i == ATA_MAX_QUEUE`).
> >>
> >> I think the AI is wrong here.
> >>
> >> That last element assigned to QC will be ATA_MAX_QUEUE - 1.
> >>
> > 
> > I think that is what it means with "`qc` will hold a pointer to the
> > last element examined". The "(`i == ATA_MAX_QUEUE`) part is a bit
> > confusing.
> > 
> > I think what it is trying to say is that if i == ATA_MAX_QUEUE,
> > qc would point to the last examined element, which would not
> > have ATA_QCFLAG_ACTIVE set because otherwise it would have
> > exited the loop. Yet, ap->deferred_qc could be set, and the
> > if statement would be true even though i == ATA_MAX_QUEUE
> > and there was no qc match.
> > 
> >>
> >>>  If this last element happens to be `ap->deferred_qc`, the condition
> >>>  `qc == ap->deferred_qc` evaluates to true despite the loop not breaking on a
> >>>  match.
> >>>
> > 
> > That is pretty much much repeating what I said above, without
> > the confusing "(`i == ATA_MAX_QUEUE`)" part.
> > 
> >>>  Could this mistakenly intercept a command that completed normally after a SCSI
> >>>  timeout, returning a timeout error instead of success? Would this also
> >>>  incorrectly clear `ap->deferred_qc`, dropping the deferred command?
> >>
> > 
> > This part is beyond my understanding, primarily because I don't know
> > what "qc->deferred" actually refers to.
> 
> There are 2 types of ATA commands: queueable ones (NCQ == Native Command
> Queueing) and non-queueable ones (legacy/old ATA commands). The 2 types cannot
> be mixed. When NCQ commands are on-going, you cannot issue a non-NCQ command,
> and vice-versa. This has always been handled with command requeueing in
> libata-scsi (since forever), but with blk-mq introduction, there was a potential
> command starvation issue for non-NCQ commands that has existed for a long time.
> 
> We fixed that recently by keeping on hand any non-NCQ command that must wait for
> on-going NCQ commands to complete first. This is ap->deferred_qc.
> 
> > 
> >> I think the AI is partially wrong here.
> >>
> >> If you read the comment below it if (), we know that ap->deferred_qc is only set until that command has been issued. So if it is set, that qc has not been issued, so it can't have successfully completed.
> >>
> >> But... Since we don't verify that i < ATA_MAX_QUEUE, we might end up completing the deferred QC as a failed command, even though it did not time out...
> >>
> >> On NCQ error, we complete the deferred QC as a failed command.
> >>
> >> However, if there was a timeout of a command, which was not the deferred QC, but the deferred QC did not timeout, I think it is wrong to complete the deferred QC as a failed command.
> >>
> >> So... I actually think that the change suggested by the AI is something we want.
> >> (Especially after Damien commit queued in for-next where we will not invoke error_handler() if there were no timed out commands.)
> >>
> > 
> > So should I send a patch, or do you want to handle it ?
> > It might be better if you handle it since I don't know
> > how to exactly describe the problem differently than the AI.
> 
> Send a patch. Write a commit message based on the information I sent in my
> previous email. We can correct the commit message if needed.
> 
I'll give it a try.

Thanks,
Guenter
