Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E3884DEA
	for <linux-ide@vger.kernel.org>; Tue, 23 Jul 2024 00:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721695204; cv=none; b=rO0iFOjAwr32Rt/BBK0Z2RjnUSE3Az8Q3Hq9hy9+3NgkNAHw38fsFQOzyFoC8dV7C3i4XFgQUhvQdr3WFFTn3Ol00RSxazqp5drWKCt+L/y8jv+CUI0a3JelzfErl90Fhnv4O9eTva+FTkNVJaB7K4QQDfhBHvubJw46tXrG6cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721695204; c=relaxed/simple;
	bh=MeBI/D1tamTuxSCQ5R1jpSUuQ4jSkputTyxvAlqBxRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=loyHJYS/TROcHG+2Ci24SGDZz0f6ycbGfHF7xm8R7ZNRIXZPtO4NlDgDVW/jxanveq0wXx9+sElQQBNPClebQO6I0ak6eq6hd0B7pzLoBFsr6ZiBKdpOhLgy4RSeSJL3mg/UqpAPHKQ+QJ0CeYc52VIn6poqUjRVxgeiAFHcbaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3Q4qvm2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3Q4qvm2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E576C116B1;
	Tue, 23 Jul 2024 00:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721695204;
	bh=MeBI/D1tamTuxSCQ5R1jpSUuQ4jSkputTyxvAlqBxRw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=A3Q4qvm23x2VrnDvnugg4dNm3tQw/CbM43wfOhin3DcxsoLywBpV+9Vm0j+jx8utP
	 tjjBl6PnzKC8L8S37Qqv+3cPLSGlY1c697lIBa17Q9iBDFP6znz8Po1uhzUXZks+Y8
	 fDSPfSSG+sssWJ5pnsXpru+FuhE4PgW7Kow54Beb6WKnKvPuWRjGxpvGCf50WRkGh/
	 bO0fXBuxHaF9YuCNsWa0Xcd9GtoEqwDydjmH0R2e3wmNWwYNODulJ60p2Aw9Z0zTqv
	 QXbkpc7UgIC0MGJ0CdkmY0TP8omE+DLmM+ifQbXNbb05wQEWmDOllhvYHvtr7faIjy
	 esdzHlVwv7hbw==
Message-ID: <6eb8186b-7fd9-4713-9c52-da835f222681@kernel.org>
Date: Tue, 23 Jul 2024 09:40:03 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] ata: libata: Print horkages applied to devices
To: "Robin H. Johnson" <robbat2@gentoo.org>, linux-ide@vger.kernel.org
References: <20240722013412.274267-1-dlemoal@kernel.org>
 <20240722013412.274267-4-dlemoal@kernel.org> <Zp7PjJ0dJidXmY7c@google.com>
 <0abbefb8-351a-4be9-90a7-bf26dbe969c7@kernel.org>
 <robbat2-20240723T002725-219465571Z@orbis-terrarum.net>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <robbat2-20240723T002725-219465571Z@orbis-terrarum.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/24 09:28, Robin H. Johnson wrote:
> On Tue, Jul 23, 2024 at 08:10:01AM +0900, Damien Le Moal wrote:
>>>
>>> Should this check be '__ATA_HORKAGE_MAX > 32'?
>>>
>>> When __ATA_HORKAGE_MAX is 32 then the last horkage bit will be 31.
> Do we need to save that last bit for a future expansion? ATA_HORKAGE2?

I do not think so. When/if we end up adding horkage bits beyond 32, we can
simply convert from an unsigned int to an u64 or a bitfield (bitmap).

-- 
Damien Le Moal
Western Digital Research

