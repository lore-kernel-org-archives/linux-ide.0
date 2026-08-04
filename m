Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E618943E9FF;
	Tue,  4 Aug 2026 09:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785837185; cv=none; b=g1Dbp28OqQJB/t9Wc9RXiwaYZB7n/4JXTx0FUVfBxX3oRTzip282PUxdD0p4NvvEX+WLLg7HdvQvEp26UeTIfKEWbquPMfsfc2WAsM8psMWfBDrdALxumUYF96AUVijk5N5yPV0uQVJMqHlKZs6wpxnBVIJ20uEmMV0irFOyIjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785837185; c=relaxed/simple;
	bh=V1ppXudoztMnTHhGuVNpn2/gCAt6c7NG96fFWxkOiUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OZJv2UsiHraw1v1F9x8jDrlsdyZVG0vQHVVRWZrVKnKbc4HJVFhYpLQVEhKCqFA/tIOZ7pvvxrZLVHkE7cC6uZJl0n161itbakGJVyLjp5u3kCBZO7XC20XHkoGnixqnV+6dIp69aXGagobbfGKgP0aUvprHm4fbI0Y+eCdugEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cr5IoQou; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cr5IoQou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E47F1F000E9;
	Tue,  4 Aug 2026 09:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785837180;
	bh=KKs7/7JPE7yApYKmJ22DDhDRKAYk6ZDvY361JWQTCMY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cr5IoQouwnNKQ/LUPneXYtM0T4Fpunh08csXrOFYfY818p7CMFG1/TFGycJxO7NuM
	 n0he0TA3/RnkDrPWjfrXY63kQd51ube9mpkGx0QfUUKUzyvRcCdP/gsDIPqhjSjKis
	 S3u58Jo1FT9J2g9jwHq7O50cSi6sFLEPm0tardmLUky6cU8iw57Eb3pe+oW01ynhlK
	 +TaDPBcZO2a88c3+YbUetCuowcanq9MW+iXliBvuJDO+CFWu5EEx6lC45T/4sfINAR
	 hbAIOosntoL0arOy8jx8bsOh/hfOltSUIe7MlaNuoGALgvBVRIYKkC4eIdMa+krYy8
	 PIudn4//SNuXA==
Message-ID: <2008afae-57ee-4e61-a433-b3cd4aca27d6@kernel.org>
Date: Tue, 4 Aug 2026 18:52:57 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: use named initializers for acpi_device_id
To: pzalewski@thegoodpenguin.co.uk, Hans de Goede <hansg@kernel.org>,
 Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260804-ata-acpi-v2-1-8825e646b80d@thegoodpenguin.co.uk>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260804-ata-acpi-v2-1-8825e646b80d@thegoodpenguin.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/26 18:44, Pawel Zalewski via B4 Relay wrote:
> From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
> 
> Use a named initializer for the acpi_device_id fields which
> makes the code more readable and consistent with how lists
> are initialized in the rest of the kernel code base. Also
> drop explicitly setting fields to 0 where it is redundant.
> 
> While we are at it - unify the list terminator to have
> a single space between the brackets and no trailing
> comma.
> 
> Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>

Applied to for-7.3. Thanks!

-- 
Damien Le Moal
Western Digital Research
