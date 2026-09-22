Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B436E390609;
	Tue, 22 Sep 2026 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088792; cv=none; b=aAh1Tr7QzG+tuitiBJe01qXKA4oHfJ60x9vTtuCqjdu7vQ6YnfWtzPAdafSdm0b8RnGhORYWSM4BJqf5ZJzYfSeNs9wzjZ1Ts8xmZ3cL4kgWCAWaFHe5C2TdR9R91CdXwgacI2diIVVnZ488xEuMQ6zv+O70Xo3Q93rIpYSuvFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088792; c=relaxed/simple;
	bh=+lEw7mJyRhd/lo6EBvoSB9sqc7G34JP86/ycKm+ZmzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONG1L4tUlD/s0b0KJmm41VUyC27V95rGGqH16rR4UJEBZ/8Ugq0DSnFw2birDIXIF+UdacDY/oLw+EcViSukjCL7QbgrK+j0Hi0AtsPfcZFtG/CojyF6/rTQ1f63GYVyD6db+TcK4+ISut5HjGSM/hHhjhEIVarPdL4iCxWmEO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Teso46Iw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Teso46Iw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396081F000FF;
	Tue, 22 Sep 2026 14:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790088791;
	bh=MNIzUj+H/4D7L4WZcUVggtuHpI4+FmeR5jq8I48Gyzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Teso46Iwn8LZtX+dg1zOIzktP/UH6EskMRtxm53Mb879GUMXIeVRE+c72YAwPlnzI
	 qSyJG/3mNcKInY5JeyxTfpVrFKNGABeFZWz7wDVRtAh4ismWnaxQDqzBKotkI+KyrU
	 Yk/L40P9+jUM+TgLfIrccMKXP8magr5fm8S6o4pqVbvPsT7nhKSPfo+0j70XaTOD1R
	 y/ttzNtf7+DiPERj9WRA1hMvpIzlSUjsTG4N092aCjyCdPDGJm/6FGXC2G8OlvrAjd
	 GbD8m+gnSd2YbNxcq+63D/5h5H3BH2lE33m4Gq19+FiPeI+ywOTIlmkPcRyhZ2KIFw
	 LSdA0UStNhfQA==
Date: Tue, 22 Sep 2026 16:53:07 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ata: pata_parport: pin the protocol module before
 device_register()
Message-ID: <arKWUwJeXUdGHpp0@ryzen>
References: <cover.1790047457.git.xiaopei01@kylinos.cn>
 <952bac5f61dc69079c3ffe62d6392bcc89f6aac0.1790047457.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <952bac5f61dc69079c3ffe62d6392bcc89f6aac0.1790047457.git.xiaopei01@kylinos.cn>

Hello Pei,

On Tue, Sep 22, 2026 at 11:38:00AM +0800, Pei Xiao wrote:
> pi_init_one() calls device_register() before try_module_get(). Between
> these two calls the device is already visible but the module is not
> pinned yet, so an unload in this window leaves pi->proto dangling:
> 
>     pi_init_one()                       rmmod -f <proto>
>     --------------------------------------------------------
>     device_register(&pi->dev)
>          device visible on the bus
>                                            module memory freed
>          pi->proto = pr        <- writes into freed memory / dangles
>          try_module_get(...)   <- too late, module already gone
> 
> Take the module reference before registering the device, and drop it
> on the device_register() failure path.
> 
> Fixes: 246a1c4c6b7f ("ata: pata_parport: add driver (PARIDE replacement)")
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>

Looking at the code, this race cannot happen.

All three callers hold pi_mutex throughout pi_init_one().

pata_parport_unregister_driver() also acquires the mutex
before unregistering.

Thus, unload cannot complete at the same time as pi_init_one().
So the motivation looks wrong.

Additionally, rmmod -f bypasses a non-zero module reference count,
so I don't see how taking a refcount earlier would solve a rmmod -f.

Are you building your kernel with CONFIG_MODULE_FORCE_UNLOAD ?


Kind regards,
Niklas
