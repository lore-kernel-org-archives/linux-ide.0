Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003F930BF6B
	for <linux-ide@vger.kernel.org>; Fri, 22 Aug 2025 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874194; cv=none; b=qIte80UHCLnxmf63qUwVlopbc3lc2+PBWP+zMxlTbV3yyRSXSKBki1Z9yE6yJ63kdWbENZ7yiZSXIN88zTAeOFanYEkptlaQtYY6pJ/zWXl5XE/c3Qiw5sVJz4ftlee2cJhouJaHgyhBsIoc4t1D18lVjN8hvxTc83ztn535zAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874194; c=relaxed/simple;
	bh=+Q5K+FMmFR34XmpBQQfmbQ5SG7N0mkqfk2DE34MSK5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSIRTpQgJmCEKKteoE1MxR/crIjedNcyD9eVC/nq2CG/zOqqzKWIEXkY374wBJxBeHJmOshNJPB5Az965pHhSJLr+o2H8hNyh3hMQ/jY4V1GrxXY9mNmVOWdCs+dNd9Vka9mmHq1E08bFYZRFgtkF6ZcNmQ7IEF5kP6PxOBSzpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvZi+jQ1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvZi+jQ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2ECC4CEED;
	Fri, 22 Aug 2025 14:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755874193;
	bh=+Q5K+FMmFR34XmpBQQfmbQ5SG7N0mkqfk2DE34MSK5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AvZi+jQ1RpkItxCq/55VC7QTeYRMjvIE+OyzrcqaU25SVs/+Xcn5CxQXJyQFrM5Ui
	 yq9A6+Ij0G2UKa3kvqy8RU8tqsvlhzlBtjj89JYDUmA5KWJv3OiQ6UepzmYT4WB84d
	 SDFSg2jcuD9dcZy5kb4GCioSKjQ8pFsf2+7+/TgeIP2mmsHqjXMF/7vQgGmPwfjSsy
	 p95uB7rlQiBL/Wm16A9Iw71nFtJK7Qwouro/u+MOyQrIvEoovF0a9eUyw4/D7qgjrc
	 V+MJf8ljsM6iYIt1HF4PHFqng+yofmDOVp3DfYUfoU4G603GyVexcPY/bL0UFNLLOe
	 Sic5ggyGsGP+w==
Date: Fri, 22 Aug 2025 16:49:49 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Dieter Mummenschanz <dmummenschanz@web.de>
Subject: Re: [PATCH v2] ata: ahci: Allow ignoring the external/hotplug
 capability of ports
Message-ID: <aKiDjVODoAN2z46C@ryzen>
References: <20250821080651.65800-1-dlemoal@kernel.org>
 <aKhj7prAFmQ9U95z@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKhj7prAFmQ9U95z@ryzen>

On Fri, Aug 22, 2025 at 02:34:54PM +0200, Niklas Cassel wrote:

(snip)

> But do we really want a introduce a module parameter for this?
> I know that commit 4edf1505b76d ("ata: ahci: Disallow LPM policy control for
> external ports")
> if external, both:
> 1) sets initial lpm policy to MAX_POWER (so that hot plug works by default)
> 2) sets ATA_FLAG_NO_LPM, so that you cannot change the LPM policy using sysfs
> 
> I think that 1) is good.
> 
> However, why should we forbid the user to override to policy via sysfs just
> because the port is external?
> If a system admin has installed a udev rule or similar to set a lpm policy,
> why should we not respect that?
> 
> Yes, I know that many distros supply a rule that just enables LPM
> unconditionally for all disks...
> 
> But... instead of forbidding the user to change to policy using sysfs, perhaps
> a better way would be for the system admin/distros to improve their udev rules?
> 
> We have a sysfs property that says if the port supports LPM.
> Perhaps we should have a sysfs attribute that says if the port is external.
> 
> The udev rules can then be smarter and just set the LPM policy if the port is
> not external. But the user would still have the option to set a LPM policy
> (using the same interface), if they don't care about hotplug.
> 
> It seems more user friendly for a user that has a laptop with a docking
> station with hotplug capable ports, to install a udev rule to set an LPM
> policy, than to set a kernel module param.
> 
> What do you think?

Another idea: perhaps we could add something like:
"hotplug_supported" and "hotplug_enable" to sysfs.

For ports marked as external/hotplug capable, we set
"hotplug_supported" to true, and for ports that support
hotplug, we set "hotplug_enable" to true by default.

We can then continue to disallow (return -EOPNOTSUPP) when the user tries
to write to /sys/class/scsi_host/hostX/link_power_management_policy
for a port that has "hotplug_enable" == true.

If a user sets "hotplug_enable" = false, we allow writing to
/sys/class/scsi_host/hostX/link_power_management_policy

What do you think? Better or worse idea?


Kind regards,
Niklas
