Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475AD3F58D9
	for <linux-ide@vger.kernel.org>; Wed, 27 May 2026 18:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779907417; cv=none; b=GNttELqg50pR8wIQ4zxiT9qQ6TE7IUBpKmpR8mFwWAGLN8ArIck7j1KPNFzUJ/DpCXaVDfXRsH32q/lnL9JbLMBvUWgLQkMLGz1H/mt+23wJ52pLsexpjN8JEK1lwDNnEroNAwmqYv7LB5+tl0IUZV4m4yCwJFL27jZBrOdBe2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779907417; c=relaxed/simple;
	bh=gEgOxKZaGNnNy69Can6SNKLsrcgeaGJRXrkaiCSrmTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1Dr9rjqaxP39vLC9GKHmVSAf4XndCEw1EpgrpDrn65QHgqTqmHG5ukhxBMyuYBnPbWYBMe7ZVkFlxl2a8FFwkXA3QP2L0ndmbypEUbdRlL1j4JheaapsVYCvTnQkPWDjYdPnfjP0fc1dRInPhrYj86u1MTNBUseWpKI4CFi5os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSsdU20S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSsdU20S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BEF51F000E9;
	Wed, 27 May 2026 18:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779907415;
	bh=Rh+4Gs3ZdWdkNi6QYsLqJatLmlBdDMMFGJ7/oJK8mtw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GSsdU20S+LYS/aOul7LG6w18a38j3X68P77Xk/Oh50MtfJUe6R/EHuITb3eCAIW1i
	 LEZOIjZfRS/enjs91h4/y7ECy0BQhis2OVFziyCdWifPcfNngDd5kxvbA3bHwuLAl4
	 xNF/+y1MMlWhYWd+Xx8gwH1Jczr9CpSbZS3e1A76u6Z6Luu/zgcS6oxdV9zLtw3ll8
	 ux+3v+UDu8JtkxA+aVeLyPC2gFK1MAnnnDE997J+O8nYL33JdWN1TlVqespnanSr3P
	 3ISZWyeddx+ErXKZrKKGjri260i5HyFW39P/AynG198shc2fdkLco0pFRE257ESIeS
	 zsBDtfi+TWWSw==
Message-ID: <ad5c6534-d161-4c17-81cf-dd2b944ebe9f@kernel.org>
Date: Thu, 28 May 2026 03:43:33 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] ata: libata: Pass the ATA port argument directly
 to __ata_scsi_queuecmd()
To: Bart Van Assche <bvanassche@acm.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Marco Elver <elver@google.com>
References: <20260521173347.2079560-1-bvanassche@acm.org>
 <20260521173347.2079560-3-bvanassche@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260521173347.2079560-3-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/05/22 2:33, Bart Van Assche wrote:
> Prepare for adding lock context annotations that refer to the ATA port
> argument (ap). No functionality has been changed.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

I do not have a strong objection to this patch, but its justification without
the annotation change together with it is weak. This change is introduced
because you want to add a __must_hold(ap->lock) annotation. But why can't we
have the annotation be
__must_hold(dev->link->ap->lock) ?
Or a simple lockedp_assert_held(dev->link->ap->lock) ?

lockedp_assert_held() is for runtime. I am not sure if this includes a
__must_hold() call for compile time checks, but if not, what about defining a
lockdep_must_hold() function that does ? That way, we can have both runtime and
compile time checks.

And a similar comment applies to patches 3 to 7.

So in the end, I am not sure this is needed. See also my comment on patch 9.

-- 
Damien Le Moal
Western Digital Research
