Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FF75733E;
	Thu,  9 Jul 2026 02:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783562441; cv=none; b=E6EXXXR4x33wxUHpm+T491SCLHI1L2npntlfGLkl1xsZXC/SI596OCy0uLSUYyjE0n2k89pRzaBBvxg7e41SuOl2uUZS4SNkPyf6z2wOX5vI13BLa6Y9myJPGr2x6b7FaLE9NnX8NjhVPif+MrWH8sRlo+KhIhFWaaZA+b41TDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783562441; c=relaxed/simple;
	bh=B4OS3Yx4Xx0f6sOuRPbsOd0W9kohEXPLjRLZKp/nCyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=asponIeqYZmSsT66WoN+Qr9P9IbMnej7eyNPQ3K7ESDYQmb3yps4YwMFOO0Mwz6eFxFCBS60hUc7Ec/whWrydIzIcJ59TrgDZO9+einjVguoDgeLb+V6h2hjf+hkvgWNQUshgyFAj9XVzmRonYbZS6opNpmolk7SeG+E7X7YeuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRZJHWYa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRZJHWYa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA411F000E9;
	Thu,  9 Jul 2026 02:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783562440;
	bh=FYkvqbzpOYj968fwqnTfP/E+q7+lZvL2lsiXbbi/lMI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GRZJHWYa6YUTOz5cRcwXCUhIqBUlvsihu3S+LW1mYAuwHdrE6IhHXkspAmZgBN4HA
	 D5n5WdIivU4M0+D55WKi8aw6w+jM8I6xAcf8DxWS4tdPt7QLdpAGrQvdM/UIzNzPAz
	 ntpxmszugWRQ1JPmg/WxFeygBqegD8ESbfSqwUWHcymKtL7BKESm/yBf98aeUTROJI
	 r0DjOs8Ot/vogF3SFkE3SP+zeDAtLtVPEKLrv8anxUPty23vdIIUSUUaANXprcglNJ
	 tQP+qwVgt0WGG8/Z88WnUWHY8Yw/NBmy84HyBzdsetkqYrfNa4gyvSq+loOrageXSY
	 EZhJWnEJ9Yo9Q==
Message-ID: <13da36c1-f123-4490-ac3c-d72b278c289c@kernel.org>
Date: Thu, 9 Jul 2026 11:00:38 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libahci_platform: use of_platform_device_create()
 return value
To: Rosen Penev <rosenp@gmail.com>, sashiko-reviews@lists.linux.dev
Cc: cassel@kernel.org, linux-ide@vger.kernel.org
References: <20260709014230.1905756-1-rosenp@gmail.com>
 <20260709015021.BC6D91F000E9@smtp.kernel.org>
 <CAKxU2N9B6xndc8GT+KrRAPjtafGzrEBjJXFWguw61KmAjUzsKQ@mail.gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAKxU2N9B6xndc8GT+KrRAPjtafGzrEBjJXFWguw61KmAjUzsKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/9/26 10:59, Rosen Penev wrote:
> On Wed, Jul 8, 2026 at 6:50 PM <sashiko-bot@kernel.org> wrote:
>>
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [High] Using the return value of `of_platform_device_create()` breaks target regulator fetching during driver rebind or probe deferral, leading to unpowered SATA ports.
>> --
>>
>> --- Patch [1]: [PATCH] ata: libahci_platform: use of_platform_device_create() return value ---
>> commit b10e7693c196a90e6a36f9889202414e7cb20fc9
>> Author: Rosen Penev <rosenp@gmail.com>
>>
>> ata: libahci_platform: use of_platform_device_create() return value
>>
>> This commit updates ahci_platform_get_resources() to use the return value
>> of of_platform_device_create() directly, removing the subsequent call to
>> of_find_device_by_node() to avoid needing to free the reference.
>>
>>> --- a/drivers/ata/libahci_platform.c
>>> +++ b/drivers/ata/libahci_platform.c
>>> @@ -617,10 +617,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>>>                       mask_port_map |= BIT(port);
>>>
>>>  #ifdef CONFIG_OF_ADDRESS
>>> -                     of_platform_device_create(child, NULL, NULL);
>>> -
>>> -                     port_dev = of_find_device_by_node(child);
>>> -
>>> +                     port_dev = of_platform_device_create(child, NULL, NULL);
>>>                       if (port_dev) {
>>>                               rc = ahci_platform_get_regulator(hpriv, port,
>>>                                                               &port_dev->dev);
>>
>> [Severity: High]
>> Does this change break regulator fetching during a probe deferral?
>>
>> When of_platform_device_create() successfully creates the device on the first
>> probe attempt, it sets the OF_POPULATED flag on the child device node.
>>
>> If a subsequent initialization step triggers a probe deferral (for instance,
>> returning -EPROBE_DEFER), the probe is aborted. However, the driver's cleanup
>> path does not depopulate the platform device, so the OF_POPULATED flag remains
>> set on the child node.
>>
>> During the second probe attempt, of_platform_device_create() sees the
>> OF_POPULATED flag and returns NULL.
>>
>> Because port_dev is now NULL, the block above is bypassed, and
>> ahci_platform_get_regulator() is silently skipped. This leaves the SATA port
>> without its required target power regulator.
> Welp. So much for that.

Indeed. Not a great API... So we would need a pattern like:

		if (of_node_check_flag(child, OF_POPULATED))
			port_dev = of_find_device_by_node(child);
		else
			port_dev = of_platform_device_create(child, NULL, NULL);

Which kind of makes the patch not needed. Let's drop it ?

-- 
Damien Le Moal
Western Digital Research
