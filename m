Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78823329C40
	for <linux-ide@vger.kernel.org>; Wed,  7 Jan 2026 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767782294; cv=none; b=Xko0402T2yTZR0eqw+HhBwHpu7+jCuBw+YJR336weNKrCwlpp3v7b3ynRv8ZOSv/pF6P97sfuClgEaX07yOVPow3PJPo6VPCltOyzuGFF+1keDtZn+C1sscwJcWvPMG3ud6bw7V+LKEsNY2QRVYQvk0gcnQmtu36wsOtFdJoz/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767782294; c=relaxed/simple;
	bh=ZD0lv0yvMvZYI2jQKQ5+PYeAogtghSsKE3OqAUBqP40=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XNZOmXHSfD9KJT9/3hzUP74odPvyu6Af1Hw4of0FZ6ajR9J07aEiNYzr8w2zJD55B81reLrvDzdYkaQRvBKSX+bW8cItO1on9jk+6/Is5FGTWLeD9uLbEMArarXnczyPztySQAdUDLpvTpKal7ZYC0rvpefaq46YuJTk9/frn4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zr1o7HzW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zr1o7HzW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F44C4CEF7;
	Wed,  7 Jan 2026 10:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767782293;
	bh=ZD0lv0yvMvZYI2jQKQ5+PYeAogtghSsKE3OqAUBqP40=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Zr1o7HzWCenzxsB9boQghwJ6xAwbkVMLigT2I0MRRwxsaNTQShrGhL3gMM8/H5Vqs
	 UnqLeXsWvkeEAS9sIDZH5hVAlxWuiYUviThMy8sdqWt2vySVz/I0yVgknK5KXUrKza
	 rVOOJU6MgUaVbL+wnxFVJPjdcayBuh4CVsVHNkd3DT4sJbpaZPxmAnpALsSsYuAhe7
	 JJd1GyV6/NXrW1tGZaFccWV5nDN5aXFI/tKgUjTbxQbmwgKW5gPLQUQBkWc16RI9Bj
	 t5tTTtt18m/YQ73Q/Kw40nOEemeXfA74zToQjNxotd+E65r45zV9SSBhYP5rskhuw2
	 goGykHPtWRG7w==
Message-ID: <047a9f08-30d1-494a-8e4c-a2924e516ac4@kernel.org>
Date: Wed, 7 Jan 2026 11:38:11 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] libata: SATA LPM forcibly disabled on Intel Raptor
 Lake since Linux 6.14.
To: wolf@yoxt.cc, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 Niklas Cassel <cassel@kernel.org>
References: <605b34a7723436284699c9a8e524907b@yoxt.cc>
 <aV4yBZkxVD2Olg3X@ryzen> <85cae643-f3bc-43db-966c-3f57d8daa6b6@kernel.org>
 <70a55b1ecd97f30795879994a07764bc@yoxt.cc>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <70a55b1ecd97f30795879994a07764bc@yoxt.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/26 11:28, wolf@yoxt.cc wrote:
> On 2026-01-07 11:19, Damien Le Moal wrote:
>> On 1/7/26 11:14, Niklas Cassel wrote:
>>> On Tue, Jan 06, 2026 at 08:57:07PM +0100, wolf@yoxt.cc wrote:
>>>> Hello,
>>>>
>>>> I am reporting a power-management regression in libata affecting the 
>>>> Intel
>>>> Raptor Lake SATA AHCI Controller, introduced after Linux 6.14.
>>>
>>> (snip)
>>>
>>>> and 4 apparent dummy ports might be unexpected?
>>>>
>>>> Manually setting LPM on the affected hosts fails with:
>>>> echo med_power_with_dipm >
>>>> /sys/class/scsi_host/host*/link_power_management_policy
>>>> -bash: echo: write error: Operation not supported
>>
>> This will not work with the dummy ports. Can you do that successfully 
>> with the
>> valid ports ?
>>
>>>
>>> This is most likely because your ports are marked as External / 
>>> Hotplug
>>> capable by BIOS.
>>
>> I do not think so. There is no "ext" advertized in the log for the 
>> valid ports.
>> But still worth trying to see if the BIOS has a hotplug option and 
>> disable it if
>> it does.
>>
>>>
>>> LPM and Hotplug are mutually exlusive in SATA.
>>> So in order allow your ports to detect a hotplug event, LPM cannot be
>>> disabled.
>>>
>>>
>>> Things you can do:
>>> -Go into your BIOS settings and disable the hot-plugging capability 
>>> for the
>>>  ports.
>>> -If you don't have such a setting, you can use the mask_port_ext AHCI 
>>> module
>>>  parameter. Simply add:
>>>  ahci.mask_port_ext=<your portmask here> to your kernel command line
>>>
>>>
>>> For more info, see this thread:
>>> https://lore.kernel.org/linux-ide/5a74106a-d9db-4e63-b3e6-3857f30a1190@interia.pl/T/
>>>
>>>
>>> Kind regards,
>>> Niklas
> 
> Hello Damien,
> 
> I can apply med_power_with_dipm without error successfully to 4 out of 
> the 8 available.
> 
> /sys/class/scsi_host/host0
> /sys/class/scsi_host/host1
> /sys/class/scsi_host/host2
> /sys/class/scsi_host/host3
> - these do not work, those give an error.

Yep, that is expected since these are dummy ports. So all good.
These come from the adapter indicating that the ports are not actually physical
ones. I wonder if something is off here. How many SATA plugs does your main
board has ? Only 4 ? More ?



-- 
Damien Le Moal
Western Digital Research
