Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3107D5FDA7
	for <linux-ide@vger.kernel.org>; Mon,  2 Sep 2024 22:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725317362; cv=none; b=mSKoJHLzRc8kRFEFZ4zInWljxVCDcQrWApcRvmpQMLf99Rbeh49E+HOGiEUfP79y76FBzpWDhVIA80kjEA38WUBxgftJc7QmKC6qQx80MRwT02upgYYHUrGHLujACvfviWoZS9clbr2/o8oUoAdJC+MUfdPSnKyxvSfSnvjm4lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725317362; c=relaxed/simple;
	bh=GibCbAbVdcumYj1jNEgDvtp4UWi+x1mC0lzfSeLMGYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fj9u4qFoKGtNhhaBXqaEd06ojABP+xk+aZlBN45xpoaCZVSXRSlHUNiuaIBYV8rhXYRIfT28svy+X8ssOTj6/vlxrA1gtWguhKWNXKZAl2ZslYjFuoH9cKckuqotarA5H+139NiYtBrv9+VJzv7L6d/aJZfWekXzNk7fg8dG5+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulsegh1Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulsegh1Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657A8C4CEC2;
	Mon,  2 Sep 2024 22:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725317361;
	bh=GibCbAbVdcumYj1jNEgDvtp4UWi+x1mC0lzfSeLMGYM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ulsegh1QxCCSdfk52DdnvKawYA6fpW+tlZuKeFeSHEl8PkGgy8VOMJbhzQZDZOu2r
	 nbb1Pjf/w74vBLNfTdowwky6ouWLZOGmohtcR0hH0CYGeOf/c72Y6vKTS7/uB49+co
	 pacyJ92Tlhi8e7ewlqxNrSvN2A+Maknqlj+bhhs5ljpdKB8INwzBGK/rqXZvfay0NS
	 ZMfiK7cOCz1VIk1X8ErOjZGEwpDuY2vlq/deNzcYuY04AuYiOwTgSFY1WKgAmp2QN3
	 1/InTerhHXmB9ibD6c3b1A7mKaF/6GTow8A5TYPTql517SqPOfmmQNw9Qmqt4KSW/J
	 ENwjy4PR6RX0g==
Message-ID: <74ac118d-d210-44d1-8d92-59f49748345a@kernel.org>
Date: Tue, 3 Sep 2024 07:49:20 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] ata: libata: Move sector_buf from struct ata_port
 to struct ata_device
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20240902115400.166881-1-dlemoal@kernel.org>
 <20240902115400.166881-7-dlemoal@kernel.org> <ZtYnwqWFNeDx3YOt@x1-carbon.lan>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ZtYnwqWFNeDx3YOt@x1-carbon.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/24 06:01, Niklas Cassel wrote:
> On Mon, Sep 02, 2024 at 08:53:59PM +0900, Damien Le Moal wrote:
>> The 512B buffer sector_buf field of struct ata_port is used for scanning
>> devices as well as during error recovery with ata EH. This buffer is
>> thus useless if a port does not have a device connected to it.
>> And also given that commands using this buffer are issued to devices,
>> and not to ports, move this buffer definition from struct ata_port to
>> struct ata_device.
>>
>> This change slightly increases system memory usage for systems using a
>> port-multiplier as in that case we do not need a per-device buffer for
>> scanning devices (PMP does not allow parallel scanning) nor for EH (as
>> when entering EH we are guaranteed that all commands to all devices
>> connected to the PMP have completed or have been aborted). However,
>> this change reduces memory usage on systems that have many ports with
>> only few devices rives connected, which is a much more common use case
>> than the PMP use case.
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>> ---
> 
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> 
> ...and since I suggested this specific change in my reply
> to your V1 series, I feel that I should get a:
> Suggested-by: Niklas Cassel <cassel@kernel.org>

Indeed. Added.

> 
> :)

-- 
Damien Le Moal
Western Digital Research

