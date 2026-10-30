Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793384484;
	b=Mte/+kgRWNEZ/HOMrn0BxBogvnfO9fjTRNtlJhdbVLNfFEq6/GCWG1Gs0YIW5sCdk+q7
	 R7LTJ3fSuh0Lm4IOQUaHwxqhxZPHSBi7pOIMo80Ww5bWAF5WZK8TMujB9aSbCBQk3rQB1
	 FkdkgV8GhFW7caEVen44wy6fEnGHj434pYjJiOCtp6OQjx+9cQ5/Po1Bl94ufdbDueYFm
	 hG/An/l92TEeEac1yjgvTeMYHw1cXkKYsWZCKisLwc/7wbZO4kTzalm4wt12XxzrZyfeT
	 apy2t+Vo5qywuD0pgWMJY8rEJRBD+Ve0Y5dRaBkxe+6iE7OXH4CWLDTXxKtADScwAaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793384484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=NYZ7hhe4bE9R3R42DEAzuWzBpHbg28iNE1oLBWDsosM=;
	b=Qzfm5SBZ8+espBIQNlXlUBKLozWFBPE/UScCyLuT5oBNFxCmyE09Z/TMtT3d7k32Azqj
	 H/HG/DniMvmEDXO8xzODWgfcsQCTAOYkePJkWQkh0IfRUalE6/L8QO975AgXb/hd+fDc6
	 rfmTOHtdBxitp36dwXa03zZaINenmdGYjYhszKKVrBFTYg5hhz5YkAFrajSKrAEQItZsK
	 UMAzgnBMDGTj5x7P4Wy8CA34rkWzbLMuL2uZkNr1oHC9raeIKvmO7WqACAL84nbzNV3s8
	 dlhyf0jT93sRDUIhf1Cx4ZjkqdgqyvGTdD6WLaBxblrrd8hU+SicaUsx1Yy/Z1b0DPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ga0HXskX;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09743606A31A
	for <linux-ide@vger.kernel.org>; Fri, 30 Oct 2026 18:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09743606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ga0HXskX
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2eb0a52d605so7035ad.0
        for <linux-ide@vger.kernel.org>; Fri, 30 Oct 2026 11:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793384483; x=1793989283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NYZ7hhe4bE9R3R42DEAzuWzBpHbg28iNE1oLBWDsosM=;
        b=ga0HXskXfnB9htu5YMvyi4n6UGgCZQQY4QoLci0y5DA5ZmJq9uvBC2BYm/DQyb0bp5
         RAUVQWddjSxyjDvr8RS7Qu3oJjDlLrM6VJWhiWljZlfzEB6ltQKgBy/zdfX8vIvTuMLH
         L8hOylVHSpWRU/qJc1Agyt5ChxNtER3DTjyizkFc+6vXkoTHjF0VuxobdAVAxAEDjH6c
         oO+S0NL77Xvps1NJ0+DDSYNrL+Pqdks5WbUgdkawA3DmjHNPuZLPpFQllr31ESDaBStw
         99+DndMIiZ7IZ8rxgzsucucc2MnK1Xo9QrShhkIwAKOp7m1zKYvem7/AtImG4fzRDEKa
         PdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793384483; x=1793989283;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NYZ7hhe4bE9R3R42DEAzuWzBpHbg28iNE1oLBWDsosM=;
        b=U8FjrkOxU48oH9l02scIxsbN8YTGrmaGellqFtYYxvV1pBdNsicOLSqD1zpFrTE8Rs
         w4NEaHxZvb6vU7BCmNur5ngfJ4joYdFIUISBEuy5/Rf1FDOacaWzRQtNU7rimZ8PXi/E
         unZMGbPV2+GgZirvhrQpj7v8jhF1uCFbxQm9rLc1yXeccIMp42EMAETbUSZ3MffTrg9f
         LZjkKx7ty9+Y/7B+hn6L+D6Hrm4uyMc1w73lElmgjXbIUmHC4nT6v+MswKAH9TgyGjv5
         31t79K7i2bQNrXFmWUSGHv7ftwUgXfdUJgRYelmxPHjWXFHH3TsPdlgSg6DBWCRFQSJo
         90eA==
