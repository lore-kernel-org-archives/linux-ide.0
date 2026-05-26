Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB6934F492
	for <linux-ide@vger.kernel.org>; Tue, 26 May 2026 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779831968; cv=none; b=WqW5n56FCPeYqxvXqrNGM2Cg9k0AG5GsPSga+8TP3Vo2X4sAdmFS5kMXfROIyGLfzsIMxngQUjiQCIFXRCLVw0iUq//LVn9LXrGh4NDxdtdpty0L7M7B3Y15ydCAxY4OC0jSteMvNCEGk/A1wPDlSglsq8zThTJs4q1fHBNjeHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779831968; c=relaxed/simple;
	bh=gBa8dl/8h8EBgkH1vuiIB5yoOcJcnOcsks+hKWWsyP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gAX6hk5w1M4XlpXcQR7hdoQn7vxv5dhsLEaVZwNIHphb/ZzQU6hDPjCZ/QVxDt9mkfcl02cve/hm7XLVNANtQGHm74fX941binGXCQMd04xZkBzQdkc2pzK/jUQR9jkVaY12x3Mitos1NO/rn2HKg3Bu4zbb9oazdf/l6f1kxRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=pzoFfkbh; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="pzoFfkbh"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gQ5sp3vSGzlh2kr;
	Tue, 26 May 2026 21:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1779831963; x=1782423964; bh=oErpLwjsLcyT3xKHfPKhLRf7
	AqfqLkxWBnCB9uoxmik=; b=pzoFfkbhqhkwglf3NoMAZ7eToDIB+veMGdidMh6H
	nviwaVx1eJDF2Aj2SAJkkhcp2PTq2jkMeUtf/NkD248jv6IhojlaUjNf25AVUI6z
	Eepz+j/uH2qzZnb/T+oH0OYf0v4o/rXUP5dZMesjv/iO1TcEKSHpf7PnHqzZj4mW
	rVJdE8aImSuWig5hkWRmkIkTSJsAK0Ho1J4qVwetC9+U0D9Rth/K59UbpJaXTt9p
	Br11ua4b3CBLfzSF1HHSB1KV7watGensyH9rL/oy466ZIdvOTDRn6bZivvXTLcuG
	bYWW2izxTYtUjVf/eCBDG7yNU76QP3cFN4Yix0NEjOpuKA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id iH21A2sonnJR; Tue, 26 May 2026 21:46:03 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gQ5sk3Q0SzlfgQJ;
	Tue, 26 May 2026 21:46:02 +0000 (UTC)
Message-ID: <da5ecf6a-b01c-4cbd-bb95-ab5a1e6a9ad7@acm.org>
Date: Tue, 26 May 2026 14:46:01 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] ata: libata: Pass the ATA port argument directly
 to __ata_scsi_queuecmd()
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Marco Elver <elver@google.com>
References: <20260521173347.2079560-1-bvanassche@acm.org>
 <20260521173347.2079560-3-bvanassche@acm.org> <ahW3GuCDCz1wnp3H@ryzen>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ahW3GuCDCz1wnp3H@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/26/26 8:07 AM, Niklas Cassel wrote:
> Hello Bart,
> 
> On Thu, May 21, 2026 at 10:33:30AM -0700, Bart Van Assche wrote:
>> Prepare for adding lock context annotations that refer to the ATA port
>> argument (ap). No functionality has been changed.
> 
> For this and the other preparation patches:
> Please add some additional text explaining why this change is required for
> us to add lock context annotations.
> 
> I guess it is not possible to simply add __must_hold(dev->link->ap->lock)
> annotation to __ata_scsi_queuecmd() ?

Context annotations with complex expressions are supported by Clang.
However, annotating __ata_scsi_queuecmd() with
__must_hold(dev->link->ap->lock) would require annotating many 
__ata_scsi_queuecmd() callers with 
__assume_ctx_lock(dev->link->ap->lock) to tell the compiler that 
dev->link->ap->lock is the same
synchronization object as ap->lock. If the "ap" argument is added then
these __assume_ctx_lock() annotations aren't necessary in the
__ata_scsi_queuecmd() callers.

Do you really want me to repeat this explanation in every patch that
adds the "ap" argument to a function?

> But at the same time, you do add __must_hold(dev->link->ap->lock) to e.g.
> ata_scsi_translate().
> 
> Looking at the C-file, I can see that patch 9/9 adds:
> 
> +	/* Tell the compiler that dev->link->ap == ap. */
> +	__assume_ctx_lock(dev->link->ap->lock);
> 
> to __ata_scsi_queuecmd().
> 
> but, that annotation is using dev->link->ap and not ap directly.

I will look into adding "ap" to the ata_scsi_translate() arguments and
removing the __assume_ctx_lock() mentioned above.

> Patch 9/9 also adds a __must_hold(ap->lock) annotation to the declaration
> of __ata_scsi_queuecmd(), i.e. in the header file.
> 
> Personally, I think that it makes more sense to have the annotation in the
> definition (C-file), since that is what we most often read.
> If clang requires us to also add the annotation to the declaration, then
> perhaps we can have the annotation both in the C-file and the header file?
> (Especially since you do annotate the function definition for those functions
> that do not have a declaration in the header file.)

I will look into adding annotations to both the header and the C files.

> Not strictly needed, but assuming that we still need to grow an ap parameter
> to many functions, would it perhaps be possible to restructure the series like:
> 1) Pass the ATA port argument directly to __ata_scsi_queuecmd()
> 2) Add annotations to __ata_scsi_queuecmd()
> 3) Pass the ATA port argument directly to ata_qc_schedule_eh()
> 4) Add annotations to ata_qc_schedule_eh()
> 5) Pass the ATA port argument directly to ata_qc_complete()
> 6) Add annotations to ata_qc_complete()
> ...
> 
> That should be possible, right?
> (I guess you might need to reorder some patches.)

Hmm ... there is no way to check that the intermediate state will be 
consistent because with this approach CONTEXT_ANALYSIS := y would have
to be moved to the end of the patch series. Once CONTEXT_ANALYSIS := y
is moved to the end of the patch series, how to let the compiler verify
that any intermediate annotations are consistent?

Thanks,

Bart.
