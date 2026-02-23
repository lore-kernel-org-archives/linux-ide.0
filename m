Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CDF3370FE
	for <linux-ide@vger.kernel.org>; Mon, 23 Feb 2026 17:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868927; cv=none; b=SOcqfS4o31oVItS2YDkcHLcrGNNcrgYetFbQm40pgds4K1Ak3/0UsvmzMOrbuDpJSJNXp0FQo6Qa8YURSVfESPNR0KW3ZWqcZcHUEoCfXy3jnP2lekUqQ6Ar+7VDop+p9gK8bR3PzULb6J1CPTYGIjBmKhsoDBJcFQANs/Ol+7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868927; c=relaxed/simple;
	bh=UrfZ5MYWOFIPLfpwD3rCBVOPfjIAnyrRbXEt+Y5WDRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b86lyWrcgVIrvl1gLvQb67bnIGg4NC4pgvuTNdGxdsL/pgxgX0a94w1XcXIFmaJN6cADBP/jzNL8snY+zkYkCzPfDI84OaPAjCCBXhEtcl3jwXWwoC95QqiNecmlkiHQEJ+9ntCEDOK891/+wrYXcv1coR2jKNBihGqzaEsNKfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ot7TJIa9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ot7TJIa9"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a76b39587aso2145ad.0
        for <linux-ide@vger.kernel.org>; Mon, 23 Feb 2026 09:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771868925; x=1772473725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fSMYf/SK8h8mWKDt+z1tL8b46vzqqkP2QabnWfLzpCM=;
        b=Ot7TJIa9suj1E39ywFkXnUc79sHELBvq1vtf8r6A3HQzQHFw98SBF/MjpydN4XcR3Y
         vwL3ZRmtjgQdhpYddw0DoVNM/nZSl1Tqpux2tJSB6mRqRaAt5gYbN3icamakqMrgtnIK
         vqN2LaOJydzscNPzuOa78KHPJIPW5LUBqQGr1mPkx5sCiwkVP6ui/X/pXgTXNb6QsFpY
         SJEy8GpkJLwjofpUNmusTSBhgE9udy8jEQqQnHWj+ti2C2NI3s37f3V6S3o7Cjf9DY3G
         4z6g4m6dXTQtubiYllSmN8ILZgwNcOeGHMTh6Op27wWVJxgvDrIpegulxiZZ+S0HTfAi
         /lBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771868925; x=1772473725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fSMYf/SK8h8mWKDt+z1tL8b46vzqqkP2QabnWfLzpCM=;
        b=pG6TKCD8tYRrrXlbZ1t57womMMP9ArR6XQUTzm/i3mT1F9ADeTwZp74O4d4gEB0GqO
         JcUYS+UKRWj26XvsEZU3mPXzvy6D6leISNUD/j1cowhLOZy7xPQsi43fVD95+fRgczcu
         ZIBysUSa0DF5ervbnFDKd7UBaTbFLvw9ktC179Ij3+ic2Y8vlZPQWaWpNmOiKD0JNeHi
         fedUet5LF9rXfvUMcHpuumkABjzXB2MX7s3KK0BdLaoH+WA1A79WGrtQWFdt1yQzmqoc
         9QYHtQOinOVUu/WfHhIlZBX722l3oriayivryB0U5v4TUzDjYR8QQaw6aOgbU2RlXbQl
         NOOw==
X-Gm-Message-State: AOJu0YyWZp1xkAjfsCcshZf8LTMLiZzkfXVEj1tzhSkl8R6iCGnKitFz
	CkIHEsixaeJXx4mfS0d9wcRJ2vkC/JENMERcQBapW7xO5679Vr11GqDmA5jT6MpfeA==
X-Gm-Gg: ATEYQzz4MoPKbi8CaYHW4yPEcNPuGrW/mfXFo6biYhSJC4PQuKn5yBtf7EGfWP/bhJ7
	ghLfpEQUA87FAsqFZQCoJ/EohnBktsdhDiqhKwZwm18XriR7tnou22wu523/7Ux39iwpexcGCoY
	pBlIEcBhxrHj/N1XdWM8GPPQU9VBgoV/7DdzVDA4tmbKtc2lSMRKQIpgByI2xFM3mxf6p7fRzNR
	lwJgIYfxI/X/xsuA/L9Wua/FyzMeJcu7iHmiJ5NP+5PJ1n9VXTVGge2zkwti4JrI1NQOx1mDGMZ
	cIHOap6qmXQn53oYI56sUIDs8VChJ5EbKMDmNnz62T8y1S6JxzuG6jMgS1Efi5NDJkmXcIhazg3
	+B3EpWEResPfIrMh9U8QPddshVMnxl/2biyTGPPnwUTmUNn15sDvjVHthF/xq4NuHEzswBkU/3h
	wB7VPKIJnv9FctX6xr0bX8XyedSom6sA7d5FviZM4L1qwPJi/Pl7kJAMaVUMU=
X-Received: by 2002:a17:902:f60a:b0:2a9:5c9d:d1b with SMTP id d9443c01a7336-2ad75d58576mr3024205ad.9.1771868924554;
        Mon, 23 Feb 2026 09:48:44 -0800 (PST)
Received: from google.com (33.75.230.35.bc.googleusercontent.com. [35.230.75.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74f5e0f2sm81369715ad.31.2026.02.23.09.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:48:44 -0800 (PST)
Date: Mon, 23 Feb 2026 09:48:39 -0800
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v2 1/2] ata: libata-eh: correctly handle deferred qc
 timeouts
Message-ID: <aZyS92-DhZga9kuD@google.com>
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

Reviewed-by: Igor Pylypiv <ipylypiv@google.com>

Thanks,
Igor
