Received: from nick.sneptech.io (nick.sneptech.io [178.62.38.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA6520F96E
	for <linux-ide@vger.kernel.org>; Thu, 23 Jan 2025 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.38.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737639434; cv=none; b=bbLTXJkFbOXjZrJqgf9Ton6CskHABJ63b1IwO2aHdo85BfBV6XH43XaR0+1GJk+bKDLo6FZfLtLbNaevbIVrK0Cb6qT2dudyVwLHrRoHC/rUHsMrOC/XPEefqnZbmIVoEjPs8X7/AwNfyDB0hH7q2RilYS6MAbENi+0rsNapL+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737639434; c=relaxed/simple;
	bh=lFWg8YzA6y2OUNWs5UsaSS++qfOiG7TOW2tnEvAI9as=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=upWzG+RZvpfiWnETZPP1gw5g0TuD0O0GbSUeIgP5kycfZE7vM1wyd4VuWySj7sAAL5d6vdJl9BS4AVVnR4Uh//SKjd7049nX9xqDZN3E5c0zttxM3c6rm5fp9rMBBP8qXP0OiFtdgU8BRmi01MlSmACD6w6PjVdZc1koltSovm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk; spf=pass smtp.mailfrom=philpem.me.uk; dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b=YLFMzjVS; arc=none smtp.client-ip=178.62.38.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b="YLFMzjVS"
Received: from wolf.philpem.me.uk (148.163.187.81.in-addr.arpa [81.187.163.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mailrelay_wolf@philpem.me.uk)
	by nick.sneptech.io (Postfix) with ESMTPSA id 6BC9CBD09B;
	Thu, 23 Jan 2025 13:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=philpem.me.uk;
	s=mail; t=1737638369;
	bh=lFWg8YzA6y2OUNWs5UsaSS++qfOiG7TOW2tnEvAI9as=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YLFMzjVShh62+AuD36ay7TW+RdOBsn8HtLd6gW/jyKBMSEcCYXCnmLXm/49A59JFc
	 M7bBK55B2+ww+zqsOyNvY5IcD+1iOyjCq+5krPFtrKCV3asIzjm3AeUS5ZO1SH303A
	 d9VwnYxhTHKxAs7xUJovsgImXofP2a581QKslw58=
Received: from [10.0.0.32] (cheetah.homenet.philpem.me.uk [10.0.0.32])
	by wolf.philpem.me.uk (Postfix) with ESMTPSA id A70CC2C009F;
	Thu, 23 Jan 2025 13:19:28 +0000 (GMT)
Message-ID: <4f1b5cef-8d7c-44c7-85ce-7a2bb890719f@philpem.me.uk>
Date: Thu, 23 Jan 2025 13:19:28 +0000
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zip 100 ATAPI not working, "qc timeout" and "failed to clear UNIT
 ATTENTION"
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <c6722ee8-5e21-4169-af59-cbbae9edc02f@philpem.me.uk>
 <Z36GMwr49ihd2nAG@ryzen> <e1985151-c206-4be1-91c1-92eac16f6236@philpem.me.uk>
 <Z3-_dt0m_2UrtKon@ryzen> <e1b79ece-b4b2-42e5-b259-290820324b5e@philpem.me.uk>
 <Z4pdD1Z2mJnF7N3O@ryzen>
Content-Language: en-GB
From: Philip Pemberton <lists@philpem.me.uk>
In-Reply-To: <Z4pdD1Z2mJnF7N3O@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Niklas,

On 17/01/2025 13:37, Niklas Cassel wrote:
> Unfortunately, so far I do not think that we have enough information to
> do much about this issue.
> 
> We know that the "SATA-to-PATA adatper + Zip drive" combo worked on some
> other PC (that might have used another SATA HBA) with an ancient kernel.
> 
> I think my first recommendation would be to try to build an ancient kernel
> on your current PC, and see if the same "SATA-to-PATA adatper + Zip drive"
> combo then works. If it does work, then I think the best bet is to use
> PCI passthrough and do an git bisection (which can be automated).
> 
> Or, do the opposite, see if the latest kernel with other PC still handles
> the Zip drive properly, if it doesn't, then perhaps the best thing is to
> to the bisection on this other PC.

I've just got the other PC up and running, running a network boot of 
Debian to make it easy to swap and change kernels and initrd's.

I've tested the following kernels and found them to work --

Debian Buster - 4.19.0-27-686-pae - no issues accessing the Zip drive.
Debian Buster - 5.10.0-0-686 - likewise.
Debian Bookworm - 6.1.0-30-686-pae

I checked and found (via "udevadm info -an /dev/sdX | grep DRIVER") that 
it was using the ata_piix driver.
By the same route (udevadm), the workstation is using the "ahci" driver.

I'm not sure what that really says, other than the PIIX driver isn't 
affected.

I'll dig out another machine which uses the "ahci" driver (and ideally 
the same chipset) and report back with my findings.

Thanks,
-- 
Phil.
philpem@philpem.me.uk
https://www.philpem.me.uk/
