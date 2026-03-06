Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A52333688C
	for <linux-ide@vger.kernel.org>; Fri,  6 Mar 2026 01:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772760685; cv=none; b=coPJKtykiV9FYnuOnNTlv4p+vr5ZOa8JU3/r93CEokY7dI+ZfoySL/XBSdCUQz5HWtrE00ufiM6UeGRIz3ebwgM1jePa6Lf/sSbqtmmdSQ3kyfRNfnRr7k/7JL6z6gOiwyLpoUW04nf1AKZWATZy4PxKwCTn437nMIcG8JPH3mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772760685; c=relaxed/simple;
	bh=+4TUtrbI31GWhaflB0Jmh3ao1eYVKyiOAhAFE9GYr7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfaviLNhGBvC39kbNgcabwjOyth7T9KJH8Xshu90NU8VUMLmcuVWaamUXhVIx7epqY45lvbx2GCaAGo5ixX1icNk3TlzRFApHg3Y91EQl9KGn1T0SeBNcbrsGVFFeVzxPs6pCa4liqTn0W2Yy38xATl+ukl52zzHaTVuko+AgsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0XKo25S; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0XKo25S"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2be27fa54feso4707905eec.0
        for <linux-ide@vger.kernel.org>; Thu, 05 Mar 2026 17:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772760683; x=1773365483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSMDVlW1zmseliwhFAnMUHE4WgT1//gTFOpTqofFPIM=;
        b=H0XKo25SlOhc/JcFmsF7ZUNnrd3eXidEgVZrUGjUScoZezHNbNxCS74HUPEOxwf9K+
         o9L9vbXjFKmZ794V4+WR/1evdo2QdEb+tfZotZYqfb4W23TlJzW1OxR4hi9M4rq6KpJw
         LW6e+zGoE2MAwia12GQ1KGr7Y56/UxRuQBqu7hOi3RiAMwg7GqD2kyo4Rxz8AiV/balc
         BenVQeGhs73m1QfiQ14T+8ogsREElfK8x+rqNSurpEFMxVViLfU7nUM9AHEC3lZdePqG
         BlQEptXSyXasaYkL/NJygww4Qa1ieNUB+SsnsRFHUrMIxV3keLSlKOFLmyXHdX7szbXP
         uDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772760683; x=1773365483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gSMDVlW1zmseliwhFAnMUHE4WgT1//gTFOpTqofFPIM=;
        b=U2hOAI3KzJq91xxmXvppa4GbPl3a08nIT26ZAZ+/4pBQ38E9yFhvQf5VSYnfxVHnuq
         YmVcWKmuYrC9o+G0TcKvCKeaiYI+OIx2hhNxZL22bA38KtCjbifHznrcyYIkdwWKYS76
         T8EGopLeT7SuiQWVR5zHJC4Ntlt7MxljN+bepqloPJT2M62lUf/Qw1yF6yRqXYAgImiS
         lCAFjynAm6I7O16EyDytB/35/dslhbf0JyET3NPj2KdLW/O/qmbwn20D7yZFofAdw5aS
         mGNH+y96aHsDrXO6kDI/3m3gH6Zlbm3ho4iQSnZmgcYDdApspiF2hg4SCnmWfqhlF8B6
         GOgQ==
X-Gm-Message-State: AOJu0YxW398yusVUDAHvpi8jajLB15UFCWutjfJ7DUli4bEf3CRecdWX
	TfVcXRG5BNrrPh32goR7zUlvPYieNxtXt4jAbrCrWvc2hHwBPY/0YzP0BKf2i+cA
X-Gm-Gg: ATEYQzyO5qHPNoFCLw3KtfVTL7Fn1i1EPJE9gvqBEQ3vz5MAofQZmhPKHA+QQWX9ZHG
	8F2iIpzMu75Sqk6M6QeY9HNE49EinBbBYdxN0hXZBAGNz8pEcagPuvV46w3BM2CY4xzDYMvaKSR
	p7oucA5k6yPexUvJfC12mkxduxGuKRm8JPDOgn7zAwEDH9F/WOpkw2serTL3dDHUf8yTWjlrnCm
	w2QCZtm3RDT419cU0CC4qAokqNlPiRbeXttkjA4l4GsZtslFCD5lRGM4vofmkIK+LUMIxH1aZrl
	38QNWrRAL/clIG+2HBqUcLbI7L1SirKsPYOuImqtAhf1Edde8P0RlL2GnKSp2XzyY13/9qRo0XT
	8h7GKgWNGWsLQL4jPl57DKKM2g7vQgKJgs+eDuR/5S2vLAwjDtlpueVl6JDk68djL8o8XRf0A6t
	+mfxC3j8kdEdXa6Pi2kqQaOMaCIGRlG8dg4HL6jH7sC6/5YBA=
X-Received: by 2002:a05:7301:4b03:b0:2b6:af85:dd2d with SMTP id 5a478bee46e88-2be4e08b2a4mr197449eec.32.1772760682956;
        Thu, 05 Mar 2026 17:31:22 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f82316bsm34173eec.7.2026.03.05.17.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 17:31:22 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 5 Mar 2026 17:31:20 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v2 1/2] ata: libata-eh: correctly handle deferred qc
 timeouts
