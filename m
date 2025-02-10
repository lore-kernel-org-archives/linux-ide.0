Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B391EF1D
	for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2025 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185728; cv=none; b=XEZGp0KS9nRLkGbp5oct1aeR1KuKIyYW7btiGFfjpmYrIVX3Q93s6e6eS7oAmjbnJeZNjUwUqN68Nhizy6QZHXG/bH/7HyRrJTPWnYM7MZXK/iB7wPGXCzza7G45byDfcxQSSHVH40L2YksvvYr7NJ/3ReDaHV1seq/lu7gw8PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185728; c=relaxed/simple;
	bh=dJVSIqN5cbTfbAIehKi9Ddy5SbqzAym5EqtV5iD+2qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoIiGyWSOFB2E7r3r1IXerxCnTfekaYQoDDMQkglh3KAr2L1W+jgL70DeXodr0dWEtjr56zeJlsyq2Lk3hwQNiFyeuYBOYxAf3anx5+57BhfbxQEvpbJRMphaWEN7EQObfJQuwnJSISgf6fFTjYWdDNxUau08OedAT+y27nHroY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGgOhavu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGgOhavu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C376C4CED1;
	Mon, 10 Feb 2025 11:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739185727;
	bh=dJVSIqN5cbTfbAIehKi9Ddy5SbqzAym5EqtV5iD+2qE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dGgOhavu8/KXn9RYptoG7ujWRUwwLOklXxJc32XRIgIkwsAHCsP1mzRhnqzAqTaGu
	 FKiZEXqNP2YMudBp5ugXVrxaMMJVTDQx7Gd1foF4ja9JaFxm1RiSiQVsJYssbx2LuA
	 jC2qX/+GYnYVPWMKeDy9Mm6Y5TcXtzuJXNDoJUbcF5hVDOEvMgCeQ+uYOFWWf/el65
	 dNNqtV4ZNcSrMGA1m8LLVkIUdNUQI/R2DPwwlGLYl466jpXoIIC2gigGRE+67ITAYZ
	 PiSu18dgJNep7wLGCzdlgccpRAc5yU/zONw+sQ5wloQ4qaYDPbWS/u3NmSh+jNOIvx
	 c/5a9Mw6oxkOw==
Date: Mon, 10 Feb 2025 12:08:44 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Daniel Baumann <daniel@debian.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Dieter Mummenschanz <dmummenschanz@web.de>
Subject: Re: Samsung SSD 870 QVO LPM issues
Message-ID: <Z6nePJ38aL92agTW@ryzen>
References: <Z6MjZ1Nniwn_uldf@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6MjZ1Nniwn_uldf@ryzen>

On Wed, Feb 05, 2025 at 09:37:59AM +0100, Niklas Cassel wrote:
> Hello Daniel, Dieter,
> 
> Dieter recently submitted an issue on bugzilla that v6.14-rc1
> breaks entering lower power packages states:
> https://bugzilla.kernel.org/show_bug.cgi?id=219747
> 
> Most likely, the problem is caused by Daniel's recent commit:
> cc77e2ce187d ("ata: libata-core: Add ATA_QUIRK_NOLPM for Samsung SSD 870
> QVO drives")
> 
> Dieter is using 'Samsung SSD 870 QVO 8TB', rev 'SVQ02B6Q'.
> 
> No longer being able to enter lower package states, suggests that
> LPM was previously working for Dieter's Samsung SSD 870 QVO drives.
> 
> Daniel claimed that enabling LPM for his Samsung SSD 870 QVO drive,
> caused them to stop working.
> 
> 
> Could it be that you guys are running different firmware versions on
> your Samsung SSD 870 QVO drives, and that Samsung has managed to fix
> their LPM issues in more recent firmware updates?
> 
> It seems like Dieter is using firmware 'SVQ02B6Q'
> which also seems to be the latest when looking at:
> https://semiconductor.samsung.com/consumer-storage/support/tools/
> 
> Daniel, could you please tell us which firmware version you are using?
> 
> We might have to adjust the QUIRK to only apply for the firmware version
> that you are using.
> 
> It could also be interesting to see if you could update the firmware on
> your drive, and revert the quirk, and see if LPM is working for you with
> the latest firmware version.

Hello Daniel,

Could you please provide which firmware version you are using.

If not, I do not see any other option but to revert your patch.


Kind regards,
Niklas
