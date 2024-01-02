Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077EE171D3
	for <linux-ide@vger.kernel.org>; Tue,  2 Jan 2024 22:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glwFiyBg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73740C433C7;
	Tue,  2 Jan 2024 22:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704235610;
	bh=N5llZgrukLYsgZLHI/YxYi+N/S/EzTbsN2AbpoL4w0M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=glwFiyBgb4Buy9HwLK1ddeev1fAED8bSo8iHw4Kuzo+1AO/r1S8S8LcxOWLgownCx
	 h4NHfPbCvdrRkMap/LVOq7f64KjvMMNB6t7PRMGw0UsweHwy/8099hAi6mbLGxGtt9
	 JO5Co/HPM62leeYJZCBc/KUxlKQVsalS+zRmGEkjtr373TSoqnJitvVvIf0rQE9MQL
	 Zzn149b51uWcmaDNok4nXUqr3ETLhJpR7RkfCiwzlPTDN6pdVi+v8unl5pmPQK/3qN
	 TKVpovVRfn6oLMxRQnxcKrO6qke9sx3Mg2dyhUSHw2jsR+OsLK7+31R8cPtw2bgr/l
	 OUGAEecnLRJcw==
Message-ID: <5e910396-3941-4cd6-a8f6-ced585efdcb6@kernel.org>
Date: Wed, 3 Jan 2024 07:46:49 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] Only activate drive once during system resume
Content-Language: en-US
To: Phillip Susi <phill@thesusis.net>
Cc: linux-ide@vger.kernel.org
References: <20231225151915.258816-1-phill@thesusis.net>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231225151915.258816-1-phill@thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/26/23 00:19, Phillip Susi wrote:
> I have been wondering why I kept seeing drives activated twice
> during system resume since this got added.  It seems that the EH
> process can run up to 5 times as long as there is still pending
> EH.  I am not sure why, but it look like my Intel AHCI controller
> issues an error interrupt during the first round of EH, even
> though there does not appear to be any error.  This causes
> the EH_PENDING flag to be set again, and so a second round of
> EH happens, which then tries to activate the disk a second time.

For a single patch, the commit message should be self explanatory. So the above
should be added to the commit message (may be not as-is though).

> 
> I propose the following patch to only set the ACTIVE flag once.
> 
> Phillip Susi (1):
>   libata: only wake a drive once on system resume
> 
>  drivers/ata/libata-eh.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

-- 
Damien Le Moal
Western Digital Research

