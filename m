Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793323089;
	b=1Gf0sMuRDGi6CQVqjLQ+BaMNuHwVZnBBbF7uKJPBExqnfyZH32IJrtJeghLFBxs0E5wL
	 BnL6QCPwEEPuhLF8cSf9OZ2gkUMaDkUsT4BHv3DX+ktz6obNjtPhqG+YEy9qc5ENfRgyL
	 +qS/go7FGAhFy2k77vpxEJel8pVdI+NWNAwsDN7xMy8lt4Jyyy4UMeCPCKFHd8EOAh3qd
	 vzJK95gRstDqLJ59UeL9WYhs0hZLcg8OcJDUVHF+8asUPX+Bjod75oNr+9r8ZxxqZb+T0
	 lpc8PQGnFFJBpIz25gL/CR8Lpoc9uJHymbNWCaCFutgk3upwInPO8p139/c6B+WeVkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793323089;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=+RfaDMTpW0gHuPAQJwyUf5tqfXJoAbY8G1el9WGL2Ng=;
	b=eIFvaBoo1D6tKCWco3eiWMywf7QRCeAsM0mcNpc7b1T0BLsHEwf2QZcqLEP+1PxIT/D3
	 xYeaVc48UHTZpveDaBAjmrcKA/+AoORLXaUZedusWfzQgdeXCFTonKkckKrxQCJeQ4WKN
	 V06nKfwaRv4GTB+nh9vLUf4LRhsEg6PXHJC956AUl+a5IXFrMk8YjYDbdNrdafj52YbmL
	 oAh5W+522CfNyq0AEI59nFn4giVl+iWFfI0TO5oYL8TZpYKoso3cq9PPZU+QUyqjBNd+G
	 9nBGsV0A0HArUM2r0sh2VkwsieQYiFdABShc1pknEVKymD9tit9qRNU7c2/RnHW4UhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MA5iGJW4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EA2606A31A;
	Fri, 30 Oct 2026 01:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MA5iGJW4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2595F1F000C1;
	Fri, 30 Oct 2026 01:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793323088;
	bh=+RfaDMTpW0gHuPAQJwyUf5tqfXJoAbY8G1el9WGL2Ng=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MA5iGJW4r6NLeVkToPA9s6HHHyInUpxd6vghADZIV389uwelVvwSbG9hJa+J2P7VU
	 +OCC9D2m9S17v+WBugZn1XM9xMzj/h7VrN4f3NElt+7clM81aj6HyzhNXgMeiNVer/
	 OVV7Tg7BX06ZPqWppnLjgWQD58MC0eQ+UY+I9SV8qNUdvkB6Ylz/8GXrUr3wqYqcg1
	 vZUuK+v3BKnaGCCezVVfuvXxWEMRrIwF+ADYyfHJH44yhbmnCKAG74lBnsMUd/uQr/
	 EVaHyyGd26gNHkGOvGB/cOVE9w9gRWho2x5AToBooyNuVczTSsW2xuNFW65BjsHyP8
	 ifuEVJ84jZU4w==
Message-ID: <2def2444-0b73-4371-9ba2-78af235e64cb@kernel.org>
Date: Fri, 30 Oct 2026 08:18:04 +0700
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata-scsi: reject data-in commands with a
 data-out buffer
To: Zhao Gongyi <zhaogongyi@bytedance.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261027090809.94126-1-zhaogongyi@bytedance.com>
 <20261028113903.19569-1-zhaogongyi@bytedance.com>
 <8ec9e401-4c00-42fe-b997-228e05ed9c2a@kernel.org>
 <36648b88-c295-4acb-8b6e-25d742d50946@bytedance.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <36648b88-c295-4acb-8b6e-25d742d50946@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/29 11:37, Zhao Gongyi wrote:
> Hi Damien,
> 
> Thanks for the review.
> 
> On 10/28/26 9:59 PM, Damien Le Moal wrote:
>> On 2026/10/28 18:39, Zhao Gongyi wrote:
>>
>> No they cannot, as long as the kernel is correct for internally issued commands.
>> But t is not clear here if you are still talking about commands passed through
>> SG_IO.
>>
> 
> Yes, by "translated commands" I meant commands submitted through SG_IO
> and subsequently translated by libata, not commands issued internally
> by the kernel. I will make that explicit and narrow the description to
> the affected ZBC IN and GET PHYSICAL ELEMENT STATUS paths.
> 
>>
>> Why is this being checked here and not in the SCSI layer (sg driver and bsg)? It
>> seems sensible to check this there.
>>
> 
> I checked the SG and BSG submission paths. For data-direction purposes,
> they derive the request direction from the SG_IO descriptor and otherwise
> treat the CDB as opaque. I could not find a generic helper that derives
> the transfer direction of arbitrary standard, service-action, ATA
> pass-through, and vendor-specific CDBs.

Yeah, forgot about that. Ideally, we should get the ioctl(SG_IO) to return
-EINVAL for an invalid data direction but that indeed requires parsing the
commands, which we do *not* want to do.

> For simulated commands, libata itself performs the CPU-side write. For
> the ZBC IN and GET PHYSICAL ELEMENT STATUS translation paths, the actual
> ATA data direction is known after xlat_func() has built qc->tf, and their
> completion handlers may modify the receive buffer.

Yep, these are the only ones we can catch easily. Other commands we do not look
at/know about will keep potentially triggering iommu page faults, but that is
fine as that is not a crash. However, ideally, that should lead to the command
being failed, which it seems we are unable to do... Did you check if we can
propagate the fault into a the request to indicate a failure?

>> The CDB may be perfectly correct. The error is in the SG_IO descriptor setup,
>> NOT in the CDB. So returning invalid field in CDB seems very misleading.
>> This is not something that SAT defines as far as I know, so we need to find a
>> sense code that is more informative. Please have a loo at
>> include/scsi/scsi_sense.h to see if something better exist.
>>
> 
> Agreed. INVALID FIELD IN CDB is misleading here. I propose returning
> ABORTED COMMAND / DATA PHASE ERROR (4b/00) instead.

Not sure if that one is ideal either. Let me check and get back to you next week.


-- 
Damien Le Moal
Western Digital Research
