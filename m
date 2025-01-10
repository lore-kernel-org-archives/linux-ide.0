Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C98018FC80;
	Fri, 10 Jan 2025 09:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502613; cv=none; b=A8OqTyR6MNNOgzzKAMdI5D6rCotCFimnCTwYN9xfNpb/xCSK8NHdsQdWWLIXOPY5atEl/FZQ9K1j9HiwT/zpARfZngC8WdUEMPf9muqrAsw4M13L5gqVM0NRNDf4TR+D750ZbttVDxBRNNedDHOMv2OXM2s1WGn0QBT3pVe5FDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502613; c=relaxed/simple;
	bh=QjSlokZbHzrDT5/ewGXgNh941e4jLmBXSHjzGFDvr7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cvx9CKXpALV2Om+HP759hxdDKN0pXSsPu79j28Bmr24joXjJPPlougZcc6nDKRueoynnJk2M+U5HR5XqyUnmrX4DG3cZAwEAqFWVslU/tYF3N8Z+P/ILbnbo8zTGlt6MpEE8hZ5SICkJ5jraDDmAN1E9mVCC4yvadYEahehi+jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRsy0IX+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRsy0IX+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72E4C4CED6;
	Fri, 10 Jan 2025 09:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736502612;
	bh=QjSlokZbHzrDT5/ewGXgNh941e4jLmBXSHjzGFDvr7M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eRsy0IX+pQZbwZd1vdW/eDRWj/Vj4I6UIe/iTc3jkbC0RHAAn+++XxfdUU8oTf3uS
	 y1OKVHB4LJK/ozfPmiJ+tyzX2Cd24ipQVgtuc4xKWM6lvQPpkbNVe7mm8rVKDoDYpC
	 kujmThLoyv4AXzMFT6ryYHm6K5oRq8uOi7aJNWBRNutn+Ywy1foVG9XCjEdGsQ3rrO
	 993K9+rwApnpfogHfz7xvbgh+PryBiQMnXlqi9LPF5pvr6n6I/86gT5XZmyChdYgdD
	 SLLyATWWSpraAGCE1o4bMHWitDyBi1cFaQi6LzSHLiOgLang+6zU+slp5HLDx8dtR4
	 ZMcdicdgsutHw==
Message-ID: <60469206-2168-4f53-8882-eddcddc14e80@kernel.org>
Date: Fri, 10 Jan 2025 18:50:10 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] BU40N Blu-Ray drive broken since
 7627a0edef54
To: Christian Heusel <christian@heusel.eu>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Niklas Cassel <cassel@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
References: <e2be6f70-dff6-4b79-bd49-70ec7e27fc1c@heusel.eu>
 <d1b79f57-9e77-4b2a-9dfb-f86cdcffcb0d@kernel.org>
 <928aa39d-9c8d-474a-b077-d08e984ad5e9@heusel.eu>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <928aa39d-9c8d-474a-b077-d08e984ad5e9@heusel.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/01/10 18:42, Christian Heusel wrote:
> On 25/01/10 06:24PM, Damien Le Moal wrote:
>> On 2025/01/10 18:04, Christian Heusel wrote:
>>> Hello everyone,
>>>
>>> we have recently received a report by a user in the Arch Linux Forums
>>> user that their Blue Ray player, a HL-DT-ST BD-RE BU40N stopped working
>>> somewhere since kernel version v6.8.0. We have then bisected the issue
>>> together with them within the mainline kernel sources to the following
>>> commit that changes the default power policy:
>>>
>>>     7627a0edef54 ("ata: ahci: Drop low power policy board type")
>>>
>>> The user reports that adding "ahci.mobile_lpm_policy=1" as a kernel
>>> parameter fixes the issue for them.
>>>
>>> Additionally fellow forum user @loqs came up with a quirk patch, that
>>> sadly was reported to not work:
>>>
>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>> index c085dd8..ef01ccd 100644
>>> --- a/drivers/ata/libata-core.c
>>> +++ b/drivers/ata/libata-core.c
>>> @@ -4118,6 +4118,9 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
>>>  	{ "SAMSUNG MZ7TD256HAFV-000L9", NULL,       ATA_QUIRK_NOLPM },
>>>  	{ "SAMSUNG MZ7TE512HMHP-000L1", "EXT06L0Q", ATA_QUIRK_NOLPM },
>>>  
>>> +	/* Hitachi-LG Data Storage models with LPM issues */
>>> +	{ "HL-DT-ST BD-RE BU40N", NULL, ATA_QUIRK_NOLPM },
>>
>> Looks like "BU40N" may be the FW rev ? If we can get a dmesg ourput of the
>> failing case, we should be able to sort out this. Likely it is a bad string
>> reference here.
> 
> I have attached the dmesg outputs, here is the relevant output:
> 
> [   81.230713] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [   81.235708] ata4.00: ATAPI: HL-DT-ST BD-RE BU40N, 1.03, max UDMA/133
> [   81.240789] ata4.00: configured for UDMA/133
> [   81.248585] scsi 3:0:0:0: CD-ROM            HL-DT-ST BD-RE BU40N      1.03 PQ: 0 ANSI: 5
> [   81.302830] scsi 3:0:0:0: Attached scsi generic sg2 type 5
> [   81.382131] sr 3:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray

Is this with the latest kernel 6.13-rc6 ?

> 
> Aswell as the output for "hdparm -i /dev/sr0":
> 
> /dev/sr0:
> 
>  Model=HL-DT-ST BD-RE BU40N, FwRev=1.03, SerialNo=

Odd... The device model string is correct in the patch, so it should work.
May be something is not being done correctly for ATAPI. Let me check.

>  Config={ Fixed Removable DTR<=5Mbs DTR>10Mbs nonMagnetic }
>  RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
>  BuffType=unknown, BuffSize=unknown, MaxMultSect=0
>  CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
>  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4 
>  DMA modes:  mdma0 mdma1 mdma2 
>  UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 udma6 
>  AdvancedPM=no
>  Drive conforms to: unknown:  ATA/ATAPI-3,4,5,6,7
> 
>  * signifies the current active mode
> 
> Cheers,
> Chris


-- 
Damien Le Moal
Western Digital Research
