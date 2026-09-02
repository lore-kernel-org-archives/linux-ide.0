Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A334570C5
	for <linux-ide@vger.kernel.org>; Wed,  2 Sep 2026 23:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788392119; cv=none; b=k81c1kbflDN9/v4ew7P5tRNwu+m9A55Y9HKK8Bpmaky05hmOysuvgqb45Fxq53/XNm3dPBgdJVeYei4su3tO9fTsjic9YVUPWbmAVN4ahrHv/9x2Y3wSiu/Qva8+D9+9YUip3z7cUsmKipzq/i1utYFoaHpenCI9LZXGtUEdC5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788392119; c=relaxed/simple;
	bh=INiPj+xHOoKIn0qdIIAvuWci4pAo4MpW4Sa1N7lHVg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rwzLstJgEQQa1xHV7nMgh7fJnXixB6xmSdRo44yVsYLPZ8IccxphLP5J9LQ8XFmd0Z/VVe386Z00zsMBYG5mNA6VruikHDHLk+7RwOHw7RedtAjw7xYhCo3bEfPlkzcV2TvLDcf186mE21dJrR44hL/EITRO0cfLWrL2v3Gv/Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1pJ6Fvt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1pJ6Fvt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04281F000E9;
	Wed,  2 Sep 2026 23:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788392116;
	bh=fVY26QZhYUkvnJhjY7tmTCvu6MbyWfm1+asvXuT1RC8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Q1pJ6FvtyN2dvbaXzIuiFXz7znmf8hGVeZmsMm+42SYqGj4nxPNNz9uvnAUZc2DzU
	 EHCkeginmnB6qq6pSEdSMUx75HGcM0Xpil1aGyYA361SE26uoNKowcbFD1DDNfZniv
	 K9AjhBuaICdMeInJVAU3LgsPG4DPTzYXI/NX5tS9xRkFz9H8ukZFFyZaj65zRSjXde
	 qhy7Q3pP2jCX5NHpnX5h0+O3ctIVz8Tiva/EY0rdvRa4tq0+6HOIJEo7U76U2YQ4nG
	 wAUok784pcFqfpgHbVGcIXEIxLZXHH2HrSw7Qeis6HHo1hkNcfxQgSNzF2gqsfzS8l
	 G7LWUmhnOZJuQ==
Message-ID: <32add842-ca4d-47a5-9661-72c2085a514a@kernel.org>
Date: Thu, 3 Sep 2026 08:35:13 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-scsi: do not raise UA for storage element
 depopulation and restoration
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20260902020828.1436048-1-dlemoal@kernel.org>
 <ape2oGgWOqfHYx9w@ryzen>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ape2oGgWOqfHYx9w@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/26 14:39, Niklas Cassel wrote:
> It sounds a bit weird to repeat translated twice. Perhaps something like:
> "
> The libata command completion for the ATA commands 'REMOVE ELEMENT AND
> TRUNCATE' and 'RESTORE ELEMENTS AND REBUILD' is handled using the
> "
> 
> 
> No need to send a new patch, just tell me and I can fixup when applying.

Oops. I really should better re-read what I write :)
Yes, please fix it up as above, it sounds way better.
Thanks.

-- 
Damien Le Moal
Western Digital Research
