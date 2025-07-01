Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F48833EC
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 09:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751361862; cv=none; b=VksLwVVM8ZbJDhT6D7CC8KsU2vq6V5JqRz+2EFRI/f9Vv3fLEDb+k7safdJpfL9MX4kfckMXq2UvIuUpQa6mDdpr/JXvPdc74cP59ffVVHhkYdY7jsUiHWXwksCxCvvezTfnlxd9QG109wQ6c0pka47ILIP0nmQ8khnxIF7u8II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751361862; c=relaxed/simple;
	bh=Cjd8DU0pQ3dvQ9WGPm2SHCHS/q0OXBHS6s4PSeFxcdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhJZRWSdGjc69A2w3qBr2AMDJIf8gW+rW77WuDIHa6aa71UUz53JY+iHn7yHEw+gT4ZSCfm/asiYklALn5aw/IghDc6sCmNN7mU8nHpqz+5R1zbHPaFxgPT7kkVg1CFcQzZVDVQn3Iv7lz8cgd6L1fzx8uStAVRyUF9bx51BfBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OB6Lxnvx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OB6Lxnvx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41042C4CEEB;
	Tue,  1 Jul 2025 09:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751361862;
	bh=Cjd8DU0pQ3dvQ9WGPm2SHCHS/q0OXBHS6s4PSeFxcdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OB6Lxnvxc3K4GcoyfoISd97ox5mbrXf5ZHsM8HdJwy7iMT74Fs1OtiiLxr8msHILq
	 +1Eb4E/qbSya+51hG4WkWUBOYD00v18gg+EsnvDZDqfQh6uKEGMSYlCvA+7Hda4UKu
	 Fi4jrk8JP+HULJILjaCIbrIKDnM6XfBmcRjPoMj0sYtjWL5PE1rMaxEKukPOzFJ6Aw
	 WjNKzrC/t/BDWOx4FvUGjcv0iICsmU8UsmeGzneMKz/PjhwD/rWVJJTKePZYX0V/nE
	 XdLETIZnsmTA7qn1vcUmckCi2SNC4qrwUz+dN1UCZGwgXcuvN1q39FSmRM6JN1GqGG
	 h4b6Rjb0lIN/Q==
Date: Tue, 1 Jul 2025 11:24:18 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org
Subject: Re: [PATCH 04/10] ata: libata-eh: Avoid unnecessary resets when
 revalidating devices
Message-ID: <aGOpQtkxF1FehZ9G@ryzen>
References: <20250630062637.258329-1-dlemoal@kernel.org>
 <20250630062637.258329-5-dlemoal@kernel.org>
 <60dd0013-20a3-4b10-a60b-0e567526e0f9@suse.de>
 <097726fe-638a-4336-8427-3eb3055de5b7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <097726fe-638a-4336-8427-3eb3055de5b7@kernel.org>

On Tue, Jul 01, 2025 at 03:48:15PM +0900, Damien Le Moal wrote:
> 
> There is a 10ms wait already in sata_link_scr_lpm() but it seems to not always
> be enough. The specs say that transitions out of HIPM "shall not take more than
> 10ms", but hey, we all know how devices always follow the specs, right ? :)

HIPM / ALPM includes Partial, Slumber and DevSleep.

10 ms is for Slumber.

DevSleep can be much longer than that:
          - DevSleep: The Phy logic may be powered down. The exit latency from
                      this state is no longer than 20 ms, unless otherwise
                      specified by DETO in the device Identify Device Data log.


From PxDEVSLP.DETO:
  Device Sleep Exit Timeout (DETO): This field specifies the maximum duration (in
  approximate 1ms granularity) from DEVSLP de-assertion until the device is ready to
  accept OOB. The nominal value is 20ms while the max value is 255ms depending
  on device identification information.


So technically it can be 255 ms :)


Note that we do actually read and save DETO:
https://github.com/torvalds/linux/blob/v6.16-rc4/drivers/ata/libahci.c#L2293-L2295

But like you said below, with this patch, we should be able to remove the sleep
if we wanted, so I don't think that we necessarily need to increase it.


> 
> > From a cursory glance we just continue, and (apparently) hope that
> > everything will be well eventually.
> > Hmm?
> 
> It is fine to continue because transitions out of DIPM/HIPM/DevSleep are
> automatic if you send a command. So we actually do not need to wait at all and
> probably can remove that 10ms sleep in sata_link_scr_lpm(). But I have not for now.
