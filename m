Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A38363C4C;
	Wed,  8 Jul 2026 01:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783474736; cv=none; b=eqzTrhZYHnnWLS+WRmQrOZYqlkEXFU7s0qgQMu7If6p7vqccT89rvvNUEg1Zau+NbSBbRoloPp8qDjCK4iDOJuVLcjCIL1qg11ZLqpmeEX98tiaaNrIY+lfdTYzPGTaRppo6w4lxXftY/yD4Js6+5lG5XeGm/kZTOAp2VHubMlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783474736; c=relaxed/simple;
	bh=9P98sxWksgutyd7cyKeYNQNYpQFhRak4cr3QessPYsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UsMm5yBRNj1bihnXxGjs6RWvYlc86vIAjSXhlp1tsZFX8/7dvU+yBoUG8MN98o1wTT2xhTz0a8fSEmE1WUaOrz+SOtq53P8R861rfs0ec5LASkgnjilJYgAV3NrYLEqMMKG3JDw5jiXhVaFhErUts5gtzL5JLVKLiorO/FroZwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwNaSTP9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwNaSTP9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE4E1F000E9;
	Wed,  8 Jul 2026 01:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783474735;
	bh=yN9iKChOmvQfvlHbRNVT0fNh6gZ+NBH8Tnkf/NZAdoY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dwNaSTP9TqCZsJfLvBxO9VWhX9zg9N7TmTCLnyTrcJq+s2CuJ30iKDkeZQ+E1yzXB
	 4f67UysuH3WxzpgX29MwGXJf1g+UD5wCdj7UHlRjBClr5cQciaoPuR4p+tN4vpLgJ3
	 FzaTylnuz35KRhGgs0L1GxqVmx05qphgVpwRQMNRj9cLsxCHII2p0J48PyKnHRgyns
	 uyLOgFZ3FAIJvSmUsM3RdFJGw42rAcKQ1euUj+6JW2a3SeMBKmUe13tkyaBezx4GWw
	 fsvPNJ6uO9xWNEz1mnrf9uzkInV2XHlr/JzyINt3ZglzpkZ9z4ThM+TrnPJ6X16u6Y
	 xfEE3cEA/0umQ==
Message-ID: <a21d5f7d-df57-49c6-ba94-f210c674a24a@kernel.org>
Date: Wed, 8 Jul 2026 10:38:43 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ata: libata-core: Skip HPA resize for locked
 drives
To: TJ Adams <tadamsjr@google.com>
Cc: Niklas Cassel <cassel@kernel.org>, Hannes Reinecke <hare@suse.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 Igor Pylypiv <ipylypiv@google.com>,
 Salomon Dushimirimana <salomondush@google.com>
References: <akaHPScetfl1VbF8@ryzen>
 <20260706210054.1336654-1-tadamsjr@google.com>
 <20260706210054.1336654-2-tadamsjr@google.com>
 <3fbfd30e-1555-4ce2-9cb5-72807c1a8b23@kernel.org>
 <CAL54JgdpKG6VJ6GLjjs5prB7tH7mF-SCVdH-AHgCzBj2uCynfg@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <CAL54JgdpKG6VJ6GLjjs5prB7tH7mF-SCVdH-AHgCzBj2uCynfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/8/26 02:01, TJ Adams wrote:
> On Mon, Jul 6, 2026 at 11:02 PM Damien Le Moal <dlemoal@kernel.org> wrote:
>>
>> On 7/7/26 06:00, TJ Adams wrote:
>>> Skip HPA resize in ata_hpa_resize() if the drive is security locked.
>>> If the drive is locked, the command to read the native max address
>>> fails with -EACCES, which currently causes the sticky quirk
>>> ATA_QUIRK_BROKEN_HPA to be set on the device.
>>>
>>> Setting this sticky quirk causes subsequent revalidations (after the
>>> drive is unlocked) to bypass HPA checks, preventing the unlocked drive
>>> from exposing its full native capacity without a reboot or device removal.
>>>
>>> Signed-off-by: Terrence Adams <tadamsjr@google.com>
>>
>> Doesn't this need the same fixes tag as patch 2 ?
> 
> Hey Damien,
> 
> I don't think this should have the same fixes tag as patch 2, because without
> commit 91842ed844a0 ("ata: libata-core: Set capacity to zero for a security
> locked drive") the problem still exists.
> 
> The quirk gets set not because of the capacity being zero but because the locked
> drive returns -EACCES.
> 
> I think Fixes: 05027adccc09 ("libata: remiplement ata_hpa_resize()"), might be
> better for this patch.

Most likely not. This dates back to 2007 and security was not supported until
2017 (commit 818831c8b22f7). Let me dig a little more. But at the very least, I
will add a Cc: stable tag to the patch.

> If you agree, I can send a v3 or if it's easier, feel free to amend the commit
> message yourself.

No need to resend. I will add whatever tag is needed.
Thanks.

> 
> Best Regards,
> TJ Adams
> 


-- 
Damien Le Moal
Western Digital Research
