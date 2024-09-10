Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8186524B4
	for <linux-ide@vger.kernel.org>; Tue, 10 Sep 2024 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725973798; cv=none; b=lcl1cvQHw7u/XZKk2RnUj8AedulzH6JjDYE3i6EIyrPoQrNUR59DDLF5ubsVVk0zlATi75XM3/D3qeI2vKPgqKPPfZ3FRo7NsWR9Wvc2Fo6HKHZRkHNc/vnU5a9Qyh0jLZD+p9UeKVJ03gW1zCaWgFTrC+Fybu1J4QpkhlVqb4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725973798; c=relaxed/simple;
	bh=RoN/j59kFzc9qPzRsCl9+MQ1AoS6/HalJxdirO9KUvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jI6AkO8f/b/TsKplM+LQXefTw9/dWmCq22g66+tsyF0vYrR84CsdRwHXg1qOyKriCh8BzRmqp3QkKzk5E0kvE5nhOskIJd49fzGJ+pLimfvMK9ZsiFf/MJIxah5KZUcSompJoVs7gekrEBC+WVzcteSpnRELt7baYrJlvuaWqNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDZpSj0z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDZpSj0z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D4FC4CEC3;
	Tue, 10 Sep 2024 13:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725973798;
	bh=RoN/j59kFzc9qPzRsCl9+MQ1AoS6/HalJxdirO9KUvY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HDZpSj0zAkcKaVEHhICGe9kYMX87wg03ApwGQMemOWwlwdP+/5nc6cgL1V6rwEK6U
	 vOv+icohEIfL+FoZ1Gk9Ic+LOde9W7YyJ/oE17ObVk50S8DmSyr355BATzfW0mbc4M
	 ROzdjF9tflDl4aVCaQ5fymV/6KDJrnBJfaP5I/i8WERbdCpeqHXWqdHHkd7Qt1jFQi
	 LAvgRsNFZwuWxK/0pDHXd4t14szoBiAXqasxMj0ch7zLq/4gnkg1Ieue4N9Wr7lGku
	 jj0JZXRoWnqLp7xOTN6APVIA0kXi+Sd3XSACRO0wzXSxsIJihp/r0bZjA6uN9KNJ5W
	 TQLKDpxEFox2w==
Message-ID: <f5209cc3-a0c6-4722-92b7-533c0b244527@kernel.org>
Date: Tue, 10 Sep 2024 22:09:56 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ata_generic: use IS_ENABLED() macro
To: Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
Cc: lvc-project@linuxtesting.org
References: <d9c0acab-909e-da06-decf-be5de59d23bf@omp.ru>
 <87f85704-656d-4c08-b729-87c9b2e6d686@kernel.org>
 <4414c20f-7e0e-de47-8311-4a8948f2504d@omp.ru>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <4414c20f-7e0e-de47-8311-4a8948f2504d@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/09/10 17:52, Sergey Shtylyov wrote:
> On 9/10/24 7:50 AM, Damien Le Moal wrote:
> [...]
> 
>>> Replace now gone out of fashion defined(CONFIG_PATA_TOSHIBA[_MODULE])
>>> with the new-fangled IS_ENABLED() macro in the ata_generic[] definition.
>>
>> Please mention that CONFIG_PATA_TOSHIBA_MODULE actually does not exist at all
>> and so can be removed.
> 
>    Huh? =)
>    CONFIG_PATA_TOSHIBA is a tristate option, so CONFIG_PATA_TOSHIBA_MODULE
> does exist; else there would be no point in using IS_ENABLED() at all...

Oops... Indeed. Got confused with something else :)

>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> [...[
> 
>>> Index: linux/drivers/ata/ata_generic.c
>>> ===================================================================
>>> --- linux.orig/drivers/ata/ata_generic.c
>>> +++ linux/drivers/ata/ata_generic.c
>>> @@ -220,7 +220,7 @@ static struct pci_device_id ata_generic[
>>>  	{ PCI_DEVICE(PCI_VENDOR_ID_OPTI,   PCI_DEVICE_ID_OPTI_82C558), },
>>>  	{ PCI_DEVICE(PCI_VENDOR_ID_CENATEK,PCI_DEVICE_ID_CENATEK_IDE),
>>>  	  .driver_data = ATA_GEN_FORCE_DMA },
>>> -#if !defined(CONFIG_PATA_TOSHIBA) && !defined(CONFIG_PATA_TOSHIBA_MODULE)
>>> +#if !IS_ENABLED(CONFIG_PATA_TOSHIBA)
>>
>> I do not understand the negation here... It seems very wrong. If the driver is
>> indeed enabled, we need to add its PCI ID, no ? and the reverse when not defined...
> 
>    The separate driver was added by Alan Cox in 2009, before that
> Toshiba Piccolo controllers were handled by this generic driver...

OK, makes sense now. Maybe we should add a comment above that IS_ENABLED() to
say so ?

> 
> [...]
> 
> MBR, Sergey
> 

-- 
Damien Le Moal
Western Digital Research