X-Forwarded-Encrypted: i=1; AKwUvBx0M/Fbn0c46mZZmvUKLnAYoPxyPOsoqwkqR0bkotdSSLFhw95gKXHyCIZFKlwppOkvM2V9JbJC3+I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpnLh9ohJ42yewcJ8mAz+Gl3GbSHJ0Q4DBD7+i/YNn82CC5tLz
	/akiGswaoVvnsp3+c9qSaG0OGrVmQ8/Zs6kKDG7yy824ouOsxfV85K0RO7b3iAeLGg==
X-Gm-Gg: AYBFou1xxtpAiU3tsFP4VZuZG9iLmTYbCk0sYHQCgmxt4slyc/CORYrlEzy6OS7fijA
	pFoi3nV7e8digN6yt8FEoQ9YKcWNJj0cAlsmire805Iur+S1h77+fQgvB28cAPg5i2pi4emdWvF
	ZHKt58Y54A6oRT9N5Qym4Tf/A4EcTwpmrMrL1o/29m05Mf6G2qGCHxXw16dHdfeFAwuAFDChgsJ
	jTTZ4IM9S81pMCAjs8ppoHOnTy574MyEuiTA2CjAshbZ2VttyA69DUI+XQZzjdMNraOBJFzRYeB
	1Lkp95wArReRkCZCBDkh/mTLkUJj+7w8gEeNCtuLZ1nrpGf5/8YL3lfYtjdadH3geUxHxaVSX9F
	Wk7Q+JuAHg8D09ymJNNlhsG5qxpYq57RXNK0Z0oAR2AxB91AdAwGg93MsRFSdk6ZZd92FQyh4x4
	/LdygbsvtTs0FtYK6HkwTKxEs+zsdsKvUT7Qk2FeQJgSPWaKIwKgmKKfaa7lfkNM1V4qsX7b6Z9
	hXnmVxoG3noLC5y7DDBnGsfuTL+y+Vz3wzyCJb/hoZLjHBkzvlV/yEsFpKoJjGJWoqzKMNkP1kY
	fGQ974ztNXkaZ95NOZieCXC8dot8nJcaIWHvu5yDJVuDMPJbVWMx3vOH0gXCTUxq0WFm
X-Received: by 2002:a17:902:ce90:b0:2d0:1aaf:daec with SMTP id d9443c01a7336-2eb1b6c6b09mr11584355ad.9.1793384482786;
        Fri, 30 Oct 2026 11:21:22 -0700 (PDT)
Received: from google.com (144.102.82.34.bc.googleusercontent.com. [34.82.102.144])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7d5b8csm9790621a91.1.2026.10.30.11.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 11:21:22 -0700 (PDT)
Date: Fri, 30 Oct 2026 11:21:18 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-eh: Retry non-NCQ commands when their sense
 data asks for it
Message-ID: <auTgHptFA3dZBvcO@google.com>
References: <20261030090047.407906-2-cassel@kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030090047.407906-2-cassel@kernel.org>

On Fri, Oct 30, 2026 at 10:00:48AM +0100, Niklas Cassel wrote:
> When a failed command has valid sense data, ata_eh_analyze_tf() asks
> scsi_check_sense() whether the command should be retried, and sets
> ATA_QCFLAG_RETRY if it should. ata_eh_link_autopsy() then clears
> AC_ERR_DEV and AC_ERR_OTHER from qc->err_mask, relying on that decision.
> 
> For an NCQ command, qc->err_mask still has AC_ERR_NCQ, so
> ata_eh_finish() honors ATA_QCFLAG_RETRY. For a non-NCQ command, whose
> sense data comes from REQUEST SENSE DATA EXT, qc->err_mask is now zero,
> and ata_eh_finish() completes the command with scmd->retries set to
> scmd->allowed, without looking at ATA_QCFLAG_RETRY. Such a command is
> thus never retried, even when its sense data asks for a retry, e.g. a
> transient error reported as ABORTED COMMAND.
> 
> Make ata_eh_finish() honor ATA_QCFLAG_RETRY for commands with valid
> sense data. ata_eh_qc_retry() cannot be used for this: as qc->err_mask
> is zero, it increments scmd->allowed, so every retry would allow one
> more, and a persistent error would be retried forever. Instead,
> complete the command without touching scmd->allowed or scmd->retries,
> so that the SCSI midlayer retries it at most scmd->allowed times, like
> any other failed command.
> 
> Fixes: 3852e3738266 ("libata: evaluate SCSI sense code")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Igor Pylypiv <ipylypiv@google.com>

Thanks,
Igor
