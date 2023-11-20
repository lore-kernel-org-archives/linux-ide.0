Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBB7101F1
	for <linux-ide@vger.kernel.org>; Mon, 20 Nov 2023 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDqpwHp0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC57DC433C8;
	Mon, 20 Nov 2023 09:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700470810;
	bh=Mx5Y79L5QcR1k5/A/ihZN1xv6Z1ScPaP1y96PUl/7Do=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XDqpwHp0UG9CGLc5FiJAdKSBptKXlMg8aOATpJPtgKeiU/NL5e/Mm8GySZj8AJwVG
	 Mcjxn78ZlmQzmEH3gxlp/VcRxOKKYGy1lZw1rtfe8ss0oMK6qVmRFaip+QAqq3Gop4
	 k5qu+a/HjUcSxKGcD8j51LaiEck+59UOVxPSlUF6WfPaByhsXKMmtfDmnzq6iVvZ8z
	 khpWedDxtMW+IgDsP57SqyoxgziNrADFOJCdRKCyS9lNhjoYBtQ/W01vtcx8m5+EPg
	 sKGCE2nz4eMMq6t2EoMHISFZWj1CvOA7c2hg4iMzSlp4zwoLEXOM+GprUT+6fykb/c
	 VhmR3jSq580DA==
Message-ID: <27500ebc-1ba5-4171-b93a-227f1391d63e@kernel.org>
Date: Mon, 20 Nov 2023 18:00:08 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] scsi: sd: fix system start for ATA devices
Content-Language: en-US
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>, Phillip Susi <phill@thesusis.net>
References: <20231120073522.34180-1-dlemoal@kernel.org>
 <20231120073522.34180-3-dlemoal@kernel.org>
 <a3008d49-32db-51cc-f9aa-ca9ec91ec14d@omp.ru>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <a3008d49-32db-51cc-f9aa-ca9ec91ec14d@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/23 17:50, Sergey Shtylyov wrote:
> On 11/20/23 10:35 AM, Damien Le Moal wrote:
> 
>> Ti is not always possible to keep a device in the runtime suspended
> 
>    s/Ti/It? :-)

Arg. Yes.

> 
>> state when a system level suspend/resume cycle is executed. E.g. for ATA
>> devices connected to AHCI  adapters, system resume resets the ATA ports,
>> which causes connected devices to spin up. In such case, a runtime
>> suspended disk will incorrectly be seen with a suspended runtime state
>> because the device is not resumed by sd_resume_system(). The power state
>> seen by the user is different than the actual device physical power
>> state.
>>
>> Fix this issue by introducing the struct scsi_device flag
>> force_runtime_start_on_system_start. When set, this flag causes
>> sd_resume_system() to request a runtime resume operation for runtime
>> suspended devices. This results in the user seeing the device
>> runtime_state as active after a system resume, thus correctly reflecting
>> the device physical power state.
>>
>> Fixes: 9131bff6a9f1 ("scsi: core: pm: Only runtime resume if necessary")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> [...]
> 
> MBR, Sergey

-- 
Damien Le Moal
Western Digital Research

