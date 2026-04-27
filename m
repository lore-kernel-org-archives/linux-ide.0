Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88614224B04
	for <linux-ide@vger.kernel.org>; Mon, 27 Apr 2026 04:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777264859; cv=none; b=A9yOztDtqf6zHDj+OOqLmwiFNrIQGJ8vplxprFLsd8IfpfR6LmiAlPqqHzx+TEM2NglQzaJOn1C0XW5n9EDLUuKWPTlySHeiamZLGLvFX+iU4+kse1SxJKTZUzzPYKmIpQQlmxstPElYNQENfCZIGSR2aqiF35PjEoOHXgr5UNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777264859; c=relaxed/simple;
	bh=AM+xQlKoZoQLDOl3dS7rkIQLJLKkD+FONAP/djAB69Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=onLdik9hsDsrd3Jemmtcc+kv+ha+CAdGgqNGICQaG1drt2kDCg6sS4af63VRl4G764SWvJrdZSpM63LQs9pV9AkmkPev6ow6NMFsK1mFd9V7LT8PEvn85jG15BhOwhN1r3Ewde9WL/vt7xElpiDzd4Z3/Dx4Fa9EXidiVHzNRsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2z0LN63; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2z0LN63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49A4C19425;
	Mon, 27 Apr 2026 04:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777264859;
	bh=AM+xQlKoZoQLDOl3dS7rkIQLJLKkD+FONAP/djAB69Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c2z0LN63EyzVMwsmRrebqmbDOLfyMpNbKRjiJF8TEXJIGt2SuwUp42YjmOApJGAgY
	 osjm1cT90Ul8xPnmt7zHrrt12JctZxvlfCt0D2x07IOc35j0gfC8CgNpANvzB1NJuh
	 zWFgSmupm/GoV9HmYhZOLyzVEif5gSXJ3gk4M1yPfQw5JAkya8/BE6Y39VlqhyMYVA
	 7Lc60CLA7YR4r/hjtaZhGZTfXgtsXhan0whKPBsW7sEbjhaVavuI9W6HH6zMzNUbYv
	 lrLiVDKARfJ+RKkzNkhXCMgvNQV/yt8mNWbk9gnTIx/nfZ413Dv6lzL/W3DoDpX7ke
	 Y8EiUDglQMc1w==
Message-ID: <996a48b3-3b7a-4bb1-a13e-16e2c1897d2d@kernel.org>
Date: Mon, 27 Apr 2026 13:40:51 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: ahci: fail probe if BAR too small for claimed
 ports
To: =?UTF-8?B?5p2O5L2R6bi/?= <dayou5941@163.com>
Cc: linux-ide@vger.kernel.org, damien.lemoal@opensource.wdc.com,
 liyouhong@kylinos.cn, cassel@kernel.org
References: <20260425065509.733544-1-dayou5941@163.com>
 <75618383-ad2b-4b58-97d1-250be32a4bea@kernel.org>
 <442805bc.1eda.19dccb0e551.Coremail.dayou5941@163.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <442805bc.1eda.19dccb0e551.Coremail.dayou5941@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/27/26 11:07 AM, 李佑鸿 wrote:
> 
> 
> 
> 
> At 2026-04-27 07:46:12, "Damien Le Moal" <dlemoal@kernel.org> wrote:
>> On 4/25/26 3:55 PM, dayou5941@163.com wrote:
>>> From: liyouhong <liyouhong@kylinos.cn>
>>>
>>> When an AHCI controller is disabled in BIOS, its HOST_CAP register may
>>> contain invalid values (e.g., 0xFFFFFFFF) indicating an impossibly large
>>> number of ports. If CAP.NP claims more ports than can physically fit
>>> within the mapped BAR region, accessing port registers beyond the BAR
>>> boundary causes a kernel panic.
>>>
>>> Add validation in ahci_init_one() to check that the BAR size is
>>> sufficient for the number of ports claimed in CAP.NP. The check
>>> calculates the required MMIO size as:
>>>
>>>   required_size = 0x100 (global registers) + max_ports * 0x80
>>>
>>> If required_size exceeds the actual BAR size, the probe fails with
>>> -ENODEV, preventing the panic and providing a clear error message.
>>>
>>> This solution follows the suggestion by Damien Le Moal and Niklas Cassel
>>> to detect and reject obviously broken controller configurations early.
>>>
>>> v2:
>>> - Complete rewrite based on community feedback
>>> - Move check from libahci.c to ahci.c
>>> - Fail probe early instead of attempting to work around invalid state
>>> - Implement BAR size validation as suggested
>>>
>>> Reported-by: liyouhong <liyouhong@kylinos.cn>
>>> Suggested-by: Damien Le Moal <dlemoal@kernel.org>
>>> Suggested-by: Niklas Cassel <niklas.soderlund@corigine.com>
>>> Signed-off-by: liyouhong <liyouhong@kylinos.cn>
>>
>> Your patch is not formatted correctly: the changelog should not be part of the
>> commit message but should come between the "---" separator after the tags and
>> the first "diff" line of the patch proper. The "---" separator is missing here
>> too. Did you generate this patch with "git format-patch" ?
>>
>>>
>>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>>> index 1d73a53370cf..09026ea12cde 100644
>>> --- a/drivers/ata/ahci.c
>>> +++ b/drivers/ata/ahci.c
>>> @@ -1888,6 +1888,23 @@ static ssize_t remapped_nvme_show(struct device *dev,
>>>  
>>>  static DEVICE_ATTR_RO(remapped_nvme);
>>>  
>>> +static int ahci_validate_bar_size(struct pci_dev *pdev, void __iomem *mmio)
>>> +{
>>> +	u32 cap = readl(mmio + HOST_CAP);
>>> +	unsigned int max_ports = ahci_nr_ports(cap);
>>> +	u32 last_port_end = 0x100 + (max_ports * 0x80);
>>> +	resource_size_t bar_size = pci_resource_len(pdev, AHCI_PCI_BAR_STANDARD);
>>> +
>>> +	if (last_port_end > bar_size) {
>>
>> It may be good to check also that max_ports is not zero here.
>>
>>> +		dev_err(&pdev->dev,
>>> +			"AHCI: BAR5 too small for %u ports (last port ends at %u, BAR %llu)\n",
>>> +			max_ports, last_port_end, (unsigned long long)bar_size);
>>
> 
>> Please make this a warning (dev_warn()).
> 
> 
> Thank you for the review. Here's v3 with the requested changes:

What v3 patch ? I did not receive anything.


-- 
Damien Le Moal
Western Digital Research
