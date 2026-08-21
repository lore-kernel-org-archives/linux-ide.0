Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F185A47DD59;
	Fri, 21 Aug 2026 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787314502; cv=none; b=f/ztpZc7dfj2j+rx7ZxPblZzFksGcp7c0JFKBFs9eyO8d6oYrKglxEoYvJCchOornpMDZ607Bx2BflqAATnNJVm5TGIzRf3r4FsZ5IlPuq+a9uKw9UhkKw8Ry6I3BrtzKrDwI6tO7AxyXlRoltNww9HK/NyWb3oMFF4p3cYCJWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787314502; c=relaxed/simple;
	bh=fPm0rn4PaPh87T8UU+Mqjbr0I3Bw3Cs+zmAp62PvFWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQoHxpROG8SPhZzeiHHdt+9IXxhU6/FnvdBfgC/QxTFbCB212VRvqHR6wIf90ogQ36Gy+27NQu26yIq57WC7IFIHChX6QQ212gRe/qZGiMegdyViHgE5HU5AFVHqKTspC2WhWnvcNwGurFeQ3IbQr1+s2ndCQD4wfYyrKcAdoXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVRaY31/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVRaY31/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2051F000E9;
	Fri, 21 Aug 2026 12:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787314488;
	bh=JbN8IjjAwQ4XsB89BdQTgxt2b/ofllQCEGBc61bbmXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SVRaY31/47oYd0d8bxWZhKiRNEvFbsxVf4cHhoK7AhgrwsOz01LOLYvP4GWwua7+/
	 bsq+Hedj2xNigka099k8g7FS/J1Lr32mRfaNOV7VQWe7rRn9kmY5DA/cLbAaPZRrzR
	 0xXP4/tZPopG2R0HfNp5vU7P/+utHqXnNY2PIFGPl0ay2CMr1VoIR6f8TDVvb4GEsG
	 x6OVX0p1Yv3JCeCvwPtoiHbktt2ot8rvUM7yM784+XGz4ZIuQF2IVqDaN1F+cBXsbS
	 K+m24RIPfmNd8Tfo6Jn2Mj+/yC9/TFCXe3ol7DFnZ43e5MidmFVViVlc8SNAnNMA7b
	 IIPtL4p2hbcCg==
Date: Fri, 21 Aug 2026 14:14:44 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 04/13] drivers/ata: Stop using 32-bit MSR interfaces
Message-ID: <aohBNCPPo-sfO9IS@ryzen>
References: <20260819102314.1499258-5-jgross@suse.com>
 <20260821091210.1661197-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821091210.1661197-1-jgross@suse.com>

On Fri, Aug 21, 2026 at 11:12:10AM +0200, Juergen Gross wrote:
> The 32-bit MSR interfaces rdmsr() and wrmsr() are planned to be
> removed. Use the related 64-bit variants instead.
> 
> In drivers/ata/pata_cs5536.c don't redefine rdmsr() and wrmsr() as
> empty macros for avoiding misuse, but guard the affected code via
> a simple #ifdef.
> 
> Switch pio_cmd_timings[] to a u32 type array in order to avoid a cast
> to u32 when constructing final MSR values.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---

Acked-by: Niklas Cassel <cassel@kernel.org>
