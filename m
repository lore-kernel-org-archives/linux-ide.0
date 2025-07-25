Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B2B2E4266
	for <linux-ide@vger.kernel.org>; Fri, 25 Jul 2025 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439621; cv=none; b=Ybzef0fOXCWWA65FPfub/gB+K3pYwJm6UvJSpB/JEaKXEnzKICTTgtR1N2KWrH89Xl9DLiwyTSgyrIk1C2RNP2re9FscoUsMYmPn0f6n6Q+/vyczUptt6h9QzjPTnBR7JBcpn9FnXkqMEZe49mkXha7G6y0hfu/3gBam605Ss94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439621; c=relaxed/simple;
	bh=YP3zgdbV4rWDDNeh6M4/SahHLAfSTyA5yYPF8nAccjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6GeDbElR9nbFKJYr93dInNLzoFG8sS88Gh4F3J73kmW7HuEfzbxURSG4sB0HuOHRcwtnPODhT7OUnfwAAf/KKooKx6QR1VDW8c6jWnZVA1pVWjRRrjA3JqAm+hx580dBzZwuJnGZqlRI2f0Hx3BmlDBoL77o2mqHCv0g2JT2q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1UI3XQ1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1UI3XQ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A7EC4CEE7;
	Fri, 25 Jul 2025 10:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753439620;
	bh=YP3zgdbV4rWDDNeh6M4/SahHLAfSTyA5yYPF8nAccjM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V1UI3XQ1ILsZUWLvdZZOZ0cVP5T8wA0BdNwewnfj8up3XmTfdV43DXkUbyvCTYS1T
	 LFZz/c7azxmXyJxyvmporpAm7B7wlFMFPPLXurShb+c8tEhBYiTTBnTJDpVRmusiPD
	 CUpf7joDpTNJ8lhMY1OHHe+1qWcN7wXuqr4oRfrzAxeCVtPzuuP6BnD6/D05lofKlV
	 XrDQOT/woffjxnPToGEoLzS0lLRktOrKBkey/oSr2HG6NhyiDWngAd9twhe+q8ZyKn
	 GehbD56qqNjvudX+DMw5h0/0/aUOp8mkPL7uPgxExc4wl9G2IZXPLNKye3MCf7sveO
	 YYeHRCo93ehhg==
Message-ID: <243457b5-c1f8-494a-a88a-272c535094a7@kernel.org>
Date: Fri, 25 Jul 2025 19:33:37 +0900
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
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <07563042-6576-41cd-9a95-de83cfc95de1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/25/25 15:43, Borah, Chaitanya Kumar wrote:
> Hello Damien,
> 
> Hope you are doing well. I am Chaitanya from the linux graphics team in 
> Intel.
> 
> This mail is regarding a regression we are seeing in our CI runs[1] on
> linux-next repository.
> 
> Since the version next-20250708 [2], we are seeing the following regression
> 
> `````````````````````````````````````````````````````````````````````````````````
> (kms_pm_rpm:5821) igt_pm-CRITICAL: Test assertion failure function 
> __igt_pm_enable_sata_link_power_management, file ../lib/igt_pm.c:392:
> 
> (kms_pm_rpm:5821) igt_pm-CRITICAL: Failed assertion: write(fd, 
> "min_power\n", strlen("min_power\n")) == strlen("min_power\n")
> 
> (kms_pm_rpm:5821) igt_pm-CRITICAL: Last errno: 95, Operation not supported
> 
> (kms_pm_rpm:5821) igt_pm-CRITICAL: error: -1 != 10
> 
> Test kms_pm_rpm failed.
> `````````````````````````````````````````````````````````````````````````````````
> Details log can be found in [3].
> 
> After bisecting the tree, the following patch [4] seems to be the first 
> "bad" commit
> 
> `````````````````````````````````````````````````````````````````````````````````````````````````````````
> commit 4edf1505b76d30e1e1e283d431e4f84ad01ddcef
> 
> Author: Damien Le Moal dlemoal@kernel.org
> 
> Date:   Tue Jul 1 21:53:18 2025 +0900
> 
> 
>      ata: ahci: Disallow LPM policy control for external ports
> `````````````````````````````````````````````````````````````````````````````````````````````````````````
> 
> For some context in our kms_pm_rpm tests, we enable min_power policy for 
> SATA so that we can reach deep runtime power states and restore the 
> original policy after finishing. [5][6]
> 
> IIUC, the above change is based on spec and not something which can be 
> reverted. So as I see it, we have to drop this code path for external 
> ports. However I am not sure if we can achieve deep power states without 
> enforcing it through the sysfs entry.

I am not entirely sure what you mean with the last sentence above, but for
external ports, LPM cannot be used if you want to keep the port hotplug
capability alive and working. Without keeping such port at max power state, we
cannot detect hotplug events (which is super annoying when you have e.g. a
server with front loading drive bays allowing swapping drives without shutting
the machine down).

> Atleast for the basic-rte subtest, the test passes if we comment out the 
> functions controlling the SATA ports. We will need more testing to 
> determine if this approach work. Any thoughts on it?

Niklas and I actually suspected that we would be getting "complaints" about this
change. Well... We did :)

The problem really is that external ports have never been properly handled by
libata so SATA hot-plugging never really worked reliably. Patches queued up for
6.17 before this patch prevent the kernel from changing the power state of
external port. And this patch was introduced after seeing systemd.udevd setting
external ports power state to min_power or lower states, thus breaking again the
hotplug capability.

The error you are seeing is thus entirely correct and expected.

The question is though: do we want the user to "ignore" hotplug capability and
instead priviledge low power states. I guess we should have such capability.

> Also, are there other ways to detect a port is external other than 
> receiving EOPNOTSUPP on the sysfs write?

There is not. But it would be easy to add a sysfs port attribute, e.g.
/sys/class/ata_port/ata1/external which says "0" for regular ports and "1" for
external ports. We could also make this attribute writable in the case of
external port so that doing:

echo 0 > /sys/class/ata_port/ata1/external

forces the kernel to ignore the external nature of the port and allow user
control of the port/device LPM state.

Would that work for your case ?

-- 
Damien Le Moal
Western Digital Research
