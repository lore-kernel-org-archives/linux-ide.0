Received: from nick.sneptech.io (nick.sneptech.io [178.62.38.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF3C216388
	for <linux-ide@vger.kernel.org>; Thu,  9 Jan 2025 11:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.38.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736422577; cv=none; b=gxkdlqY0EK/J0KlVrF/AgPop/xoj1VcEM7TzSv7RImDoKhzW28+lgnh/H6KtQ2UtYekvfIyuoeDDnlFgKqxQpxZ/Xa5Cc6OhAV8/qWbSFd0l+rTafCokHJf4QpgzyRhfsWdM7yEjWQICJXcXIPdBtYFkCoLCn5rd9L9S+bH6q6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736422577; c=relaxed/simple;
	bh=L4/tWWV3Pv1Nz4s+69y8Pa8Trzdn5PqCUJnXvytbcbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ir5e7sCfEhJbryU+iTcfsz6MxI6EvWOyKtqaw/N3jSF70XMcOCDb6O8mzJY4JSBpIrqn7Amnm5RS+6DfDhzhMIVBbL25iyXvpmSfUHEb7UFGTw3Z3DozE3z+B68tsiF818OlOgF3zgqKJfGLhdc1IJtms0PM3WMU0uvy1DBlPMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk; spf=pass smtp.mailfrom=philpem.me.uk; dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b=sB5tM0Uv; arc=none smtp.client-ip=178.62.38.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b="sB5tM0Uv"
Received: from wolf.philpem.me.uk (148.163.187.81.in-addr.arpa [81.187.163.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: mailrelay_wolf@philpem.me.uk)
	by nick.sneptech.io (Postfix) with ESMTPSA id A6ADDBD152
	for <linux-ide@vger.kernel.org>; Thu,  9 Jan 2025 11:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=philpem.me.uk;
	s=mail; t=1736422572;
	bh=L4/tWWV3Pv1Nz4s+69y8Pa8Trzdn5PqCUJnXvytbcbU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=sB5tM0UvlT0ItTvlhnpq4XJDp6GZtNE8iU5fHqWlnfctHLvyA4mhxEqYGhLGxeyvp
	 sn26mWCGkX2JwcWC7okWG9cVn9DjL3FoGleuakEUPhUx4DrTH3Dx0aS407BX9A9pPw
	 8KjajZIgl39is8yBStcM9oYJlfGj48512GZaZ1iU=
Received: from [10.0.0.32] (cheetah.homenet.philpem.me.uk [10.0.0.32])
	by wolf.philpem.me.uk (Postfix) with ESMTPSA id 766042C0044
	for <linux-ide@vger.kernel.org>; Thu,  9 Jan 2025 11:36:12 +0000 (GMT)
Message-ID: <bc44660a-bff9-4f00-9289-6e58cc4e6a27@philpem.me.uk>
Date: Thu, 9 Jan 2025 11:36:12 +0000
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zip 100 ATAPI not working, "qc timeout" and "failed to clear UNIT
 ATTENTION"
To: linux-ide@vger.kernel.org
References: <c6722ee8-5e21-4169-af59-cbbae9edc02f@philpem.me.uk>
 <Z36AtY5oZY5vLcuJ@ryzen>
Content-Language: en-GB
From: Philip Pemberton <lists@philpem.me.uk>
In-Reply-To: <Z36AtY5oZY5vLcuJ@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/01/2025 13:42, Niklas Cassel wrote:
 > Did you specify anything on the kernel command line when using kernel 
3.9.6 ?

No, I didn't have to - the drive worked fine without any extra command 
line entries over the Knoppix default.

The Knoppix default command line has "libata.force=noncq" - but nothing 
related to DMADIR or similar.

Thanks
-- 
Phil.
philpem@philpem.me.uk
https://www.philpem.me.uk/