Message-ID: <23d17d21-4ff1-4478-8f74-df41b05fc995@roeck-us.net>
References: <20260220221439.533771-1-dlemoal@kernel.org>
 <20260220221439.533771-2-dlemoal@kernel.org>
 <ea6cdec5-cbd6-4387-9995-cbbfda978155@roeck-us.net>
 <8011c682-7fc6-4cab-b142-d05fd3b09de0@kernel.org>
 <68df8235-dc05-41e2-afdd-42f7143e26ec@roeck-us.net>
 <68325544-334d-45d6-b406-82cc1379df0e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68325544-334d-45d6-b406-82cc1379df0e@kernel.org>

On Fri, Mar 06, 2026 at 09:50:49AM +0900, Damien Le Moal wrote:
> On 3/6/26 09:32, Guenter Roeck wrote:
> > On 3/5/26 15:59, Damien Le Moal wrote:
> >> On 3/6/26 02:59, Guenter Roeck wrote:
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
> >>>>   <TASK>
> >>>>   __dump_stack lib/dump_stack.c:94 [inline]
> >>>>   dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
> >>>>   ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
> >>>>   __ubsan_handle_shift_out_of_bounds+0x279/0x2a0 lib/ubsan.c:494
> >>>>   ata_qc_issue.cold+0x38/0x9f drivers/ata/libata-core.c:5166
> >>>>   ata_scsi_deferred_qc_work+0x154/0x1f0 drivers/ata/libata-scsi.c:1679
> >>>>   process_one_work+0x9d7/0x1920 kernel/workqueue.c:3275
> >>>>   process_scheduled_works kernel/workqueue.c:3358 [inline]
> >>>>   worker_thread+0x5da/0xe40 kernel/workqueue.c:3439
> >>>>   kthread+0x370/0x450 kernel/kthread.c:467
> >>>>   ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
> >>>>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >>>>   </TASK>
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
> >>>>   drivers/ata/libata-eh.c | 22 +++++++++++++++++++---
> >>>>   1 file changed, 19 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> >>>> index 72a22b6c9682..b373cceb95d2 100644
> >>>> --- a/drivers/ata/libata-eh.c
> >>>> +++ b/drivers/ata/libata-eh.c
> >>>> @@ -640,12 +640,28 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
> >>>>   		set_host_byte(scmd, DID_OK);
> >>>>   
> >>>>   		ata_qc_for_each_raw(ap, qc, i) {
> >>>> -			if (qc->flags & ATA_QCFLAG_ACTIVE &&
> >>>> -			    qc->scsicmd == scmd)
> >>>> +			if (qc->scsicmd != scmd)
> >>>> +				continue;
> >>>> +			if ((qc->flags & ATA_QCFLAG_ACTIVE) ||
> >>>> +			    qc == ap->deferred_qc)
> >>>>   				break;
> >>>>   		}
> >>>>   
> >>>> -		if (i < ATA_MAX_QUEUE) {
> >>>> +		if (qc == ap->deferred_qc) {
> >>>
> >>> An experimental AI code review agent tagged this patch with the following
> >>> comment.
> >>
> >> Thanks for that.
> >>
> >>>    If the `ata_qc_for_each_raw()` loop finishes without finding a matching `scmd`,
> >>>    `qc` will hold a pointer to the last element examined (`i == ATA_MAX_QUEUE`).
> >>>    If this last element happens to be `ap->deferred_qc`, the condition
> >>>    `qc == ap->deferred_qc` evaluates to true despite the loop not breaking on a
> >>>    match.
> >>>
> >>>    Could this mistakenly intercept a command that completed normally after a SCSI
> >>>    timeout, returning a timeout error instead of success? Would this also
> >>>    incorrectly clear `ap->deferred_qc`, dropping the deferred command?
> >>>    Should we verify that the loop actually found a match, for instance by checking
> >>>    `if (i < ATA_MAX_QUEUE && qc == ap->deferred_qc)`?
> >>
> >> Yeah. Something like this. But that condition cannot actually happen. i ==
> >> ATA_MAX_QUEUE correspond to internal QCs, and these never go through the
> >> deferred path.
> >>
> > 
> > Pardon my ignorance, but doesn't i == ATA_MAX_QUEUE mean that qc points
> > to the _previously_ examined qc, i.e., the one associated with i ==
> > ATA_MAX_QUEUE - 1 ? Are you saying that this qc will always always be
> > internal and never match ap->deferred_qc ?
> 
> Arg !!!! Yes ! I screwed up. Checking ata_qc_for_each_raw(), the tag is checked
> before setting the qc pointer. So yes, you are absolutely correct, and we have a
> problem.
> 
> >>> It does seem to be a real problem to me, but I don't know the code well
> >>> enough to be sure. Please take a look and let me know if the problem is
> >>> real. If so, I'll be happy to submit a patch to fix it. If not, please let
> >>> me know what the agent is missing.
> >>
> >> See above. That is not a real problem, but it would still be good to check. I
> >> think your change is fine. Car to send a proper patch ?
> >>
> > 
> > I can try, but if the AI analysis is missing the point I don't really know
> > how to describe/explain it. Can you give me some guidance ?
> 
> I think the AI is correct. That "if" without the index check can lead to false
> positives and we can endup timeout-failing a deferred qc that has not timed out yet.
> 
> Send a patch please. As mentioned, we can touch-up the commit message if needed.
> 
Working on it.

Thnaks,
Guenter
