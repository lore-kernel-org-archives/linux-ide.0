Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC181BD9CE;
	Wed, 11 Dec 2024 04:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733891030; cv=none; b=hbZhzD8AJjrUcXN/fT6rjWEaPFkzmzg9yJ7NfW4JUOf9wFDwkqrwAcepkvGoLZWZmT3G+HqtEkQzo30lWQXngDwGyk4/FxRinXse0jF65XawJK3PqgiZtR3cEQjgdA7rKvcE4hprucAkIiRbQrm0Aa/CW3V7r5Dfp4HxpZYr9ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733891030; c=relaxed/simple;
	bh=PrhsrtoLo69mwiq5Qg8GJXNOsG39x6mcu3hXohnoYO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ju/Bd2AHuo4YlwLTgWLcW+6J+h/97TtlezVqQ4TLcN7vBOUnvE//LYGa+UgFNka3lcBHlOBQgmZZ+tpzVQIHAKl5qoS2Jv0jNtAKUTyB7v3xDQv8jV0LQdNlhiu+Hw+lOrfoPKWPVzo9vzyAiYHpcxyJKajEd9FMXoMvI7XYx8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oflfLbQl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oflfLbQl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A1BC4CED2;
	Wed, 11 Dec 2024 04:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733891029;
	bh=PrhsrtoLo69mwiq5Qg8GJXNOsG39x6mcu3hXohnoYO4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oflfLbQlIZcvXPzuwv1UIXGkaxRnJgT3R+hD5IdUMLtOIU8svyl0e7lExcRZvprJX
	 OhfX1k8LYjfZ0UIM8W7snTamfkrJDhYAfxth2eV064e4d0tBfagDZPRWtOw5k00cMh
	 w9dvk+N4pElPO7wdZkcP6fgS5CWEOX1ufY2l6nl0Yr68lBKulcSKD5EDLC+TNvrI9f
	 DWZ+L9+r+zvxGlnccdB6sSHAsGaUdzuUnzxx9umY9U2w0goNYQXPp0me8eHXLOYQ/d
	 JKowkif/hu+wjp4BVCZQR1FL7awoinqmeKucHNs5egzJv5adK3Xc/0VDHJovDpazhk
	 olhQVNzpOVnZg==
Message-ID: <8c39204e-ccbe-4dfb-9985-ce8251445c8d@kernel.org>
Date: Wed, 11 Dec 2024 13:23:22 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: sata_gemini: Remove unused
 gemini_sata_reset_bridge()
To: linux@treblig.org, linus.walleij@linaro.org, cassel@kernel.org
Cc: p.zabel@pengutronix.de, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241211011201.261935-1-linux@treblig.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241211011201.261935-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/24 10:12 AM, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> gemini_sata_reset_bridge() was added in 2017 by the initial
> commit be4e456ed3a5 ("ata: Add driver for Faraday Technology FTIDE010")
> but has never been used.
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Applied to for-6.14. Thanks !

-- 
Damien Le Moal
Western Digital Research
