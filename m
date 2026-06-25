Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7D613D886;
	Thu, 25 Jun 2026 01:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782349339; cv=none; b=qRKpu2ssuy3cWWe+dZ5m71Rftk8mQ5LabUhxE4cHGzG3ppZ/ogqNVwpzXwClJ6FRuQkLY9JvbVP0e+sfQw2hetyf4w0/+qQ81NwzDoR90t8cWxpsOrq6MABV1/Z0gqRrJY1rJg4YvPvoTKDMoJtzLCDvO3UZOduArcZBpajkHPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782349339; c=relaxed/simple;
	bh=4aBdcP/yzHkDazmvlvndiSUoGIy1y+NNUECdwWYhsDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QkPi9D/mRAJX21AQ/ATc3wURfp+lQPmyDgnJ/XKt6hPvJsQDIc7YL66ztfkW/ko57vg0aY5ZHmD3Dr8i0py59BTEAlbqV/a2Etj7cgZQYdq0oOkDUBXZKtUS0r65Hwsz1OypjfRKEfT5LQx31IlHcnEYfZab1JZuZqttwy1cXMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3e6pcdu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3e6pcdu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5151F000E9;
	Thu, 25 Jun 2026 01:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782349338;
	bh=OzB30Fgc+XGx3ElMWQ3lcxs0gbB9egP80rQZ1i8ruK4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=H3e6pcduLKvTNn5nP4q3uJR1H2LHcacP4ZEmzHC1UVbgZV1iST7vpXegrJ3u5AZcI
	 nolgEoV+5jaM+QXsNxSwHg/eKvN57iVBlmjemVj9A5HU6N6BOja4H7d5tq0CsGRQWg
	 m1walDKyZfbaybtQ4BCWQ3lEdHMfShM85mnbC7NjrXtjqlB8bymb1SS0y72SYZkGdK
	 uysdqAwL/eCPZ/iA8waDLl/zvnZWuf+znU+sJId781OH+zHzWmZktgaRta8IH1PKOY
	 tRkWCoqSSzBRojNAtCA2Fr9rZ/fUuUBTsCKrO8OcdemcI0drGJIcNf1Q4sIAkP9MvA
	 fGm7s/8Z2AFFQ==
Message-ID: <13e1821d-487f-4fee-b060-da57edcde205@kernel.org>
Date: Thu, 25 Jun 2026 10:02:06 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ata: libata-core: Reject an invalid concurrent
 positioning ranges count
To: hexlabsecurity@proton.me, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260622-b4-disp-1b9ba697-v3-1-14ac65dd4413@proton.me>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260622-b4-disp-1b9ba697-v3-1-14ac65dd4413@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/26 12:23 PM, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> ata_dev_config_cpr() takes the number of range descriptors from buf[0]
> of the concurrent positioning ranges log (up to 255), which the device
> reports independently of the log size in the GPL directory. The count is
> then walked at a fixed 32-byte stride in two places with no bound: the
> log read here, and the INQUIRY VPD page B9h emitter, which writes one
> descriptor per range into the fixed 2048-byte ata_scsi_rbuf. A device
> reporting a count larger than its own log overflows the read buffer (up
> to 7704 bytes past a 512-byte slab), and a count above 62 overflows the
> response buffer on the emit side.
> 
> Bound the count once, on probe, against both the log the device returned
> and the number of descriptors the VPD B9h response buffer can hold
> (ATA_DEV_MAX_CPR, derived from the rbuf size). Reject an out-of-range
> count with a warning; this keeps the emitter in bounds with no separate
> change there.
> 
> Suggested-by: Damien Le Moal <dlemoal@kernel.org>
> Fixes: fe22e1c2f705 ("libata: support concurrent positioning ranges log")
> Fixes: c745dfc541e7 ("libata: fix reading concurrent positioning ranges log")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Applied to fo-7.2-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research
