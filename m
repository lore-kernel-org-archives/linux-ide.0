Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D85377AA0;
	Mon, 28 Sep 2026 06:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790576662; cv=none; b=MBBUs9Dw7gmGlSCGiT8q+dHf3pE7lVeorQWi1F/o/9m9XC+DvyihEInHXlhetDcOdfnkrwy2Cx6CivQnXMWNfYL44f9XAJjFBulIwY0vta2VJD9DWQX2KUam4t5j/NIcCeRVOyxKR4iF8JcS0io9JDiqy4+Ke37kgX/InTs5O24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790576662; c=relaxed/simple;
	bh=2yCI5kDyKKqm4LMnhM1q/m9II46lMnCFh8Nyzy0eybs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dYBPuc44Z+OqmZuDUSqybzacqHrhDRrtMwsbWcnqY31wbryqWQVur0/moCC8SfgdTXeJEo/mT4xiPMskaJQIqL+3npnFNRE4D2+COzh2tlrzqtaHNvTFsmFq/vwdb6FlGLZ7eiRDRlM7EfFDVoTj8K4Zro4vCpqDCeeE6GAZ0oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQCQoD/E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQCQoD/E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9891F00893;
	Mon, 28 Sep 2026 06:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790576661;
	bh=HiKp93oyPtjKtRe7Vj6mhUt5qjm93XM2SZZY195cT04=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DQCQoD/E3mjONKKcOruR+0BGkj/Dh3HyIvQ44todIpIS2G+s6DAiUlEhNa2lq/v1I
	 SZeFY+ncmACvRAofHJNOTlJfUuWePErHtS1VsZh2RB05dcIqLBau2VYWdwZC741jlp
	 hx4wUEi3QGI8gXi1tN9Wfq2+ZAjdLwjr/dEjCoqGY0oYLzPNFd0rJHvjE/R1VVmBGr
	 qVSx+4dPrDTB6a5z3T4mG+LXQM7EzFTGourw7OvybrmB1r9wqUaJyOa1Q5R+1bYcyK
	 0dT/ec1T6ilyA+IlraYiZf1x9lPG/+RoudPnIeyxdxLHlB6OD0ixRPURNze/C9gcjo
	 oDOe7urG0Ohdg==
Message-ID: <f15b895a-ec2d-409c-aa52-2cd7cc899b61@kernel.org>
Date: Mon, 28 Sep 2026 08:24:18 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata: Fix scsi_done() documentation
To: Bart Van Assche <bvanassche@acm.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
 linux-ide@vger.kernel.org
References: <291519238580d795929d44437f3c863403d14e1f.1790359497.git.bvanassche@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <291519238580d795929d44437f3c863403d14e1f.1790359497.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/09/25 20:05, Bart Van Assche wrote:
> In 2008 the SCSI core was converted to use the block layer timeout
> infrastructure instead of its own infrastructure (see also patch
> "block: unify request timeout handling"). Since then, calling
> scsi_done() while SCSI host recovery is in progress has no effect.
> Originally the REQ_ATOM_COMPLETE flag was used to prevent double
> completions. Today the SCMD_STATE_COMPLETE flag is used to prevent
> double completions.
> 
> Instead of mentioning that calling scsi_done() is not allowed while
> host recovery is in progress, mention that it has no effect.
> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Niklas Cassel <cassel@kernel.org>
> Cc: linux-ide@vger.kernel.org
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
