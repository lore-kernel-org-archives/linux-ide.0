Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B3323536B
	for <linux-ide@vger.kernel.org>; Mon,  2 Feb 2026 04:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770008253; cv=none; b=T80OT4Tog2jYhLTFv0rg3bvqz8xXc9Dnw8D6YF8NMxRDn8y+sR0oclJtrBVCgiDgdLwnpgDGebpk5IG+hGDE/9H5PU3539zl3uHRstP/awSQieaVZSRKkbODrKxN/4ktdrSHep8phawTcY/8MZrbmzKLh2XNq15+RBvG1J6o7KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770008253; c=relaxed/simple;
	bh=tjIvPi9BpQN0DJOfQpdvrJmcBfOlny+hAXl9hmtqR84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQRCK6RY2p1zqiOEzivisaY9LOoNO3qNxrQKsSO7cLxeyZlJ6BLi7Z65cz5smT2vjW6sdWUosILP1QM+b9RIr6Gi5qcPIvu73Q6CoRwAQ8tgwNQTrstD6aHaWgRwMJQvdyHwE977+vVS4/fVjjKmJQBlEb6lVfRTkjiHZu1NNUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Je0Hw4Az; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Je0Hw4Az"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5B0C19421;
	Mon,  2 Feb 2026 04:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770008253;
	bh=tjIvPi9BpQN0DJOfQpdvrJmcBfOlny+hAXl9hmtqR84=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Je0Hw4AzSPpHG20PFGza291KVwT/MZ+OuB0eDJhaCzeXNoXKml0JZ4EJN4mw36JUP
	 9LGG2X1K73eopGGYpUZ22MvDCNYIgJMvawUj6V9om2b6axEPn/jwW1aEd+eP/nj/TZ
	 oSGKlzYb76AN2/ys5GQvhWNIsDiqsUJGsuZ3+1PuhBQN1Mc7ga4qkCe0pBUY2ooAfg
	 KYoH8vwC/ast353m5AAT5Z+QTqmQk3RcxQsP9el1s6vCX0820MLeErvznmw4WAS6r4
	 Wd+UA7uIrSjFfRBXsFmXdlkiKAYbulyHWhgWG3hFdpvjpCJ32ibxSN5gJguv5BZrhF
	 cHJQJd3C8SY3A==
Message-ID: <32a46d9c-1c60-43c0-825a-4482bd133c55@kernel.org>
Date: Mon, 2 Feb 2026 13:57:31 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: pata_legacy: remove VLB support
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
References: <20260131004732.19198-1-enelsonmoore@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260131004732.19198-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/31/26 09:47, Ethan Nelson-Moore wrote:
> This significantly reduces the complexity of the pata_legacy driver.
> The VLB bus is very obsolete and last appeared on P5 Pentium-era
> hardware. Support for it has been removed from other drivers, and
> it is highly unlikely anyone is using it with modern Linux kernels.
> Some of these chips were integrated on motherboards, but they
> seem to have all been 486-era boards, which are equally obsolete.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Applied to for-6.20. Thanks !

-- 
Damien Le Moal
Western Digital Research
