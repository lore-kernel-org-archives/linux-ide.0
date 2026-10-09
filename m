Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BFD389458;
	Fri,  9 Oct 2026 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560432; cv=none; b=fBS5H/OpDyhdW+zkwsrdSkvSHJMXSrLCwcls+MiZ40iokhDxAGGVuurrmN6UXTzuuSL6aeFpPhoNNIAeunRkd2SU1lsetBZoT/fRhi5DmY+rJD2Kjd7YfRRYlVNl7A4KR1Tc1reev5FRg6hhcKtrpGHXGWzc2cFRSmsGCHTvNQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560432; c=relaxed/simple;
	bh=ZfREm2ISmWYaR7bcpqTTUmxVi1WaVSmYCk0DF9W7ttM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o635xroKvJn81X/eFUe1i/QZtcCl/EmJ9HROqL8TXza9+LIRhdheEJyeJCa6kKoY/kn8TT5ofBpsq8VOnLeyqwW86F2Bsl+lKPjJwgyjyN5Ly1DVRaVe7SQKfOuQNb++78BBvnZr+3wMAwgD7pCvK9NfgVoYVXT6WEyhMR4i4zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9fmHlmJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9fmHlmJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772331F000FF;
	Fri,  9 Oct 2026 15:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791560431;
	bh=CoNSFUQzT9k/JCGCjNqp9pOy/DOt1JJtLGvf6kZ44WI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N9fmHlmJBIaBe2QSSLIc8bd3YL3eJi8UlmPfe0mUGKz/wbxLwvktMsFN8k89jkbYw
	 Eeb91wzeeLUOsw92HZLsLT8CThjmEu7xaqIQOelYcqx7Hq7tLEaMv7Oz54ZAQbh9yl
	 woxkSOm23XS5MRZIdeAwCd1s+gTqxxWDvo+cqS/7Ea8JZ3315L3fL6tqCLs3pbuL1A
	 ckwlRxGfvFjNkfi6dybUoCVpNmtUOIiJERsd6PGEBn/deucp1zUlIBBVkvLisSwqXg
	 Y3GnLnkjWG/tGyDfL2woN0BMuH3ozasS9mQ6ula4xXTJLvsrNIYstfuMOEzOQrstgq
	 7y8CpLdV9iFAw==
Date: Fri, 9 Oct 2026 17:40:28 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Hans-Joachim Lange <lange-achim@posteo.de>, linux-ide@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: PROBLEM: Kernel 6.8.x: =?utf-8?Q?VFS?=
 =?utf-8?Q?=3A_Unable_to_mount_root_fs_on_unknown-block=280=2C0=29_?=
 =?utf-8?B?4oCT?= SATA (Intel AHCI) not detected
Message-ID: <askK7KVJlMcfyYWp@ryzen>
References: <c096264c-640f-4491-b242-399bba9cbbac@posteo.de>
 <1b9f33d6-f887-432a-83ec-292ff43eccdd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b9f33d6-f887-432a-83ec-292ff43eccdd@kernel.org>

On Fri, Oct 09, 2026 at 09:33:42AM +0200, Damien Le Moal wrote:
> On 2026/10/07 14:40, Hans-Joachim Lange wrote:
> > Hello,
> > 
> > I am experiencing a regression: kernel 5.15.x boots fine, but 6.8.x
> > fails with "Kernel panic - not syncing: VFS: Unable to mount root fs
> > on unknown-block(0,0)". The SATA controller (Intel, rev 06) is not
> > detected; /dev/sda never appears. The ahci module is present in the
> > initramfs but does not load.
> > 
> > [1.] One line summary:
> >      Kernel 6.8.x fails to detect Intel SATA AHCI controller; /dev/sda 
> > not created.
> 
> Please try again with at least the latest stable kernel, or ideally the latest
> mainline kernel (7.3-rc6 as of this week). And also please try to capture the
> boot messages with the bad kernel. Hard to say what's happening without that.
> You can use network console or simply a video/pictures of the screen where we
> can see the ata messages.

You can also add rdinit=/bin/sh to the kernel command line
to get a shell.

Then you can do:
$ lspci

to see if the AHCI controller is there.

to see which modules are loaded.

You can then try to modprobe ahci to see
if your drives are detected.


In most of these cases, you are simply missing the required
filesystem (or similar) modules in your initramfs.


Kind regards,
Niklas
