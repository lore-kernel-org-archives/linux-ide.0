Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D472E143C61
	for <linux-ide@vger.kernel.org>; Wed, 19 Nov 2025 05:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763530875; cv=none; b=ZQfnjZADkVSEy7QmTzFD9YjHDdCcxy1nM87JYsf1XBAmHjFBU+mqZ7x2yD6ZF1VWExGyf7QVyhIn0KksNN3CQbmNe/UErUxgcta88C4CbHvN1pF/5QfiDKlmAOU1ohMMOkGzTYakjCtDDU2UzDmivNAYtVYdxf4AqjLEFR2RYP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763530875; c=relaxed/simple;
	bh=c8F2LOfMmi86tljximA1ZXmZ/bdQTNoS3sy78hNE2XY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PdeHg3FV1haL7Se2H/1kuMWqrx4hBdVyoBEtuT2tZerq+NxJRU8cR2itaPi2xzcw7OyNBK3NxES7CX1QZI0twP06/KbihyeX+d2P1fEuZgzcqs0x+2n1bGwCB3hWbNTNfM2Kd4dYWIudKuwUHVtT25otuEMdYyo7BiuMvbYz+Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swoFBbUn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swoFBbUn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8ACC2BC86;
	Wed, 19 Nov 2025 05:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763530875;
	bh=c8F2LOfMmi86tljximA1ZXmZ/bdQTNoS3sy78hNE2XY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=swoFBbUneUJ7keJHS0bmyjh6n0juJMcpi4W//8qqvaDfQZZEf7ckDNSuOE0eqrefo
	 onTc074eTj5amSPZRlDfKqz37J4OQrfDMG8xlEeRk3wTQr4QLh1PySqgPKMGi20sF/
	 TsBWq6Qgois+okDXdqt/dc14ZaXMLLrTg8AWMT/KjQxG1PTKMnpgH52VWDvcuz5eKc
	 sgTykJ0cA1HV0MmrJHTtDUurSb/Ac27jGsx0gCGLCTTL2CDV6uuCFU3mTauyoAZT1Q
	 pAWZxPrxd1l9ZwfB/4lQoI6EdIS/SqV41ZgThM16kiH9ZaQ0LJfS4VfjyC/yH6C2/U
	 PFnRrPJMnS3FQ==
Message-ID: <7cf8b035-c884-4691-a35b-ee8a2e149e03@kernel.org>
Date: Wed, 19 Nov 2025 14:41:12 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ata timeout exceptions
To: eyal@eyal.emu.id.au, Niklas Cassel <cassel@kernel.org>
Cc: list linux-ide <linux-ide@vger.kernel.org>
References: <acf2fa9f-f98d-4eb0-b18b-a04aa123201b@eyal.emu.id.au>
 <4f0fa70c-b259-4998-bf94-c6c6fd8c733c@eyal.emu.id.au>
 <aRyOFRCQ_nSWtmsh@ryzen>
 <f8eebba8-176b-44b8-877c-75de8b00db38@eyal.emu.id.au>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <f8eebba8-176b-44b8-877c-75de8b00db38@eyal.emu.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/25 08:05, Eyal Lebedinsky wrote:
> I still suspect the disk itself it at fault (I have a replacement synced and
> ready). >> 12:15:14+11:00 kernel: ata2.00: failed command: WRITE DMA EXT
>>> 12:15:14+11:00 kernel: ata2.00: cmd 35/00:00:00:68:4e/00:20:77:00:00/e0
>>> tag 28 dma 4194304 out res 40/00:00:00:4f:c2/00:00:00:00:00/40 Emask 0x4
>>> (timeout) 12:15:14+11:00 kernel: ata2.00: status: { DRDY } 
>>> 12:15:14+11:00 kernel: ata2: hard resetting link 12:15:15+11:00 kernel:
>>> ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300) 12:15:15+11:00
>>> kernel: ata2.00: configured for UDMA/133 12:15:15+11:00 kernel: ata2: EH
>>> complete
>> 
>> It is a 4194304 byte write that is failing, i.e. 4 MiB write.
> 
> Yes, this is the size of almost all commands. With NCQ enabled the sizes are
> very variable and often less that 1 MiB.

Yes, because there will be more requests queued in the block layer, which
increases the chances of merging sequential requests. That's why the average
command size goes up.

> 
>> This sounds very much like a recent bug report we have received: https://
>> bugzilla.kernel.org/show_bug.cgi?id=220693
>> 
>> In fact, a lot of the failing commands in that bug report is also a read 
>> or write of size 4 MiB.
>> 
>> I guess you could try reverting 459779d04ae8 ("block: Improve read ahead 
>> size for rotational devices") and see if that improves things for you 
>> (while keeping NCQ enabled).I read it. I never had I/O errors reported for
>> this disk so it looks different to me.
> 
> Regardless, I am not set up to build a kernel (I used to), and being my main
> server I hesitate to fiddle with it. I will keep this disk active and
> observe the situation.

No, reverting this commit will not do anything to the max command size that a
disk can see. But you could try this:

echo 1280 > /sys/block/sdX/queue/max_sectors_kb

to reduce the maximum command size that the disk will receive.

On the other hand, if all drives in your RAID6 array are the same and only this
drive is misbehaving, then I would be tempted to say the same you are: that the
disk is turning bad and replacing it is the best solution.



-- 
Damien Le Moal
Western Digital Research
