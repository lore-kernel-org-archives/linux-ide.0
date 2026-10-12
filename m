Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627122D94B5
	for <linux-ide@vger.kernel.org>; Mon, 12 Oct 2026 07:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791791122; cv=none; b=HR79+r9cCBLHuN9BsdMJJcm3bnNvbSe2YCwGFjYbMYl+bkw+IycPyHKytVMYQaTsRZRbPu3ku+s1XjY4rWTzL9wbpQetp3F2vROadKrzbdBMkaPbo7v4TYCmh5JodsCItKO/4NjatjtBmi6sYyoie3QFhtc7yXMueHvB0zMadxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791791122; c=relaxed/simple;
	bh=hbhh2hPDuF6095sfSd+8+/3H9aN1Ap6pvLdKAM61o5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAy6SZnwbQpg7JBBbDI7HTnHf0L3UNgbfLDv3ydJP+9OJJcyI466vODTqUCu0AY4X9oCRMSQp6mJUlY+Ftkz+41HnFwJtvKoq3PW+tpwOBeTbmIyjXcTKS67qi7I3mr6xvLjhzeC8UdzRn/LTfgJq7R5Ork7XxuOvI4oblkJ9Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Abj5Yhrf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Abj5Yhrf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A611F0089B;
	Mon, 12 Oct 2026 07:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791791120;
	bh=8Ucc3nrDgfKphfZN6UZtLkHtPFdQjHmHD39qV2PceLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Abj5Yhrf8MnntcgXRaA3PhpIzotJTgbMSFH7MlX5Ttv6oLht1jHyNMhCSTt0U8lYE
	 sXsEfXCxK5kKYSg5B619DiCl4BlYprDIzsC91fcrAI6elnUsIs433iVcEQz6pyPXFv
	 t1i2Pz4w3jb/DuGMtH4qxmU0z74ubvk5tDLxmbzA923TjhV8WpQ+zQ8ITsAWfc0yTI
	 vpWkDNClXJSBJoXVdZZO9mqXl62IinRNetxwG2DAAZmdJofxr/6Cju3+0crt5KgUxL
	 v4Btnyx+F1zj+2h0TiMscLdBHDaKepu957e+ZKqi2WjSxvN1smELaMNUIMgwFqTtpo
	 Iz7mZEZNU4pSA==
Date: Mon, 12 Oct 2026 09:45:17 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Hans-Joachim Lange <lange-achim@posteo.de>, linux-ide@vger.kernel.org
Subject: Re: PROBLEM: Kernel 6.8.x: =?utf-8?Q?VFS?=
 =?utf-8?Q?=3A_Unable_to_mount_root_fs_on_unknown-block=280=2C0=29_?=
 =?utf-8?B?4oCT?= SATA (Intel AHCI) not detected
Message-ID: <asyQDZ80n6bdpsD0@ryzen>
References: <c096264c-640f-4491-b242-399bba9cbbac@posteo.de>
 <1b9f33d6-f887-432a-83ec-292ff43eccdd@kernel.org>
 <d575b071-50a4-479b-a992-3268f3b37a50@posteo.de>
 <08c11d50-a358-4846-badc-7b7cb5c12d35@kernel.org>
 <e2e16c3e-df02-47de-9205-c5259875211b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2e16c3e-df02-47de-9205-c5259875211b@kernel.org>

On Sun, Oct 11, 2026 at 05:23:46PM +0200, Damien Le Moal wrote:
> On 2026/10/11 17:22, Damien Le Moal wrote:
> > On 2026/10/09 13:48, Hans-Joachim Lange wrote:
> >> Hello
> >> This the boot video link
> >>
> >> https://cloud.magdeburg.jetzt/s/7dyQZadJxWcsyrM
> > 
> > We are always happy to help in case of an issue, but please do not expect us to
> > do all the debugging work ourselves and do your own homework too: can you
> > analyze what you see there and tell us?
> > 
> 
> +Niklas

Problems I see:

You are booting 6.8.0-138

Looking at the versioning, this seems to be some Linux Mint downstream
kernel.

We asked you to test the latest upstream kernel
(7.3-rc7 at the time of writing).

You get a kernel oops when booting, which includes function:
security_module_from_file().

This is part of Linux Security Module (LSM), which suggests
to me that you are trying to load a signed kernel module,
and something went wrong.

You can read more about this here:
https://docs.kernel.org/admin-guide/module-signing.html

If you build the kernel yourself, you can simply avoid signing
kernel modules, set:
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_MODULE_SIG is not set


Your eMMC driver is failing to reset the controller.
This looks like a bug in your kernel.

I guess it could be a side effect of you failing to load some
kernel modules already.

If you try the latest kernel, and build without signed modules,
you will probably get further.

But this also asks the question, is your rootfs on eMMC?

If so, it is no wonder that you don't see any AHCI drives.


Kind regards,
Niklas
