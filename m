Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72B08C1F;
	Thu,  2 Jul 2026 02:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782959459; cv=none; b=QQPgAK5Iyos0PkpOKmpD2OHMz3KUGZkc5SnETaVjRDghq0dif2Ep/oHqEH6Rv+noO3gudKuvXOglvFLJ70pmkIfvp/Aj89KzeewodiBr044JSucGZ/mJN5MJGXkMqz0QA80nEsz9db90mAZ6gnQsH6iUfWP5sInJQHAFmW8egag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782959459; c=relaxed/simple;
	bh=ndW/zcCiho46k+Tr1GgNHaAqabWpf1/jbZOklm+VzSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+A/O2Ptjs2h8e3ijxuGWcdjUEIG+5DU7Nn+cMVMK31OYtMLR5h0yTwmLpcSygtGpSK2ucS4jrWn1ykWADFyc928hz9H1KFWHkm2q9OQnfb5JQ7s8LzA+bh1I3IRwkD1Efvr2qsK5/f3zlsY1tSZDhpogbDjTtVo2aEnL4uxcpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSVVos9Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSVVos9Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE04F1F000E9;
	Thu,  2 Jul 2026 02:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782959458;
	bh=zM2YK1IZQLcYH2u+DadITFaarNNr/CUp+KbrmKvbkVI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HSVVos9ZzfxoWF+OkJfEOE2pRPniWWNnjkxSANUqGKXcFh96h5CMtdmXR+kspbWJ/
	 yFrX5SrHkQX1i0R41r+ENbkSQfnmhTy2VzEpDz8IRfagSxbwgqd/o46PweMnvi0K8F
	 JXP/vglWlsO5EvIYgI73xYXZvkWi1FEISVMJJE5UQMR2SicwgB8mNphS1M6gWS3V05
	 +Ig+6aDtybk41/iTybhpaMoWuOqHrlT6DCt+OUwRyxm4WPChMDddk+QBBm14/WmkoC
	 2fd5OuiZlzdX30lg3XVHERhtk7BFdsBz0Ai6ludAGjmOuTi6QxIUS73YaMYebnzAvw
	 u57mOq+qCH2Dg==
Message-ID: <16780c1b-418a-4555-b4bd-d442cedd620e@kernel.org>
Date: Thu, 2 Jul 2026 11:30:56 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata-scsi: limit simulated SCSI command copy to
 response length
To: sashiko-reviews@lists.linux.dev, Karuna Ramkumar <rkaruna@google.com>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org
References: <20260702020142.3399851-1-rkaruna@google.com>
 <20260702021411.B01331F000E9@smtp.kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260702021411.B01331F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/26 11:14, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] The defensive bounds check `WARN_ON(len > ATA_SCSI_RBUF_SIZE)` is ineffective because it evaluates after the `actor` callback has already performed an out-of-bounds write.

Karuna,

Sashiko has a good point here. Let's work on fixing this with an incremental patch.


-- 
Damien Le Moal
Western Digital Research
