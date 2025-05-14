Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D029298986
	for <linux-ide@vger.kernel.org>; Wed, 14 May 2025 17:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747245461; cv=none; b=KYwPMBRjvGdH+/hw88DQjgdAwLmHws5XFZU1Yyw6TeXMYUxCcUebWoayjdnnbUh5txMB+UC6p4ur2RYcC92tbl/CJV/6VPrboUo/FMjVBnBfZRKS0UscjzcWPr2ap3gGKVYNplAUMKz+0KiB7peBP4jA72tE+YhrJ2B7UC6SVKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747245461; c=relaxed/simple;
	bh=HDEpsG8s0GT1kqq4KCFxr0PLOYeoIDxXcwvGv+hHp4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpyM/sldMyEU3lQ4dj3/t27jNAsVOI6VWdPWbyZBxEPLmrTb0R58HAOkq5GD8EJk2Za8s0WhVDW6xVUea1ljJ1FpLWsqd69STdFV6OfV7Q6dWuPJgXkY3Ojg8KqvMG8L2c4pxJ5zaXngM5m9LqXk/3VHPovD3RDotS9dquHTNys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U09tDkYo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U09tDkYo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF70BC4CEEF;
	Wed, 14 May 2025 17:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747245460;
	bh=HDEpsG8s0GT1kqq4KCFxr0PLOYeoIDxXcwvGv+hHp4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U09tDkYodU6YS1glLg6ikbqgcz2p1JcNk1vRxNisZ7Xh2qfubvv+5Pz47SIzGL9qy
	 RMu52If5b5gcxlLeGVt1ZEDH6+codJhsHCHQSh4/qakX8QqkfvADaWxakuDUa3r3wP
	 NCxiS2SfC3JcVg+wgRe2SR9zXB27qMB7xY/wNlNu3CRzypZhOnMfF9YrRGr3A+ANce
	 ZzPyVINNeHGsquR3uY5TxXqk0m4J/JJyX67V9OBPD7hp0CKdYx0zCR831qqTmMnfFu
	 vPOMaHsS2kU06AIIl4UFAEIwdZub9MfT4gMfpeCGg5Bvwy/eF/HDxP36yKzImAAyZl
	 MVuArpszIhxmQ==
Date: Wed, 14 May 2025 19:57:37 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Ioannis Barkas <jnyb.de@gmail.com>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0
 hard drives
Message-ID: <aCTZkV5mRjDsYyeE@ryzen>
References: <aB8_rITWsMzkTiyE@ryzen>
 <CAAZ0mTe7Tpf2F1cKbmr==43pXDUxcPP4Q2AydpyDFJUrFHzNHQ@mail.gmail.com>
 <98E34F63-CCAE-48C4-9584-9053C3D1A7FD@kernel.org>
 <CAAZ0mTdcAazi=133Dz0+OgSGOERe7WmCTr27ePudEVhkJj6VbA@mail.gmail.com>
 <48F49924-F5FE-4A91-8323-E2C789D1BEFB@kernel.org>
 <CAAZ0mTdtOVSidMeC76X9oZyHCtJdgyiu44+UEKqP5tSUaD9ZsQ@mail.gmail.com>
 <aCG-gS2f3uXKaQPj@ryzen>
 <CAAZ0mTfqE+w8BBCyVSg0KKQ6fYZwKaqvh_ND8dLCANg-oMaphA@mail.gmail.com>
 <aCHZg4tj6YwS9vph@ryzen>
 <CAAZ0mTeiVqZQvkWzJ8aFH4FUPCZwy5O+9hPBgDPhSgNNz+t6HA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAZ0mTeiVqZQvkWzJ8aFH4FUPCZwy5O+9hPBgDPhSgNNz+t6HA@mail.gmail.com>

Hello Mikko,

On Mon, May 12, 2025 at 05:16:14PM +0300, Mikko Juhani Korhonen wrote:
> >
> Yes, but for some reason now I get different results. I wonder what's
> different now. The earlier results were on configuration
> sata ports 5,6 -> WDC WD20EFAX-68FB5N0
> so LPM had to be disabled (it's impossible to run anything) but can't
> remember what kernel version and which variation I used to disable it.
> 
> Now with vanilla 6.14.5 and configuration:
> sata ports 5,6 -> WDC WD5000AAKX-001CA0
> sata ports 3,4 -> WDC WD20EFAX-68FB5N0
> I get:

Well we still see:

> /dev/sda:
> 
> ATA device, with non-removable media
>     Model Number:       WDC WD20EFAX-68FB5N0
>     Firmware Revision:  82.00A82
> Commands/features:
>     Enabled    Supported:
>        *    Host-initiated interface power management
>        *    Device-initiated interface power management

This drive supports both HIPM and DIPM,
and has both enabled. (Which makes sense since lpm-pol 3 includes DIPM.)


> /dev/sdb:
> 
> ATA device, with non-removable media
>     Model Number:       WDC WD20EFAX-68FB5N0
>     Firmware Revision:  82.00A82
> Commands/features:
>     Enabled    Supported:
>        *    Host-initiated interface power management
>             Device-initiated interface power management

This drive supports HIPM and DIPM,
but only HIPM has been enabled. (Which does not make sense since
lpm-pol 3 includes DIPM...)

I have no idea what is going on here...

I would add some debug prints around:
https://github.com/torvalds/linux/blob/v6.15-rc6/drivers/ata/libata-eh.c#L3512-L3520

To
1) Make sure that we actually send down the SET FEATURES command for
to the drive.

2) Check the return code (err_mask). This code looks a bit sketchy,
if (err_mask && err_mask != AC_ERR_DEV) {

It seems that if err_mask == AC_ERR_DEV, the error would get silently
discarded...


Did you do something with this drive?
Was this perhaps the drive that got timeout? and for some reason
the timeouts caused DIPM to get disabled?

Did you get any timeouts on the other drive of the same model (/dev/sda) ?


> /dev/sdc:
> 
> ATA device, with non-removable media
>     Model Number:       WDC WD5000AAKX-001CA0
>     Firmware Revision:  15.01H15
> Commands/features:
>     Enabled    Supported:
>        *    Host-initiated interface power management

This drive appears to only support HIPM, it does not support DIPM.
It has HIPM enabled, because that is the only feature supported by
the drive.



Looking at what you told before:

WD5000AAKX-001CA0 works with LPM enabled (lpm-pol 3), on port 5-6.
WD20EFAX-68FB5N0 gets timeouts with LPM enabled (lpm-pol 3), on port 5-6.

Would again suggest that your controller has issues with DIPM.
The reason why you don't need the "no lpm" quirk on the
"WDC WD5000AAKX-001CA0" drive is most likely because it doesn't support DIPM.

Remind me again, without any quirks, do you get timeouts for the
"WDC WD20EFAX-68FB5N0" drive on all drives, or just on port 5-6?


I would really like to know why DIPM is not enabled on your device,
even though it claims support for it, and you are using lpm-pol 3.


Kind regards,
Niklas
