Received: from nick.sneptech.io (nick.sneptech.io [178.62.38.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C0917E4
	for <linux-ide@vger.kernel.org>; Wed,  7 May 2025 20:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.38.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746651487; cv=none; b=aEN/LdHWOeWXQo/tXoL7JzTrcyRpAdM7JSJygeL2+eUH0SNBLngrK6hRLCkyXHWsKJTA8Vcvg4HNcUkpqnd6pawP7+0Ec9OJIqKAf3bl6t1lo0Zd2iGhGN2xBRU8enUl8cnYeZDj4RwliAUlGDhVfNFLrdnGtgqXkSGYqv603cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746651487; c=relaxed/simple;
	bh=63DaXNxHahdj9wL+daBG2opQ4qBB9WTsr5iDNdawHKg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=EX7UXtbd+BjkOpitFYeLnTEMCVfVG2aEQvtl1zBh33cnFLL1udEEuZcyIcy5R3RRhFEnAZ5y2RptaCCb7P4y/wP7r0k8AgxGJY5HcI3wE2wsl6U4ipCkR/tcDtah4deOfb9WL82SUhrtNdXDzO505UTp2QzbTnIeenz4fAbpnx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk; spf=pass smtp.mailfrom=philpem.me.uk; dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b=SpzbEyWu; arc=none smtp.client-ip=178.62.38.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b="SpzbEyWu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=philpem.me.uk;
	s=mail; t=1746625540;
	bh=63DaXNxHahdj9wL+daBG2opQ4qBB9WTsr5iDNdawHKg=;
	h=Date:To:From:Subject:From;
	b=SpzbEyWubNXKxcwPv9RUfI8ozBwrDT5OFotZktkIwNKzJlOUem+CItRdmrfARN6Xc
	 FAMQWvnc5Ri4Rt8tB9i1e+a+7Og7UDxnWs6QN2xoz3LuSGNxbf3pxtNfCouzbgR/IJ
	 OL5ZuetySQskOJENsBQYn1JPeKLT/xfVmmyQNj/g=
Received: from wolf.philpem.me.uk (unknown [81.187.163.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mailrelay_wolf@philpem.me.uk)
	by nick.sneptech.io (Postfix) with ESMTPSA id 2953FBD396
	for <linux-ide@vger.kernel.org>; Wed,  7 May 2025 13:45:40 +0000 (UTC)
Received: from [10.0.0.32] (cheetah.homenet.philpem.me.uk [10.0.0.32])
	by wolf.philpem.me.uk (Postfix) with ESMTPSA id 211CA5FCD6
	for <linux-ide@vger.kernel.org>; Wed,  7 May 2025 14:06:18 +0100 (BST)
Message-ID: <398bda0b-6eaf-4a4f-8f46-0b0befd3aa89@philpem.me.uk>
Date: Wed, 7 May 2025 14:06:17 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-ide@vger.kernel.org
From: Phil Pemberton <philpem@philpem.me.uk>
Subject: Multi-LUN ATAPI devices (Panasonic PD)
Autocrypt: addr=philpem@philpem.me.uk; keydata=
 xjMEXydiMhYJKwYBBAHaRw8BAQdAue6h7KZndZe267J4TCZIAZmDLahbJizZtyiS9Uxb3UjN
 JlBoaWwgUGVtYmVydG9uIDxwaGlscGVtQHBoaWxwZW0ubWUudWs+wpYEExYIAD4WIQQNQon0
 YFqZ5eiAzskxZE/eiPALKwUCXydiMgIbAwUJCWYBgAULCQgHAgYVCgkICwIEFgIDAQIeAQIX
 gAAKCRAxZE/eiPALK3r6AQDasyYeBzuY7Cfwsc998Kp1jhbG0yhKEcSjwlHlXDU1VwD9G06D
 +/NxJK4oGgFwXGXNy3wFZD8z0f0Nby1pH1xJegTOOARfJ2IyEgorBgEEAZdVAQUBAQdAFmcj
 /kFSpvBek1omKRwB7QnAlXHzZ8rCZZd189iJwikDAQgHwn4EGBYIACYWIQQNQon0YFqZ5eiA
 zskxZE/eiPALKwUCXydiMgIbDAUJCWYBgAAKCRAxZE/eiPALK+wFAP9PD5d+xVF3OD+Gi5S/
 +PkqPyAEXluBepMiKK5D29ONpgD/ZOkFGUeTEjvulqPznEZGGlqjYY4g5hMO8739f4jPwAs=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

It's me again, with another weird IDE device..

The device is a Panasonic PD/CD-ROM drive. Under Windows it enumerates 
as two drives, apparently LUN 0 and LUN 1. LUN 0 is a CD-ROM, and LUN 1 
is the PD-RW block device.

(PD is Phase-change Dual, a rewritable optical disc format developed by 
Panasonic in the 1990s, it stores 650MB on a CD-sized disc encased in a 
DVD-RAM-like caddy)

Unfortunately Linux 6.12.9 (on Debian Bookworm) only detects the first 
LUN, the CD drive. If a PD disk is inserted into the drive then there's 
no way to read it.

It seems like the Linux ATAPI layer only supports a single LUN. Is there 
a way to extend it to support the second LUN on the Panasonic drive?

Thanks,
-- 
Phil.
philpem@philpem.me.uk
https://www.philpem.me.uk/

