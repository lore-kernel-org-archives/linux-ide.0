Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372AB10F2;
	Wed, 29 Apr 2026 01:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777426576; cv=none; b=MowC25ETBQcUAURhIGww1UUo7xgyPC+8ud77TElNsTxFvUlrEK4VoXvnGnTGi5DgKvlqF9/nrlF4/vGnVmcmHUTDeqBVI5pwdYYXDY1Y8mH3YB+avWfSHzDzej82f5hjICXwOVmfkjqDWDHtbDO1Bh/DNPebJY9f2ppWk2tRm8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777426576; c=relaxed/simple;
	bh=IFd7ZaaqMMLDqncZfaF/fSGc2tr/U09qEKIUk40JD5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PorkUaY+QcnRQPi5YPCS/xY7m2O/nPLSmp3pP5JNv/6UnYsukYFnWrtUNqhcHuOaSvULRvGc61WMiOCeIhSq0k0Pim+TiZWt8MsjiY8z7BpRuM8HbTDrZkYGQ6NZCAl4aapo+8HVYQUFrZznjVH3wPJWPnesJj1sK76Mi6bWFmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qo8x8r53; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qo8x8r53"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4297EC2BCB7;
	Wed, 29 Apr 2026 01:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777426576;
	bh=IFd7ZaaqMMLDqncZfaF/fSGc2tr/U09qEKIUk40JD5w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qo8x8r53IXhsRUCTYC6CvstHTYuZI7YC7QvCpLmb3TbN6/xOq8NT3pLEd9fa/ntVO
	 qf4Kx9v9qp81QgbuHEoQUftgVB1KxfFq2mx8FBbjbQk9xafPbZ7KnQz16cj3paBUxE
	 TKNJXi6QaRwX4mOZmqptn/ZTCqQzieOS9D4HiV0Emq/JWAmBVg7NYXYnikzCtpLYc5
	 c21NKQc61N+2Iz6jGMlr4OCULNrIrf2o0q354pzFZelY27bxS8lr8oqPF69wGQ1e/p
	 iSYnWD3yvA9G0dKLdXk31FmAX3Wi7fYQv/QSrAELaiN8ufNQrUeiiZGhWn7gA+iVCe
	 m6gsXYDg++lMQ==
Message-ID: <66bc004a-4a18-43d1-b296-463ea72cbc85@kernel.org>
Date: Wed, 29 Apr 2026 10:36:13 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-sata: retry hardreset when device detected
 but PHY not established
To: yangxingui <yangxingui@huawei.com>, cassel@kernel.org
Cc: linux-kernel@vger.kernel.org, liuyonglong@huawei.com,
 kangfenglong@huawei.com, linux-ide@vger.kernel.org
References: <20260425060447.1312763-1-yangxingui@huawei.com>
 <e8d237bc-7191-4881-924b-86a34ff0f3b9@kernel.org>
 <a118114e-9828-06d6-d38b-2b426c92bb14@huawei.com>
 <33299d0d-d863-4e00-951e-4728ddc823e2@kernel.org>
 <0539efac-d9b5-4f95-eecd-b88cb3cb8724@huawei.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <0539efac-d9b5-4f95-eecd-b88cb3cb8724@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/29/26 10:14, yangxingui wrote:
> 
> 
> On 2026/4/27 12:45, Damien Le Moal wrote:
>> On 4/27/26 10:51 AM, yangxingui wrote:
>>>
>>>
>>> On 2026/4/26 6:53, Damien Le Moal wrote:
>>>> On 4/25/26 15:04, Xingui Yang wrote:
>>>>> When sata_link_hardreset() detects that the link is offline, it currently
>>>>> returns immediately without distinguishing the reason. According to SATA
>>>>> specification, the SStatus register's det filed (bits 0-3) indicates:
>>>>>     - 0x0: No device detected, PHY not communicating
>>>>>     - 0x1: Device detected but PHY communication not established
>>>>>     - 0x3: Device detected and PHY communication established
>>>>>
>>>>> This patch helps improve device detection reliability and adds a check
>>>>> when the link is offline but det filed shows 0x1, return -EAGAIN to
>>>>> trigger retry, rather than giving up immediately.
>>>>>
>>>>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
>>>>
>>>> This is a pure ATA patch so please CC the linux-ide list, not the linux-scsi
>>>> list.
>>>
>>> Ok.
>>>>
>>>> Also, please check your mail setup: your email was in my Junk folder.
>>>
>>> Well, patche was sent using the git send command.
>>
>> Not git send-email, your smtp server. It probably has something wrong with
>> DMARC. All your emails endup in my junk folder.
> 
> Alright, it might be related to the company's SMTP server, but this 
> configuration is fixed, and I'm not quite sure how to fix it yet.
> 
>>
>>>> This is preceeded by a call to sata_link_resume(), which calls
>>>> sata_link_debounce() and that function makes sure that DET is stable. So if
>>>> after that DET still shows that their is no PHY, there is likely a big problem
>>>> with it and it is super slow to be established.
>>>>
>>>> In this case, I do not think that doing another hardreset is the right thing to
>>>> do. Have you tried increasing the deadline for hardreset ? That deadline is used
>>>> as the limit for the link debounce too.
>>>>
>>>> Do you have a specific controller/device where you see this issue ? What exactly
>>>> is the hardware setup where you see this issue ?
>>>
>>> Our customer imports and verifies a new disk, there is an occasional failure in
>>> performing a hard reset on the disk and no exception log is generated for
>>> resume and debounce.
>>
>> Does this hold for all disks or for only one or some models ?
> 
> It may be some models, It is not found on other disks.

Some model ? Which one ?

And please remove linux-scsi from your emails for this topic.

-- 
Damien Le Moal
Western Digital Research
