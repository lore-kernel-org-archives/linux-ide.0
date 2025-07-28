Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D97D224225
	for <linux-ide@vger.kernel.org>; Mon, 28 Jul 2025 22:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753741239; cv=none; b=kvH1dYzz1furu2W1ChoT83zLhunlnlmcMfo5tb5N0iM+wjEqOCjw1GiPZbfYvHpl75IaW6s/fG9xDvtiaVTJaFAv7fuz7VddUTmOWs9rsJGibLNvMKL/4rqOhdkagm9XRNLXaa9bFS8Q6Lb7luYbpRZVpwbXpd0sV/FKJ4fHy1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753741239; c=relaxed/simple;
	bh=IppJjTusaUrLxshqiVsf8m1umQwo/apoV5H7a24flmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PFEcItQtcoB83xcfmF94aUSZZPBdp36x66HkKzMkKkQlm4a5JlVi7ODSrWGmnvb7I7NjGBAgmC+PrTL5dlVRf1zegJCnSm2C1Wezpr4a/DUzBlbEGNcV2UTuA3SsiXTA+LfAxr90VYxCo7v7C0Y0SXSy1+OyeD0RoixPcEwP+ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ublKD6XC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ublKD6XC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE7CC4CEE7;
	Mon, 28 Jul 2025 22:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753741239;
	bh=IppJjTusaUrLxshqiVsf8m1umQwo/apoV5H7a24flmg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ublKD6XCMseokKeG1ZZ5iSXR5/Hg4RbJtLatQKrhzp/LzBNaBTzGXhg0JLhGKogZO
	 IS4Fkpsgo6n0BHIJnRfXSrxSvAuAcgNPKt9M7hueCzffoT2nUopkN33E/ZxBDbyeud
	 kZSAH3A13dWeQRgPP/5f6X3ikpTKhyJHWmhPlZ+3PEGvCp/5WCCoSeXEuf2tRB6OtU
	 mjbUCHRgoiREBs8xzQzDQrhDweN0if7h0Ydmr6sZPYM7sRQnrFrpaAyH2nl2gyTsUa
	 xYHutFOAxQ6DWOphoP8aMYRkvV2b5RgvEJ7yspJZ8WbzsG15rHzKcalS5mjO1PQPl2
	 GC6fk564fjCbw==
Message-ID: <8518279b-c16c-4333-b11b-88bd114a1f1b@kernel.org>
Date: Tue, 29 Jul 2025 07:20:36 +0900
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
 lucas.demarchi@intel.com, Niklas Cassel <cassel@kernel.org>
References: <07563042-6576-41cd-9a95-de83cfc95de1@intel.com>
 <243457b5-c1f8-494a-a88a-272c535094a7@kernel.org>
 <8557d51a-3ee6-4f39-9bf7-5bd3d05c524f@intel.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <8557d51a-3ee6-4f39-9bf7-5bd3d05c524f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/25 01:37, Borah, Chaitanya Kumar wrote:
>> The question is though: do we want the user to "ignore" hotplug capability and
>> instead priviledge low power states. I guess we should have such capability.
>>
> 
> Atleast a case can be made for debugging and testing use-cases.
> 
>>> Also, are there other ways to detect a port is external other than
>>> receiving EOPNOTSUPP on the sysfs write?
>>
>> There is not. But it would be easy to add a sysfs port attribute, e.g.
>> /sys/class/ata_port/ata1/external which says "0" for regular ports and "1" for
>> external ports. We could also make this attribute writable in the case of
>> external port so that doing:
>>
>> echo 0 > /sys/class/ata_port/ata1/external
>>
>> forces the kernel to ignore the external nature of the port and allow user
>> control of the port/device LPM state.
>>
>> Would that work for your case ?
>>
> 
> Something like this should solve our problem.

I looked at this, but it is not a trivial change because of how we manage
features, which is that we do not really differentiate between "port/device
supports feature X" and "Disable X because of Y". So disabling something at
runtime instead of at device scan time (or revalidation) needs some code
massaging to remember the initial "port/device supports feature X".

One thing that would be easy to add is a "libata.force=ignore_external_ports"
module parameter to completely ignore the external nature of ports. That
probably will be the easiest solution for your case.

-- 
Damien Le Moal
Western Digital Research
