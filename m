Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A426111A8
	for <linux-ide@vger.kernel.org>; Mon, 28 Jul 2025 22:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753741855; cv=none; b=bKlR0KVd8EZ50c1LPo0kJIonUgDUFUlcDt1uEY46MsZv9nMYj3f9H4vHMdp/G1PjP1W6IIBxAvq59LSTw5SB59zZSLE3scbS87k932s6XVMImlqAAlXI0rCoJmRIQKNGBTPKRPwlP7iu73wU2oRWbAHxvQ2kKp79eIkjSM27GuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753741855; c=relaxed/simple;
	bh=/1BrXD3fQpF72mx1DAPNnhXyTgXhonfo60wpkCRVIQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ViKH82KkrvZtEK50hwx2o9jlKqOunPK+kUmZ08k3sXO6nGpi3DA8pijv9zyJCdeBbmHwBIkSBjQ7ExHNZ7VeSC5yl15baFvokMdD1cPY2lNewcnI9CqZF58qe25l9WIG4yEFZSJxvLaGeWYsLE8cqtMtnLJr0L+5apEHQGW3zdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WddkmhIi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WddkmhIi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6C3C4CEE7;
	Mon, 28 Jul 2025 22:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753741855;
	bh=/1BrXD3fQpF72mx1DAPNnhXyTgXhonfo60wpkCRVIQs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WddkmhIiirYBbUFWseRESmZgrRbCwSthhaBBDth9rJ55+FB/gYGyGHHL+bnMuzDlH
	 Xu2nrKeP8a+hnJElRD2eXKNWOs7Gp42vNYvniz6QtLUaHKJY21q8dwHUP7l9t765lg
	 fhfGrY9y/SQm6g36wgoQj1mtg4wEfrPnSarKq/NRFnflMkLYG/JP3Oidjpwok9B7WX
	 IQg3Zw5WuBDoxC6zDOkXYNw1Ry1VJq2Xh0KlOLNoVtP5eWM+ROPkIvoBucb8jqoOCI
	 iJt7hd36BJYHT89eh5N395JoNDAPhHZoExTw9fl48H+147P+k4mGtl5TRuNwRooDow
	 2FpV9LVgRGE8Q==
Message-ID: <d47b06b4-d2e6-4c0a-8721-5df15aa46378@kernel.org>
Date: Tue, 29 Jul 2025 07:30:52 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression on linux-next (next-20250708)
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 linux-ide@vger.kernel.org, mika.westerberg@intel.com,
 anshuman.gupta@intel.com, "Kurmi, Suresh Kumar"
 <suresh.kumar.kurmi@intel.com>, "Saarinen, Jani" <jani.saarinen@intel.com>,
 lucas.demarchi@intel.com
References: <07563042-6576-41cd-9a95-de83cfc95de1@intel.com>
 <f4f147cd-5847-4efd-8dd3-9a00e129e133@kernel.org>
 <8f37fcfd-300c-42df-a65b-57c10f185287@intel.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <8f37fcfd-300c-42df-a65b-57c10f185287@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/29/25 01:33, Borah, Chaitanya Kumar wrote:
> 
> 
> On 7/28/2025 11:01 AM, Damien Le Moal wrote:
>> On 7/25/25 3:43 PM, Borah, Chaitanya Kumar wrote:
>>> For some context in our kms_pm_rpm tests, we enable min_power policy for SATA
>>> so that we can reach deep runtime power states and restore the original policy
>>> after finishing. [5][6]
>>>
>>> IIUC, the above change is based on spec and not something which can be
>>> reverted. So as I see it, we have to drop this code path for external ports.
>>> However I am not sure if we can achieve deep power states without enforcing it
>>> through the sysfs entry.
>>>
>>> Atleast for the basic-rte subtest, the test passes if we comment out the
>>> functions controlling the SATA ports. We will need more testing to determine if
>>> this approach work. Any thoughts on it?
>>>
>>> Also, are there other ways to detect a port is external other than receiving
>>> EOPNOTSUPP on the sysfs write?
>>
>> I completely forgot to mention one important thing: please check your test
>> machine BIOS settings and see if you have "hotplug support" set to enable for
>> SATA ports. If it is, set that BIOS setting to disable and you will see the
>> SATA port as a regular one, not as an external port. So LPM support will be
>> back and your test program will not need changes.
>>
>> Not all BIOSes have such setting though. Most of the machine I have do have it
>> though and I checked that it does affect how the ahci driver sees the port
>> (external or regular with LPM).
>>
>>
> 
> Found a "Hot Plug" setting (thanks to Mika!) in our testing device's 
> BIOS but it does not seem to have any effect.
> 
> We also have an option called "External", toggling that did not help either.
> 
> There is another configuration which was *readonly*.
> 
> "Configured as eSATA" -> "Hot Plug supported"
> 
> Not sure if it is relevant to our discussion.

It is and that probably is the reason why disabling hotplug does nothing on the
port external characteristic. Does this machine really have eSata ports ? Do
they correspond to the 4 ports (out of 8) that you see as external
(link_power_management_supported = 0 ports) ?

Likely, you have the SXS host capability set for this machine because of this
BIOS setup. From the AHCI specifications:

Supports External SATA (SXS): When set to ‘1’, indicates that the HBA has one or
more Serial ATA ports that has a signal only connector that is externally
accessible (e.g. eSATA connector).

Hotplug is reported as a separate bit, but handled in the same way as an
external port as we cannot (easily) support LPM if we want to preserve the
hotplug capability (LPM changes the PHY state constantly, which clashes with hot
plug/unplug PHY changes and is hard to differentiate).

Note that you can see if a port is external in dmesg. Look for:

ata4: SATA max UDMA/133 abar m524288@0xaa500000 port 0xaa500280 irq 112 lpm-pol
1 ext

A regular port will not have the "ext" at the end:

ata5: SATA max UDMA/133 abar m524288@0xaa500000 port 0xaa500300 irq 112 lpm-pol 1



-- 
Damien Le Moal
Western Digital Research
