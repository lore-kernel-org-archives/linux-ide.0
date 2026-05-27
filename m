Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE75637B03E
	for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779910325; cv=none; b=ebMU30q1im5DGNYpq8dhHESykrKfi2SURyVWFzmVDIutiF1k1NzYyANvT/texoax/J/v/jeUCvcvo7pMuIQismV0I9leZSkcZsi/OsBPMKEXNryzhjubgVttx+Y7ZzRNSZowZquXhJqVXTdmru9J5o8hCfp1BRuh8H4D3chIaKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779910325; c=relaxed/simple;
	bh=4ySV9rt0kGCM6NwC6zzuJ0x0bJKjhPLQKzMDlCIqqJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lftiWIJaIn70KCHx/qjYL7GuuFSq1GhHA+Ito6WtC3aMLKeL1Pek+UQWw4G8AKEUUZbDTJGA0Aql5XAYXZgBF/VaddSS+5r1uXKx8K6MyfhN7MY8iIAYCn2CLARjIcCxvRuN0r6s+S5/fQE+N0KB1qUfBJXOTXVlRQ8neUysPw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IW1Jt/OO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IW1Jt/OO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E171F000E9;
	Wed, 27 May 2026 19:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779910324;
	bh=veV2sQyjMOWDxoPU//DPNwB3okNa2YuW6n9Yo+Jl+Xk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IW1Jt/OOPMbXXZsc9AcIwojsDsILOv3Q0raAy+NficNw9RVREVc9bhNJ+1p9iMJEj
	 4NKn9/6G+0R3cs8Lzmq2/nB6PE+tKokW6hGx3J+TnnouzP9Sydkeef6E+gHtvpuf2W
	 tviyQqru170r8qHoPQWsMFvMGl2xKll6xwDOGjEiTNFa8/7bBGo2PLIDtQyklQ36UE
	 TET0ZdB7xCU/Wdj/VwKC1tVx9N6tFwjBmBoY21VZVxXvL8Vh/ffHxqSfA2ck7uZaiN
	 LzIN/6HQNWmbmXgDlYvQshO5yy7PrE5Cm/OpuRDr6yiIJfXukHl85XyOBGtRiCYNjp
	 h+LPg71xpKbvA==
Message-ID: <59f58bdc-cfe3-42f8-95dd-0a8930b1a440@kernel.org>
Date: Thu, 28 May 2026 04:32:02 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] ata: libata: Pass the ATA port argument directly
 to __ata_scsi_queuecmd()
To: Bart Van Assche <bvanassche@acm.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Marco Elver <elver@google.com>
References: <20260521173347.2079560-1-bvanassche@acm.org>
 <20260521173347.2079560-3-bvanassche@acm.org>
 <ad5c6534-d161-4c17-81cf-dd2b944ebe9f@kernel.org>
 <fcc80572-88da-4e16-ad09-69819f43cd73@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <fcc80572-88da-4e16-ad09-69819f43cd73@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/05/28 3:55, Bart Van Assche wrote:
> On 5/27/26 11:43 AM, Damien Le Moal wrote:
>> On 2026/05/22 2:33, Bart Van Assche wrote:
>>> Prepare for adding lock context annotations that refer to the ATA port
>>> argument (ap). No functionality has been changed.
>>>
>>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>>
>> I do not have a strong objection to this patch, but its justification without
>> the annotation change together with it is weak. This change is introduced
>> because you want to add a __must_hold(ap->lock) annotation. But why can't we
>> have the annotation be
>> __must_hold(dev->link->ap->lock) ?
>> Or a simple lockedp_assert_held(dev->link->ap->lock) ?
>>
>> lockedp_assert_held() is for runtime. I am not sure if this includes a
>> __must_hold() call for compile time checks, but if not, what about defining a
>> lockdep_must_hold() function that does ? That way, we can have both runtime and
>> compile time checks.
>>
>> And a similar comment applies to patches 3 to 7.
>>
>> So in the end, I am not sure this is needed. See also my comment on patch 9.
> 
> Hi Damien,
> 
> For every patch that is left out that adds the ATA port argument to a
> function, one or more lockdep_assert_held() statements will have to be 
> added. If nobody objects I will leave out the patches that add the ATA
> port argument to several functions.

Yes, that will adds runtime checks in addition to the compile time checks. So
that would be nicer.



-- 
Damien Le Moal
Western Digital Research
