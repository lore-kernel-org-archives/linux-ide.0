Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61C452ED4A
	for <linux-ide@vger.kernel.org>; Tue,  8 Sep 2026 11:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788867801; cv=none; b=sBGXWt1s48sRN+llMeE9hxlZvuDSqWpW+yraZnmaRiqTJqfyMh1t5gNJVXRa6P8NIRfjzfTfOIFpg5KPGRAkSEY+ObohzxM5Amab5caFr2sIvbOz5wPkt0CYnV7Gk0dpCWQh6WLJ2376/1Wm2SD0u+FiLSsi9bo09tSU/Fc5qN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788867801; c=relaxed/simple;
	bh=4jmuuiTzZp7/X2s+WAjJRXqOnhoKI7hKuNJawEgZhaU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItpIbC3cLzgY4BI5ZRPDrlj2SRCOfGhwDOUnsfSRh+TZUSguYzCf2VHCZqXVVgRYOEqx4ffo7I3sBXCPahnHkVvY2ffhbPoWWe6jrtfpptaqolzSMxDXD7jGFh0xEXkoTn7VJ7YU1Lp6NK91GSkRsy84fV0X9+89riF+TeEx4ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDiVRJYG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDiVRJYG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BF41F00A3A;
	Tue,  8 Sep 2026 11:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788867793;
	bh=4jmuuiTzZp7/X2s+WAjJRXqOnhoKI7hKuNJawEgZhaU=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=cDiVRJYG7H60ZRQR0Ioc/SVVYo2uZfKe04uj2niQIFSJIMDAk6yd7VJaG7iFzk27K
	 VwkdowPl2yACk0QNXb2T+nnFq7p2FWoV3IcLlryZKhI/w77yVcjGUKl61YI/w/YI+e
	 q4SXL5P+VRyeLkp1Q/tx2NjeUOxQQxb1e6HAcO951/UUayybT0OFf8ron3oOZ2irfE
	 tJkvfb2AHqDSKmYPZFAOZVKOVy2oEzkrO6myhgPRBvBE1aAubgVXOAVzOLUMa9ByqJ
	 7ZzQD5lzftBenioKu2DHhQuQmywqQlVTMSuUF5EscPYBTnG/DpbBOuMbH+mR//CyFs
	 eI5S+Z8Dw4qJA==
Date: Tue, 8 Sep 2026 13:43:09 +0200
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	Li Jun <lijun01@kylinos.cn>
Subject: Re: [PATCH v5] ata: ahci_da850: switch to DEFINE_SIMPLE_DEV_PM_OPS
Message-ID: <ap_0zYrdl9CYR1Fq@ryzen>
References: <20260908094901.2527974-1-lijun01@kylinos.cn>
 <178886739269.2568643.10668122871048248753.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178886739269.2568643.10668122871048248753.b4-ty@kernel.org>

On Tue, Sep 08, 2026 at 01:36:53PM +0200, Niklas Cassel wrote:
> On Tue, 08 Sep 2026 17:49:01 +0800, Li Jun wrote:
> > Replace the deprecated SIMPLE_DEV_PM_OPS macro with the recommended
> > DEFINE_SIMPLE_DEV_PM_OPS. Use pm_ptr(&ahci_da850_pm_ops) to complete
> > the API migration and allow the structure to be correctly dropped
> > when CONFIG_PM=n.

CONFIG_PM_SLEEP=n.
(i.e. you can have CONFIG_PM=y and CONFIG_PM_SLEEP=n and the callbacks will
still be dropped).

Repushed it with the fixed up commit message:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/commit/?id=f091e60fc986eb12ff632f682848b88da824bccb


Kind regards,
Niklas
