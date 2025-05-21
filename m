Received: from devloop.tasossah.com (devloop.tasossah.com [145.239.141.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EBC21ABB9
	for <linux-ide@vger.kernel.org>; Wed, 21 May 2025 08:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.141.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747816701; cv=none; b=F9lBYtYBa5tIpyQVvIZIgn20Vn5Q2LWPV9rNchEumJarNRatPZzHSQGqFQA5mc2OZNIrUaZdurlakHGRtq76yxL1gFZ4K+wWqdcRLUyb/dMnI3JPXgQoQgp85XWblwqW26TflTVxKzW/Yh4rztikithu/xnhDodYmybAPTexV0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747816701; c=relaxed/simple;
	bh=c6uEf+ZkibC/CStLe9MXKlgyLIvIhf2Y69pjMb8IAC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RfrokJiMdbUxxb8NzaDPzbulFq8NF97Us0+YYzgodPrwHjc98zdbWNwhBPDDtL0JeLJyU/IPJShHrrQFg6yJFUR1ojQIX1/ZXlSV1X2E2vTPaM6/WywU9ng2rzYIv1Fpb7zJmruEUcUcYjOtOY4mu9KkMpsMWHbZaZ4T7z1LsNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tasossah.com; spf=pass smtp.mailfrom=tasossah.com; dkim=pass (4096-bit key) header.d=tasossah.com header.i=@tasossah.com header.b=XAUH+DuN; arc=none smtp.client-ip=145.239.141.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tasossah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tasossah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=tasossah.com header.i=@tasossah.com header.b="XAUH+DuN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=tasossah.com; s=devloop; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rQAD9E91Q8rNiVSWuhOddNsq6Pr8cUauVv2/PxS84J0=; b=XAUH+DuNZURn//vAjkPx1Mgl2T
	YXmgrB3EBBwYtnKxtwMsSyEt0iq6n+GwFyTIWFU+kO2nXmVslzcDIfHgC3elfamR0r4Lo2hynGdpr
	zj0W+jKTPzErnoxgaM32dWimxov24yxCYjizWzUKnmz7ulFQtnB6HTOVPu0ANn3wiWZs6UaC9EkBU
	L6QAzkvAwv97akel4P+Hqk0zQzWoZSyDZ3rKjQ8C3DY4dJxcv3t/h4jXNAySKnaOsF7/KfZsZCkyj
	v+p6D9+UrbOGSGCVW9O7xlcgLZKjPtzxeY09AIvXJYo3mgeOoaUuIrFwGDLq8JL8e0pyXnbZ0hBj+
	ooAAGFN7qqvaNrpXUlilh5oKo4sNTciSgU93v8fnHgu1TfKDAnsrl5OCTVY4M/HiJYFW1qwL9MZEG
	IeB7yTSXxUcJVHix7gp1k53p4jM511oQERY2Wr7eAE1gta5lAWQawACcyuD3mJz/ne1JYhEMsly4G
	pJ4OKUIqZKTjmVHSJyecz/Vgz6Y0TlcAZD7ZnG0cVSY8UeOeER1PRjT0+vfpzDQy5aFOG4Kup9Efr
	FOJAJcD9huKVAhvpKEMXxCCgrFBNKiXP54Ki+UyQtoociC5yID92Eguelk+VUF9Auju1b+/ByVeEq
	RqRJPvEsmwsLb6O3+HKcp80mXIfQP0ApbOygd2Iu4=;
Received: from [2a02:587:6a09:4a00:3263:4c19:b861:4371]
	by devloop.tasossah.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.97)
	(envelope-from <tasos@tasossah.com>)
	id 1uHexm-0000000CbvQ-19Ug;
	Wed, 21 May 2025 11:38:10 +0300
Message-ID: <8890b47a-1aa0-49cb-9a5d-0c5fe2dcebbb@tasossah.com>
Date: Wed, 21 May 2025 11:38:05 +0300
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: pata_via: Force PIO for ATAPI devices on
 VT6415/VT6330
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
References: <20250519085508.1398701-1-tasos@tasossah.com>
 <5c94f5d7-95ee-4341-adbb-89d6bb48fa1e@kernel.org>
From: Tasos Sahanidis <tasos@tasossah.com>
Content-Language: el-GR, en-GB
Autocrypt: addr=tasos@tasossah.com; keydata=
 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
In-Reply-To: <5c94f5d7-95ee-4341-adbb-89d6bb48fa1e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-05-20 12:30, Damien Le Moal wrote:
> On 2025/05/19 10:49, Tasos Sahanidis wrote:
>> The controller has a hardware bug that can hard hang the system when
>> doing ATAPI DMAs without any trace of what happened. Depending on the
>> device attached, it can also prevent the system from booting.
>>
>> In this case, the system hangs when reading the ATIP from optical media
>> with cdrecord -vvv -atip on an _NEC DVD_RW ND-4571A 1-01 and an
>> Optiarc DVD RW AD-7200A 1.06 attached to an ASRock 990FX Extreme 4,
>> running at UDMA/33.
>>
>> The issue can be reproduced by running the same command with a cygwin
>> build of cdrecord on WinXP, although it requires more attempts to cause
>> it. The hang in that case is also resolved by forcing PIO. It doesn't
>> appear that VIA has produced any drivers for that OS, thus no known
>> workaround exists.
>>
>> HDDs attached to the controller do not suffer from any DMA issues.
>>
>> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/916677
>> Signed-off-by: Tasos Sahanidis <tasos@tasossah.com>
> 
> Doesn't this need a Cc: stable tag ? I can add it when applying.
> 

Yes, please do so. I forgot about it. Thank you!

--
Tasos
