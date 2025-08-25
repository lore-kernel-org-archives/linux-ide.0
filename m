Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8DF131E49
	for <linux-ide@vger.kernel.org>; Mon, 25 Aug 2025 02:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756087650; cv=none; b=iQdHy4aOHFr4LouPckgXb4aWMORf1E+++dNYpjgUJWPT857D4E+nxN7F5roa/K35lZIO3R7lkwI/C0kfkWqzAH01vBZVjYPxnWxUuSZzym59tsWMe48jCpkDdtSHH8H3M/gGQ1mmLyVIiI69fG5D3mpUS6A5Q5YYb8xRdPFn7O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756087650; c=relaxed/simple;
	bh=7aFnLmAEUQD3bz6l7dRz1f3De+/8nMxemRJPkuDUAeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hyO8uf3Mb1yYlZKgMIOzfNbDDAn4wy2Teypeqkj2kQWtr1DwoCpCZSJvFciiluM7/wCxjmEm02qXcpwvJ5rFSM1a66vKqcmmRsJUDGVl788i2WKC18zZtAUZqatyXM3x5AWuImtUHRwmh0UzeOWYi6pEEofXHeKiBwyZZdgMOJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGs1QciY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGs1QciY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1413DC4CEEB;
	Mon, 25 Aug 2025 02:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756087649;
	bh=7aFnLmAEUQD3bz6l7dRz1f3De+/8nMxemRJPkuDUAeM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OGs1QciYYJ58MEd1OFavY015vA7MKPlr3ualF1Tmovf+wKtlvckMjA8pKZ8pVbWIe
	 CGiBRg+ChVaPfh1IXgxuFuBJtI79vLkYQ4fCeUbVzbdvNiIhk7ghRFa+gK2kcTYzhw
	 o3jGbx9OlB2tFO6NPuwrLZbeC/e1Hy9kUgdl44drXFEGrfyjq0a9ZKrCdSCuj5F5vZ
	 WtEw4WusLhIhGkG0yv/6iKWIapKsFB2jBobaFA1lHDFZ0f7jXfbQpVF49TLGWs3D0x
	 yQPjg1CPTwRCNaKu2jHi58MtLwy7tDi0zdsfZEr5pWqm8IEkFGRICh2NZap2fB3vRf
	 v5LhAO/xudJBw==
Message-ID: <1ea972db-c5ce-4b47-92a1-1b23d20a8c9c@kernel.org>
Date: Mon, 25 Aug 2025 11:04:41 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: ahci: Allow ignoring the external/hotplug
 capability of ports
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Dieter Mummenschanz <dmummenschanz@web.de>
References: <20250821080651.65800-1-dlemoal@kernel.org>
 <aKhj7prAFmQ9U95z@ryzen> <aKiDjVODoAN2z46C@ryzen>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <aKiDjVODoAN2z46C@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/25 11:49 PM, Niklas Cassel wrote:
> On Fri, Aug 22, 2025 at 02:34:54PM +0200, Niklas Cassel wrote:
> 
> (snip)
> 
>> But do we really want a introduce a module parameter for this?
>> I know that commit 4edf1505b76d ("ata: ahci: Disallow LPM policy control for
>> external ports")
>> if external, both:
>> 1) sets initial lpm policy to MAX_POWER (so that hot plug works by default)
>> 2) sets ATA_FLAG_NO_LPM, so that you cannot change the LPM policy using sysfs
>>
>> I think that 1) is good.
>>
>> However, why should we forbid the user to override to policy via sysfs just
>> because the port is external?
>> If a system admin has installed a udev rule or similar to set a lpm policy,
>> why should we not respect that?
>>
>> Yes, I know that many distros supply a rule that just enables LPM
>> unconditionally for all disks...
>>
>> But... instead of forbidding the user to change to policy using sysfs, perhaps
>> a better way would be for the system admin/distros to improve their udev rules?
>>
>> We have a sysfs property that says if the port supports LPM.
>> Perhaps we should have a sysfs attribute that says if the port is external.
>>
>> The udev rules can then be smarter and just set the LPM policy if the port is
>> not external. But the user would still have the option to set a LPM policy
>> (using the same interface), if they don't care about hotplug.
>>
>> It seems more user friendly for a user that has a laptop with a docking
>> station with hotplug capable ports, to install a udev rule to set an LPM
>> policy, than to set a kernel module param.
>>
>> What do you think?
> 
> Another idea: perhaps we could add something like:
> "hotplug_supported" and "hotplug_enable" to sysfs.

Yes, that would be nice to have, but... see below.

> For ports marked as external/hotplug capable, we set
> "hotplug_supported" to true, and for ports that support
> hotplug, we set "hotplug_enable" to true by default.
> 
> We can then continue to disallow (return -EOPNOTSUPP) when the user tries
> to write to /sys/class/scsi_host/hostX/link_power_management_policy
> for a port that has "hotplug_enable" == true.
> 
> If a user sets "hotplug_enable" = false, we allow writing to
> /sys/class/scsi_host/hostX/link_power_management_policy
> 
> What do you think? Better or worse idea?

It would be better, but:
1) When setting hotplug_enable to false, we need to set NO_LPM for the port and
change the target policy to max-performance. Not too hard to do, but then...
2) When setting hotplug_enable to true, we need to clear NO_LPM for the port
and set the target policy to the default. However, we actually have no idea
what set NO_LPM. It may be that the device/adapter/port actually do not support
LPM, so in that case, we should not clear it.

So because of (2), unless we cleanup the mess of port/device flags to have
different flags to differentiate between "HW supports X" and "X is
enabled/disabled", I do not think we can do the sysfs trick easily.

-- 
Damien Le Moal
Western Digital Research
