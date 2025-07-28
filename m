Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E3821348
	for <linux-ide@vger.kernel.org>; Mon, 28 Jul 2025 22:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753742043; cv=none; b=shDu14tsMfzhf+x1kcSpq8BLqI9ccvbL9LLNVE8SW03nk70XER7fvE/BKDMPHn3j1Umo6uUoCEYFACkhF+vqSm/Pb4O1L4BdmzG8ATwT/MKcuZTiGZUhpYACcTFRPyvyf2SavhYrGAB00rQmhybhZmML11S57pfpO0opGdJQ5iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753742043; c=relaxed/simple;
	bh=8a2Y93oHH/OSh9XjEyyBAAxmZiTUjcXf/ZOnnwUBTK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GoJyknb0l/SnR/UsjfI22UxarRTsA/ImJO0IxpQREm9e7jd4jEUPxz5exuq1oZZNz8+XqA/ZA8Pna1CKyUMRAD6/s9E4q5NFD/QFaD4gpBzHywMgDNwWwCm5Q4nrIDvczoXPh263oWSvKaK+LBiVtqyZ5btaTFnWZukFkPTxqW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4vpMbvS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4vpMbvS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3BAC4CEE7;
	Mon, 28 Jul 2025 22:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753742042;
	bh=8a2Y93oHH/OSh9XjEyyBAAxmZiTUjcXf/ZOnnwUBTK8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l4vpMbvS9ikuZ3UxCF1E2fplBB7lTBaFvxF04UZnb8npMgZ6CDkTwGH6Mw0CMt0Jb
	 BPvxvtUPzvpuzQBXIH3ezEGi2YY8mSDQcc9KXjvbujM0biQZH+ryS0FFyppuxGL3u0
	 q9xEqQyBWgbKkSvPIQ98H0LQq3kpFEx+DPTy9cU6ce/AOfZaHtoWBaFljzfn8PFdOx
	 +tgeeiCvA9DkZb7NgneuBhPdXg5nBpIEbmBc/+LGpgGlFrikUaSLjIwSjzz2pZKiV0
	 uxX9Bdexq33rMTQMtnJQJDPpJNLGXcGJhAD6D4D1Iy6oWSaEnzSECCckFwJT5jVzCk
	 GiBrw4lxiFzHw==
Message-ID: <5143bbee-697b-4357-9645-10f38296b561@kernel.org>
Date: Tue, 29 Jul 2025 07:33:59 +0900
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
 <f3f779e3-e269-4ac9-9bed-042859d98a83@kernel.org>
 <d34d122f-2ef8-44f1-83c9-92c7b9e83b6e@intel.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <d34d122f-2ef8-44f1-83c9-92c7b9e83b6e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/25 01:24, Borah, Chaitanya Kumar wrote:
> 
> 
> On 7/28/2025 9:41 AM, Damien Le Moal wrote:
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
>> The attached patch adds the "link_power_management_supported" sysfs device
>> attribute for drives connected to AHCI. Would that work for you ?
>>
> 
> Yes this could work. I quickly hacked the test to ignore writing policy 
> if this file returns 0.
> 
> Here is the state of the machine I am testing on.
> 
> /sys/class/scsi_host/host0/link_power_management_supported: 0
> /sys/class/scsi_host/host1/link_power_management_supported: 0
> /sys/class/scsi_host/host2/link_power_management_supported: 0
> /sys/class/scsi_host/host3/link_power_management_supported: 0
> /sys/class/scsi_host/host4/link_power_management_supported: 1
> /sys/class/scsi_host/host5/link_power_management_supported: 1
> /sys/class/scsi_host/host6/link_power_management_supported: 1
> /sys/class/scsi_host/host7/link_power_management_supported: 1

Looks good. My test machine looks exactly like this too.
I will send out this patch as it is useful anyway regardless of external/hotplug
ports since not all adapters/drives support LPM.

When posting this, can I tag it as a solution to the regression ?

And in addition to this patch, I will work on a flexible way of ignoring hotplug.


-- 
Damien Le Moal
Western Digital Research
