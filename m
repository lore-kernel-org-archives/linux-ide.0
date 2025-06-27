Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1A23C2F
	for <linux-ide@vger.kernel.org>; Fri, 27 Jun 2025 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751009740; cv=none; b=ECmbRr7yETYCxg1vM0N9Y/H1ds4+l+ELBhqJtLtHrxNPFehtNzfGrQzW/fG/plnebu8Mz6NQpGtdWycKlKxOEH1VCLCitaFJn6OY+iXH3mjqehlZOz4dGJRUpfdBX6EBEE0Qk4O+DrxsskW4C8mleAOHDaMh4A5zcYiLH8qG3Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751009740; c=relaxed/simple;
	bh=k3HCmxRJedGUsbcBuUX+/pQjxijqs2PRbzhkSoMl8lE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VDMshJO9orTaOGKpxggPeKlWNvl6QtvReURHS68O+JbBABZREWmdWp7wi+JxOnTLCLCfHerDEOpPFNko7RPy46rXWNVhSg4xe8xmssMlDCjt811NF5+N7wlciGCgE3ibp8prsS9IzVEHCa1Wn+56wzfqN+Ify2XtT9CbiSfagbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQilk21I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQilk21I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE584C4CEE3;
	Fri, 27 Jun 2025 07:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751009740;
	bh=k3HCmxRJedGUsbcBuUX+/pQjxijqs2PRbzhkSoMl8lE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=aQilk21IZr8Em7tl6urxaRREePUmTBXM8JfXpINCCBjTz7ISxmL/Ox41KF2I/qH4+
	 RGqNTCLpyxZY8pIw+2PtPi9pmwbKl5UXLWYjwKsZOi65TCjQRm1dfVsdrt6Ol4Uqty
	 FB/odqEZwbaypz5Pshw427pQPSISerD+tVddwqhD1ZLqboxWkXO+j+C+I9KW3xRao5
	 C7N9KzJcAcTq6qWrT3tGfKwvAw/LddBzZessg58I7YZ+l96HUGpaDaL6yZwFtWYem1
	 iNo5sz5SktUsPR7IrdFd5SefA8yjxGwZVA2ivf5rvzrAJ/je1NO5HfcaWcHvl7poeb
	 hJRPI7f08eHng==
Message-ID: <5b3d302b-c4e5-4061-959c-e60b1ec1bc6a@kernel.org>
Date: Fri, 27 Jun 2025 16:35:38 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] ata: Fix SATA_MOBILE_LPM_POLICY description in
 Kconfig
To: Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20250627011155.701125-1-dlemoal@kernel.org>
 <20250627011155.701125-4-dlemoal@kernel.org>
 <347157db-8a01-47ae-9dba-c46c77bae824@suse.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <347157db-8a01-47ae-9dba-c46c77bae824@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/25 15:03, Hannes Reinecke wrote:
> On 6/27/25 03:11, Damien Le Moal wrote:
>> Improve the description of the possible default SATA link power
>> management policies and add the missing description for policy 5.
>> No functional changes.
>>
>> Fixes: a5ec5a7bfd1f ("ata: ahci: Support state with min power but Partial low power state")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>   drivers/ata/Kconfig | 36 ++++++++++++++++++++++++++----------
>>   1 file changed, 26 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>> index e00536b49552..1d53d7b568bd 100644
>> --- a/drivers/ata/Kconfig
>> +++ b/drivers/ata/Kconfig
>> @@ -117,23 +117,39 @@ config SATA_AHCI
>>   
>>   config SATA_MOBILE_LPM_POLICY
>>   	int "Default SATA Link Power Management policy"
>> -	range 0 4
>> +	range 0 5
>>   	default 3
>>   	depends on SATA_AHCI
>>   	help
>>   	  Select the Default SATA Link Power Management (LPM) policy to use
>>   	  for chipsets / "South Bridges" supporting low-power modes. Such
>>   	  chipsets are ubiquitous across laptops, desktops and servers.
>> -
>> -	  The value set has the following meanings:
>> +	  Each policy combines power saving states and features:
>> +	   - Partial: The Phy logic is powered but is in a reduced power
>> +                      state. The exit latency from this state is no longer than
>> +                      10us).
>> +	   - Slumber: The Phy logic is powered but is in an even lower power
>> +                      state. The exit latency from this state is potentially
>> +		      longer, but no longer than 10ms.
>> +	   - DevSleep: The Phy logic may be powered down. The exit latency from
>> +	               this state is no longer than 20 ms, unless otherwise
>> +		       specified by DETO in the device Identify Device Data log.
>> +	   - HIPM: Host Initiated Power Management (host automatic transisitons
>> +		   to partial and slumber).
>> +	   - DIPM: Device Initiated Power Management (device automatic
>> +		   transitions to partial and slumber).
>> +
>> +	  The possible values for the default SATA link power management
>> +	  policies are:
>>   		0 => Keep firmware settings
>> -		1 => Maximum performance
>> -		2 => Medium power
>> -		3 => Medium power with Device Initiated PM enabled
>> -		4 => Minimum power
>> -
>> -	  Note "Minimum power" is known to cause issues, including disk
>> -	  corruption, with some disks and should not be used.
>> +		1 => No power savings (maximum performance)
>> +		2 => HIPM (Partial)
>> +		3 => HIPM (Partial) and DIPM (Partial and Slumber)
>> +		4 => HIPM (Partial and DevSleep) and DIPM (Partial and Slumber)
>> +		5 => HIPM (Slumber and DevSleep) and DIPM (Partial and Slumber)
>> +
>> +	  Excluding the value 0, higher values represent policies with higher
>> +	  power savings.
>>   
>>   config SATA_AHCI_PLATFORM
>>   	tristate "Platform AHCI SATA support"
> 
> Hmm. Isn't it worth creating an official documentation somewhere in
> Documentation/* to have this available without having to look at the
> source code?

Yes, I am considering this.
I did not write it in the cover letter, but these patches are the first part of
a much bigger patch series that addresses a lot of LPM issues that we recently
discovered doing completely unrelated tests. Once that is out, documenting
everything will be a good thing to do.

> 
> Otherwise:
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> 
> Cheers,
> 
> Hannes


-- 
Damien Le Moal
Western Digital Research
