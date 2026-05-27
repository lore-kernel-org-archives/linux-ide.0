Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EB53C9886
	for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779920933; cv=none; b=iCLL2Ng6S5S4inqmScbXwIDwZKJrHQj/knTbX0/m/j6vdp/pc7ZfgXbAPLUdiT+XtyYgyL5FjlvmUIIgiEgwIFL1D/ornFdJHDov9+e9kdjgiyMOuW9Oui2KeKpxEJ/ZE0KjIFoRrRAtTITlhlM82vkCFfqJXeaeEO+C3zeFxG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779920933; c=relaxed/simple;
	bh=HISujUYbbFuJDkmGEuelYhgnklmjWPrWsZC93Q6/OMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZNjKK/ul3PPZZgfhhN9cCO4k7kg3Xfl0zBBIL+IBpChtdkYPgHTgka4ECbO3lLFrFBsrDrnt+dDmbhQc8fnVhmn22Y7vkMx+Et3nmAAt+4Xlw5JrYqWcx8tifEulzYj8CkIEs01aiWjQisJchBJxHDquwp5fVAT7IT2mcMFeTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/u4mwMS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/u4mwMS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28BE1F00A3D;
	Wed, 27 May 2026 22:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779920932;
	bh=5Ggw6aAxieIUi/TaucU9PemZS7S2oWAKU7pldV+Bdl8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=f/u4mwMSrMI/VF2ZrjjcwxtBqXjyk+bgXeL8WzFe0z63lXhZWjFMd/7FfCELfvwjp
	 MdcotS0ZmKcIzCTL8IPo9UPVMLeVk+9DGnAdyfzjM9j0p8/JGl0DcIbFcPHr6Ek50a
	 oDSUA7wbNesU40xYs3z6P2CmOi8BKisdnGvlz4m1atML0wBhnqJJdcl+3rsxVO781Z
	 pTjGIF7sCcGSIQ3p6n6pn2ZQn1jCzLpUCnadNxZAT/3vR3SDc54O4yAz6A3nN+3Bn6
	 7DfWXFH5X3oFm53xMofupHI9RIE8bRi3yIbElYPCayax944aCTnAxkvSaA7kmkhhJH
	 HBxqdwNW4a70Q==
Message-ID: <35f1d7c8-8425-4d51-90ff-d217289cdca1@kernel.org>
Date: Thu, 28 May 2026 07:28:48 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ata: libata: Document when host->eh_mutex should be
 held
To: Bart Van Assche <bvanassche@acm.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Marco Elver <elver@google.com>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Viresh Kumar <vireshk@kernel.org>, Mikael Pettersson <mikpelinux@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>
References: <e95c0eb43a8297c9ab5e220341512882f8648512.1779913278.git.bvanassche@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <e95c0eb43a8297c9ab5e220341512882f8648512.1779913278.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/28/26 05:25, Bart Van Assche wrote:
> Annotate the following functions with __must_hold(&host->eh_mutex):
>  * All ata_port_operations.error_handler() implementations.
>  * ata_eh_reset() and ata_eh_recover() because these functions call
>    ata_eh_release() and ata_eh_acquire().
>  * All callers of ata_eh_reset() and ata_eh_recover().
> 
> Enable Clang's context analysis. This will cause the build to fail if
> e.g. a locking bug would be introduced in an error path. This patch
> should not affect the generated assembler code.
> 
> Note: although the Linux kernel documentation specifies 22 as minimal
> version for Clang for context analysis support, annotating function
> pointers is a Clang 23 feature. As one can see here, a patch has been
> queued that fixes the kernel documentation:
> https://lore.kernel.org/all/177926568868.711.3058599932884307249.tip-bot2@tip-bot2/
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Bart,

Thanks for doing this.
I only have a couple of nits below. With that fixed, please add:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> +		/* Tell the compiler that link->ap == ap. */
> +		lockdep_assert_held(&link->ap->host->eh_mutex);

Please drop this comment in the 2 places you have it. The comment is confusing
because it does not describe at all what lockdep_assert_held() checks. No
comment is fine. lockdep_assert_held() as a name is clear enough.

> +	/* Tell the compiler that ap->link.ap == ap. */
> +	lockdep_assert_held(&ap->link.ap->host->eh_mutex);

Same thing here.

-- 
Damien Le Moal
Western Digital Research
