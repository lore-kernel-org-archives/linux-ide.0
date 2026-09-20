Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129607081A
	for <linux-ide@vger.kernel.org>; Sun, 20 Sep 2026 04:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789878944; cv=none; b=G7qhQ/FI8nBElwf8raN4ydKUNG8ds3BqPmxLvz+nHNZ/1RqW/YMgLc6MF0TmppeU+hAzTkflJrqugC3ePzSnrAWxJdq/QNBBT7lHr26vytWRWcYZEGtJ4UMg5sM3eo7lxRlZFTA5OPCVl6eiVSKHxoXwt/wrSFAhoeVmtQeaFb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789878944; c=relaxed/simple;
	bh=O9tjA0CCEO9ygmMmPQRk93Xk9V8ZynevB/fAKZGwuqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3HtJvL4MUO9yfB+AMqC3JmRFEYh0O8UuNFJSTYd4ahjnLAbeHaHonv+NOEayXQgq3HcntvCIVlRdeGO0zl1DGi+B4+GfUEQ8IJHT1btVIh/YteZo13OoWzFJVRf8nxiFczHWoMMteQNlfKTPV0jB3Zf/HTXEmUjK/9Xb4JwF+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfZIhvZF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfZIhvZF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4121F000FF;
	Sun, 20 Sep 2026 04:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789878942;
	bh=1BXKOizvidpVzVMdG8vt5Yoro9izDbai/+rgsM3K3u8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nfZIhvZFwOZrETCXLao6/Si8HG0QRA+9oZU1xNOEiauL2Gpw/R+D5veIg53RHE1Pf
	 ZjCFMUHWgOrxRO4qlDa5kEejmYafpdkfj9rVvnC/0S9NQjXsn3hY1okIMBMJvsPNF+
	 PVjew/KWAEcVbdOAnmAaqmC3nCJqTYdVHXe7Ev5DOHDKIIoXuZqZx5sNOr56pxQkex
	 HnvayNkVoby5TKEfGt03WiziPrMs+0eOkY0DmxuMvizrpElwSyc4IfRlIuO4IBvMjN
	 VIgrinkzpnBk9vbea4mEllTYzR6ztJAkikZlzfPRN04+ThRu0L8yvb58G3Eh4MDK3I
	 5yCPqSjZYvACg==
Message-ID: <1022afd9-3443-4f1d-a35a-e550615a67d6@kernel.org>
Date: Sun, 20 Sep 2026 13:35:40 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ata: libata: Correct libata.force parameter
 documentation
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, grandmastertriplej@gmail.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Natikar, Basavaraj" <basavaraj.natikar@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
References: <20260918124030.1962773-4-cassel@kernel.org>
 <20260918124030.1962773-6-cassel@kernel.org> <aq0zTqvUzopOdQwF@ryzen>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aq0zTqvUzopOdQwF@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/26 21:49, Niklas Cassel wrote:
> On Fri, Sep 18, 2026 at 02:40:33PM +0200, Niklas Cassel wrote:
>> Align the documented libata.force options with their implementation.
>> The force table accepts PIO modes 0 through 6, not mode 7, and ncqati
>> controls NCQ generally rather than only queued TRIM.
>>
>> The max_sec_1024 and max_sec_lba48 options only set transfer size
>> limits. Remove the misleading claim that they can also clear them.
>>
>> Signed-off-by: Niklas Cassel <cassel@kernel.org>
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 33cd30996e47..24459f7ff810 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -3491,7 +3491,7 @@ Kernel parameters
>>  
>>  			* SATA link speed limit: 1.5Gbps or 3.0Gbps.
>>  
>> -			* Transfer mode: pio[0-7], mwdma[0-4] and udma[0-7].
>> +			* Transfer mode: pio[0-6], mwdma[0-4] and udma[0-7].
>>  			  udma[/][16,25,33,44,66,100,133] notation is also
>>  			  allowed.
>>  
>> @@ -3509,7 +3509,7 @@ Kernel parameters
>>  
>>  			* [no]ncqtrim: Enable or disable queued DSM TRIM.
>>  
>> -			* [no]ncqati: Enable or disable NCQ trim on ATI chipset.
>> +			* [no]ncqati: Enable or disable NCQ on ATI chipsets.
> 
> Hmm.. I guess we could theoretically remove the [no]ncqati parameter from
> libata.force.
> If a user wants to enable/disable ncq, they can use the [no]ncq libata.force
> parameter.
> 
> However, since this libata.force kernel parameter already exists, I guess it
> might actually be used by someone, so we can't really remove it without
> potentially breaking existing setups, so I guess the easiest thing is just
> to keep it, even if it is not strictly needed.

It can be needed on a machine that has multiple adapters from different vendors.


-- 
Damien Le Moal
Western Digital Research
