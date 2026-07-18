Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1456F846F;
	Sat, 18 Jul 2026 01:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784338702; cv=none; b=n/Vz6EK+wJWkqEscHAQmhHJJR9eTREbkIRFLKgBxKpNRVg2Y30cK1YksRid6BlJvNYe/3d5v6OvBwu1y2Vl+wpRDrnH/ngzCrG0/OCY8JxPnQOOSI2fswJaFB3I02DAMB2/CTfT9GfKwV54m0OHnof/+LR7je/t6nlBZs8q22i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784338702; c=relaxed/simple;
	bh=4DAkOeI1OCrboqGoXdr71fPS/sgIkrw3xOJvxP2VwMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eEkiQy/Ww4ga0aka1G/WAlyJ0MlVoX7pBcVM+xnISH6XOQ5IohPaw9FZS90O4MXz1PIrA0SG+czixXztCuXewVSPKrmwOlzwpDu5GVfL+eHN1rjsU/SPoLoHBJrC5i53DAcDTihs8KYILyvBz0k4nhmwNBvxQLLvfffBwqeCF0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FT+RDH+f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FT+RDH+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB431F000E9;
	Sat, 18 Jul 2026 01:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784338700;
	bh=UOcDZJKdzSX2P8isU2o9Rg0QCcU5CNA/SEKsxvnXaa0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FT+RDH+fCqseFYhVzzXGsEkbqa4MDWzeqdrIP9+rcyc6eyS5q5bz+j/1IRv0gH9vw
	 snCBDQCF8qmLDkTzJmEXcZsKt+FW1nGR/SwbPpr/Wy/9vmtIJOEL28cewWl7Dp2TNR
	 8lTQ28ZfYq2rMUbDsq/zfIPXSCvVfMwVOiUboKeWwaxaA1UGVLQ+6qEyxJBDxdHZ6H
	 bybja9j6TddVjLaLtxa9pPT9wMKoH63tZxuE0VvmnsHV9ApqZ4SgPCRHg2Wq0BLRwG
	 GbMfCUq0zuJnltizFLA21jgY8fS28mBzZbplHcsWarS2V93gvzrkVG2JfdT1LDSKRM
	 g6mGrXXAXjANQ==
Message-ID: <9ea6841d-6157-49dd-9b32-60d7c70e7b10@kernel.org>
Date: Sat, 18 Jul 2026 10:38:17 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: sata_mv: accept 1 or 2 resources in platform probe
To: Rosen Penev <rosenp@gmail.com>, linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20260712223137.1058531-1-rosenp@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260712223137.1058531-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/13/26 07:31, Rosen Penev wrote:
> Board files in arch/arm/plat-orion, arch/arm/mach-dove,
> arch/arm/mach-mv78xx0 and arch/arm/mach-orion5x still register the
> "sata_mv" device with two resources (IORESOURCE_MEM plus IORESOURCE_IRQ).
> Those devices are rejected with -EINVAL, so SATA no longer probes on
> legacy Marvell Orion/Kirkwood-style boards.
> 
> Accept both 1 resource (DT, IRQ fetched via platform_get_irq()) and 2
> resources (legacy, IRQ supplied as a second resource) so both probing
> paths work.
> 
> Fixes: b3b2bec9646e ("ata: sata_mv: Fixes expected number of resources now IRQs are gone")
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Applied to for-7.2-fixes. Thanks!


-- 
Damien Le Moal
Western Digital Research
