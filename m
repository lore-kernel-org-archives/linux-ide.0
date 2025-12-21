Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0292D78F2B
	for <linux-ide@vger.kernel.org>; Sun, 21 Dec 2025 08:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766306044; cv=none; b=KOM6zol8DWDadss3S7sAGHaHQw2gzcbeFH3MMcb2GfolXQrjr8B6m0i2XeSzdApn1vSTMhykSCQl6WRhAckP4Gu9tAqGWQ1EV9V/YgRg856KrVaiNz6h15xiKqFjhERXf6e0eDpi9FKewIPFGvJJU2Me5mePebNPiNTo1UL0GIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766306044; c=relaxed/simple;
	bh=zIQ8prvbsRFKzZNjGnptHDaJwzrwhEujy2I7GNBDpds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDzMdl+3kaIEdTruNmiD6whfMit4KbejhCsVRRy7f3IuUySOi/A8Ofx5MVtaOyLzQo81fLXgrK33baPLBukVMXdkR0NXUG27+XLHsk07qJ4udFOE8b2PUWx+FSq6e5WSgXFrslIu5mtHUmjr0JWDsagAYJvAwKZQQ23cHmVHCfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IECKRTz8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IECKRTz8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AD6C4CEFB;
	Sun, 21 Dec 2025 08:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766306043;
	bh=zIQ8prvbsRFKzZNjGnptHDaJwzrwhEujy2I7GNBDpds=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IECKRTz8L6jsDL2awCpRYBrQCE/PXP0VdfREz5njGUVyp1V2WD+c8hyHaGT9wklfD
	 KY4XIq7A9ZTbv6yP8D8hzyzObvgASyH5yHCMj/Ohk+LwPR2/XpAOJzX+Bo2jKDk7LY
	 g8fo/y+PNVocX0Xs82pJsYiorfCX8vsawTzGMPmH9eZgkZJQOUj7uW7+o8c6M/AN5E
	 xw9HMLv7kYAO6pmXV8AVbFLiyyn9Vz/0MQKrV2lopG7caIPBe52UrTtN5rJWuTOtCq
	 3udb7zBCTCe3yoG22+OukZkpET3MyWTHvc0ghafwtAcb1xIXnzXkOu8UcaN4eEOwm3
	 ES7908AzAZEdw==
Message-ID: <3d476e67-31a9-4e7d-b8cc-5bb298a6d62f@kernel.org>
Date: Sun, 21 Dec 2025 17:34:01 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ata timeout exceptions
To: eyal@eyal.emu.id.au, list linux-ide <linux-ide@vger.kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>
References: <acf2fa9f-f98d-4eb0-b18b-a04aa123201b@eyal.emu.id.au>
 <080383fe-63cf-4198-966a-b32d798bea06@eyal.emu.id.au>
 <13bf2e98-1774-4444-bc56-38a39d539d8e@kernel.org>
 <79fcb2f0-d09b-4649-bda0-55f309b20985@eyal.emu.id.au>
 <746FB9BB-5945-415F-915F-3F05D8A6B063@kernel.org>
 <582e748c-3e29-4f21-af7c-c799fb457e59@eyal.emu.id.au>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <582e748c-3e29-4f21-af7c-c799fb457e59@eyal.emu.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/20/25 13:03, Eyal Lebedinsky wrote:
> On 17/12/25 23:02, Niklas Cassel wrote:
>> On 17 December 2025 20:56:07 GMT+09:00, Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:
> 
> [trimmed]
> 
>>> Do you want me to try different max_sectors_kb values to see where it breaks?
>>>
>>
>> You can also try this:
>>
>> https://github.com/floatious/max-sectors-quirk
>>
>> It tries these max_sector_kb values:
>> declare -a sizes=(128 1024 2048 3072 4095 4096)
>>
>> You can simply modify the script if you want to try more intermediate sizes.
> 
> After testing the script on a sacrificial disk, I got brave and ran it on the offending disk.
> See comments after the test report.

From your test results, it seems that the drive actually correctly handles very
large write commands, but because it is a drive-managed SMR disk, such commands
can take a very long time to process (due to the drive needing internal garbage
collection first), which triggers a timeout and a reset as the ata subsystem
assumes that the drive has stopped responding.

Limiting write commands to smaller sizes seems to mostly avoid this issue, even
though I do not think that gives any guarantees that the same issue will not
happen for small writes too.

So my suggestion is that you run with something like "libata.force=[<port
ID>:]max_sec=1024" for that drive. We can also add a permanent quirk for it too,
but that would be a really more of a big hammer solution.

-- 
Damien Le Moal
Western Digital Research
