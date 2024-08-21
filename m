Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC65116CD0A;
	Wed, 21 Aug 2024 05:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724218606; cv=none; b=RVcFyp3v9kkQH8pFk8OEYdCoxRHsIEw+oRN5v6zLLOSJ8JiSmPSTPtTg7w5RjvAvPDcyuUkm68+KPAP6qEuoCCKGHnlMrDpWoT/P/PcdUaq9rx5Zn67D/VgE0n5BnW7/CJfmsGSQgip/gYJRx6kjoxbDQkNDpuhuN6l7Geqq28A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724218606; c=relaxed/simple;
	bh=u6wlsGPaSbN9mix3uszAEpIzPI363xr5NjNow1rz6BA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1SIrGdB9KzKSlIftxIBd1fOJSHNi9ShrWhJ8+5KXbAVexpLAO/Anhy+SEYlocWCmDWVBnhVPezm91C7TlKs9Yyh7OALCYl2fqBsT2BnSLho2eDosMgsTP3aBR2K0d2f8tnaGOwBw3ec9R1qJJ5aluZIz6rsHli0VPH+j8Y5SoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9H/2WAu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9H/2WAu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589A9C4AF09;
	Wed, 21 Aug 2024 05:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724218605;
	bh=u6wlsGPaSbN9mix3uszAEpIzPI363xr5NjNow1rz6BA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T9H/2WAuntRz/eTIOAmelXDyCsguiLrb7bV5S0oWsYfpER0pR23CkmaiYif+mb9IK
	 bKkAbc1UC7X7uSF9ViOcTmdUts1R4OoQNpYpsGFwlaN7afrbhIQ7EyFRYQKGbFP7dD
	 LVb3XMUh2XIyVjdj7GR+SN1YbGp6tdPvUVzCe0+bdFrdgtSzf77nO4qZoQTU4OLnDh
	 xZnJZWLCjfxZeMXXlvmlsEhHzbqHpCQbRh5j3Qg/qDZ/oqg2XxtTHcgyK+GRj/Odyf
	 x43gWQpmZ1vuoHVvo3OXryp8sFHVYy22gE8V9oad7lRnyqapiVJ4gtHYok6z+Q7bss
	 W1liuyBukGHAg==
Message-ID: <aae0353c-0d5c-4acf-be44-3690a0c50613@kernel.org>
Date: Wed, 21 Aug 2024 14:36:44 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: pata_macio: Use WARN instead of BUG
To: Michael Ellerman <mpe@ellerman.id.au>, cassel@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, hch@lst.de, linux-ppc@kolla.no,
 vidra@ufal.mff.cuni.cz
References: <20240820030407.627785-1-mpe@ellerman.id.au>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240820030407.627785-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/24 12:04 PM, Michael Ellerman wrote:
> The overflow/underflow conditions in pata_macio_qc_prep() should never
> happen. But if they do there's no need to kill the system entirely, a
> WARN and failing the IO request should be sufficient and might allow the
> system to keep running.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to for-6.11-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research

