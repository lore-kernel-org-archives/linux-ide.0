Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E1352F6F
	for <linux-ide@vger.kernel.org>; Wed, 31 Jan 2024 07:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706686711; cv=none; b=hVQR0DP57w3lUTwuwCzunGfNI+Uf4dBqa839ZrY3RuOqp9DcP3pM6J/OSZ0Yf7CZeMaH66PWxHo/dMiRm5S/pSn4z/QpEusF9xo5UW2ldvvWEmCeKrfyqCKVfN6ULa9mMgMuPSXTUYpHAahrXeRX8rWI3DSwkSqZIU1HMbcuMpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706686711; c=relaxed/simple;
	bh=f0Gu/cyfDSzPqnKlxnlRGsqamvy0PevxKq7skAXsbfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X4bqAiDw2hN27JbiV4CY9RFNSot6snd/AsZCYngsB0shdgzIgj94A/Y/6UGkw63n2lVXvBrxLNy7Uh6f8xkAxM4NgG9bY2MUXTMvya5Jk9lDpdwvJr79sqJQ1U1J/TJY0aGpVgjwdhT3gBgCeoMylhuFVxYjq6lSCr7K0nrnXik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyiC5PI0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyiC5PI0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3525EC43390;
	Wed, 31 Jan 2024 07:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706686710;
	bh=f0Gu/cyfDSzPqnKlxnlRGsqamvy0PevxKq7skAXsbfU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=nyiC5PI0MnggnRMrNQZEcBH2HUqCoJDPE7DyFwB1kOhXlaRGr8lC8M+pzY7jeGl01
	 EYgEXhAMSrkAqzjW12wIZi0qKQ9Lgx95OwQ1L0fLyBj72Uemmrrbu9NBtdR/XLdJCn
	 sIQXI5rgMol0bKGXJTV52iWmUeCDQzP5PXhQakNiwdx3kXnwbajAbyINDwoB2g+vTX
	 t1cikWdIJi+lV2tlnTT9MvoOYRFi3hoygnztIln56jnpm+skLwzojsZ5uSA0ZrTAPD
	 A9k0WCJYKcIYODZP/yJ92ZqY67uxlagXfooKsu+RVPbdtZeH2ElcWFRjoTowMtEXEs
	 SgLE4mm26P/fg==
Message-ID: <3f7cef2a-5ba4-465b-a1f5-77e2bcc50ddb@kernel.org>
Date: Wed, 31 Jan 2024 16:38:28 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Aw: Re: Re: [PATCH 0/2] Power management fixes
Content-Language: en-US
To: Dieter Mummenschanz <dmummenschanz@web.de>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20240111115123.1258422-1-dlemoal@kernel.org>
 <DU0P251MB082515FC8FE77424231B475CF4682@DU0P251MB0825.EURP251.PROD.OUTLOOK.COM>
 <345be856-8959-4148-bcae-00b3fbcd0d08@kernel.org>
 <trinity-0be6e8a8-e6d3-4d60-be0d-59592a9edd65-1706010022623@3c-app-webde-bap10>
 <a72daedd-48c4-4eaf-9a77-a34679636a8c@kernel.org>
 <trinity-0df92d73-be55-433c-bdb2-4387f7ea590b-1706686178879@3c-app-webde-bap43>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <trinity-0df92d73-be55-433c-bdb2-4387f7ea590b-1706686178879@3c-app-webde-bap43>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/31/24 16:29, Dieter Mummenschanz wrote:
> Damien,
> so I've applied the patch to 6.8-rc2. Interesting thing is that the behaviour is 
> exactly the same as before (w/o the patch). Besides not 
> honoring CONFIG_SATA_MOBILE_LPM_POLICY=3 after boot my system refuses to 
> transition into lower power states > pc2 after resume even after letting it sit 
> idle for 10 minutes. Transition is only reached after issuing hdparm -Y. So if 
> the patch restores the original behaviour then why did it stop working?!

Interesting... hdparm -Y puts the drive to sleep while the revert puts the drive
in standby state. Sleep is a near complete shutdown of the drive, while standby
is not.

In any case, I think something else is causing this. Probably PCI or ACPI
related changes. So a bisect would be needed to understand this. But this is
going to be very painful to do for this as each test take a while I guess ? How
long do you need to wait to see the system going into low power state (when it
is working that is) ?

Also, which kernel version is the last one you know is OK ?

> dmesg:
> https://pastes.io/1vmmvhvfub
> Regards
> Dieter
> *Gesendet:* Dienstag, 23. Januar 2024 um 12:52 Uhr
> *Von:* "Damien Le Moal" <dlemoal@kernel.org>
> *An:* "Dieter Mummenschanz" <dmummenschanz@web.de>, linux-ide@vger.kernel.org
> *Betreff:* Re: Aw: Re: [PATCH 0/2] Power management fixes
> On 1/23/24 20:40, Dieter Mummenschanz wrote:
>  > Damien,
>  > sorry for getting back to you so late. So is this patch series just a revert or
>  > is it something new? Can I patch and test against 6.8-rc or should I use 6.7?
>  > Anyway I need at least a couple of days since I'm very busy ATM.
> 
> Yes, the second patch is essentially a revert. If you can test with 6.8-rc1 it
> would be great.
> 
> Thanks.
> 
> --
> Damien Le Moal
> Western Digital Research

-- 
Damien Le Moal
Western Digital Research

