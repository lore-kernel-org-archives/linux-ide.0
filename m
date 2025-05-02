Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ED1BA50
	for <linux-ide@vger.kernel.org>; Fri,  2 May 2025 01:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746149567; cv=none; b=mZ03z/O8LjUY2yxBdTSmkzC1NZz2lx+psoKqwlUd+KU6TmPn0obk8xLIjmMjc3O8LjUpdFvrYhqa1e+yQD4HKg6/8Viiqfs61agsyKfOjw2YreW58pddqcvhIifqgRxou49nPVCZ5NTUiF3DzQd4sgUN3Npp2sb8B4n3mANp5JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746149567; c=relaxed/simple;
	bh=sR2sUqbPiShDWbjam9eUlzFw7YqSujCMJLLONCwpOEk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=jTB+uplbVi/V3TLS+ezqlUoDZpF+yOielbOC3xw/zNwngkKE/suB3BxF78pqY92hpOL0T/DHX78wrUV63MLqYEnfv2IgdTl9QzVXkcn/FoaQkqToTx+P6MegG+F0hWyU+rzH6V97UykHACDSZbc+swC1dUYBfxAukJxOAA4P/nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnK7Mgqa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnK7Mgqa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348C5C4CEE3;
	Fri,  2 May 2025 01:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746149566;
	bh=sR2sUqbPiShDWbjam9eUlzFw7YqSujCMJLLONCwpOEk=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=FnK7MgqatrKvg+QV6YGHpwCfehICQgzSZcG9fRzP3qMTKnJ/m1+ybdhWZBO4HDRQw
	 /XbET5SuDzuCwGM3oLKRyc5VKP+tH6yREq8gt3WDda0qEk8HxtyHPUJ3a9zReT+REI
	 jFu7q1U6HaKrPGOIfN1AjgENHxj8oMgNkRgQB1aIwKz2QS36T2FtYYcHZy1U1StMER
	 ehIY64BwNZjBAjxdkp+UDS2k0V8zNQJVu2+gmexEAtmVQGuvPzpPndMBFWHh9Wp6DC
	 asbEzrvf4n7zYQrvcQz10UmZCy+fZSzTKysI1iJHTLOTVfiAaV1fT6EI78yi8Z7jyr
	 a9Zx5amCKJe/g==
Message-ID: <88a6fb5f-dc85-41e0-a65d-92704b4c8499@kernel.org>
Date: Fri, 2 May 2025 10:32:45 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard
 drives
From: Damien Le Moal <dlemoal@kernel.org>
To: Ioannis Barkas <jnyb.de@gmail.com>, linux-ide@vger.kernel.org,
 Niklas Cassel <Niklas.Cassel@wdc.com>, Mikko Korhonen <mjkorhon@gmail.com>
References: <CADUzMVbneDW06V4vd8si8k=NN_6df3JeejaF3fVk2U=LVC1UHA@mail.gmail.com>
 <fe406980-f230-4060-9b1a-16295b6cfa48@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <fe406980-f230-4060-9b1a-16295b6cfa48@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/2/25 03:47, Damien Le Moal wrote:
> On 5/1/25 05:36, Ioannis Barkas wrote:
>> Hello guys,
>>
>> It would be better to have more details on this since only the 2TB
>> model is targeted.
>>
>> Please provide hdparm, health details from the affected disk, full
>> dmesg on the latest kernel you get errors so that we can confirm
>> active lpm-pol and see platform in use as well as board & chipset.
>> Have you tested this disk at another LPM capable system or HBA?
>>
>> If the disk is in mint condition then it should be blacklisted if it
>> fails on LPM transitions.
> 
> I removed this patch from for-6.15-fixes because the model string "WDC
> WD20EFAX-68FB5N0" is wrong: it contains the drive serial number which should not
> be there, of course.

My bad on this one. The model string is absolutely correct. However, this drive
is not known to have any LPM related issues and that is something that is tested
during the drive development and known to the manufacturer to be working. So the
issue could be due to the AHCI adapter, or the adapter not liking this drive for
some reason...

> Mikko,
> 
> As Ioannis suggested, please send the output of "hdparm -I /dev/sdX" for the drive.

This information will still be useful to check which FW revision you are running
on the drive. This particular model is EOL so there are no more FW updates, but
we should at least check that you are running the latest rev.

Could you also share a dmesg output showing the adapter probe and drive scan on
boot as well as any error message that may be happening ? That will tell us the
adapter you are using as well.

And if you could test the same adapter with another drive to see if LPM works,
that would be great. Thanks !

> 
> 
>>
>> Best regards,
>> Ioannis
>>
> 
> 


-- 
Damien Le Moal
Western Digital Research
