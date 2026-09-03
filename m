Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E3E36B939;
	Thu,  3 Sep 2026 22:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788473374; cv=none; b=cXCgRknMgvf1TMb/8n9qhGeWIuF7wr7ZKlAclPgN3mi/hUGA+YBWPyBL/ASG9bXyhY2JeC4seISG3K7zkrJjM5JTS1TTT64T14yc59qlf3APNp1OfJ4tEEsYnxkizva20I1wno6p1n3VAQFVBD2x74+iIVFXxgCfjIgakdKGRqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788473374; c=relaxed/simple;
	bh=XUmQ8UThOmT9gMkl14y7HKkO2u4SYYMcodlQ8bz7cVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ebg87nb7hroOyJ7FB0+AWjYAz+7TNq/8LVy+xa4lhbxJ86iru3Mox6zs9u1gv/C0M04D6aPuiWXjcwbF0shbFshyQc6jxCeEtyF630xjlRTkSaDebX/9yKEdKzyLw3x56ng0LNSV3T0rDT2KCZLij0MxKq0jFMFOMYfB8yqPiXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DR4kG73Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DR4kG73Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160BA1F000E9;
	Thu,  3 Sep 2026 22:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788473373;
	bh=ohw0XeYw1ERw/37A+FtT1lx4zlmTIrbXTmcflGJ8udc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DR4kG73QIJyZ1auFxy5zaPpYr8lru6+DTQoQRolGfi8JBICbqakaTX3OatGS65qMZ
	 cbhDN+T47cyJcTtzOob4l8KYj6+zsaKX+AUgB5+LJDuBgZ7po3S+npeEZKeg8v9ZXA
	 4BOvPB8/TeuOzVdkX/6DSS4ISCZkkYL2iuH+ye8nPZ70jdaBnm+zZI/utQxZjbwiya
	 RopljTQqq1RB8OMmDpCH8+KtJ/A1x0PLsmT96FI2utIBwyNg3IKoBqISxOD/ySpZ+O
	 L11MVVyaeHBwt1x7bNSMAItfZ/LXv1nlc9Qs7pMKItJWyeRwQ6Ak4YNJdeg9xsmDWs
	 OjicIx0QcWHCQ==
Date: Fri, 4 Sep 2026 00:09:29 +0200
From: Niklas Cassel <cassel@kernel.org>
To: jhon cadena <jhon_jairo_cadena@protonmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"linux-pcmcia@lists.infradead.org" <linux-pcmcia@lists.infradead.org>
Subject: Re: [REGRESSION] pata_pcmcia: ~80 second delay after physically
 removing PC Card CF device
Message-ID: <apnwGStb-9FRo95y@ryzen>
References: <1zX3C-O2LeyhM2Zkz1FCkoqLUvxXWI_b5CfSB7DfI37xPsH9vIz1YlzPLWxAWUJi4rYcww6jDfuyKWZRBRQrzfUb0aLwkSHQxm9z_OHyMLU=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1zX3C-O2LeyhM2Zkz1FCkoqLUvxXWI_b5CfSB7DfI37xPsH9vIz1YlzPLWxAWUJi4rYcww6jDfuyKWZRBRQrzfUb0aLwkSHQxm9z_OHyMLU=@protonmail.com>

Hello Jhon,

On Thu, Sep 03, 2026 at 08:12:56PM +0000, jhon cadena wrote:
> The same type of PC Card storage worked normally on Debian 9 on my previous Toughbook.
> After moving to Debian 11 with a newer kernel, physically removing the card causes an
> approximately 79-second delay while the kernel continues trying to access the device
> before finally disabling it.

(snip)

> Current software:
> 
> -   Debian 11
>     
> -   Kernel: 5.10.0-46-amd64

Debian 9 uses kernel v4.9, released in 2016.
Debian 11 uses kernel v5.10, released in 2020.

On this mailing list, we only care about the latest kernel version.
At this point in time, v7.3-rc1, released Aug 30 2026.

Please thest on the latest kernel version, or report the problem to the
debian bug tracker.

Normally, we recommend to do a git bisect to find the commit that
introduced the problem. However, you know that v4.9 is good.

You should first see if v7.3-rc1 is good or bad before starting a
git bisect.


Kind regards,
Niklas
